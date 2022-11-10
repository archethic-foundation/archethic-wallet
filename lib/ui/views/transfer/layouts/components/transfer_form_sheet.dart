/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/currency.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/transfer/bloc/provider.dart';
import 'package:aewallet/ui/views/transfer/bloc/state.dart';
import 'package:aewallet/ui/views/transfer/layouts/transfer_sheet.dart';
import 'package:aewallet/ui/widgets/balance/balance_indicator.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/icons.dart';
import 'package:aewallet/ui/widgets/components/network_indicator.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/ui/widgets/components/tap_outside_unfocus.dart';
import 'package:aewallet/ui/widgets/fees/fee_infos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalization.of(context)!;
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final accountSelected =
        ref.watch(AccountProviders.selectedAccount).valueOrNull;
    final currency = ref.watch(CurrencyProviders.selectedCurrency);
    final transfer = ref.watch(TransferFormProvider.transferForm);
    final transferNotifier =
        ref.watch(TransferFormProvider.transferForm.notifier);

    if (accountSelected == null) return const SizedBox();

    return TapOutsideUnfocus(
      child: SafeArea(
        minimum:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
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
                  child: Padding(
                    padding: EdgeInsets.only(bottom: bottom + 80),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 25),
                        if (transfer.transferType != TransferType.nft)
                          const TransferTextFieldAmount(),
                        Container(
                          padding: const EdgeInsets.only(
                            top: 20,
                            bottom: 20,
                          ),
                          alignment: Alignment.topCenter,
                          child: const TransferTextFieldAddress(),
                        ),
                        FeeInfos(
                          feeEstimation: transfer.feeEstimation,
                          tokenPrice:
                              accountSelected.balance!.tokenPrice!.amount ?? 0,
                          currencyName: currency.currency.name,
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
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    if (transfer.canTransfer)
                      AppButtonTiny(
                        AppButtonTinyType.primary,
                        actionButtonTitle ?? localizations.send,
                        Dimens.buttonBottomDimens,
                        key: const Key('send'),
                        icon: Icon(
                          UiIcons.send,
                          color: theme.text,
                          size: 14,
                        ),
                        onPressed: () async {
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
                      )
                    else
                      AppButtonTiny(
                        AppButtonTinyType.primaryOutline,
                        actionButtonTitle ?? localizations.send,
                        Dimens.buttonBottomDimens,
                        key: const Key('send'),
                        icon: Icon(
                          UiIcons.send,
                          color: theme.text30,
                          size: 14,
                        ),
                        onPressed: () {},
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
