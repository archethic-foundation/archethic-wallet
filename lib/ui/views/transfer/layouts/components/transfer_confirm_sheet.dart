/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

// Project imports:
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/authentication/authentication.dart';
import 'package:aewallet/application/connectivity_status.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/bus/authenticated_event.dart';
import 'package:aewallet/bus/transaction_send_event.dart';
import 'package:aewallet/domain/models/transaction_event.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/ui/themes/themes.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/routes.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/authenticate/auth_factory.dart';
import 'package:aewallet/ui/views/transfer/bloc/provider.dart';
import 'package:aewallet/ui/views/transfer/bloc/state.dart';
import 'package:aewallet/ui/views/transfer/layouts/components/token_transfer_detail.dart';
import 'package:aewallet/ui/views/transfer/layouts/components/uco_transfer_detail.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/ui/widgets/components/show_sending_animation.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransferConfirmSheet extends ConsumerStatefulWidget {
  const TransferConfirmSheet({
    super.key,
    this.title,
  });

  final String? title;

  @override
  ConsumerState<TransferConfirmSheet> createState() =>
      _TransferConfirmSheetState();
}

class _TransferConfirmSheetState extends ConsumerState<TransferConfirmSheet> {
  bool? animationOpen;

  StreamSubscription<AuthenticatedEvent>? _authSub;
  StreamSubscription<TransactionSendEvent>? _sendTxSub;

  void _registerBus() {
    _authSub = EventTaxiImpl.singleton()
        .registerTo<AuthenticatedEvent>()
        .listen((AuthenticatedEvent event) {
      final theme = ref.read(ThemeProviders.selectedTheme);
      ShowSendingAnimation.build(
        context,
        theme,
      );

      ref.read(TransferFormProvider.transferForm.notifier).send(context);
    });

    _sendTxSub = EventTaxiImpl.singleton()
        .registerTo<TransactionSendEvent>()
        .listen((TransactionSendEvent event) async {
      final theme = ref.read(ThemeProviders.selectedTheme);
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
              .transferConfirmed1
              .replaceAll('%1', event.nbConfirmations.toString())
              .replaceAll('%2', event.maxConfirmations.toString())
          : AppLocalization.of(context)!
              .transferConfirmed
              .replaceAll('%1', event.nbConfirmations.toString())
              .replaceAll('%2', event.maxConfirmations.toString()),
      context,
      ref,
      theme.text!,
      theme.snackBarShadow!,
      duration: const Duration(milliseconds: 5000),
    );
    final transfer = ref.read(TransferFormProvider.transferForm);
    if (transfer.transferType == TransferType.nft) {
      final transactionMap = await sl
          .get<ApiService>()
          .getLastTransaction([event.transactionAddress!]);
      final transaction = transactionMap[event.transactionAddress!];
      final tokenMap = await sl.get<ApiService>().getToken(
        [transaction!.data!.ledger!.token!.transfers[0].tokenAddress!],
        request: 'id',
      );

      final selectedAccount = await ref.read(
        AccountProviders.selectedAccount.future,
      );

      await selectedAccount!.removeftInfosOffChain(
        tokenMap[transaction.data!.ledger!.token!.transfers[0].tokenAddress!]!
            .id,
      ); // TODO(reddwarf03): we should not interact directly with data source. Use Providers instead. (3)

      await ref.read(AccountProviders.selectedAccount.notifier).refreshNFTs();
    }

    ref
        .read(AccountProviders.selectedAccount.notifier)
        .refreshRecentTransactions();
    if (transfer.transferType == TransferType.token) {
      ref
          .read(AccountProviders.selectedAccount.notifier)
          .refreshFungibleTokens();
    }

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
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalization.of(context)!;
    final transfer = ref.watch(TransferFormProvider.transferForm);
    final transferNotifier =
        ref.watch(TransferFormProvider.transferForm.notifier);
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);

    return SafeArea(
      minimum:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
      child: Column(
        children: <Widget>[
          SheetHeader(
            title: widget.title ?? localizations.transfering,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: transfer.transferType == TransferType.uco
                        ? const UCOTransferDetail()
                        : transfer.transferType == TransferType.token ||
                                transfer.transferType == TransferType.nft
                            ? const TokenTransferDetail()
                            : const SizedBox(),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    if (connectivityStatusProvider ==
                        ConnectivityStatus.isConnected)
                      AppButtonTiny(
                        AppButtonTinyType.primary,
                        localizations.confirm,
                        Dimens.buttonTopDimens,
                        key: const Key('confirm'),
                        icon: Icon(
                          Icons.check,
                          color: theme.mainButtonLabel,
                          size: 14,
                        ),
                        onPressed: () async {
                          final authMethod = AuthenticationMethod(
                            ref.read(
                              AuthenticationProviders.settings.select(
                                (settings) => settings.authenticationMethod,
                              ),
                            ),
                          );
                          final auth = await AuthFactory.authenticate(
                            context,
                            ref,
                            authMethod: authMethod,
                            activeVibrations: ref
                                .read(SettingsProviders.settings)
                                .activeVibrations,
                          );
                          if (auth) {
                            EventTaxiImpl.singleton()
                                .fire(AuthenticatedEvent());
                          }
                        },
                      )
                    else
                      AppButtonTiny(
                        AppButtonTinyType.primaryOutline,
                        localizations.confirm,
                        Dimens.buttonTopDimens,
                        key: const Key('confirm'),
                        icon: Icon(
                          Icons.check,
                          color: theme.mainButtonLabel!.withOpacity(0.3),
                          size: 14,
                        ),
                        onPressed: () {},
                      ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    AppButtonTiny(
                      AppButtonTinyType.primary,
                      localizations.back,
                      Dimens.buttonBottomDimens,
                      key: const Key('back'),
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: theme.mainButtonLabel,
                        size: 14,
                      ),
                      onPressed: () {
                        transferNotifier.setTransferProcessStep(
                          TransferProcessStep.form,
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
    );
  }
}
