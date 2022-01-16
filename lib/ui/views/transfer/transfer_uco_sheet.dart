// Dart imports:
// ignore_for_file: avoid_unnecessary_containers

import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart' show UCOTransfer;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:archethic_wallet/appstate_container.dart';
import 'package:archethic_wallet/ui/util/dimens.dart';
import 'package:archethic_wallet/localization.dart';
import 'package:archethic_wallet/model/address.dart';
import 'package:archethic_wallet/model/available_currency.dart';
import 'package:archethic_wallet/model/data/appdb.dart';
import 'package:archethic_wallet/model/data/hive_db.dart';
import 'package:archethic_wallet/service/app_service.dart';
import 'package:archethic_wallet/util/service_locator.dart';
import 'package:archethic_wallet/ui/util/styles.dart';
import 'package:archethic_wallet/ui/util/formatters.dart';
import 'package:archethic_wallet/ui/util/ui_util.dart';
import 'package:archethic_wallet/ui/views/transfer/transfer_confirm_sheet.dart';
import 'package:archethic_wallet/ui/widgets/components/app_text_field.dart';
import 'package:archethic_wallet/ui/widgets/components/buttons.dart';
import 'package:archethic_wallet/ui/widgets/components/icon_widget.dart';
import 'package:archethic_wallet/ui/widgets/components/sheet_util.dart';
import 'package:archethic_wallet/util/number_util.dart';
import 'package:archethic_wallet/util/user_data_util.dart';

class TransferUcoSheet extends StatefulWidget {
  const TransferUcoSheet(
      {@required this.localCurrency,
      this.contact,
      this.address,
      this.quickSendAmount,
      this.title,
      this.actionButtonTitle,
      this.contactsRef,
      Key? key})
      : super(key: key);

  final List<Contact>? contactsRef;
  final AvailableCurrency? localCurrency;
  final Contact? contact;
  final String? address;
  final String? quickSendAmount;
  final String? title;
  final String? actionButtonTitle;

  @override
  _TransferUcoSheetState createState() => _TransferUcoSheetState();
}

enum AddressStyle { text60, text90, primary }

class _TransferUcoSheetState extends State<TransferUcoSheet> {
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

  List<UCOTransfer> ucoTransferList = List<UCOTransfer>.empty(growable: true);

  @override
  void initState() {
    super.initState();
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
            // A row for the header of the sheet, balance text and close button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //Empty SizedBox
                const SizedBox(
                  width: 60,
                  height: 0,
                ),

                // Container for the header, address and balance text
                Column(
                  children: <Widget>[
                    // Sheet handle
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
                          // Header
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
                if (kIsWeb || Platform.isMacOS)
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
                                                    .getAccountBalanceUCODisplay(),
                                                style: AppStyles
                                                    .textStyleSize14W700Primary(
                                                        context)),
                                            TextSpan(
                                                text: ' UCO)',
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
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color:
                                                      StateContainer.of(context)
                                                          .curTheme
                                                          .backgroundDarkest,
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                  ),
                                                  margin: const EdgeInsets.only(
                                                      bottom: 50),
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 0, top: 0),
                                                    itemCount:
                                                        _contacts!.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return _buildContactItem(
                                                          _contacts![index]);
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
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
                                      child: Text(
                                        '+ ' +
                                            AppLocalization.of(context)!.fees +
                                            ': ' +
                                            sl
                                                .get<AppService>()
                                                .getFeesEstimation()
                                                .toStringAsFixed(5) +
                                            ' UCO',
                                        style: AppStyles
                                            .textStyleSize14W100Primary(
                                                context),
                                      ),
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
                      AppButton.buildAppButton(
                          context,
                          AppButtonType.primary,
                          widget.actionButtonTitle ??
                              AppLocalization.of(context)!.send,
                          Dimens.buttonTopDimens, onPressed: () async {
                        validRequest = _validateRequest();
                        if (_sendAddressController!.text.startsWith('@') &&
                            validRequest) {
                          try {
                            await sl.get<DBHelper>().getContactWithName(
                                _sendAddressController!.text);

                            Sheets.showAppHeightNineSheet(
                                context: context,
                                widget: TransferConfirmSheet(
                                    ucoTransferList: ucoTransferList,
                                    contactsRef: widget.contactsRef,
                                    title: widget.title,
                                    typeTransfer: 'UCO',
                                    localCurrency: null));
                          } on Exception {
                            setState(() {
                              _addressValidationText =
                                  AppLocalization.of(context)!.contactInvalid;
                            });
                          }
                        } else if (validRequest) {
                          Sheets.showAppHeightNineSheet(
                              context: context,
                              widget: TransferConfirmSheet(
                                  ucoTransferList: ucoTransferList,
                                  contactsRef: widget.contactsRef,
                                  title: widget.title,
                                  typeTransfer: 'UCO',
                                  localCurrency: null));
                        }
                      }),
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
          .getAccountBalanceUCODisplay()
          .replaceAll(r',', '');

      double? _balanceDouble;
      double? _feesDouble;
      _balanceDouble = double.tryParse(balance);
      _feesDouble = sl.get<AppService>().getFeesEstimation();
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
            onPressed: () {
              _sendAddressController!.text = contact.name!;
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
                style: AppStyles.textStyleSize14W100Primary(context)),
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
  bool _validateRequest() {
    bool isValid = true;
    UCOTransfer ucoTransfer = UCOTransfer();
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
      final double estimationFees = sl.get<AppService>().getFeesEstimation();

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
      } else if (sendAmount + estimationFees > balanceRaw) {
        isValid = false;
        setState(() {
          _amountValidationText =
              AppLocalization.of(context)!.insufficientBalance;
        });
      } else {
        ucoTransfer.amount = BigInt.from(sendAmount * 100000000);
      }
    }
    // Validate address
    final bool isContact = _sendAddressController!.text.startsWith('@');
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
      setState(() {
        _addressValidationText = '';
        _qrCodeButtonVisible = false;
      });
      _sendAddressFocusNode!.unfocus();
    }

    if (isValid) {
      ucoTransferList.clear();
      ucoTransfer.to = _sendAddressController!.text.trim();
      ucoTransferList.add(ucoTransfer);
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
      onChanged: (String text) {
        // Always reset the error message to be less annoying
        setState(() {
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
        icon: FontAwesomeIcons.angleDoubleUp,
        onPressed: () {
          setState(() {
            _amountValidationText = '';
            // Reset the raw amount
            _rawAmount = null;
          });
          if (_isMaxSend()) {
            return;
          }

          final double estimationFees =
              sl.get<AppService>().getFeesEstimation();
          _sendAmountController!.text = StateContainer.of(context)
              .wallet!
              .getAccountBalanceMoinsFeesDisplay(estimationFees)
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
            LengthLimitingTextInputFormatter(66),
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

            UIUtil.cancelLockEvent();
            final String? scanResult =
                await UserDataUtil.getQRData(DataType.address, context);
            if (scanResult == null) {
              UIUtil.showSnackbar(
                  AppLocalization.of(context)!.qrInvalidAddress, context);
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
            ? AppStyles.textStyleSize14W100Text60(context)
            : _sendAddressStyle == AddressStyle.text90
                ? AppStyles.textStyleSize14W100Primary(context)
                : AppStyles.textStyleSize14W100Primary(context),
        onChanged: (String text) async {
          if (text.isNotEmpty) {
            setState(() {
              _showContactButton = false;
            });
          } else {
            setState(() {
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
}
