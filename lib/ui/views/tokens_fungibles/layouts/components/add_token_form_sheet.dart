/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/currency.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/tokens_fungibles/bloc/provider.dart';
import 'package:aewallet/ui/views/tokens_fungibles/bloc/state.dart';
import 'package:aewallet/ui/widgets/balance/balance_indicator.dart';
import 'package:aewallet/ui/widgets/components/app_button.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/network_indicator.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/ui/widgets/components/tap_outside_unfocus.dart';
import 'package:aewallet/ui/widgets/fees/fee_infos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'add_token_textfield_initial_supply.dart';
part 'add_token_textfield_name.dart';
part 'add_token_textfield_symbol.dart';

class AddTokenFormSheet extends ConsumerStatefulWidget {
  const AddTokenFormSheet({
    super.key,
  });

  @override
  ConsumerState<AddTokenFormSheet> createState() => _AddTokenFormSheetState();
}

class _AddTokenFormSheetState extends ConsumerState<AddTokenFormSheet> {
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
    final accountSelected = ref.watch(AccountProviders.selectedAccount)!;
    final currency = ref.watch(CurrencyProviders.selectedCurrency);
    final addToken = ref.watch(AddTokenFormProvider.addTokenForm);
    final addTokenNotifier =
        ref.watch(AddTokenFormProvider.addTokenForm.notifier);

    return TapOutsideUnfocus(
      child: SafeArea(
        minimum:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
        child: Column(
          children: <Widget>[
            SheetHeader(
              title: localizations.createFungibleToken,
              widgetBeforeTitle: const NetworkIndicator(),
              widgetAfterTitle: const BalanceIndicatorWidget(
                displaySwitchButton: false,
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Scrollbar(
                  controller: scrollController,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: bottom + 80),
                      child: Column(
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: AddTokenTextFieldName(),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: AddTokenTextFieldSymbol(),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: AddTokenTextFieldInitialSupply(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: FeeInfos(
                              feeEstimation: addToken.feeEstimation,
                              tokenPrice:
                                  accountSelected.balance!.tokenPrice!.amount ??
                                      0,
                              currencyName: currency.currency.name,
                              estimatedFeesNote:
                                  localizations.estimatedFeesAddTokenNote,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    if (addToken.canAddToken)
                      AppButton(
                        AppButtonType.primary,
                        localizations.createToken,
                        Dimens.buttonBottomDimens,
                        key: const Key('createToken'),
                        onPressed: () async {
                          final isNameOk =
                              addTokenNotifier.controlName(context);
                          final isSymbolOk =
                              addTokenNotifier.controlSymbol(context);
                          final isInitialSupplyOk =
                              addTokenNotifier.controlInitialSupply(context);
                          final isAmountOk = addTokenNotifier.controlAmount(
                            context,
                            accountSelected,
                          );
                          if (isNameOk &&
                              isSymbolOk &&
                              isInitialSupplyOk &&
                              isAmountOk) {
                            addTokenNotifier.setAddTokenProcessStep(
                              AddTokenProcessStep.confirmation,
                            );
                          }
                        },
                      )
                    else
                      AppButton(
                        AppButtonType.primaryOutline,
                        localizations.createToken,
                        Dimens.buttonBottomDimens,
                        key: const Key('createToken'),
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
