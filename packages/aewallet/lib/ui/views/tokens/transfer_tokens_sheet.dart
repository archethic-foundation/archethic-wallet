/// SPDX-License-Identifier: AGPL-3.0-or-later
// ignore_for_file: avoid_unnecessary_containers

// Dart imports:
import 'dart:io';
import 'dart:ui';

// Flutter imports:
import 'package:core/util/haptic_util.dart';
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
import 'package:aeuniverse/util/user_data_util.dart';
import 'package:aewallet/model/uco_transfer_wallet.dart';
import 'package:aewallet/ui/views/tokens/transfer_confirm_sheet.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/localization.dart';
import 'package:core/model/address.dart';
import 'package:core/model/available_currency.dart';
import 'package:core/model/available_networks.dart';
import 'package:core/model/data/appdb.dart';
import 'package:core/model/data/hive_db.dart';
import 'package:core/service/app_service.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core/util/global_var.dart';
import 'package:core/util/number_util.dart';
import 'package:core_ui/ui/util/dimens.dart';
import 'package:core_ui/ui/util/formatters.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart'
    show AddressService, isHex;

class TransferTokensSheet extends StatefulWidget {
  const TransferTokensSheet(
      {@required this.localCurrency,
      this.contact,
      this.address,
      this.quickSendAmount,
      this.title,
      this.actionButtonTitle,
      Key? key})
      : super(key: key);

  final AvailableCurrency? localCurrency;
  final Contact? contact;
  final String? address;
  final String? quickSendAmount;
  final String? title;
  final String? actionButtonTitle;

  @override
  _TransferTokensSheetState createState() => _TransferTokensSheetState();
}

enum AddressStyle { text60, text90, primary }

class _TransferTokensSheetState extends State<TransferTokensSheet> {
  FocusNode? _sendAddressFocusNode;
  TextEditingController? _sendAddressController;
  FocusNode? _sendAmountFocusNode;
  TextEditingController? _sendAmountController;

  // States
  AddressStyle? _sendAddressStyle;
  String? _amountHint = '';
  String? _addressHint = '';
  String? _amountValidationText = '';
  String? _addressValidationText = '';
  String? quickSendAmount;
  List<Contact>? _contacts;
  // Used to replace address textfield with colorized TextSpan
  bool _addressValidAndUnfocused = false;
  // Set to true when a contact is being entered
  bool _isContact = false;
  // Buttons States (Used because we hide the buttons under certain conditions)
  bool _qrCodeButtonVisible = true;
  bool _showContactButton = true;
  NumberFormat? _localCurrencyFormat;
  String? _rawAmount;
  bool validRequest = true;
  double feeEstimation = 0.0;
  bool? _isPressed;

  List<UCOTransferWallet> ucoTransferList =
      List<UCOTransferWallet>.empty(growable: true);

  @override
  void initState() {
    super.initState();
    _isPressed = false;
    _sendAmountFocusNode = FocusNode();
    _sendAddressFocusNode = FocusNode();
    _sendAmountController = TextEditingController();
    _sendAddressController = TextEditingController();
    _sendAddressStyle = AddressStyle.text60;
    _contacts = List<Contact>.empty(growable: true);
    quickSendAmount = widget.quickSendAmount;
    if (widget.contact != null) {
      // Setup initial state for contact pre-filled
      _sendAddressController!.text = widget.contact!.name!;
      _isContact = true;
      _showContactButton = false;
      _qrCodeButtonVisible = false;
      _sendAddressStyle = AddressStyle.primary;
    } else if (widget.address != null) {
      // Setup initial state with prefilled address
      _sendAddressController!.text = widget.address!;
      _showContactButton = false;
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
        setState(() {
          _amountHint = null;
        });
      } else {
        setState(() {
          _amountHint = '';
        });
      }
    });
    // On address focus change
    _sendAddressFocusNode!.addListener(() {
      if (_sendAddressFocusNode!.hasFocus) {
        setState(() {
          _addressHint = null;
          //_addressValidAndUnfocused = false;
        });
        _sendAddressController!.selection = TextSelection.fromPosition(
            TextPosition(offset: _sendAddressController!.text.length));
        if (_sendAddressController!.text.startsWith('@')) {
          sl
              .get<DBHelper>()
              .getContactsWithNameLike(_sendAddressController!.text)
              .then((List<Contact> contactList) {
            setState(() {
              _contacts = contactList;
            });
          });
        }
      } else {
        setState(() {
          _addressHint = '';
          _contacts = <Contact>[];
          if (Address(_sendAddressController!.text).isValid()) {
            //_addressValidAndUnfocused = true;
          }
        });
        if (_sendAddressController!.text.trim() == '@') {
          _sendAddressController!.text = '';
          setState(() {
            _showContactButton = true;
          });
        }
      }
    });

    // Set initial currency format
    _localCurrencyFormat = NumberFormat.currency(
        locale: widget.localCurrency!.getLocale().toString(),
        symbol: widget.localCurrency!.getCurrencySymbol());
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
    return SafeArea(
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
                  height: 0,
                ),
                Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: 5,
                      width: MediaQuery.of(context).size.width * 0.15,
                      decoration: BoxDecoration(
                        color: StateContainer.of(context).curTheme.primary60,
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
                              StateContainer.of(context)
                                          .curNetwork
                                          .getIndex() ==
                                      AvailableNetworks.AETestNet.index
                                  ? SvgPicture.asset(
                                      StateContainer.of(context)
                                              .curTheme
                                              .assetsFolder! +
                                          StateContainer.of(context)
                                              .curTheme
                                              .logoAlone! +
                                          '.svg',
                                      color: Colors.green,
                                      height: 15,
                                    )
                                  : StateContainer.of(context)
                                              .curNetwork
                                              .getIndex() ==
                                          AvailableNetworks.AEDevNet.index
                                      ? SvgPicture.asset(
                                          StateContainer.of(context)
                                                  .curTheme
                                                  .assetsFolder! +
                                              StateContainer.of(context)
                                                  .curTheme
                                                  .logoAlone! +
                                              '.svg',
                                          color: Colors.orange,
                                          height: 15,
                                        )
                                      : SvgPicture.asset(
                                          StateContainer.of(context)
                                                  .curTheme
                                                  .assetsFolder! +
                                              StateContainer.of(context)
                                                  .curTheme
                                                  .logoAlone! +
                                              '.svg',
                                          height: 15,
                                        ),
                              Text(
                                  StateContainer.of(context)
                                      .curNetwork
                                      .getLongDisplayName(),
                                  style: AppStyles.textStyleSize10W100Primary(
                                      context)),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ), // Header
                          AutoSizeText(
                            widget.title ?? AppLocalization.of(context)!.send,
                            style:
                                AppStyles.textStyleSize24W700Primary(context),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            stepGranularity: 0.1,
                          ),
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
                          padding: const EdgeInsets.only(top: 10, right: 0),
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
                margin: const EdgeInsets.only(top: 0, bottom: 10),
                child: Stack(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        _sendAddressFocusNode!.unfocus();
                        _sendAmountFocusNode!.unfocus();
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: const SizedBox.expand(),
                        constraints: const BoxConstraints.expand(),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(top: 0, bottom: bottom + 80),
                        child: Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Container(
                                      child: RichText(
                                        textAlign: TextAlign.start,
                                        text: TextSpan(
                                          text: '',
                                          children: <InlineSpan>[
                                            TextSpan(
                                              text: '(',
                                              style: AppStyles
                                                  .textStyleSize14W100Primary(
                                                      context),
                                            ),
                                            TextSpan(
                                                text: StateContainer.of(context)
                                                    .wallet!
                                                    .getAccountBalanceDisplay(),
                                                style: AppStyles
                                                    .textStyleSize14W700Primary(
                                                        context)),
                                            TextSpan(
                                                text: ' ' +
                                                    StateContainer.of(context)
                                                        .curNetwork
                                                        .getNetworkCryptoCurrencyLabel() +
                                                    ')',
                                                style: AppStyles
                                                    .textStyleSize14W100Primary(
                                                        context)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    getEnterAmountContainer(),
                                    Container(
                                      alignment:
                                          const AlignmentDirectional(0, 0),
                                      margin: const EdgeInsets.only(top: 3),
                                      child: Text(_amountValidationText!,
                                          style: AppStyles
                                              .textStyleSize14W600Primary(
                                                  context)),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topCenter,
                                      child: Stack(
                                        alignment: Alignment.topCenter,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.105,
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.105),
                                            alignment: Alignment.bottomCenter,
                                            constraints: const BoxConstraints(
                                                maxHeight: 173, minHeight: 0),
                                            // The pop-up Contacts List
                                            child: _contacts != null &&
                                                    _contacts!.isNotEmpty
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    child: BackdropFilter(
                                                      filter: ImageFilter.blur(
                                                          sigmaX: 8, sigmaY: 8),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: StateContainer
                                                                  .of(context)
                                                              .curTheme
                                                              .backgroundDark!
                                                              .withOpacity(0.9),
                                                        ),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25),
                                                          ),
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 50),
                                                          child:
                                                              ListView.builder(
                                                            shrinkWrap: true,
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 0,
                                                                    top: 0),
                                                            itemCount:
                                                                _contacts!
                                                                    .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return _buildContactItem(
                                                                  _contacts![
                                                                      index]);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox(),
                                          ),
                                          getEnterAddressContainer(),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment:
                                          const AlignmentDirectional(0, 0),
                                      margin: const EdgeInsets.only(top: 3),
                                      child: Text(_addressValidationText!,
                                          style: AppStyles
                                              .textStyleSize14W600Primary(
                                                  context)),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      child: feeEstimation > 0
                                          ? Text(
                                              '+ ' +
                                                  AppLocalization.of(context)!
                                                      .estimatedFees +
                                                  ': ' +
                                                  feeEstimation.toString() +
                                                  ' ' +
                                                  StateContainer.of(context)
                                                      .curNetwork
                                                      .getNetworkCryptoCurrencyLabel(),
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
                                  ],
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
                                      setState(() {
                                        _isPressed = false;
                                      });
                                    },
                                    context: context,
                                    widget: TransferConfirmSheet(
                                      lastAddress: StateContainer.of(context)
                                          .selectedAccount
                                          .lastAddress!,
                                      ucoTransferList: ucoTransferList,
                                      title: widget.title,
                                      typeTransfer: 'TOKEN',
                                      feeEstimation: feeEstimation,
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
        ));
  }

  // Determine if this is a max send or not by comparing balances
  bool _isMaxSend() {
    // Sanitize commas
    if (_sendAmountController!.text.isEmpty) {
      return false;
    }
    final double? _sendAmount = double.tryParse(_sendAmountController!.text);
    if (_sendAmount == null) {
      return false;
    } else {
      String balance = StateContainer.of(context)
          .wallet!
          .getAccountBalanceDisplay()
          .replaceAll(r',', '');

      double? _balanceDouble;
      double? _feesDouble;
      _balanceDouble = double.tryParse(balance);
      _feesDouble = feeEstimation;
      if (_balanceDouble == null) {
        return false;
      } else {
        if (_balanceDouble == _sendAmount + _feesDouble) {
          return true;
        } else {
          return false;
        }
      }
    }
  }

  // Build contact items for the list
  Widget _buildContactItem(Contact contact) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: 42,
          width: double.infinity - 5,
          child: TextButton(
            onPressed: () async {
              sl.get<HapticUtil>().feedback(FeedbackType.light);
              _sendAddressController!.text = contact.name!;
              feeEstimation = await getFee();
              _sendAddressFocusNode!.unfocus();
              setState(() {
                _isContact = true;
                _showContactButton = false;
                _qrCodeButtonVisible = false;
                _sendAddressStyle = AddressStyle.primary;
              });
            },
            child: Text(contact.name!,
                textAlign: TextAlign.center,
                style: AppStyles.textStyleSize14W600Primary(context)),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          height: 1,
          color: StateContainer.of(context).curTheme.primary03,
        ),
      ],
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
      _amountValidationText = '';
    });
    // Validate amount
    if (_sendAmountController!.text.trim().isEmpty) {
      isValid = false;
      setState(() {
        _amountValidationText = AppLocalization.of(context)!.amountMissing;
      });
    } else {
      // Estimation of fees
      feeEstimation = await getFee();

      final String amount = _rawAmount == null
          ? _sendAmountController!.text
          : NumberUtil.getRawAsUsableString(_rawAmount!);
      final double balanceRaw =
          StateContainer.of(context).wallet!.accountBalance.uco!;
      final double sendAmount = double.tryParse(amount)!;
      if (sendAmount == null) {
        isValid = false;
        setState(() {
          _amountValidationText = AppLocalization.of(context)!.amountMissing;
        });
      } else if (sendAmount + feeEstimation > balanceRaw) {
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
      if (lastAddressRecipient ==
          StateContainer.of(context).selectedAccount.lastAddress!) {
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

  AppTextField getEnterAmountContainer() {
    return AppTextField(
      focusNode: _sendAmountFocusNode,
      controller: _sendAmountController,
      topMargin: 30,
      cursorColor: StateContainer.of(context).curTheme.primary,
      style: AppStyles.textStyleSize16W700Primary(context),
      inputFormatters: _rawAmount == null
          // ignore: always_specify_types
          ? [
              LengthLimitingTextInputFormatter(16),
              CurrencyFormatter(maxDecimalDigits: NumberUtil.maxDecimalDigits),
              LocalCurrencyFormatter(
                  active: false, currencyFormat: _localCurrencyFormat!)
            ]
          : <LengthLimitingTextInputFormatter>[
              LengthLimitingTextInputFormatter(16)
            ],
      onChanged: (String text) async {
        double _fee = await getFee();
        // Always reset the error message to be less annoying
        setState(() {
          feeEstimation = _fee;
          _amountValidationText = '';
          // Reset the raw amount
          _rawAmount = null;
        });
      },
      textInputAction: TextInputAction.next,
      maxLines: null,
      autocorrect: false,
      hintText:
          _amountHint == null ? '' : AppLocalization.of(context)!.enterAmount,
      suffixButton: TextFieldButton(
        icon: FontAwesomeIcons.anglesUp,
        onPressed: () async {
          sl.get<HapticUtil>().feedback(FeedbackType.light);
          double _fee = await getFee(maxSend: true);

          setState(() {
            feeEstimation = _fee;
            _amountValidationText = '';
            // Reset the raw amount
            _rawAmount = null;
          });
          if (_isMaxSend()) {
            return;
          }

          feeEstimation = await getFee();
          _sendAmountController!.text = StateContainer.of(context)
              .wallet!
              .getAccountBalanceMoinsFeesDisplay(feeEstimation)
              .replaceAll(r',', '');
          _sendAddressController!.selection = TextSelection.fromPosition(
              TextPosition(offset: _sendAddressController!.text.length));
        },
      ),
      fadeSuffixOnCondition: true,
      suffixShowFirstCondition: !_isMaxSend(),
      keyboardType:
          const TextInputType.numberWithOptions(signed: true, decimal: true),
      textAlign: TextAlign.center,
      onSubmitted: (String text) {
        FocusScope.of(context).unfocus();
        if (!Address(_sendAddressController!.text).isValid()) {
          FocusScope.of(context).requestFocus(_sendAddressFocusNode);
        }
      },
    );
  }

  AppTextField getEnterAddressContainer() {
    return AppTextField(
        topMargin: 124,
        padding: _addressValidAndUnfocused
            ? const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0)
            : EdgeInsets.zero,
        textAlign: TextAlign.center,
        focusNode: _sendAddressFocusNode,
        controller: _sendAddressController,
        cursorColor: StateContainer.of(context).curTheme.primary,
        inputFormatters: <LengthLimitingTextInputFormatter>[
          if (_isContact)
            LengthLimitingTextInputFormatter(20)
          else
            LengthLimitingTextInputFormatter(68),
        ],
        textInputAction: TextInputAction.done,
        maxLines: null,
        autocorrect: false,
        hintText: _addressHint == null
            ? ''
            : AppLocalization.of(context)!.enterAddress,
        prefixButton: TextFieldButton(
          icon: FontAwesomeIcons.at,
          onPressed: () {
            sl.get<HapticUtil>().feedback(FeedbackType.light);
            if (_showContactButton && _contacts!.isEmpty) {
              // Show menu
              FocusScope.of(context).requestFocus(_sendAddressFocusNode);
              if (_sendAddressController!.text.isEmpty) {
                _sendAddressController!.text = '@';
                _sendAddressController!.selection = TextSelection.fromPosition(
                    TextPosition(offset: _sendAddressController!.text.length));
              }
              sl
                  .get<DBHelper>()
                  .getContacts()
                  .then((List<Contact> contactList) {
                setState(() {
                  _contacts = contactList;
                });
              });
            }
          },
        ),
        fadePrefixOnCondition: true,
        prefixShowFirstCondition: _showContactButton && _contacts!.isEmpty,
        suffixButton: TextFieldButton(
          icon: FontAwesomeIcons.qrcode,
          onPressed: () async {
            if (!_qrCodeButtonVisible) {
              return;
            }
            sl.get<HapticUtil>().feedback(FeedbackType.light);
            UIUtil.cancelLockEvent();
            final String? scanResult =
                await UserDataUtil.getQRData(DataType.address, context);
            if (scanResult == null) {
              UIUtil.showSnackbar(
                  AppLocalization.of(context)!.qrInvalidAddress,
                  context,
                  StateContainer.of(context).curTheme.primary!,
                  StateContainer.of(context).curTheme.overlay80!);
            } else if (QRScanErrs.errorList.contains(scanResult)) {
              return;
            } else {
              // Is a URI
              final Address address = Address(scanResult);
              // See if this address belongs to a contact
              final Contact? contact;
              try {
                contact = await sl
                    .get<DBHelper>()
                    .getContactWithAddress(address.address);

                // Is a contact
                if (mounted) {
                  setState(() {
                    _isContact = true;
                    _addressValidationText = '';
                    _sendAddressStyle = AddressStyle.primary;
                    _qrCodeButtonVisible = false;
                    _showContactButton = false;
                  });
                  _sendAddressController!.text = contact.name!;
                }
              } on Exception {
                // Not a contact
                if (mounted) {
                  setState(() {
                    _isContact = false;
                    _addressValidationText = '';
                    _sendAddressStyle = AddressStyle.text90;
                    _qrCodeButtonVisible = false;
                    _showContactButton = false;
                  });
                  _sendAddressController!.text = address.address;
                  _sendAddressFocusNode!.unfocus();
                  setState(() {
                    _addressValidAndUnfocused = true;
                  });
                }
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
          double _fee = await getFee();
          if (text.isNotEmpty) {
            setState(() {
              feeEstimation = _fee;
              _showContactButton = false;
            });
          } else {
            setState(() {
              feeEstimation = _fee;
              _showContactButton = true;
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
                .then((List<Contact> matchedList) {
              setState(() {
                _contacts = matchedList;
              });
            });
          } else {
            setState(() {
              _isContact = false;
              _contacts = <Contact>[];
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

    final bool isContact = _sendAddressController!.text.startsWith('@');
    String _recipientAddress = '';
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
            _recipientAddress = contact.address!;
          } else {
            return fee;
          }
        } catch (e) {
          return fee;
        }
      } else {
        _recipientAddress = _sendAddressController!.text.trim();
      }
    }
    try {
      final String transactionChainSeed =
          await StateContainer.of(context).getSeed();
      List<UCOTransferWallet> ucoTransferListForFee =
          List<UCOTransferWallet>.empty(growable: true);
      ucoTransferListForFee.add(UCOTransferWallet(
          amount: maxSend
              ? BigInt.from(
                  StateContainer.of(context).wallet!.accountBalance.uco! *
                      100000000)
              : BigInt.from(
                  double.tryParse(_sendAmountController!.text)! * 100000000),
          to: _recipientAddress));
      fee = await sl.get<AppService>().getFeesEstimationUCO(
          globalVarOriginPrivateKey,
          transactionChainSeed,
          StateContainer.of(context).selectedAccount.lastAddress!,
          ucoTransferListForFee);
    } catch (e) {
      fee = 0;
    }
    return fee;
  }
}
