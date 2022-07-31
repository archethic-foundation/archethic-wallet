/// SPDX-License-Identifier: AGPL-3.0-or-later
// ignore_for_file: avoid_unnecessary_containers

// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/util/ui_util.dart';
import 'package:aeuniverse/ui/widgets/components/app_text_field.dart';
import 'package:aeuniverse/ui/widgets/components/buttons.dart';
import 'package:aeuniverse/ui/widgets/components/icon_widget.dart';
import 'package:aeuniverse/ui/widgets/components/sheet_util.dart';
import 'package:aeuniverse/ui/widgets/components/tap_outside_unfocus.dart';
import 'package:aeuniverse/ui/widgets/dialogs/contacts_dialog.dart';
import 'package:aeuniverse/util/user_data_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/localization.dart';
import 'package:core/model/address.dart';
import 'package:core/model/available_currency.dart';
import 'package:core/model/data/appdb.dart';
import 'package:core/model/data/contact.dart';
import 'package:core/model/primary_currency.dart';
import 'package:core/service/app_service.dart';
import 'package:core/util/currency_util.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core/util/haptic_util.dart';
import 'package:core/util/number_util.dart';
import 'package:core_ui/ui/util/dimens.dart';
import 'package:core_ui/ui/util/formatters.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:aewallet/model/uco_transfer_wallet.dart';
import 'package:aewallet/ui/views/uco/transfer_confirm_sheet.dart';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart'
    show AddressService, isHex, ApiService;

class TransferUCOSheet extends StatefulWidget {
  const TransferUCOSheet(
      {@required this.localCurrency,
      this.contact,
      this.address,
      this.quickSendAmount,
      this.title,
      this.actionButtonTitle,
      this.primaryCurrency,
      super.key});

  final AvailableCurrency? localCurrency;
  final Contact? contact;
  final String? address;
  final String? quickSendAmount;
  final String? title;
  final String? actionButtonTitle;
  final PrimaryCurrencySetting? primaryCurrency;

  @override
  State<TransferUCOSheet> createState() => _TransferUCOSheetState();
}

enum AddressStyle { text60, text90, primary }

enum PrimaryCurrency { network, selected }

class _TransferUCOSheetState extends State<TransferUCOSheet> {
  FocusNode? _sendAddressFocusNode;
  TextEditingController? _sendAddressController;
  FocusNode? _sendAmountFocusNode;
  TextEditingController? _sendAmountController;
  FocusNode? _messageFocusNode;
  TextEditingController? _messageController;

  AddressStyle? _sendAddressStyle;
  String? _amountValidationText = '';
  String? _addressValidationText = '';
  String? _messageValidationText = '';
  String? quickSendAmount;
  bool _addressValidAndUnfocused = false;
  bool _isContact = false;
  bool _qrCodeButtonVisible = true;
  NumberFormat? _localCurrencyFormat;
  String? _rawAmount;
  bool validRequest = true;
  double feeEstimation = 0.0;
  bool? _isPressed;
  PrimaryCurrency primaryCurrency = PrimaryCurrency.network;
  double priceConverted = 0.0;

  List<UCOTransferWallet> ucoTransferList =
      List<UCOTransferWallet>.empty(growable: true);

  @override
  void initState() {
    super.initState();
    if (widget.primaryCurrency!.primaryCurrency.name ==
        PrimaryCurrencySetting(AvailablePrimaryCurrency.NATIVE)
            .primaryCurrency
            .name) {
      primaryCurrency = PrimaryCurrency.network;
    } else {
      primaryCurrency = PrimaryCurrency.selected;
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
            TextPosition(offset: _sendAddressController!.text.length));
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
        locale:
            CurrencyUtil.getLocale(widget.localCurrency!.toString()).toString(),
        symbol:
            CurrencyUtil.getCurrencySymbol(widget.localCurrency!.toString()));
    // Set quick send amount
    if (quickSendAmount != null) {
      _sendAmountController!.text =
          NumberUtil.getRawAsUsableString(quickSendAmount!).replaceAll(',', '');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double bottom = MediaQuery.of(context).viewInsets.bottom;
    // The main column that holds everything
    return TapOutsideUnfocus(
      child: SafeArea(
        minimum:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  width: 60,
                ),
                Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: 5,
                      width: MediaQuery.of(context).size.width * 0.15,
                      decoration: BoxDecoration(
                        color: StateContainer.of(context).curTheme.text60,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15.0),
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width - 140),
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: [
                              SvgPicture.asset(
                                '${StateContainer.of(context).curTheme.assetsFolder!}${StateContainer.of(context).curTheme.logoAlone!}.svg',
                                height: 30,
                              ),
                              Text(
                                  StateContainer.of(context)
                                      .curNetwork
                                      .getDisplayName(context),
                                  style: AppStyles.textStyleSize10W100Primary(
                                      context)),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ), // Header
                          AutoSizeText(
                            widget.title ?? AppLocalization.of(context)!.send,
                            style: AppStyles.textStyleSize24W700EquinoxPrimary(
                                context),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            stepGranularity: 0.1,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          StateContainer.of(context).showBalance
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    primaryCurrency == PrimaryCurrency.selected
                                        ? Column(
                                            children: [
                                              _balanceSelected(context, true),
                                              _balanceNetwork(context, false),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              _balanceNetwork(context, true),
                                              _balanceSelected(context, false),
                                            ],
                                          ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.change_circle),
                                      alignment: Alignment.centerRight,
                                      color: StateContainer.of(context)
                                          .curTheme
                                          .textFieldIcon,
                                      onPressed: () {
                                        sl.get<HapticUtil>().feedback(
                                            FeedbackType.light,
                                            StateContainer.of(context)
                                                .activeVibrations);
                                        _sendAmountController!.text = '';
                                        if (primaryCurrency ==
                                            PrimaryCurrency.network) {
                                          setState(() {
                                            primaryCurrency =
                                                PrimaryCurrency.selected;
                                          });
                                        } else {
                                          setState(() {
                                            primaryCurrency =
                                                PrimaryCurrency.network;
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),
                if (kIsWeb || Platform.isMacOS || Platform.isWindows)
                  Stack(
                    children: <Widget>[
                      const SizedBox(
                        width: 60,
                        height: 40,
                      ),
                      Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Column(
                                children: <Widget>[
                                  buildIconDataWidget(
                                      context, Icons.close_outlined, 30, 30),
                                ],
                              ))),
                    ],
                  )
                else
                  const SizedBox(
                    width: 60,
                    height: 40,
                  ),
              ],
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
                                getEnterAmountContainer(),
                                Container(
                                  alignment: const AlignmentDirectional(0, 0),
                                  margin: const EdgeInsets.only(top: 3),
                                  child: Text(_amountValidationText!,
                                      style:
                                          AppStyles.textStyleSize14W600Primary(
                                              context)),
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
                                  alignment: const AlignmentDirectional(0, 0),
                                  margin: const EdgeInsets.only(
                                      left: 50, right: 40, top: 3),
                                  child: Text(_addressValidationText!,
                                      style:
                                          AppStyles.textStyleSize14W600Primary(
                                              context)),
                                ),
                                const SizedBox(height: 10),
                                getEnterMessage(),
                                Container(
                                  alignment: const AlignmentDirectional(0, 0),
                                  margin: const EdgeInsets.only(
                                      left: 50, right: 40, top: 3),
                                  child: Text(_messageValidationText!,
                                      style:
                                          AppStyles.textStyleSize14W600Primary(
                                              context)),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  child: feeEstimation > 0
                                      ? Text(
                                          '+ ${AppLocalization.of(context)!.estimatedFees}: $feeEstimation ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()}',
                                          style: AppStyles
                                              .textStyleSize14W100Primary(
                                                  context),
                                        )
                                      : Text(
                                          AppLocalization.of(context)!
                                              .estimatedFeesNote,
                                          style: AppStyles
                                              .textStyleSize14W100Primary(
                                                  context)),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  child: feeEstimation > 0
                                      ? Text(
                                          '(${CurrencyUtil.convertAmountFormatedWithNumberOfDigits(StateContainer.of(context).curCurrency.currency.name, StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!.balance!.tokenPrice!.amount!, feeEstimation, 8)})',
                                          style: AppStyles
                                              .textStyleSize14W100Primary(
                                                  context),
                                        )
                                      : const SizedBox(),
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
                                          .lastAddress!,
                                      ucoTransferList: ucoTransferList,
                                      title: widget.title,
                                      typeTransfer: 'UCO',
                                      feeEstimation: feeEstimation,
                                      message: _messageController!.text.trim(),
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
      final String amount = _rawAmount == null
          ? _sendAmountController!.text
          : NumberUtil.getRawAsUsableString(_rawAmount!);
      final double balanceRaw = StateContainer.of(context)
          .appWallet!
          .appKeychain!
          .getAccountSelected()!
          .balance!
          .nativeTokenValue!;
      if (primaryCurrency == PrimaryCurrency.network) {
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

  Widget _balanceNetwork(BuildContext context, bool primary) {
    return Container(
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          text: '',
          children: <InlineSpan>[
            TextSpan(
              text: '(',
              style: primary
                  ? AppStyles.textStyleSize16W100Primary(context)
                  : AppStyles.textStyleSize14W100Primary(context),
            ),
            TextSpan(
              text:
                  '${StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!.balance!.nativeTokenValueToString()} ${StateContainer.of(context).appWallet!.appKeychain!.getAccountSelected()!.balance!.nativeTokenName!}',
              style: primary
                  ? AppStyles.textStyleSize16W700Primary(context)
                  : AppStyles.textStyleSize14W700Primary(context),
            ),
            TextSpan(
              text: ')',
              style: primary
                  ? AppStyles.textStyleSize16W100Primary(context)
                  : AppStyles.textStyleSize14W100Primary(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _balanceSelected(BuildContext context, bool primary) {
    return Container(
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          text: '',
          children: <InlineSpan>[
            TextSpan(
              text: '(',
              style: primary
                  ? AppStyles.textStyleSize16W100Primary(context)
                  : AppStyles.textStyleSize14W100Primary(context),
            ),
            TextSpan(
              text: CurrencyUtil.getConvertedAmount(
                  StateContainer.of(context).curCurrency.currency.name,
                  StateContainer.of(context)
                      .appWallet!
                      .appKeychain!
                      .getAccountSelected()!
                      .balance!
                      .fiatCurrencyValue!),
              style: primary
                  ? AppStyles.textStyleSize16W700Primary(context)
                  : AppStyles.textStyleSize14W700Primary(context),
            ),
            TextSpan(
              text: ')',
              style: primary
                  ? AppStyles.textStyleSize16W100Primary(context)
                  : AppStyles.textStyleSize14W100Primary(context),
            ),
          ],
        ),
      ),
    );
  }

  /// Validate form data to see if valid
  /// @returns true if valid, false otherwise
  Future<bool> _validateRequest() async {
    bool isValid = true;
    UCOTransferWallet ucoTransfer = UCOTransferWallet();
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
      if (double.tryParse((_sendAmountController!.text))! <= 0) {
        isValid = false;
        setState(() {
          _amountValidationText = AppLocalization.of(context)!.amountZero;
        });
      } else {
        // Estimation of fees
        feeEstimation = await getFee();

        final String amount = _rawAmount == null
            ? _sendAmountController!.text
            : NumberUtil.getRawAsUsableString(_rawAmount!);
        final double balanceRaw = StateContainer.of(context)
            .appWallet!
            .appKeychain!
            .getAccountSelected()!
            .balance!
            .nativeTokenValue!;
        double sendAmount = 0;
        if (primaryCurrency == PrimaryCurrency.network) {
          sendAmount = double.tryParse(amount)!;
        } else {
          sendAmount = priceConverted;
        }
        if (sendAmount + feeEstimation > balanceRaw) {
          isValid = false;
          setState(() {
            _amountValidationText = AppLocalization.of(context)!
                .insufficientBalance
                .replaceAll(
                    '%1',
                    StateContainer.of(context)
                        .curNetwork
                        .getNetworkCryptoCurrencyLabel());
          });
        } else {
          ucoTransfer.amount = BigInt.from(sendAmount * 100000000);
        }
      }
    }
    // Validate address
    final bool isContact = _sendAddressController!.text.startsWith('@');
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
      if (contact != null) {
        ucoTransfer.toContactName = contact.name!;
        ucoTransfer.to = contact.address!;
      } else {
        ucoTransfer.to = _sendAddressController!.text.trim();
      }
      //
      String lastAddressRecipient = await sl
          .get<AddressService>()
          .lastAddressFromAddress(ucoTransfer.to!);
      if (lastAddressRecipient == '') {
        lastAddressRecipient = ucoTransfer.to!;
      }
      if (lastAddressRecipient ==
          StateContainer.of(context)
              .appWallet!
              .appKeychain!
              .getAccountSelected()!
              .lastAddress!) {
        isValid = false;
        setState(() {
          _addressValidationText = AppLocalization.of(context)!
              .sendToMeError
              .replaceAll(
                  '%1',
                  StateContainer.of(context)
                      .curNetwork
                      .getNetworkCryptoCurrencyLabel());
          _qrCodeButtonVisible = true;
        });
      } else {
        ucoTransferList.add(ucoTransfer);
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
                maxDecimalDigits: primaryCurrency == PrimaryCurrency.network
                    ? 8
                    : _localCurrencyFormat!.decimalDigits!),
            LocalCurrencyFormatter(
                active: false, currencyFormat: _localCurrencyFormat!),
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,8}')),
          ],
          onChanged: (String text) async {
            double? amount = double.tryParse(text);
            if (amount != null && amount > 0) {
              double fee = await getFee();
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
          labelText: primaryCurrency == PrimaryCurrency.network
              ? '${AppLocalization.of(context)!.enterAmount} (${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()})'
              : '${AppLocalization.of(context)!.enterAmount} (${StateContainer.of(context).curCurrency.currency.name})',
          suffixButton: TextFieldButton(
            icon: FontAwesomeIcons.anglesUp,
            onPressed: () async {
              sl.get<HapticUtil>().feedback(FeedbackType.light,
                  StateContainer.of(context).activeVibrations);
              double fee = await getFee(maxSend: true);

              double sendAmount = 0;
              if (primaryCurrency == PrimaryCurrency.network) {
                sendAmount = StateContainer.of(context)
                        .appWallet!
                        .appKeychain!
                        .getAccountSelected()!
                        .balance!
                        .nativeTokenValue! -
                    fee;
                _sendAmountController!.text = sendAmount.toStringAsFixed(8);
              } else {
                double selectedCurrencyFee = StateContainer.of(context)
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
                    .toStringAsFixed(_localCurrencyFormat!.decimalDigits!);
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
                  TextPosition(offset: _sendAddressController!.text.length));
            },
          ),
          fadeSuffixOnCondition: true,
          suffixShowFirstCondition: !_isMaxSend(),
          keyboardType: const TextInputType.numberWithOptions(
              signed: true, decimal: true),
          textAlign: TextAlign.center,
          onSubmitted: (String text) {
            FocusScope.of(context).unfocus();
            if (!Address(_sendAddressController!.text).isValid()) {
              FocusScope.of(context).requestFocus(_sendAddressFocusNode);
            }
          },
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
                  child: primaryCurrency == PrimaryCurrency.network
                      ? Text('= ${_convertNetworkCurrencyToSelectedCurrency()}',
                          textAlign: TextAlign.right,
                          style: AppStyles.textStyleSize14W100Primary(context))
                      : Text('= ${_convertSelectedCurrencyToNetworkCurrency()}',
                          textAlign: TextAlign.right,
                          style: AppStyles.textStyleSize14W100Primary(context)),
                )
              : const SizedBox(),
        ]),
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
      onChanged: (String text) {
        setState(() {});
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
            ? const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0)
            : EdgeInsets.zero,
        textAlign: TextAlign.center,
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
            sl.get<HapticUtil>().feedback(FeedbackType.light,
                StateContainer.of(context).activeVibrations);

            Contact? contact = await ContactsDialog.getDialog(context);
            if (contact != null && contact.name != null) {
              _sendAddressController!.text = contact.name!;
              _sendAddressStyle = AddressStyle.text90;
              double fee = await getFee();
              setState(() {
                feeEstimation = fee;
              });
            }
          },
        ),
        fadePrefixOnCondition: true,
        prefixShowFirstCondition: true,
        suffixButton: TextFieldButton(
          icon: FontAwesomeIcons.qrcode,
          onPressed: () async {
            if (!_qrCodeButtonVisible) {
              return;
            }
            sl.get<HapticUtil>().feedback(FeedbackType.light,
                StateContainer.of(context).activeVibrations);
            UIUtil.cancelLockEvent();
            final String? scanResult =
                await UserDataUtil.getQRData(DataType.address, context);
            QRScanErrs.errorList;
            if (scanResult == null) {
              UIUtil.showSnackbar(
                  AppLocalization.of(context)!.qrInvalidAddress,
                  context,
                  StateContainer.of(context).curTheme.text!,
                  StateContainer.of(context).curTheme.snackBarShadow!);
            } else if (QRScanErrs.errorList.contains(scanResult)) {
              UIUtil.showSnackbar(
                  scanResult,
                  context,
                  StateContainer.of(context).curTheme.text!,
                  StateContainer.of(context).curTheme.snackBarShadow!);
              return;
            } else {
              // Is a URI
              final Address address = Address(scanResult);
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
        ),
        fadeSuffixOnCondition: true,
        suffixShowFirstCondition: _qrCodeButtonVisible,
        style: _sendAddressStyle == AddressStyle.text60
            ? AppStyles.textStyleSize14W700Text60(context)
            : _sendAddressStyle == AddressStyle.text90
                ? AppStyles.textStyleSize14W700Primary(context)
                : AppStyles.textStyleSize14W700Primary(context),
        onChanged: (String text) async {
          double fee = await getFee();
          if (text.isNotEmpty) {
            setState(() {
              feeEstimation = fee;
            });
          } else {
            setState(() {
              feeEstimation = fee;
            });
          }
          final bool isContact = text.startsWith('@');
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
                    context, _sendAddressController!.text))
            : null);
  }

  Future<double> getFee({maxSend = false}) async {
    double fee = 0;
    if (double.tryParse(_sendAmountController!.text) == null) {
      return fee;
    }
    final bool isContact = _sendAddressController!.text.startsWith('@');
    String recipientAddress = '';
    if (_sendAddressController!.text.isEmpty ||
        (!isContact && !isHex(_sendAddressController!.text))) {
      return fee;
    } else {
      if (isContact) {
        try {
          Contact? contact = await sl
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
      final String? transactionChainSeed =
          await StateContainer.of(context).getSeed();
      List<UCOTransferWallet> ucoTransferListForFee =
          List<UCOTransferWallet>.empty(growable: true);
      ucoTransferListForFee.add(UCOTransferWallet(
          amount: maxSend
              ? BigInt.from(StateContainer.of(context)
                      .appWallet!
                      .appKeychain!
                      .getAccountSelected()!
                      .balance!
                      .nativeTokenValue! *
                  100000000)
              : BigInt.from(
                  double.tryParse(_sendAmountController!.text)! * 100000000),
          to: recipientAddress));
      final String originPrivateKey = sl.get<ApiService>().getOriginKey();
      fee = await sl.get<AppService>().getFeesEstimationUCO(
          originPrivateKey,
          transactionChainSeed!,
          StateContainer.of(context)
              .appWallet!
              .appKeychain!
              .getAccountSelected()!
              .lastAddress!,
          ucoTransferListForFee,
          _messageController!.text);
    } catch (e) {
      fee = 0;
    }
    return fee;
  }

  String _convertSelectedCurrencyToNetworkCurrency() {
    String convertedAmt = _sendAmountController!.text.replaceAll(",", ".");
    convertedAmt = NumberUtil.sanitizeNumber(convertedAmt);
    if (convertedAmt.isEmpty || double.tryParse(convertedAmt) == 0) {
      return '';
    }
    priceConverted = (Decimal.parse(convertedAmt) /
            Decimal.parse(StateContainer.of(context)
                .appWallet!
                .appKeychain!
                .getAccountSelected()!
                .balance!
                .tokenPrice!
                .amount!
                .toString()))
        .toDouble();
    return '${priceConverted.toStringAsFixed(8)} ${StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel()}';
  }

  String _convertNetworkCurrencyToSelectedCurrency() {
    String convertedAmt = NumberUtil.sanitizeNumber(_sendAmountController!.text,
        maxDecimalDigits: _localCurrencyFormat!.decimalDigits!);
    if (convertedAmt.isEmpty) {
      return '';
    }
    priceConverted = (Decimal.parse(StateContainer.of(context)
                .appWallet!
                .appKeychain!
                .getAccountSelected()!
                .balance!
                .tokenPrice!
                .amount!
                .toString()) *
            Decimal.parse(convertedAmt))
        .toDouble();
    return _localCurrencyFormat!.format(priceConverted);
  }
}
