/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../transfer_sheet.dart';

class TransferTextFieldAmount extends ConsumerStatefulWidget {
  const TransferTextFieldAmount({
    super.key,
    required this.accountSelected,
    this.accountToken,
  });

  final Account accountSelected;
  final AccountToken? accountToken;

  @override
  ConsumerState<TransferTextFieldAmount> createState() =>
      _TransferTextFieldAmountState();
}

class _TransferTextFieldAmountState
    extends ConsumerState<TransferTextFieldAmount>
    with PrimaryCurrencyConverter {
  TextEditingController? sendAmountController;
  FocusNode? sendAmountFocusNode;

  @override
  void initState() {
    super.initState();

    sendAmountFocusNode = FocusNode();
    sendAmountController = TextEditingController();
  }

  @override
  void dispose() {
    sendAmountFocusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final currency = ref.watch(CurrencyProviders.selectedCurrency);
    final preferences = ref.watch(SettingsProviders.settings);
    final transferNotifier = ref.watch(TransferProvider.transfer.notifier);
    final primaryCurrency =
        ref.watch(PrimaryCurrencyProviders.selectedPrimaryCurrency);
    final transfer = ref.watch(TransferProvider.transfer);
    final localCurrencyFormat = NumberFormat.currency(
      locale: CurrencyUtil.getLocale(currency.currency.name).toString(),
      symbol: CurrencyUtil.getCurrencySymbol(
        currency.currency.name,
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
          labelText: widget.accountToken == null
              ? primaryCurrency.primaryCurrency ==
                      AvailablePrimaryCurrencyEnum.native
                  ? '${localizations.enterAmount} (${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()})'
                  : '${localizations.enterAmount} (${currency.currency.name})'
              : '${localizations.enterAmount} (${widget.accountToken!.tokenInformations!.symbol})',
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
                sendAmount = widget.accountSelected.balance!.nativeTokenValue! -
                    transfer.feeEstimation;
                sendAmountController!.text = sendAmount.toStringAsFixed(8);
              } else {
                final selectedCurrencyFee =
                    widget.accountSelected.balance!.tokenPrice!.amount! *
                        transfer.feeEstimation;
                sendAmount =
                    widget.accountSelected.balance!.fiatCurrencyValue! -
                        selectedCurrencyFee;
                sendAmountController!.text = sendAmount
                    .toStringAsFixed(localCurrencyFormat.decimalDigits!);
              }

              if (transfer.isMaxSend) {
                return;
              }
            },
          ),
          fadeSuffixOnCondition: true,
          suffixShowFirstCondition:
              widget.accountToken == null && !transfer.isMaxSend,
          keyboardType: const TextInputType.numberWithOptions(
            signed: true,
            decimal: true,
          ),
        ),
        if (widget.accountToken == null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 40),
                alignment: Alignment.centerLeft,
                child: AutoSizeText(
                  '1 ${widget.accountSelected.balance!.nativeTokenName!} = ${CurrencyUtil.getAmountPlusSymbol(widget.accountSelected.balance!.fiatCurrencyCode!, widget.accountSelected.balance!.tokenPrice!.amount!)}',
                  style: theme.textStyleSize14W100Primary,
                ),
              ),
              if (sendAmountController!.text.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(right: 40),
                  alignment: Alignment.centerRight,
                  child: primaryCurrency.primaryCurrency ==
                          AvailablePrimaryCurrencyEnum.native
                      ? Text(
                          '= ${_convertNetworkCurrencyToSelectedCurrency(
                            transfer.amount.toString(),
                            widget.accountSelected.balance!.tokenPrice!.amount,
                            localCurrencyFormat,
                          )}',
                          textAlign: TextAlign.right,
                          style: theme.textStyleSize14W100Primary,
                        )
                      : Text(
                          '= ${_convertSelectedCurrencyToNetworkCurrency(
                            transfer.amount.toString(),
                            widget.accountSelected.balance!.tokenPrice!.amount,
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
                  '${NumberUtil.formatThousands(widget.accountToken!.amount!)} ${widget.accountToken!.tokenInformations!.symbol}',
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
