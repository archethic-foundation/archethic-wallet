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
    final currency = ref.watch(CurrencyProviders.selectedCurrency);
    final preferences = ref.watch(SettingsProviders.settings);
    final transfer = ref.watch(TransferFormProvider.transferForm);
    final transferNotifier =
        ref.watch(TransferFormProvider.transferForm.notifier);
    final primaryCurrency =
        ref.watch(PrimaryCurrencyProviders.selectedPrimaryCurrency);
    final primaryCurrencyNotifier =
        ref.read(PrimaryCurrencyProviders.selectedPrimaryCurrency.notifier);
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
          autofocus: true,
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
            FilteringTextInputFormatter.allow(
              RegExp(r'^\d+\.?\d{0,8}'),
            ),
          ],
          onChanged: (String text) async {
            transferNotifier.setAmount(
              context: context,
              amount: double.tryParse(text) ?? 0,
              tokenPrice: accountSelected!.balance!.tokenPrice!.amount ?? 0,
            );
          },
          textInputAction: TextInputAction.next,
          maxLines: null,
          autocorrect: false,
          labelText: transfer.transferType == TransferType.uco
              ? primaryCurrency.primaryCurrency ==
                      AvailablePrimaryCurrencyEnum.native
                  ? '${localizations.enterAmount} (${transfer.symbol(context)})'
                  : '${AppLocalization.of(context)!.enterAmount} (${currency.currency.name.toUpperCase()})'
              : '${localizations.enterAmount} (${transfer.symbol(context)})',
          prefixButton: TextFieldButton(
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
                tokenPrice: accountSelected!.balance!.tokenPrice!.amount,
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
                  child: Text(
                    '= ${primaryCurrencyNotifier.getValueConvertedLabel(amount: transfer.amount, tokenPrice: accountSelected.balance!.tokenPrice!.amount!, context: context)}',
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
