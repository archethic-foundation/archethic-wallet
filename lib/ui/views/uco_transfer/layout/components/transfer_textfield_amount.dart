/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../transfer_sheet.dart';

class TransferTextFieldAmount extends ConsumerWidget
    with PrimaryCurrencyConverter {
  const TransferTextFieldAmount({
    super.key,
    required this.accountSelected,
    this.accountToken,
  });

  final Account accountSelected;
  final AccountToken? accountToken;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final currency = ref.watch(CurrencyProviders.selectedCurrency);
    final preferences = ref.watch(preferenceProvider);
    final transferNotifier = ref.watch(TransferProvider.transfer.notifier);
    final primaryCurrency =
        ref.watch(PrimaryCurrencyProviders.selectedPrimaryCurrency);
    final transfer = ref.watch(TransferProvider.transfer);

    final sendAmountController =
        TextEditingController(text: transfer.amount.toString());

    final localCurrencyFormat = NumberFormat.currency(
      locale: CurrencyUtil.getLocale(currency.currency.name).toString(),
      symbol: CurrencyUtil.getCurrencySymbol(
        currency.currency.name,
      ),
    );

    return Column(
      children: [
        AppTextField(
          controller: sendAmountController,
          cursorColor: theme.text,
          style: theme.textStyleSize16W700Primary,
          inputFormatters: [
            LengthLimitingTextInputFormatter(16),
            CurrencyFormatter(
              maxDecimalDigits: primaryCurrency.primaryCurrency ==
                      AvailablePrimaryCurrencyEnum.native
                  ? 8
                  : localCurrencyFormat.decimalDigits!,
            ),
            LocalCurrencyFormatter(
              active: false,
              currencyFormat: localCurrencyFormat,
            ),
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,8}')),
          ],
          onChanged: (String text) async {
            final amount = double.tryParse(text);
            transferNotifier.setAmount(amount ?? 0);
          },
          textInputAction: TextInputAction.next,
          maxLines: null,
          autocorrect: false,
          labelText: accountToken == null
              ? primaryCurrency.primaryCurrency ==
                      AvailablePrimaryCurrencyEnum.native
                  ? '${localizations.enterAmount} (${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()})'
                  : '${localizations.enterAmount} (${currency.currency.name})'
              : '${localizations.enterAmount} (${accountToken!.tokenInformations!.symbol})',
          suffixButton: TextFieldButton(
            icon: FontAwesomeIcons.anglesUp,
            onPressed: () async {
              sl.get<HapticUtil>().feedback(
                    FeedbackType.light,
                    preferences.activeVibrations,
                  );

              var sendAmount = 0.0;
              if (primaryCurrency.primaryCurrency ==
                  AvailablePrimaryCurrencyEnum.native) {
                sendAmount = accountSelected.balance!.nativeTokenValue! -
                    transfer.feeEstimation;
                sendAmountController.text = sendAmount.toStringAsFixed(8);
              } else {
                final selectedCurrencyFee =
                    accountSelected.balance!.tokenPrice!.amount! *
                        transfer.feeEstimation;
                sendAmount = accountSelected.balance!.fiatCurrencyValue! -
                    selectedCurrencyFee;
                sendAmountController.text = sendAmount
                    .toStringAsFixed(localCurrencyFormat.decimalDigits!);
              }

              if (transfer.isMaxSend) {
                return;
              }
            },
          ),
          fadeSuffixOnCondition: true,
          suffixShowFirstCondition: accountToken == null && !transfer.isMaxSend,
          keyboardType: const TextInputType.numberWithOptions(
            signed: true,
            decimal: true,
          ),
        ),
        if (accountToken == null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 40),
                alignment: Alignment.centerLeft,
                child: AutoSizeText(
                  '1 ${accountSelected.balance!.nativeTokenName!} = ${CurrencyUtil.getAmountPlusSymbol(accountSelected.balance!.fiatCurrencyCode!, accountSelected.balance!.tokenPrice!.amount!)}',
                  style: theme.textStyleSize14W100Primary,
                ),
              ),
              if (sendAmountController.text.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(right: 40),
                  alignment: Alignment.centerRight,
                  child: primaryCurrency.primaryCurrency ==
                          AvailablePrimaryCurrencyEnum.native
                      ? Text(
                          '= ${_convertNetworkCurrencyToSelectedCurrency(
                            transfer.amount.toString(),
                            accountSelected.balance!.tokenPrice!.amount,
                            localCurrencyFormat,
                          )}',
                          textAlign: TextAlign.right,
                          style: theme.textStyleSize14W100Primary,
                        )
                      : Text(
                          '= ${_convertSelectedCurrencyToNetworkCurrency(
                            transfer.amount.toString(),
                            accountSelected.balance!.tokenPrice!.amount,
                            context,
                          )}',
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
                  '${NumberUtil.formatThousands(accountToken!.amount!)} ${accountToken!.tokenInformations!.symbol}',
                  style: theme.textStyleSize14W100Primary,
                ),
              ),
            ],
          )
      ],
    );
  }
}

mixin PrimaryCurrencyConverter {
  String _convertSelectedCurrencyToNetworkCurrency(
    String amountEntered,
    double? tokenPriceAmount,
    BuildContext context,
  ) {
    var priceConverted = 0.0;
    var convertedAmt = amountEntered.replaceAll(',', '.');
    convertedAmt = NumberUtil.sanitizeNumber(convertedAmt);
    if (convertedAmt.isEmpty || double.tryParse(convertedAmt) == 0) {
      return '';
    }
    priceConverted = (Decimal.parse(convertedAmt) /
            Decimal.parse(
              tokenPriceAmount.toString(),
            ))
        .toDouble();
    return '${priceConverted.toStringAsFixed(8)} ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()}';
  }

  String _convertNetworkCurrencyToSelectedCurrency(
    String amountEntered,
    double? tokenPriceAmount,
    NumberFormat localCurrencyFormat,
  ) {
    var priceConverted = 0.0;
    final convertedAmt = NumberUtil.sanitizeNumber(
      amountEntered,
      maxDecimalDigits: localCurrencyFormat.decimalDigits!,
    );
    if (convertedAmt.isEmpty) {
      return '';
    }
    priceConverted = (Decimal.parse(
              tokenPriceAmount.toString(),
            ) *
            Decimal.parse(convertedAmt))
        .toDouble();
    return localCurrencyFormat.format(priceConverted);
  }
}
