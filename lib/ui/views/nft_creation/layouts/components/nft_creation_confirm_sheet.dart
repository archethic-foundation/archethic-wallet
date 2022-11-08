/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/bus/authenticated_event.dart';
import 'package:aewallet/bus/transaction_send_event.dart';
import 'package:aewallet/domain/models/transaction_event.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/themes/themes.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/routes.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/authenticate/auth_factory.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/state.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/nft_creation_detail.dart';
import 'package:aewallet/ui/widgets/components/app_button.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/ui/widgets/components/show_sending_animation.dart';
import 'package:aewallet/util/preferences.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NftCreationConfirmSheet extends ConsumerStatefulWidget {
  const NftCreationConfirmSheet({
    super.key,
  });

  @override
  ConsumerState<NftCreationConfirmSheet> createState() =>
      _NftCreationConfirmState();
}

class _NftCreationConfirmState extends ConsumerState<NftCreationConfirmSheet> {
  bool? animationOpen;

  StreamSubscription<AuthenticatedEvent>? _authSub;
  StreamSubscription<TransactionSendEvent>? _sendTxSub;

  void _registerBus() {
    _authSub = EventTaxiImpl.singleton()
        .registerTo<AuthenticatedEvent>()
        .listen((AuthenticatedEvent event) {
      final theme = ref.watch(ThemeProviders.selectedTheme);
      ShowSendingAnimation.build(
        context,
        theme,
      );
      final nftCreationNotifier = ref.watch(
        NftCreationFormProvider.nftCreationForm(
          ref.read(
            NftCreationFormProvider.nftCreationFormArgs,
          ),
        ).notifier,
      );
      nftCreationNotifier.send(context);
    });

    _sendTxSub = EventTaxiImpl.singleton()
        .registerTo<TransactionSendEvent>()
        .listen((TransactionSendEvent event) async {
      final theme = ref.watch(ThemeProviders.selectedTheme);
      if (event.response != 'ok' && event.nbConfirmations == 0) {
        // Send failed
        _showSendFailed(event, theme);
        return;
      }

      if (event.response == 'ok' &&
          TransactionConfirmation.isEnoughConfirmations(
            event.nbConfirmations!,
            event.maxConfirmations!,
          )) {
        final nftCreation = ref.watch(
          NftCreationFormProvider.nftCreationForm(
            ref.read(
              NftCreationFormProvider.nftCreationFormArgs,
            ),
          ),
        );

        final selectedAccount = ref.read(AccountProviders.selectedAccount);
        await selectedAccount?.updateNftInfosOffChain(
          tokenAddress: event.transactionAddress,
          categoryNftIndex: nftCreation.currentNftCategoryIndex,
        );

        await ref.read(AccountProviders.selectedAccount.notifier).refreshNFTs();

        await _showSendSucceed(event, theme);
        return;
      }

      _showNotEnoughConfirmation(theme);
    });
  }

  void _showNotEnoughConfirmation(BaseTheme theme) {
    UIUtil.showSnackbar(
      AppLocalization.of(context)!.notEnoughConfirmations,
      context,
      ref,
      theme.text!,
      theme.snackBarShadow!,
    );
    Navigator.of(context).pop();
  }

  Future<void> _showSendSucceed(
    TransactionSendEvent event,
    BaseTheme theme,
  ) async {
    UIUtil.showSnackbar(
      event.nbConfirmations == 1
          ? AppLocalization.of(context)!
              .nftCreationTransactionConfirmed1
              .replaceAll('%1', event.nbConfirmations.toString())
              .replaceAll('%2', event.maxConfirmations.toString())
          : AppLocalization.of(context)!
              .nftCreationTransactionConfirmed
              .replaceAll('%1', event.nbConfirmations.toString())
              .replaceAll('%2', event.maxConfirmations.toString()),
      context,
      ref,
      theme.text!,
      theme.snackBarShadow!,
      duration: const Duration(milliseconds: 5000),
    );

    setState(() {
      StateContainer.of(context).requestUpdate();
    });
    Navigator.of(context).popUntil(RouteUtils.withNameLike('/home'));
  }

  void _showSendFailed(
    TransactionSendEvent event,
    BaseTheme theme,
  ) {
    // Send failed
    if (animationOpen!) {
      Navigator.of(context).pop();
    }
    UIUtil.showSnackbar(
      event.response!,
      context,
      ref,
      theme.text!,
      theme.snackBarShadow!,
      duration: const Duration(seconds: 5),
    );
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    _registerBus();
    animationOpen = false;
  }

  @override
  void dispose() {
    _authSub?.cancel();
    _sendTxSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final nftCreationNotifier = ref.watch(
      NftCreationFormProvider.nftCreationForm(
        ref.read(
          NftCreationFormProvider.nftCreationFormArgs,
        ),
      ).notifier,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              theme.background3Small!,
            ),
            fit: BoxFit.fitHeight,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[theme.backgroundDark!, theme.background!],
          ),
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) =>
              SafeArea(
            minimum: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.035,
            ),
            child: Column(
              children: <Widget>[
                SheetHeader(
                  title: localizations.createNFT,
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Text(
                          localizations.createNFTConfirmationMessage,
                          style: theme.textStyleSize14W600Primary,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const NftCreationDetail(),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          AppButton(
                            AppButtonType.primary,
                            localizations.confirm,
                            Dimens.buttonTopDimens,
                            key: const Key('confirm'),
                            onPressed: () async {
                              // Authenticate
                              final preferences =
                                  await Preferences.getInstance();
                              final authMethod = preferences.getAuthMethod();
                              final auth = await AuthFactory.authenticate(
                                context,
                                ref,
                                authMethod: authMethod,
                                activeVibrations: ref
                                    .watch(SettingsProviders.settings)
                                    .activeVibrations,
                              );
                              if (auth) {
                                EventTaxiImpl.singleton()
                                    .fire(AuthenticatedEvent());
                              }
                            },
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          AppButton(
                            AppButtonType.primary,
                            localizations.cancel,
                            Dimens.buttonBottomDimens,
                            key: const Key('cancel'),
                            onPressed: () {
                              nftCreationNotifier
                                  .setIndexTab(NftCreationTab.summary.index);
                              nftCreationNotifier.setNftCreationProcessStep(
                                NftCreationProcessStep.form,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
