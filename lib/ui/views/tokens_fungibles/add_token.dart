/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

// Project imports:
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/service/app_service.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/tokens_fungibles/add_token_confirm.dart';
import 'package:aewallet/ui/widgets/balance/balance_indicator.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';
import 'package:aewallet/ui/widgets/components/network_indicator.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/ui/widgets/components/tap_outside_unfocus.dart';
import 'package:aewallet/util/get_it_instance.dart';
// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddTokenSheet extends ConsumerStatefulWidget {
  const AddTokenSheet({
    super.key,
    this.primaryCurrency,
  });

  final PrimaryCurrencySetting? primaryCurrency;

  @override
  ConsumerState<AddTokenSheet> createState() => _AddTokenSheetState();
}

class _AddTokenSheetState extends ConsumerState<AddTokenSheet> {
  FocusNode? _nameFocusNode;
  FocusNode? _symbolFocusNode;
  FocusNode? _initialSupplyFocusNode;
  TextEditingController? _nameController;
  TextEditingController? _symbolController;
  TextEditingController? _initialSupplyController;

  late String _nameValidationText;
  late String _symbolValidationText;
  late String _initialSupplyValidationText;

  bool? animationOpen;
  double feeEstimation = 0;
  bool? _isPressed;
  bool validRequest = true;

  @override
  void initState() {
    super.initState();

    _isPressed = false;
    _nameFocusNode = FocusNode();
    _symbolFocusNode = FocusNode();
    _initialSupplyFocusNode = FocusNode();
    _nameController = TextEditingController();
    _symbolController = TextEditingController();
    _initialSupplyController = TextEditingController();
    _nameValidationText = '';
    _symbolValidationText = '';
    _initialSupplyValidationText = '';
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.read(ThemeProviders.theme);
    final accountSelected = StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!;
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return TapOutsideUnfocus(
      child: SafeArea(
        minimum: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
        child: Column(
          children: <Widget>[
            SheetHeader(
              title: localizations.createFungibleToken,
              widgetBeforeTitle: const NetworkIndicator(),
              widgetAfterTitle: BalanceIndicatorWidget(
                primaryCurrency: widget.primaryCurrency,
                displaySwitchButton: false,
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Stack(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        _nameFocusNode!.unfocus();
                        _symbolFocusNode!.unfocus();
                        _initialSupplyFocusNode!.unfocus();
                      },
                      child: Container(
                        color: Colors.transparent,
                        constraints: const BoxConstraints.expand(),
                        child: const SizedBox.expand(),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: bottom + 80),
                        child: Column(
                          children: <Widget>[
                            AppTextField(
                              focusNode: _nameFocusNode,
                              controller: _nameController,
                              cursorColor: theme.text,
                              textInputAction: TextInputAction.next,
                              labelText: localizations.tokenNameHint,
                              autocorrect: false,
                              keyboardType: TextInputType.text,
                              style: theme.textStyleSize16W600Primary,
                              inputFormatters: <LengthLimitingTextInputFormatter>[
                                LengthLimitingTextInputFormatter(40),
                              ],
                              onChanged: (_) async {
                                final fee = await getFee(
                                  accountSelected.name!,
                                );
                                // Always reset the error message to be less annoying
                                setState(() {
                                  feeEstimation = fee;
                                });
                              },
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                _nameValidationText,
                                style: theme.textStyleSize14W600Primary,
                              ),
                            ),
                            AppTextField(
                              focusNode: _symbolFocusNode,
                              controller: _symbolController,
                              cursorColor: theme.text,
                              textInputAction: TextInputAction.next,
                              labelText: localizations.tokenSymbolHint,
                              autocorrect: false,
                              keyboardType: TextInputType.text,
                              style: theme.textStyleSize16W600Primary,
                              inputFormatters: [
                                UpperCaseTextFormatter(),
                                LengthLimitingTextInputFormatter(4),
                              ],
                              onChanged: (_) async {
                                final fee = await getFee(
                                  accountSelected.name!,
                                );
                                // Always reset the error message to be less annoying
                                setState(() {
                                  feeEstimation = fee;
                                });
                              },
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.only(
                                left: 40,
                                top: 5,
                                bottom: 5,
                              ),
                              child: Text(
                                localizations.tokenSymbolMaxNumberCharacter,
                                style: theme.textStyleSize10W100Primary,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                _symbolValidationText,
                                style: theme.textStyleSize14W600Primary,
                              ),
                            ),
                            AppTextField(
                              focusNode: _initialSupplyFocusNode,
                              controller: _initialSupplyController,
                              cursorColor: theme.text,
                              textInputAction: TextInputAction.next,
                              labelText: localizations.tokenInitialSupplyHint,
                              keyboardType: TextInputType.number,
                              style: theme.textStyleSize16W600Primary,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(23),
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,8}'),
                                ),
                              ],
                              onChanged: (_) async {
                                final fee = await getFee(
                                  accountSelected.name!,
                                );
                                // Always reset the error message to be less annoying
                                setState(() {
                                  feeEstimation = fee;
                                });
                              },
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                _initialSupplyValidationText,
                                style: theme.textStyleSize14W600Primary,
                              ),
                            ),
                            if (feeEstimation > 0)
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 30,
                                  right: 30,
                                ),
                                child: Text(
                                  '${localizations.estimatedFees}: $feeEstimation ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()}',
                                  style: theme.textStyleSize14W100Primary,
                                  textAlign: TextAlign.justify,
                                ),
                              )
                            else
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 30,
                                  right: 30,
                                ),
                                child: Text(
                                  localizations.estimatedFeesAddTokenNote,
                                  style: theme.textStyleSize14W100Primary,
                                  textAlign: TextAlign.justify,
                                ),
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
                    if (_isPressed == true)
                      AppButton.buildAppButton(
                        const Key('createToken'),
                        context,
                        ref,
                        AppButtonType.primaryOutline,
                        localizations.createToken,
                        Dimens.buttonTopDimens,
                        onPressed: () {},
                      )
                    else
                      AppButton.buildAppButton(
                        const Key('createToken'),
                        context,
                        ref,
                        AppButtonType.primary,
                        localizations.createToken,
                        Dimens.buttonTopDimens,
                        onPressed: () async {
                          setState(() {
                            _isPressed = true;
                          });

                          validRequest = await _validateRequest(accountSelected);
                          if (validRequest) {
                            Sheets.showAppHeightNineSheet(
                              ref: ref,
                              onDisposed: () {
                                if (mounted) {
                                  setState(() {
                                    _isPressed = false;
                                  });
                                }
                              },
                              context: context,
                              widget: AddTokenConfirm(
                                tokenName: _nameController!.text,
                                tokenSymbol: _symbolController!.text,
                                feeEstimation: feeEstimation,
                                tokenInitialSupply: double.tryParse(
                                  _initialSupplyController!.text.replaceAll(' ', ''),
                                ),
                              ),
                            );
                          } else {
                            setState(() {
                              _isPressed = false;
                            });
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

  Future<bool> _validateRequest(Account accountSelected) async {
    final localizations = AppLocalization.of(context)!;
    var isValid = true;
    setState(() {
      _nameValidationText = '';
      _symbolValidationText = '';
      _initialSupplyValidationText = '';
    });
    if (_nameController!.text.isEmpty) {
      isValid = false;
      setState(() {
        _nameValidationText = localizations.tokenNameMissing;
      });
    }
    if (_symbolController!.text.isEmpty) {
      isValid = false;
      setState(() {
        _symbolValidationText = localizations.tokenSymbolMissing;
      });
    }
    if (_initialSupplyController!.text.isEmpty) {
      isValid = false;
      setState(() {
        _initialSupplyValidationText = localizations.tokenInitialSupplyMissing;
      });
    } else {
      if (double.tryParse(_initialSupplyController!.text.replaceAll(' ', '')) == null ||
          double.tryParse(
                _initialSupplyController!.text.replaceAll(' ', ''),
              )! <=
              0) {
        isValid = false;
        setState(() {
          _initialSupplyValidationText = localizations.tokenInitialSupplyPositive;
        });
      } else {
        if (double.tryParse(
              _initialSupplyController!.text.replaceAll(' ', ''),
            )! >
            9999999999) {
          isValid = false;
          setState(() {
            _initialSupplyValidationText = localizations.tokenInitialSupplyTooHigh;
          });
        }
      }
    }
    // Estimation of fees
    feeEstimation = await getFee(
      accountSelected.name!,
    );

    if (feeEstimation > accountSelected.balance!.nativeTokenValue!) {
      isValid = false;
      setState(() {
        _initialSupplyValidationText = localizations.insufficientBalance.replaceAll(
          '%1',
          StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel(),
        );
      });
    }

    return isValid;
  }

  Future<double> getFee(String accountName) async {
    var fee = 0.0;
    if (_initialSupplyController!.text.isEmpty || _symbolController!.text.isEmpty || _nameController!.text.isEmpty) {
      return fee;
    }
    try {
      final seed = await StateContainer.of(context).getSeed();
      final originPrivateKey = sl.get<ApiService>().getOriginKey();
      final token = Token(
        name: _nameController!.text,
        supply: toBigInt(
          double.tryParse(
            _initialSupplyController!.text.replaceAll(' ', ''),
          ),
        ),
        type: 'fungible',
        symbol: _symbolController!.text,
      );
      fee = await sl.get<AppService>().getFeesEstimationCreateToken(
            originPrivateKey,
            seed!,
            token,
            accountName,
          );
    } catch (e) {
      fee = 0;
    }
    return fee;
  }
}
