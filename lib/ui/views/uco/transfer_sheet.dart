/// SPDX-License-Identifier: AGPL-3.0-or-later
// ignore_for_file: avoid_unnecessary_containers

// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/address.dart';
import 'package:aewallet/model/available_currency.dart';
import 'package:aewallet/model/data/account_token.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/model/token_transfer_wallet.dart';
import 'package:aewallet/model/uco_transfer_wallet.dart';
import 'package:aewallet/service/app_service.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/formatters.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/uco/transfer_confirm_sheet.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/balance_indicator.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';
import 'package:aewallet/ui/widgets/components/network_indicator.dart';
import 'package:aewallet/ui/widgets/components/sheet_header.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/ui/widgets/components/tap_outside_unfocus.dart';
import 'package:aewallet/ui/widgets/dialogs/contacts_dialog.dart';
import 'package:aewallet/util/currency_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/number_util.dart';
import 'package:aewallet/util/user_data_util.dart';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart'
    show AddressService, isHex, ApiService, toBigInt;

class TransferSheet extends StatefulWidget {
  const TransferSheet({
    @required this.localCurrency,
    this.contact,
    this.address,
    this.quickSendAmount,
    this.title,
    this.actionButtonTitle,
    this.primaryCurrency,
    this.accountToken,
    super.key,
  });

  final AvailableCurrency? localCurrency;
  final Contact? contact;
  final String? address;
  final String? quickSendAmount;
  final String? title;
  final String? actionButtonTitle;
  final AccountToken? accountToken;
  final PrimaryCurrencySetting? primaryCurrency;

  @override
  State<TransferSheet> createState() => _TransferSheetState();
}

enum AddressStyle { text60, text90, primary }

class _TransferSheetState extends State<TransferSheet> {
  FocusNode? _sendAddressFocusNode;
  TextEditingController? _sendAddressController;
  FocusNode? _sendAmountFocusNode;
  TextEditingController? _sendAmountController;
  FocusNode? _messageFocusNode;
  TextEditingController? _messageController;

  AddressStyle? _sendAddressStyle;
  String _amountValidationText = '';
  String _addressValidationText = '';
  String _messageValidationText = '';
  String? quickSendAmount;
  bool _addressValidAndUnfocused = false;
  bool _isContact = false;
  bool _qrCodeButtonVisible = true;
  late NumberFormat _localCurrencyFormat;
  String? _rawAmount;
  bool validRequest = true;
  double feeEstimation = 0;
  bool? _isPressed;
  double priceConverted = 0;

  List<UCOTransferWallet> ucoTransferList =
      List<UCOTransferWallet>.empty(growable: true);

  List<TokenTransferWallet> tokenTransferList =
      List<TokenTransferWallet>.empty(growable: true);

  PrimaryCurrency primaryCurrencySelected = PrimaryCurrency.native;

  @override
  void initState() {
    super.initState();
    if (widget.primaryCurrency!.primaryCurrency.name ==
        PrimaryCurrencySetting(AvailablePrimaryCurrency.native)
            .primaryCurrency
            .name) {
      primaryCurrencySelected = PrimaryCurrency.native;
    } else {
      primaryCurrencySelected = PrimaryCurrency.fiat;
    }

    _isPressed = false;
    _sendAmountFocusNode = FocusNode();
    _sendAddressFocusNode = FocusNode();
    _messageFocusNode = FocusNode();
    _sendAmountController = TextEditingController();
    _sendAddressController = TextEditingController();
    _messageController = TextEditingController();
    _sendAddressStyle = AddressStyle.text60;
    quickSendAmount = widget.quickSendAmount;
    if (widget.contact != null) {
      // Setup initial state for contact pre-filled
      _sendAddressController!.text = widget.contact!.name!;
      _isContact = true;
      _qrCodeButtonVisible = false;
      _sendAddressStyle = AddressStyle.primary;
    } else if (widget.address != null) {
      // Setup initial state with prefilled address
      _sendAddressController!.text = widget.address!;
      _qrCodeButtonVisible = false;
      _sendAddressStyle = AddressStyle.text90;
      _addressValidAndUnfocused = true;
    }

    if (widget.accountToken != null &&
        widget.accountToken!.tokenInformations != null &&
        widget.accountToken!.tokenInformations!.type == 'non-fungible') {
      _sendAmountController!.text = '1';
    }

    // On amount focus change
    _sendAmountFocusNode!.addListener(() {
      if (_sendAmountFocusNode!.hasFocus) {
        if (_rawAmount != null) {
          setState(() {
            _sendAmountController!.text =
                NumberUtil.getRawAsUsableString(_rawAmount!)
                    .replaceAll(',', '');
            _rawAmount = null;
          });
        }
        if (quickSendAmount != null) {
          _sendAmountController!.text = '';
          setState(() {
            quickSendAmount = null;
          });
        }
      }
    });
    // On address focus change
    _sendAddressFocusNode!.addListener(() {
      if (_sendAddressFocusNode!.hasFocus) {
        _sendAddressController!.selection = TextSelection.fromPosition(
          TextPosition(offset: _sendAddressController!.text.length),
        );
        if (_sendAddressController!.text.startsWith('@')) {
          sl
              .get<DBHelper>()
              .getContactsWithNameLike(_sendAddressController!.text)
              .then((List<Contact> contactList) {});
        }
      } else {
        if (_sendAddressController!.text.trim() == '@') {
          _sendAddressController!.text = '';
        }
      }
    });

    // Set initial currency format
    _localCurrencyFormat = NumberFormat.currency(
      locale: CurrencyUtil.getLocale(widget.localCurrency!.currency.name)
          .toString(),
      symbol: CurrencyUtil.getCurrencySymbol(
        widget.localCurrency!.currency.name,
      ),
    );
    // Set quick send amount
    if (quickSendAmount != null) {
      _sendAmountController!.text =
          NumberUtil.getRawAsUsableString(quickSendAmount!).replaceAll(',', '');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    // The main column that holds everything
    return TapOutsideUnfocus(
      child: SafeArea(
        minimum:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
        child: Column(
          children: <Widget>[
            SheetHeader(
              title: widget.title ?? AppLocalization.of(context)!.send,
              widgetBeforeTitle: const NetworkIndicator(),
              widgetAfterTitle: BalanceIndicatorWidget(
                primaryCurrency: widget.primaryCurrency,
                onPrimaryCurrencySelected: (value) {
                  setState(() {
                    primaryCurrencySelected = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Stack(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        _sendAddressFocusNode!.unfocus();
                        _sendAmountFocusNode!.unfocus();
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
                            const SizedBox(height: 25),
                            Column(
                              children: <Widget>[
                                if (widget.accountToken == null ||
                                    (widget.accountToken != null &&
                                        widget.accountToken!
                                                .tokenInformations !=
                                            null &&
                                        widget.accountToken!.tokenInformations!
                                                .type ==
                                            'fungible'))
                                  getEnterAmountContainer(),
                                Container(
                                  alignment: AlignmentDirectional.center,
                                  margin: const EdgeInsets.only(top: 3),
                                  child: Text(
                                    _amountValidationText,
                                    style: AppStyles.textStyleSize14W600Primary(
                                      context,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topCenter,
                                  child: getEnterAddressContainer(),
                                ),
                                Container(
                                  alignment: AlignmentDirectional.center,
                                  margin: const EdgeInsets.only(
                                    left: 50,
                                    right: 40,
                                    top: 3,
                                  ),
                                  child: Text(
                                    _addressValidationText,
                                    style: AppStyles.textStyleSize14W600Primary(
                                      context,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                  ),
                                  child: feeEstimation > 0
                                      ? Text(
                                          '+ ${AppLocalization.of(context)!.estimatedFees}: $feeEstimation ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()}',
                                          style: AppStyles
                                              .textStyleSize14W100Primary(
                                            context,
                                          ),
                                        )
                                      : Text(
                                          AppLocalization.of(context)!
                                              .estimatedFeesNote,
                                          style: AppStyles
                                              .textStyleSize14W100Primary(
                                            context,
                                          ),
                                        ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                  ),
                                  child: feeEstimation > 0
                                      ? Text(
                                          '(${CurrencyUtil.convertAmountFormatedWithNumberOfDigits(StateContainer.of(context).curCurrency.currency.name, StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!.balance!.tokenPrice!.amount!, feeEstimation, 8)})',
                                          style: AppStyles
                                              .textStyleSize14W100Primary(
                                            context,
                                          ),
                                        )
                                      : const SizedBox(),
                                ),
                                const SizedBox(height: 10),
                                getEnterMessage(),
                                Container(
                                  alignment: AlignmentDirectional.center,
                                  margin: const EdgeInsets.only(
                                    left: 50,
                                    right: 40,
                                    top: 3,
                                  ),
                                  child: Text(
                                    _messageValidationText,
                                    style: AppStyles.textStyleSize14W600Primary(
                                      context,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      _isPressed == true
                          ? AppButton.buildAppButton(
                              const Key('send'),
                              context,
                              AppButtonType.primaryOutline,
                              widget.actionButtonTitle ??
                                  AppLocalization.of(context)!.send,
                              Dimens.buttonTopDimens,
                              onPressed: () {},
                            )
                          : AppButton.buildAppButton(
                              const Key('send'),
                              context,
                              AppButtonType.primary,
                              widget.actionButtonTitle ??
                                  AppLocalization.of(context)!.send,
                              Dimens.buttonTopDimens,
                              onPressed: () async {
                                setState(() {
                                  _isPressed = true;
                                });
                                validRequest = await _validateRequest();
                                if (validRequest) {
                                  Sheets.showAppHeightNineSheet(
                                    onDisposed: () {
                                      if (mounted) {
                                        setState(() {
                                          _isPressed = false;
                                        });
                                      }
                                    },
                                    context: context,
                                    widget: TransferConfirmSheet(
                                      lastAddress: StateContainer.of(context)
                                          .appWallet!
                                          .appKeychain!
                                          .getAccountSelected()!
                                          .lastAddress,
                                      ucoTransferList: ucoTransferList,
                                      tokenTransferList: tokenTransferList,
                                      title: widget.title,
                                      typeTransfer: widget.accountToken == null
                                          ? 'UCO'
                                          : 'TOKEN',
                                      feeEstimation: feeEstimation,
                                      message: _messageController!.text.trim(),
                                      symbol: widget.accountToken == null
                                          ? null
                                          : widget.accountToken!
                                              .tokenInformations!.symbol!,
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
            ),
          ],
        ),
      ),
    );
  }

  // Determine if this is a max send or not by comparing balances
  bool _isMaxSend() {
    if (_sendAmountController!.text.isEmpty) {
      return false;
    }
    try {
      final amount = _rawAmount == null
          ? _sendAmountController!.text
          : NumberUtil.getRawAsUsableString(_rawAmount!);
      final balanceRaw = StateContainer.of(context)
          .appWallet!
          .appKeychain!
          .getAccountSelected()!
          .balance!
          .nativeTokenValue!;
      if (primaryCurrencySelected == PrimaryCurrency.native) {
        if (double.tryParse(amount)! + feeEstimation == balanceRaw) {
          return true;
        } else {
          return false;
        }
      } else {
        if (priceConverted + feeEstimation ==
            StateContainer.of(context)
                .appWallet!
                .appKeychain!
                .getAccountSelected()!
                .balance!
                .fiatCurrencyValue) {
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      return false;
    }
  }

  /// Validate form data to see if valid
  /// @returns true if valid, false otherwise
  Future<bool> _validateRequest() async {
    var isValid = true;
    final ucoTransfer = UCOTransferWallet();
    final tokenTransfer = TokenTransferWallet();
    setState(() {
      _sendAmountFocusNode!.unfocus();
      _sendAddressFocusNode!.unfocus();
      _addressValidationText = '';
      _messageValidationText = '';
      _amountValidationText = '';
    });
    // Validate amount
    if (_sendAmountController!.text.trim().isEmpty) {
      isValid = false;
      setState(() {
        _amountValidationText = AppLocalization.of(context)!.amountMissing;
      });
    } else {
      if (double.tryParse(_sendAmountController!.text)! <= 0) {
        isValid = false;
        setState(() {
          _amountValidationText = AppLocalization.of(context)!.amountZero;
        });
      } else {
        // Estimation of fees
        feeEstimation = await getFee();

        final amount = _rawAmount == null
            ? _sendAmountController!.text
            : NumberUtil.getRawAsUsableString(_rawAmount!);
        var balanceRaw = 0.0;
        var sendAmount = 0.0;
        if (widget.accountToken == null) {
          balanceRaw = StateContainer.of(context)
              .appWallet!
              .appKeychain!
              .getAccountSelected()!
              .balance!
              .nativeTokenValue!;

          if (primaryCurrencySelected == PrimaryCurrency.native) {
            sendAmount = double.tryParse(amount)!;
          } else {
            sendAmount = priceConverted;
          }
          if (sendAmount + feeEstimation > balanceRaw) {
            isValid = false;
            setState(() {
              _amountValidationText =
                  AppLocalization.of(context)!.insufficientBalance.replaceAll(
                        '%1',
                        StateContainer.of(context)
                            .curNetwork
                            .getNetworkCryptoCurrencyLabel(),
                      );
            });
          } else {
            ucoTransfer.amount = toBigInt(sendAmount);
          }
        } else {
          balanceRaw = widget.accountToken!.amount!;
          sendAmount = double.tryParse(amount)!;
          if (sendAmount > balanceRaw) {
            isValid = false;
            setState(() {
              _amountValidationText =
                  AppLocalization.of(context)!.insufficientBalance.replaceAll(
                        '%1',
                        widget.accountToken!.tokenInformations!.symbol!,
                      );
            });
          } else {
            if (feeEstimation >
                StateContainer.of(context)
                    .appWallet!
                    .appKeychain!
                    .getAccountSelected()!
                    .balance!
                    .nativeTokenValue!) {
              isValid = false;
              setState(() {
                _amountValidationText =
                    AppLocalization.of(context)!.insufficientBalance.replaceAll(
                          '%1',
                          StateContainer.of(context)
                              .curNetwork
                              .getNetworkCryptoCurrencyLabel(),
                        );
              });
            } else {
              tokenTransfer.amount = toBigInt(sendAmount);
            }
          }
        }
      }
    }
    // Validate address
    final isContact = _sendAddressController!.text.startsWith('@');
    Contact? contact;
    if (_sendAddressController!.text.trim().isEmpty) {
      isValid = false;
      setState(() {
        _addressValidationText = AppLocalization.of(context)!.addressMissing;
        _qrCodeButtonVisible = true;
      });
    } else if (!isContact && !Address(_sendAddressController!.text).isValid()) {
      isValid = false;
      setState(() {
        _addressValidationText = AppLocalization.of(context)!.invalidAddress;
        _qrCodeButtonVisible = true;
      });
    } else if (!isContact) {
      try {
        contact = await sl
            .get<DBHelper>()
            .getContactWithAddress(_sendAddressController!.text);
        // ignore: empty_catches
      } catch (e) {}

      setState(() {
        _addressValidationText = '';
        _qrCodeButtonVisible = false;
      });
      _sendAddressFocusNode!.unfocus();
    } else {
      // Get contact info
      try {
        contact = await sl
            .get<DBHelper>()
            .getContactWithName(_sendAddressController!.text);
      } catch (e) {
        isValid = false;
        setState(() {
          _addressValidationText = AppLocalization.of(context)!.contactInvalid;
          _qrCodeButtonVisible = true;
        });
      }
    }

    if (isValid) {
      ucoTransferList.clear();
      tokenTransferList.clear();

      var lastAddressRecipient = '';
      if (widget.accountToken == null) {
        if (contact != null) {
          ucoTransfer.toContactName = contact.name;
          ucoTransfer.to = contact.address;
        } else {
          ucoTransfer.to = _sendAddressController!.text.trim();
        }

        lastAddressRecipient = await sl
            .get<AddressService>()
            .lastAddressFromAddress(ucoTransfer.to!);
        if (lastAddressRecipient == '') {
          lastAddressRecipient = ucoTransfer.to!;
        }
      } else {
        if (contact != null) {
          tokenTransfer.toContactName = contact.name;
          tokenTransfer.to = contact.address;
        } else {
          tokenTransfer.to = _sendAddressController!.text.trim();
        }
        //
        lastAddressRecipient = await sl
            .get<AddressService>()
            .lastAddressFromAddress(tokenTransfer.to!);
        if (lastAddressRecipient == '') {
          lastAddressRecipient = tokenTransfer.to!;
        }
      }

      if (lastAddressRecipient ==
          StateContainer.of(context)
              .appWallet!
              .appKeychain!
              .getAccountSelected()!
              .lastAddress!) {
        isValid = false;
        if (widget.accountToken == null) {
          _addressValidationText =
              AppLocalization.of(context)!.sendToMeError.replaceAll(
                    '%1',
                    StateContainer.of(context)
                        .curNetwork
                        .getNetworkCryptoCurrencyLabel(),
                  );
        } else {
          _addressValidationText =
              AppLocalization.of(context)!.sendToMeError.replaceAll(
                    '%1',
                    widget.accountToken!.tokenInformations!.symbol!,
                  );
        }
        setState(() {
          _qrCodeButtonVisible = true;
        });
      } else {
        if (widget.accountToken == null) {
          ucoTransferList.add(ucoTransfer);
        } else {
          tokenTransfer.tokenAddress =
              widget.accountToken!.tokenInformations!.address;
          // TODO(redDwarf03): Warning about collection
          if (widget.accountToken!.tokenInformations!.type == 'fungible') {
            tokenTransfer.tokenId = 0;
          } else {
            tokenTransfer.tokenId = 1;
          }

          tokenTransferList.add(tokenTransfer);
        }
      }
    }
    return isValid;
  }

  Widget getEnterAmountContainer() {
    return Column(
      children: [
        AppTextField(
          focusNode: _sendAmountFocusNode,
          controller: _sendAmountController,
          cursorColor: StateContainer.of(context).curTheme.text,
          style: AppStyles.textStyleSize16W700Primary(context),
          inputFormatters: [
            LengthLimitingTextInputFormatter(16),
            CurrencyFormatter(
              maxDecimalDigits: widget.primaryCurrency!.primaryCurrency.name ==
                      PrimaryCurrencySetting(AvailablePrimaryCurrency.native)
                          .primaryCurrency
                          .name
                  ? 8
                  : _localCurrencyFormat.decimalDigits!,
            ),
            LocalCurrencyFormatter(
              active: false,
              currencyFormat: _localCurrencyFormat,
            ),
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,8}')),
          ],
          onChanged: (String text) async {
            final amount = double.tryParse(text);
            if (amount != null && amount > 0) {
              final fee = await getFee();
              // Always reset the error message to be less annoying
              setState(() {
                feeEstimation = fee;
                _amountValidationText = '';
                // Reset the raw amount
                _rawAmount = null;
              });
            } else {
              setState(() {
                feeEstimation = 0;
                _amountValidationText = '';
                // Reset the raw amount
                _rawAmount = null;
              });
            }
          },
          textInputAction: TextInputAction.next,
          maxLines: null,
          autocorrect: false,
          labelText: widget.accountToken == null
              ? primaryCurrencySelected == PrimaryCurrency.native
                  ? '${AppLocalization.of(context)!.enterAmount} (${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()})'
                  : '${AppLocalization.of(context)!.enterAmount} (${StateContainer.of(context).curCurrency.currency.name})'
              : '${AppLocalization.of(context)!.enterAmount} (${widget.accountToken!.tokenInformations!.symbol})',
          suffixButton: TextFieldButton(
            icon: FontAwesomeIcons.anglesUp,
            onPressed: () async {
              sl.get<HapticUtil>().feedback(
                    FeedbackType.light,
                    StateContainer.of(context).activeVibrations,
                  );
              final fee = await getFee(maxSend: true);

              var sendAmount = 0.0;
              if (primaryCurrencySelected == PrimaryCurrency.native) {
                sendAmount = StateContainer.of(context)
                        .appWallet!
                        .appKeychain!
                        .getAccountSelected()!
                        .balance!
                        .nativeTokenValue! -
                    fee;
                _sendAmountController!.text = sendAmount.toStringAsFixed(8);
              } else {
                final selectedCurrencyFee = StateContainer.of(context)
                        .appWallet!
                        .appKeychain!
                        .getAccountSelected()!
                        .balance!
                        .tokenPrice!
                        .amount! *
                    fee;
                sendAmount = StateContainer.of(context)
                        .appWallet!
                        .appKeychain!
                        .getAccountSelected()!
                        .balance!
                        .fiatCurrencyValue! -
                    selectedCurrencyFee;
                _sendAmountController!.text = sendAmount
                    .toStringAsFixed(_localCurrencyFormat.decimalDigits!);
              }

              setState(() {
                feeEstimation = fee;
                _amountValidationText = '';
                // Reset the raw amount
                _rawAmount = null;
              });
              if (_isMaxSend()) {
                return;
              }

              feeEstimation = await getFee();
              _sendAddressController!.selection = TextSelection.fromPosition(
                TextPosition(offset: _sendAddressController!.text.length),
              );
            },
          ),
          fadeSuffixOnCondition: true,
          suffixShowFirstCondition:
              widget.accountToken == null && !_isMaxSend(),
          keyboardType: const TextInputType.numberWithOptions(
            signed: true,
            decimal: true,
          ),
          onSubmitted: (String text) {
            FocusScope.of(context).unfocus();
            if (!Address(_sendAddressController!.text).isValid()) {
              FocusScope.of(context).requestFocus(_sendAddressFocusNode);
            }
          },
        ),
        widget.accountToken == null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 40),
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      '1 ${StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!.balance!.nativeTokenName!} = ${CurrencyUtil.getAmountPlusSymbol(StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!.balance!.fiatCurrencyCode!, StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!.balance!.tokenPrice!.amount!)}',
                      style: AppStyles.textStyleSize14W100Primary(context),
                    ),
                  ),
                  _sendAmountController!.text.isNotEmpty
                      ? Container(
                          margin: const EdgeInsets.only(right: 40),
                          alignment: Alignment.centerRight,
                          child: primaryCurrencySelected ==
                                  PrimaryCurrency.native
                              ? Text(
                                  '= ${_convertNetworkCurrencyToSelectedCurrency()}',
                                  textAlign: TextAlign.right,
                                  style: AppStyles.textStyleSize14W100Primary(
                                    context,
                                  ),
                                )
                              : Text(
                                  '= ${_convertSelectedCurrencyToNetworkCurrency()}',
                                  textAlign: TextAlign.right,
                                  style: AppStyles.textStyleSize14W100Primary(
                                    context,
                                  ),
                                ),
                        )
                      : const SizedBox(),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 40),
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      '${NumberUtil.formatThousands(widget.accountToken!.amount!)} ${widget.accountToken!.tokenInformations!.symbol}',
                      style: AppStyles.textStyleSize14W100Primary(context),
                    ),
                  ),
                ],
              )
      ],
    );
  }

  AppTextField getEnterMessage() {
    return AppTextField(
      focusNode: _messageFocusNode,
      controller: _messageController,
      maxLines: 4,
      labelText:
          '${AppLocalization.of(context)!.sendMessageHeader} (${_messageController!.text.length}/200)',
      onChanged: (String text) async {
        final fee = await getFee();
        setState(() {
          feeEstimation = fee;
        });
      },
      keyboardType: TextInputType.text,
      textAlign: TextAlign.left,
      style: AppStyles.textStyleSize16W600Primary(context),
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(200),
      ],
    );
  }

  AppTextField getEnterAddressContainer() {
    return AppTextField(
      padding: _addressValidAndUnfocused
          ? const EdgeInsets.symmetric(horizontal: 25, vertical: 15)
          : EdgeInsets.zero,
      focusNode: _sendAddressFocusNode,
      controller: _sendAddressController,
      cursorColor: StateContainer.of(context).curTheme.text,
      inputFormatters: <LengthLimitingTextInputFormatter>[
        if (_isContact)
          LengthLimitingTextInputFormatter(20)
        else
          LengthLimitingTextInputFormatter(68),
      ],
      textInputAction: TextInputAction.done,
      maxLines: null,
      autocorrect: false,
      labelText: AppLocalization.of(context)!.enterAddress,
      prefixButton: TextFieldButton(
        icon: FontAwesomeIcons.at,
        onPressed: () async {
          sl.get<HapticUtil>().feedback(
                FeedbackType.light,
                StateContainer.of(context).activeVibrations,
              );

          final contact = await ContactsDialog.getDialog(context);
          if (contact != null && contact.name != null) {
            _sendAddressController!.text = contact.name!;
            _sendAddressStyle = AddressStyle.text90;
            final fee = await getFee();
            setState(() {
              feeEstimation = fee;
            });
          }
        },
      ),
      fadePrefixOnCondition: true,
      prefixShowFirstCondition: true,
      suffixButton: kIsWeb == false && (Platform.isIOS || Platform.isAndroid)
          ? TextFieldButton(
              icon: FontAwesomeIcons.qrcode,
              onPressed: () async {
                if (!_qrCodeButtonVisible) {
                  return;
                }
                sl.get<HapticUtil>().feedback(
                      FeedbackType.light,
                      StateContainer.of(context).activeVibrations,
                    );
                UIUtil.cancelLockEvent();
                final scanResult =
                    await UserDataUtil.getQRData(DataType.address, context);
                if (scanResult == null) {
                  UIUtil.showSnackbar(
                    AppLocalization.of(context)!.qrInvalidAddress,
                    context,
                    StateContainer.of(context).curTheme.text!,
                    StateContainer.of(context).curTheme.snackBarShadow!,
                  );
                } else if (QRScanErrs.errorList.contains(scanResult)) {
                  UIUtil.showSnackbar(
                    scanResult,
                    context,
                    StateContainer.of(context).curTheme.text!,
                    StateContainer.of(context).curTheme.snackBarShadow!,
                  );
                  return;
                } else {
                  // Is a URI
                  final address = Address(scanResult);
                  // See if this address belongs to a contact
                  final Contact? contact;

                  contact = await sl
                      .get<DBHelper>()
                      .getContactWithAddress(address.address);

                  if (contact != null) {
                    setState(() {
                      _isContact = true;
                      _addressValidationText = '';
                      _sendAddressStyle = AddressStyle.primary;
                      _qrCodeButtonVisible = false;
                    });
                    if (contact.name != null) {
                      _sendAddressController!.text = contact.name!;
                    }
                  } else {
                    setState(() {
                      _isContact = false;
                      _addressValidationText = '';
                      _sendAddressStyle = AddressStyle.text90;
                      _qrCodeButtonVisible = false;
                    });
                    _sendAddressController!.text = address.address;
                    _sendAddressFocusNode!.unfocus();
                    setState(() {
                      _addressValidAndUnfocused = true;
                    });
                  }
                }
              },
            )
          : null,
      fadeSuffixOnCondition: true,
      suffixShowFirstCondition: _qrCodeButtonVisible,
      style: _sendAddressStyle == AddressStyle.text60
          ? AppStyles.textStyleSize14W700Text60(context)
          : _sendAddressStyle == AddressStyle.text90
              ? AppStyles.textStyleSize14W700Primary(context)
              : AppStyles.textStyleSize14W700Primary(context),
      onChanged: (String text) async {
        final fee = await getFee();
        if (text.isNotEmpty) {
          setState(() {
            feeEstimation = fee;
          });
        } else {
          setState(() {
            feeEstimation = fee;
          });
        }
        final isContact = text.startsWith('@');
        // Switch to contact mode if starts with @
        if (isContact) {
          setState(() {
            _isContact = true;
          });
          sl
              .get<DBHelper>()
              .getContactsWithNameLike(text)
              .then((List<Contact> matchedList) {});
        } else {
          setState(() {
            _isContact = false;
          });
        }
        // Always reset the error message to be less annoying
        setState(() {
          _addressValidationText = '';
        });
        if (!isContact && Address(text).isValid()) {
          //_sendAddressFocusNode.unfocus();
          setState(() {
            _sendAddressStyle = AddressStyle.text90;
            _addressValidationText = '';
            _qrCodeButtonVisible = true;
          });
        } else if (!isContact) {
          setState(() {
            _sendAddressStyle = AddressStyle.text60;
            _qrCodeButtonVisible = true;
          });
        } else {
          try {
            await sl.get<DBHelper>().getContactWithName(text);
            setState(() {
              _qrCodeButtonVisible = false;
              _addressValidationText = '';
              _sendAddressStyle = AddressStyle.primary;
            });
          } on Exception {
            setState(() {
              _sendAddressStyle = AddressStyle.text60;
            });
          }
        }
      },
      overrideTextFieldWidget: _addressValidAndUnfocused
          ? GestureDetector(
              onTap: () {
                setState(() {
                  _addressValidAndUnfocused = false;
                  _addressValidationText = '';
                });
                Future<void>.delayed(const Duration(milliseconds: 50), () {
                  FocusScope.of(context).requestFocus(_sendAddressFocusNode);
                });
              },
              child: UIUtil.threeLinetextStyleSmallestW400Text(
                context,
                _sendAddressController!.text,
              ),
            )
          : null,
    );
  }

  Future<double> getFee({bool maxSend = false}) async {
    var fee = 0.0;
    if (double.tryParse(_sendAmountController!.text) == null ||
        double.tryParse(_sendAmountController!.text)! <= 0) {
      return fee;
    }
    final isContact = _sendAddressController!.text.startsWith('@');
    var recipientAddress = '';
    if (_sendAddressController!.text.isEmpty ||
        (!isContact && !isHex(_sendAddressController!.text))) {
      return fee;
    } else {
      if (isContact) {
        try {
          final contact = await sl
              .get<DBHelper>()
              .getContactWithName(_sendAddressController!.text);
          if (contact.address != null) {
            recipientAddress = contact.address!;
          } else {
            return fee;
          }
        } catch (e) {
          return fee;
        }
      } else {
        recipientAddress = _sendAddressController!.text.trim();
      }
    }
    try {
      final seed = await StateContainer.of(context).getSeed();
      final ucoTransferListForFee =
          List<UCOTransferWallet>.empty(growable: true);

      final tokenTransferListForFee =
          List<TokenTransferWallet>.empty(growable: true);
      if (widget.accountToken == null) {
        ucoTransferListForFee.add(
          UCOTransferWallet(
            amount: maxSend
                ? toBigInt(
                    StateContainer.of(context)
                        .appWallet!
                        .appKeychain!
                        .getAccountSelected()!
                        .balance!
                        .nativeTokenValue,
                  )
                : toBigInt(double.tryParse(_sendAmountController!.text)),
            to: recipientAddress,
          ),
        );
      } else {
        tokenTransferListForFee.add(
          TokenTransferWallet(
            amount: maxSend
                ? toBigInt(widget.accountToken!.amount)
                : toBigInt(double.tryParse(_sendAmountController!.text)),
            to: recipientAddress,
            tokenAddress: widget.accountToken!.tokenInformations!.address,
          ),
        );
      }

      final originPrivateKey = sl.get<ApiService>().getOriginKey();
      fee = await sl.get<AppService>().getFeesEstimation(
            originPrivateKey,
            seed!,
            StateContainer.of(context)
                .appWallet!
                .appKeychain!
                .getAccountSelected()!
                .lastAddress!,
            ucoTransferListForFee,
            tokenTransferListForFee,
            _messageController!.text,
            StateContainer.of(context)
                .appWallet!
                .appKeychain!
                .getAccountSelected()!
                .name!,
          );
    } catch (e) {
      fee = 0;
    }
    return fee;
  }

  String _convertSelectedCurrencyToNetworkCurrency() {
    var convertedAmt = _sendAmountController!.text.replaceAll(',', '.');
    convertedAmt = NumberUtil.sanitizeNumber(convertedAmt);
    if (convertedAmt.isEmpty || double.tryParse(convertedAmt) == 0) {
      return '';
    }
    priceConverted = (Decimal.parse(convertedAmt) /
            Decimal.parse(
              StateContainer.of(context)
                  .appWallet!
                  .appKeychain!
                  .getAccountSelected()!
                  .balance!
                  .tokenPrice!
                  .amount!
                  .toString(),
            ))
        .toDouble();
    return '${priceConverted.toStringAsFixed(8)} ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()}';
  }

  String _convertNetworkCurrencyToSelectedCurrency() {
    final convertedAmt = NumberUtil.sanitizeNumber(
      _sendAmountController!.text,
      maxDecimalDigits: _localCurrencyFormat.decimalDigits!,
    );
    if (convertedAmt.isEmpty) {
      return '';
    }
    priceConverted = (Decimal.parse(
              StateContainer.of(context)
                  .appWallet!
                  .appKeychain!
                  .getAccountSelected()!
                  .balance!
                  .tokenPrice!
                  .amount!
                  .toString(),
            ) *
            Decimal.parse(convertedAmt))
        .toDouble();
    return _localCurrencyFormat.format(priceConverted);
  }
}
