/// SPDX-License-Identifier: AGPL-3.0-or-later
part of '../transfer_sheet.dart';

class TransferTextFieldAmount extends ConsumerStatefulWidget {
  const TransferTextFieldAmount({
    super.key,
    required this.seed,
  });

  final String seed;

  @override
  ConsumerState<TransferTextFieldAmount> createState() =>
      _TransferTextFieldAmountState();
}

class _TransferTextFieldAmountState
    extends ConsumerState<TransferTextFieldAmount>
    with PrimaryCurrencyConverter {
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
    final currency = ref.watch(CurrencyProviders.selectedCurrency);
    final preferences = ref.watch(SettingsProviders.settings);
    final transfer = ref.watch(TransferFormProvider.transferForm);
    final transferNotifier =
        ref.watch(TransferFormProvider.transferForm.notifier);
    final primaryCurrency =
        ref.watch(PrimaryCurrencyProviders.selectedPrimaryCurrency);
    final accountSelected = ref.read(
      AccountProviders.getSelectedAccount(context: context),
    );
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
                  : localCurrencyFormat
                      .decimalDigits!, // TODO(Chralu): `decimalDigits` property seems to never be set.
            ),
            LocalCurrencyFormatter(
              active: false,
              currencyFormat: localCurrencyFormat,
            ),
            FilteringTextInputFormatter.allow(
              RegExp(r'^\d+\.?\d{0,8}'),
            ),
          ],
          onChanged: (String text) async {
            transferNotifier.setAmount(
              context: context,
              amount: double.tryParse(text) ?? 0,
            );
          },
          textInputAction: TextInputAction.next,
          maxLines: null,
          autocorrect: false,
          labelText: primaryCurrency.primaryCurrency ==
                  AvailablePrimaryCurrencyEnum.native
              ? '${localizations.enterAmount} (${transfer.symbol(context)})'
              : '${AppLocalization.of(context)!.enterAmount} (${currency.currency.name.toUpperCase()})',
          suffixButton: TextFieldButton(
            icon: FontAwesomeIcons.anglesUp,
            onPressed: () async {
              transferNotifier.setDefineMaxAmountInProgress(
                defineMaxAmountInProgress: true,
              );
              sl.get<HapticUtil>().feedback(
                    FeedbackType.light,
                    preferences.activeVibrations,
                  );
              if (transferNotifier.controlMaxSend(context) == false) {
                transferNotifier.setDefineMaxAmountInProgress(
                  defineMaxAmountInProgress: false,
                );
                return;
              }
              await transferNotifier.setMaxAmount(
                context: context,
              );
              _updateAmountTextController();
              transferNotifier.setDefineMaxAmountInProgress(
                defineMaxAmountInProgress: false,
              );
            },
          ),
          fadeSuffixOnCondition: true,
          suffixShowFirstCondition: !transfer.defineMaxAmountInProgress &&
              (transfer.accountToken == null && transfer.showMaxAmountButton),
          keyboardType: const TextInputType.numberWithOptions(
            signed: true,
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
                  '1 ${transfer.symbol(context)} = ${CurrencyUtil.getAmountPlusSymbol(accountSelected!.balance!.fiatCurrencyCode!, accountSelected.balance!.tokenPrice!.amount!)}',
                  style: theme.textStyleSize14W100Primary,
                ),
              ),
              if (transfer.amount != 0)
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
