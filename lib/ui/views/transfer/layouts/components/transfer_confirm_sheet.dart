/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:async';

// Project imports:
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/bus/transaction_send_event.dart';
import 'package:aewallet/service/app_service.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/views/main/home_page.dart';
import 'package:aewallet/ui/views/transfer/bloc/provider.dart';
import 'package:aewallet/ui/views/transfer/bloc/state.dart';
import 'package:aewallet/ui/views/transfer/layouts/components/token_transfer_detail.dart';
import 'package:aewallet/ui/views/transfer/layouts/components/uco_transfer_detail.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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

class _TransferConfirmSheetState extends ConsumerState<TransferConfirmSheet>
    implements SheetSkeletonInterface {
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
    context.pop();
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

    try {
      final transfer = ref.read(TransferFormProvider.transferForm);
      if (transfer.transferType == TransferType.nft) {
        final transactionMap = await sl
            .get<ApiService>()
            .getLastTransaction([event.transactionAddress!]);
        final transaction = transactionMap[event.transactionAddress!];
        final tokenMap = await sl.get<AppService>().getToken(
          [
            transaction!.data!.ledger!.token!.transfers[0].tokenAddress!,
          ],
        );

        final selectedAccount = await ref.read(
          AccountProviders.selectedAccount.future,
        );

        await selectedAccount!.removeftInfosOffChain(
          tokenMap[transaction.data!.ledger!.token!.transfers[0].tokenAddress!]!
              .id,
        ); // TODO(reddwarf03): we should not interact directly with data source. Use Providers instead. (3)

        unawaited(
          ref.read(AccountProviders.selectedAccount.notifier).refreshNFTs(),
        );
      }

      unawaited(
        ref
            .read(AccountProviders.selectedAccount.notifier)
            .refreshRecentTransactions(),
      );
      if (transfer.transferType == TransferType.token) {
        unawaited(
          ref
              .read(AccountProviders.selectedAccount.notifier)
              .refreshFungibleTokens(),
        );
      }
    } finally {
      context.go(HomePage.routerPage);
    }
  }

  void _showSendFailed(
    TransactionSendEvent event,
  ) {
    // Send failed
    if (animationOpen!) {
      context.pop();
    }
    UIUtil.showSnackbar(
      event.response!,
      context,
      ref,
      ArchethicTheme.text,
      ArchethicTheme.snackBarShadow,
      duration: const Duration(seconds: 5),
    );
    context.pop();
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
    return SheetSkeleton(
      appBar: getAppBar(context, ref),
      floatingActionButton: getFloatingActionButton(context, ref),
      sheetContent: getSheetContent(context, ref),
    );
  }

  @override
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return Row(
      children: <Widget>[
        AppButtonTinyConnectivity(
          localizations.confirm,
          Dimens.buttonBottomDimens,
          key: const Key('confirm'),
          onPressed: () async {
            unawaited(
              Navigator.of(context).push(
                AnimationLoadingOverlay(
                  AnimationType.send,
                  ArchethicTheme.animationOverlayStrong,
                  title: AppLocalizations.of(context)!.pleaseWait,
                ),
              ),
            );
            await ref
                .read(
                  TransferFormProvider.transferForm.notifier,
                )
                .send(context);
          },
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final transferNotifier =
        ref.watch(TransferFormProvider.transferForm.notifier);

    return SheetAppBar(
      title: widget.title ?? localizations.transfering,
      widgetLeft: BackButton(
        key: const Key('back'),
        color: ArchethicTheme.text,
        onPressed: () {
          transferNotifier.setTransferProcessStep(
            TransferProcessStep.form,
          );
        },
      ),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final transfer = ref.watch(TransferFormProvider.transferForm);
    return SizedBox(
      child: transfer.transferType == TransferType.uco
          ? const UCOTransferDetail()
          : transfer.transferType == TransferType.token ||
                  transfer.transferType == TransferType.nft
              ? TokenTransferDetail(
                  tokenId: widget.tokenId,
                )
              : const SizedBox(),
    );
  }
}
