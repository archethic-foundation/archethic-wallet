/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/currency.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/amount_formatters.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/transfer/bloc/model.dart';
import 'package:aewallet/ui/views/transfer/bloc/provider.dart';
import 'package:aewallet/ui/views/transfer/layouts/transfer_sheet.dart';
import 'package:aewallet/ui/widgets/balance/balance_indicator.dart';
import 'package:aewallet/ui/widgets/components/app_button.dart';
import 'package:aewallet/ui/widgets/components/network_indicator.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/ui/widgets/components/tap_outside_unfocus.dart';
import 'package:aewallet/util/currency_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransferFormSheet extends ConsumerWidget {
  const TransferFormSheet({
    required this.seed,
    this.actionButtonTitle,
    required this.title,
    super.key,
  });

  final String? actionButtonTitle;
  final String seed;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final accountSelected = StateContainer.of(context)
        .appWallet!
        .appKeychain!
        .getAccountSelected()!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final currency = ref.watch(CurrencyProviders.selectedCurrency);
    final transfer = ref.watch(TransferFormProvider.transferForm);
    final transferNotifier =
        ref.watch(TransferFormProvider.transferForm.notifier);

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
                child: Stack(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: bottom + 80),
                        child: Column(
                          children: <Widget>[
                            const SizedBox(height: 25),
                            if (transfer.transferType != TransferType.nft)
                              TransferTextFieldAmount(
                                seed: seed,
                              ),
                            Container(
                              padding: const EdgeInsets.only(
                                top: 20,
                                bottom: 20,
                              ),
                              alignment: Alignment.topCenter,
                              child: TransferTextFieldAddress(
                                seed: seed,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 30,
                              ),
                              child: transfer.feeEstimation > 0
                                  ? Text(
                                      '+ ${localizations.estimatedFees}: ${AmountFormatters.standardSmallValue(transfer.feeEstimation, StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel())}',
                                      style: theme.textStyleSize14W100Primary,
                                    )
                                  : Text(
                                      localizations.estimatedFeesNote,
                                      style: theme.textStyleSize14W100Primary,
                                    ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 30,
                              ),
                              child: transfer.feeEstimation > 0
                                  ? Text(
                                      '(${CurrencyUtil.convertAmountFormatedWithNumberOfDigits(currency.currency.name, accountSelected.balance!.tokenPrice!.amount!, transfer.feeEstimation, 8)})',
                                      style: theme.textStyleSize14W100Primary,
                                    )
                                  : const SizedBox(),
                            ),
                            const SizedBox(height: 10),
                            TransferTextFieldMessage(
                              seed: seed,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    AppButton(
                      AppButtonType.primary,
                      actionButtonTitle ?? localizations.send,
                      Dimens.buttonBottomDimens,
                      key: const Key('send'),
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
