/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:async';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/bus/transaction_send_event.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/routes.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/state.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/nft_creation_detail.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/ui/widgets/components/show_sending_animation.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

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

  StreamSubscription<TransactionSendEvent>? _sendTxSub;

  void _registerBus() {
    _sendTxSub = EventTaxiImpl.singleton()
        .registerTo<TransactionSendEvent>()
        .listen((TransactionSendEvent event) async {
      if (event.response != 'ok' && event.nbConfirmations == 0) {
        // Send failed
        _showSendFailed(
          event,
        );
        return;
      }

      if (event.response == 'ok') {
        final nftCreation = ref.read(
          NftCreationFormProvider.nftCreationForm(
            ref.read(
              NftCreationFormProvider.nftCreationFormArgs,
            ),
          ),
        );

        final selectedAccount =
            await ref.read(AccountProviders.selectedAccount.future);
        await selectedAccount?.updateNftInfosOffChain(
          tokenAddress: event.transactionAddress,
          categoryNftIndex: nftCreation.currentNftCategoryIndex,
        );

        await ref.read(AccountProviders.selectedAccount.notifier).refreshNFTs();

        await _showSendSucceed(event);
        return;
      }

      _showNotEnoughConfirmation();
    });
  }

  void _showNotEnoughConfirmation() {
    UIUtil.showSnackbar(
      AppLocalizations.of(context)!.notEnoughConfirmations,
      context,
      ref,
      ArchethicTheme.text,
      ArchethicTheme.snackBarShadow,
    );
    Navigator.of(context).pop();
  }

  Future<void> _showSendSucceed(
    TransactionSendEvent event,
  ) async {
    UIUtil.showSnackbar(
      event.nbConfirmations == 1
          ? AppLocalizations.of(context)!
              .nftCreationTransactionConfirmed1
              .replaceAll('%1', event.nbConfirmations.toString())
              .replaceAll('%2', event.maxConfirmations.toString())
          : AppLocalizations.of(context)!
              .nftCreationTransactionConfirmed
              .replaceAll('%1', event.nbConfirmations.toString())
              .replaceAll('%2', event.maxConfirmations.toString()),
      context,
      ref,
      ArchethicTheme.text,
      ArchethicTheme.snackBarShadow,
      icon: Symbols.info,
      duration: const Duration(milliseconds: 5000),
    );

    Navigator.of(context).popUntil(RouteUtils.withNameLike('/home'));
  }

  void _showSendFailed(
    TransactionSendEvent event,
  ) {
    // Send failed
    if (animationOpen!) {
      Navigator.of(context).pop();
    }
    UIUtil.showSnackbar(
      event.response!,
      context,
      ref,
      ArchethicTheme.text,
      ArchethicTheme.snackBarShadow,
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
    _sendTxSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final nftCreation = ref.watch(
      NftCreationFormProvider.nftCreationForm(
        ref.read(
          NftCreationFormProvider.nftCreationFormArgs,
        ),
      ),
    );
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
              ArchethicTheme.backgroundSmall,
            ),
            fit: BoxFit.fitHeight,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              ArchethicTheme.backgroundDark,
              ArchethicTheme.background,
            ],
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
                          style:
                              ArchethicThemeStyles.textStyleSize14W600Primary,
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
                          AppButtonTinyConnectivity(
                            localizations.confirm,
                            Dimens.buttonTopDimens,
                            key: const Key('confirm'),
                            icon: Symbols.check,
                            onPressed: () async {
                              ShowSendingAnimation.build(
                                context,
                              );

                              await ref
                                  .read(
                                    NftCreationFormProvider.nftCreationForm(
                                      ref.read(
                                        NftCreationFormProvider
                                            .nftCreationFormArgs,
                                      ),
                                    ).notifier,
                                  )
                                  .send(context);
                            },
                            disabled:
                                nftCreation.canConfirmNFTCreation == false,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          AppButtonTiny(
                            AppButtonTinyType.primary,
                            localizations.cancel,
                            Dimens.buttonBottomDimens,
                            key: const Key('cancel'),
                            icon: Icon(
                              Symbols.arrow_back_ios,
                              color: ArchethicTheme.mainButtonLabel,
                              size: 14,
                            ),
                            onPressed: () {
                              nftCreationNotifier
                                ..setIndexTab(NftCreationTab.summary.index)
                                ..setCheckPreventUserPublicInfo(false)
                                ..setNftCreationProcessStep(
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
