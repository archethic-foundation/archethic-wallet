/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/transfer/bloc/provider.dart';
import 'package:aewallet/ui/views/transfer/bloc/state.dart';
import 'package:aewallet/ui/views/transfer/layouts/transfer_sheet.dart';
import 'package:aewallet/ui/widgets/balance/balance_indicator.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/network_indicator.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/ui/widgets/components/tap_outside_unfocus.dart';
import 'package:aewallet/ui/widgets/fees/fee_infos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

    return TapOutsideUnfocus(
      child: SafeArea(
        minimum:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          children: <Widget>[
            SheetHeader(
              title: title,
              widgetBeforeTitle: const NetworkIndicator(),
              widgetAfterTitle: const BalanceIndicatorWidget(),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: ArchethicScrollbar(
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 25),
                      Container(
                        alignment: Alignment.topCenter,
                        child: const TransferTextFieldAddress(),
                      ),
                      if (transfer.transferType != TransferType.nft)
                        Container(
                          padding: const EdgeInsets.only(
                            top: 20,
                            bottom: 20,
                          ),
                          alignment: Alignment.topCenter,
                          child: const TransferTextFieldAmount(),
                        ),
                      FeeInfos(
                        asyncFeeEstimation: transfer.feeEstimation,
                        estimatedFeesNote:
                            transfer.transferType == TransferType.nft
                                ? localizations.estimatedFeesNoteNFT
                                : localizations.estimatedFeesNote,
                      ),
                      const SizedBox(height: 10),
                      const TransferTextFieldMessage(),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    AppButtonTinyConnectivity(
                      actionButtonTitle ?? localizations.send,
                      Dimens.buttonTopDimens,
                      key: const Key('send'),
                      icon: Symbols.call_made,
                      onPressed: () async {
                        final transferNotifier = ref
                            .read(TransferFormProvider.transferForm.notifier);

                        final isAddressOk =
                            await transferNotifier.controlAddress(
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
