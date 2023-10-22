/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:async';

// Project imports:
import 'package:aewallet/application/account/providers.dart';

import 'package:aewallet/bus/transaction_send_event.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/routes.dart';
import 'package:aewallet/ui/util/ui_util.dart';
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
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class TransferConfirmSheet extends ConsumerStatefulWidget {
  const TransferConfirmSheet({
    super.key,
    this.title,
    this.tokenId,
  });

  final String? title;
  final String? tokenId;

  @override
  ConsumerState<TransferConfirmSheet> createState() =>
      _TransferConfirmSheetState();
}

class _TransferConfirmSheetState extends ConsumerState<TransferConfirmSheet> {
  bool? animationOpen;

  StreamSubscription<TransactionSendEvent>? _sendTxSub;

  void _registerBus() {
    _sendTxSub = EventTaxiImpl.singleton()
        .registerTo<TransactionSendEvent>()
        .listen((TransactionSendEvent event) async {
      if (event.response != 'ok' && event.nbConfirmations == 0) {
        // Send failed
        _showSendFailed(event);
        return;
      }

      if (event.response == 'ok') {
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
              .transferConfirmed1
              .replaceAll('%1', event.nbConfirmations.toString())
              .replaceAll('%2', event.maxConfirmations.toString())
          : AppLocalizations.of(context)!
              .transferConfirmed
              .replaceAll('%1', event.nbConfirmations.toString())
              .replaceAll('%2', event.maxConfirmations.toString()),
      context,
      ref,
      ArchethicTheme.text,
      ArchethicTheme.snackBarShadow,
      duration: const Duration(milliseconds: 5000),
      icon: Symbols.info,
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
    final transfer = ref.watch(TransferFormProvider.transferForm);
    final transferNotifier =
        ref.watch(TransferFormProvider.transferForm.notifier);

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
                            ? TokenTransferDetail(
                                tokenId: widget.tokenId,
                              )
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
                            .read(TransferFormProvider.transferForm.notifier)
                            .send(context);
                      },
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
                        Symbols.arrow_back_ios,
                        color: ArchethicTheme.mainButtonLabel,
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
