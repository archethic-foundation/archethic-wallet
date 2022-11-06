/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/currency.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/transfer/bloc/provider.dart';
import 'package:aewallet/ui/views/transfer/bloc/state.dart';
import 'package:aewallet/ui/views/transfer/layouts/transfer_sheet.dart';
import 'package:aewallet/ui/widgets/balance/balance_indicator.dart';
import 'package:aewallet/ui/widgets/components/app_button.dart';
import 'package:aewallet/ui/widgets/components/network_indicator.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/ui/widgets/components/tap_outside_unfocus.dart';
import 'package:aewallet/ui/widgets/fees/fee_infos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransferFormSheet extends ConsumerStatefulWidget {
  const TransferFormSheet({
    this.actionButtonTitle,
    required this.title,
    super.key,
  });

  final String? actionButtonTitle;
  final String title;

  @override
  ConsumerState<TransferFormSheet> createState() => _TransferFormSheetState();
}

class _TransferFormSheetState extends ConsumerState<TransferFormSheet> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalization.of(context)!;
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final accountSelected =
        StateContainer.of(context).appWallet!.appKeychain.getAccountSelected()!;
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
              title: widget.title,
              widgetBeforeTitle: const NetworkIndicator(),
              widgetAfterTitle: const BalanceIndicatorWidget(),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Stack(
                  children: <Widget>[
                    Scrollbar(
                      controller: scrollController,
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        controller: scrollController,
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
                                tokenPrice: accountSelected
                                        .balance!.tokenPrice!.amount ??
                                    0,
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
                  ],
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    if (transfer.canTransfer)
                      AppButton(
                        AppButtonType.primary,
                        widget.actionButtonTitle ?? localizations.send,
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
                      )
                    else
                      AppButton(
                        AppButtonType.primaryOutline,
                        widget.actionButtonTitle ?? localizations.send,
                        Dimens.buttonBottomDimens,
                        key: const Key('send'),
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
