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
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
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
    final valueLabel = ref.read(
      PrimaryCurrencyProviders.convertedValueLabel(
        amount: transfer.amount,
        tokenPrice: selectedCurrencyMarketPrice.amount,
        context: context,
      ),
    );

    return Column(
      children: [
        AppTextField(
          focusNode: sendAmountFocusNode,
          controller: sendAmountController,
          cursorColor: theme.text,
          style: theme.textStyleSize16W700Primary,
          inputFormatters: [
            AmountTextInputFormatter(
              precision: primaryCurrency.primaryCurrency ==
                      AvailablePrimaryCurrencyEnum.native
                  ? 8
                  : localCurrencyFormat.decimalDigits!,
            ),
            LengthLimitingTextInputFormatter(16),
          ],
          onChanged: (String text) async {
            await transferNotifier.setAmount(
              context: context,
              amount: double.tryParse(text.replaceAll(' ', '')) ?? 0,
            );
          },
          textInputAction: TextInputAction.next,
          maxLines: null,
          autocorrect: false,
          labelText: transfer.transferType == TransferType.uco
              ? primaryCurrency.primaryCurrency ==
                      AvailablePrimaryCurrencyEnum.native
                  ? '${localizations.enterAmount} (${transfer.symbol(context)})'
                  : '${AppLocalization.of(context)!.enterAmount} (${settings.currency.name.toUpperCase()})'
              : '${localizations.enterAmount} (${transfer.symbol(context)})',
          prefixButton: TextFieldButton(
            icon: UiIcons.max,
            onPressed: () async {
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
          ),
          fadePrefixOnCondition: true,
          prefixShowFirstCondition: !transfer.defineMaxAmountInProgress &&
              transfer.showMaxAmountButton(primaryCurrency),
          keyboardType: const TextInputType.numberWithOptions(
            decimal: true,
          ),
        ),
        if (transfer.transferType == TransferType.uco)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 40),
                alignment: Alignment.centerLeft,
                child: AutoSizeText(
                  '1 ${transfer.symbol(context)} = ${CurrencyUtil.getAmountPlusSymbol(currency.name, selectedCurrencyMarketPrice.amount)}',
                  style: theme.textStyleSize14W100Primary,
                ),
              ),
              if (transfer.amount != 0)
                Container(
                  margin: const EdgeInsets.only(right: 40),
                  alignment: Alignment.centerRight,
                  child: Text(
                    '= $valueLabel',
                    textAlign: TextAlign.right,
                    style: theme.textStyleSize14W100Primary,
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
              Container(
                margin: const EdgeInsets.only(left: 40),
                alignment: Alignment.centerLeft,
                child: AutoSizeText(
                  '${NumberUtil.formatThousands(transfer.accountToken!.amount!)} ${transfer.accountToken!.tokenInformations!.symbol}',
                  style: theme.textStyleSize14W100Primary,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
