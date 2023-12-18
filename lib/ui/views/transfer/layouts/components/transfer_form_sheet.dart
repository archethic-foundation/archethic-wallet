/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/views/main/home_page.dart';
import 'package:aewallet/ui/views/transfer/bloc/provider.dart';
import 'package:aewallet/ui/views/transfer/bloc/state.dart';
import 'package:aewallet/ui/views/transfer/layouts/transfer_sheet.dart';
import 'package:aewallet/ui/widgets/balance/balance_indicator.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/network_indicator.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/fees/fee_infos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

class TransferFormSheet extends ConsumerWidget {
  const TransferFormSheet({
    this.actionButtonTitle,
    required this.title,
    super.key,
  });

  final String? actionButtonTitle;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final accountSelected =
        ref.watch(AccountProviders.selectedAccount).valueOrNull;
    final transfer = ref.watch(TransferFormProvider.transferForm);

    if (accountSelected == null) return const SizedBox();

    return Scaffold(
      drawerEdgeDragWidth: 0,
      extendBodyBehindAppBar: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        children: <Widget>[
          AppButtonTinyConnectivity(
            actionButtonTitle ?? localizations.send,
            Dimens.buttonTopDimens,
            key: const Key('send'),
            icon: Symbols.call_made,
            onPressed: () async {
              final transferNotifier =
                  ref.read(TransferFormProvider.transferForm.notifier);

              final isAddressOk = await transferNotifier.controlAddress(
                context,
                accountSelected,
              );
              final isAmountOk = transferNotifier.controlAmount(
                context,
                accountSelected,
              );

              if (isAddressOk && isAmountOk) {
                transferNotifier.setTransferProcessStep(
                  TransferProcessStep.confirmation,
                );
              }
            },
            disabled: !transfer.canTransfer,
          ),
        ],
      ),
      backgroundColor: ArchethicTheme.background,
      appBar: SheetAppBar(
        title: title,
        widgetLeft: BackButton(
          key: const Key('back'),
          color: ArchethicTheme.text,
          onPressed: () {
            context.go(HomePage.routerPage);
          },
        ),
        widgetBeforeTitle: const NetworkIndicator(),
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ArchethicTheme.backgroundSmall,
            ),
            fit: BoxFit.fitHeight,
            opacity: 0.7,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 120),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: ArchethicScrollbar(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 25),
                        const TransferTextFieldAddress(),
                        if (transfer.transferType != TransferType.nft)
                          Container(
                            padding: const EdgeInsets.only(
                              top: 20,
                              bottom: 20,
                            ),
                            alignment: Alignment.topCenter,
                            child: const TransferTextFieldAmount(),
                          ),
                        const BalanceIndicatorWidget(allDigits: false),
                        FeeInfos(
                          asyncFeeEstimation: transfer.feeEstimation,
                          estimatedFeesNote:
                              transfer.transferType == TransferType.nft
                                  ? localizations.estimatedFeesNoteNFT
                                  : localizations.estimatedFeesNote,
                        ),
                        const SizedBox(height: 20),
                        const TransferTextFieldMessage(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
