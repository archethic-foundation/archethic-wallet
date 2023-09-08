/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/tokens_fungibles/bloc/provider.dart';
import 'package:aewallet/ui/views/tokens_fungibles/bloc/state.dart';
import 'package:aewallet/ui/widgets/balance/balance_indicator.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/network_indicator.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/ui/widgets/components/tap_outside_unfocus.dart';
import 'package:aewallet/ui/widgets/fees/fee_infos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

part 'add_token_textfield_initial_supply.dart';
part 'add_token_textfield_name.dart';
part 'add_token_textfield_symbol.dart';

class AddTokenFormSheet extends ConsumerWidget {
  const AddTokenFormSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final accountSelected =
        ref.watch(AccountProviders.selectedAccount).valueOrNull;
    final addToken = ref.watch(AddTokenFormProvider.addTokenForm);
    final addTokenNotifier =
        ref.watch(AddTokenFormProvider.addTokenForm.notifier);

    if (accountSelected == null) return const SizedBox();

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
                child: ArchethicScrollbar(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: bottom + 80),
                    child: Column(
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: AddTokenTextFieldName(
                            key: Key('ftName'),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: AddTokenTextFieldSymbol(
                            key: Key('ftSymbol'),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: AddTokenTextFieldInitialSupply(
                            key: Key('ftOffer'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: FeeInfos(
                            asyncFeeEstimation: addToken.feeEstimation,
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
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    AppButtonTinyConnectivity(
                      localizations.createToken,
                      icon: Symbols.add,
                      Dimens.buttonBottomDimens,
                      key: const Key('createToken'),
                      onPressed: () async {
                        final isNameOk = addTokenNotifier.controlName(context);
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
                      disabled: !addToken.canAddToken,
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
