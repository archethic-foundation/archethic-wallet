/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../transfer_sheet.dart';

class TransferTextFieldAmount extends ConsumerStatefulWidget {
  const TransferTextFieldAmount({
    super.key,
  });

  @override
  ConsumerState<TransferTextFieldAmount> createState() =>
      _TransferTextFieldAmountState();
}

class _TransferTextFieldAmountState
    extends ConsumerState<TransferTextFieldAmount> {
  late TextEditingController sendAmountController;
  late FocusNode sendAmountFocusNode;

  @override
  void initState() {
    super.initState();

    sendAmountFocusNode = FocusNode();
    sendAmountController = TextEditingController();
    _updateAmountTextController();
  }

  @override
  void dispose() {
    sendAmountFocusNode.dispose();
    sendAmountController.dispose();
    super.dispose();
  }

  void _updateAmountTextController() {
    final transfer = ref.read(TransferFormProvider.transferForm);
    sendAmountController.text = transfer.amount == 0
        ? ''
        : AmountFormatters.withoutCurrency(
            transfer.amount,
          );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final localizations = AppLocalizations.of(context)!;

    final settings = ref.watch(SettingsProviders.settings);
    final transfer = ref.watch(TransferFormProvider.transferForm);
    final transferNotifier =
        ref.watch(TransferFormProvider.transferForm.notifier);
    final primaryCurrency =
        ref.watch(PrimaryCurrencyProviders.selectedPrimaryCurrency);
    final accountSelected =
        ref.watch(AccountProviders.selectedAccount).valueOrNull;
    final localCurrencyFormat = NumberFormat.currency(
      locale: CurrencyUtil.getLocale(settings.currency.name).toString(),
      symbol: CurrencyUtil.getCurrencySymbol(settings.currency.name),
    );

    final currency = ref.watch(
      SettingsProviders.settings.select((settings) => settings.currency),
    );
    final selectedCurrencyMarketPrice = ref
        .watch(
          MarketPriceProviders.selectedCurrencyMarketPrice,
        )
        .valueOrNull;

    if (accountSelected == null || selectedCurrencyMarketPrice == null) {
      return const SizedBox();
    }
    final valueLabel = ref.watch(
      PrimaryCurrencyProviders.convertedValueLabel(
        amount: transfer.amount,
        tokenPrice: selectedCurrencyMarketPrice.amount,
        context: context,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            transfer.transferType == TransferType.uco
                ? primaryCurrency.primaryCurrency ==
                        AvailablePrimaryCurrencyEnum.native
                    ? '${localizations.enterAmount} (${transfer.symbol(context)})'
                    : '${AppLocalizations.of(context)!.enterAmount} (${settings.currency.name.toUpperCase()})'
                : '${localizations.enterAmount} (${transfer.symbol(context)})',
          ),
        ),
        Stack(
          alignment: Alignment.centerRight,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                    border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                      width: 0.5,
                                    ),
                                    gradient: ArchethicThemeBase
                                        .gradientInputFormBackground,
                                  ),
                                  child: TextField(
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                    autocorrect: false,
                                    controller: sendAmountController,
                                    onChanged: (String text) async {
                                      await transferNotifier.setAmount(
                                        context: context,
                                        amount: double.tryParse(
                                              text.replaceAll(' ', ''),
                                            ) ??
                                            0,
                                      );
                                    },
                                    textInputAction: TextInputAction.next,
                                    maxLines: null,
                                    focusNode: sendAmountFocusNode,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                    inputFormatters: [
                                      AmountTextInputFormatter(
                                        precision:
                                            primaryCurrency.primaryCurrency ==
                                                    AvailablePrimaryCurrencyEnum
                                                        .native
                                                ? 8
                                                : localCurrencyFormat
                                                    .decimalDigits!,
                                      ),
                                      LengthLimitingTextInputFormatter(16),
                                    ],
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(left: 10),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  if (transfer.transferType == TransferType.uco)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                            '1 ${transfer.symbol(context)} = ${CurrencyUtil.getAmountPlusSymbol(currency.name, selectedCurrencyMarketPrice.amount)}',
                            style:
                                ArchethicThemeStyles.textStyleSize14W100Primary,
                          ),
                        ),
                        if (transfer.amount != 0)
                          Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '= $valueLabel',
                              textAlign: TextAlign.right,
                              style: ArchethicThemeStyles
                                  .textStyleSize14W100Primary,
                            ),
                          )
                        else
                          const SizedBox(),
                      ],
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            AutoSizeText(
                              '${NumberUtil.formatThousands(transfer.accountToken!.amount!)} ${transfer.accountToken!.tokenInformation!.symbol}',
                              style: ArchethicThemeStyles
                                  .textStyleSize14W100Primary,
                            ),
                            if (transfer.accountToken != null &&
                                transfer.accountToken!.tokenInformation !=
                                    null &&
                                transfer.accountToken!.tokenInformation!.type ==
                                    'fungible' &&
                                transfer.accountToken!.tokenInformation!
                                        .address !=
                                    null)
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  VerifiedTokenIcon(
                                    address: transfer.accountToken!
                                        .tokenInformation!.address!,
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 19),
              child: InkWell(
                onTap: () async {
                  transferNotifier.setDefineMaxAmountInProgress(
                    defineMaxAmountInProgress: true,
                  );
                  sl.get<HapticUtil>().feedback(
                        FeedbackType.light,
                        settings.activeVibrations,
                      );
                  if (transferNotifier.controlMaxSend(context) == false) {
                    transferNotifier.setDefineMaxAmountInProgress(
                      defineMaxAmountInProgress: false,
                    );
                    return;
                  }
                  final selectedCurrencyMarketPrice = await ref.read(
                    MarketPriceProviders.selectedCurrencyMarketPrice.future,
                  );

                  await transferNotifier.setMaxAmount(
                    context: context,
                    tokenPrice: selectedCurrencyMarketPrice.amount,
                  );
                  _updateAmountTextController();
                  transferNotifier.setDefineMaxAmountInProgress(
                    defineMaxAmountInProgress: false,
                  );
                },
                child: Text(
                  'MAX',
                  style: TextStyle(color: ArchethicTheme.maxButtonColor),
                )
                    .animate()
                    .fade(
                      duration: const Duration(milliseconds: 500),
                    )
                    .scale(
                      duration: const Duration(milliseconds: 500),
                    ),
              ),
            ),
          ],
        ),
      ],
    )
        .animate()
        .fade(duration: const Duration(milliseconds: 200))
        .scale(duration: const Duration(milliseconds: 200));
  }
}
