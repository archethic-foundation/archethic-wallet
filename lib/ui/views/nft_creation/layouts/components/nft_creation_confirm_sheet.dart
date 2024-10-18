/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:async';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/bus/transaction_send_event.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/views/main/home_page.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/provider.dart';
import 'package:aewallet/ui/views/nft_creation/bloc/state.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/components/nft_creation_detail.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class NftCreationConfirmSheet extends ConsumerStatefulWidget {
  const NftCreationConfirmSheet({
    super.key,
  });

  @override
  ConsumerState<NftCreationConfirmSheet> createState() =>
      _NftCreationConfirmState();
}

class _NftCreationConfirmState extends ConsumerState<NftCreationConfirmSheet>
    implements SheetSkeletonInterface {
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
        final selectedAccount =
            await ref.read(AccountProviders.accounts.future).selectedAccount;
        await selectedAccount?.updateNftInfosOffChain(
          tokenAddress: event.transactionAddress,
        );

        await (await ref
                .read(AccountProviders.accounts.notifier)
                .selectedAccountNotifier)
            ?.refreshNFTs();

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

    context.go(HomePage.routerPage);
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

    final nftCreation = ref.watch(
      NftCreationFormProvider.nftCreationForm,
    );
    return Row(
      children: <Widget>[
        AppButtonTinyConnectivity(
          localizations.confirm,
          Dimens.buttonBottomDimens,
          key: const Key('confirm'),
          onPressed: () async {
            context.loadingOverlay.show(
              title: AppLocalizations.of(context)!.pleaseWait,
            );

            await ref
                .read(
                  NftCreationFormProvider.nftCreationForm.notifier,
                )
                .send(context);
            context.loadingOverlay.hide();
          },
          disabled: nftCreation.canConfirmNFTCreation == false,
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final nftCreationNotifier = ref.watch(
      NftCreationFormProvider.nftCreationForm.notifier,
    );
    return SheetAppBar(
      title: ' ',
      widgetLeft: BackButton(
        key: const Key('back'),
        color: ArchethicTheme.text,
        onPressed: () {
          nftCreationNotifier
            ..setIndexTab(NftCreationTab.summary.index)
            ..setCheckPreventUserPublicInfo(false)
            ..setNftCreationProcessStep(
              NftCreationProcessStep.form,
            );
        },
      ),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    return Column(
      children: <Widget>[
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Text(
            localizations.createNFTConfirmationMessage,
            style: ArchethicThemeStyles.textStyleSize14W600Primary,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const NftCreationDetail(),
      ],
    );
  }
}
