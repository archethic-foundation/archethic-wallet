// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart' show UCOTransfer;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:archethic_mobile_wallet/app_icons.dart';
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/dimens.dart';
import 'package:archethic_mobile_wallet/localization.dart';
import 'package:archethic_mobile_wallet/model/address.dart';
import 'package:archethic_mobile_wallet/model/available_currency.dart';
import 'package:archethic_mobile_wallet/model/db/appdb.dart';
import 'package:archethic_mobile_wallet/model/db/contact.dart';
import 'package:archethic_mobile_wallet/service/app_service.dart';
import 'package:archethic_mobile_wallet/service_locator.dart';
import 'package:archethic_mobile_wallet/styles.dart';
import 'package:archethic_mobile_wallet/ui/transfer/transfer_confirm_sheet.dart';
import 'package:archethic_mobile_wallet/ui/transfer/uco_transfer_list.dart';
import 'package:archethic_mobile_wallet/ui/util/formatters.dart';
import 'package:archethic_mobile_wallet/ui/util/ui_util.dart';
import 'package:archethic_mobile_wallet/ui/widgets/app_text_field.dart';
import 'package:archethic_mobile_wallet/ui/widgets/buttons.dart';
import 'package:archethic_mobile_wallet/ui/widgets/sheet_util.dart';
import 'package:archethic_mobile_wallet/util/numberutil.dart';
import 'package:archethic_mobile_wallet/util/sharedprefsutil.dart';
import 'package:archethic_mobile_wallet/util/user_data_util.dart';

class TransferUcoSheet extends StatefulWidget {
  const TransferUcoSheet({
    @required this.localCurrency,
    this.contact,
    this.address,
    this.quickSendAmount,
    this.title,
    this.actionButtonTitle,
    this.contactsRef,
  }) : super();

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

enum AddressStyle { TEXT60, TEXT90, PRIMARY }

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
  bool? animationOpen;
  // Used to replace address textfield with colorized TextSpan
  bool _addressValidAndUnfocused = false;
  // Set to true when a contact is being entered
  bool _isContact = false;
  // Buttons States (Used because we hide the buttons under certain conditions)
  bool _pasteButtonVisible = true;
  bool _showContactButton = true;
  // Local currency mode/fiat conversion
  bool _localCurrencyMode = false;
  String _lastLocalCurrencyAmount = '';
  String _lastCryptoAmount = '';
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
    _sendAddressStyle = AddressStyle.TEXT60;
    _contacts = List<Contact>.empty(growable: true);
    quickSendAmount = widget.quickSendAmount;
    animationOpen = false;
    if (widget.contact != null) {
      // Setup initial state for contact pre-filled
      _sendAddressController!.text = widget.contact!.name!;
      _isContact = true;
      _showContactButton = false;
      _pasteButtonVisible = false;
      _sendAddressStyle = AddressStyle.PRIMARY;
    } else if (widget.address != null) {
      // Setup initial state with prefilled address
      _sendAddressController!.text = widget.address!;
      _showContactButton = false;
      _pasteButtonVisible = false;
      _sendAddressStyle = AddressStyle.TEXT90;
      _addressValidAndUnfocused = true;
    }
    // On amount focus change
    _sendAmountFocusNode!.addListener(() {
      if (_sendAmountFocusNode!.hasFocus) {
        if (_rawAmount != null) {
          setState(() {
            _sendAmountController!.text =
                NumberUtil.getRawAsUsableString(_rawAmount).replaceAll(',', '');
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
          _contacts = [];
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
          NumberUtil.getRawAsUsableString(quickSendAmount).replaceAll(',', '');
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
                        color: StateContainer.of(context).curTheme.primary10,
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
                            (widget.title ?? AppLocalization.of(context).send)!,
                            style:
                                AppStyles.textStyleLargerW700Primary(context),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            stepGranularity: 0.1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                //Empty SizedBox
                const SizedBox(
                  width: 60,
                  height: 0,
                ),
              ],
            ),

            // A main container that holds everything
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 0, bottom: 10),
                child: Stack(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        // Clear focus of our fields when tapped in this empty space
                        _sendAddressFocusNode!.unfocus();
                        _sendAmountFocusNode!.unfocus();
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: const SizedBox.expand(),
                        constraints: const BoxConstraints.expand(),
                      ),
                    ),
                    // A column for Enter Amount, Enter Address, Error containers and the pop up list
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(top: 0, bottom: bottom + 80),
                        child: Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                // Column for Balance Text, Enter Amount container + Enter Amount Error container
                                Column(
                                  children: <Widget>[
                                    // Balance Text
                                    FutureBuilder(
                                      future: sl
                                          .get<SharedPrefsUtil>()
                                          .getPriceConversion(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<PriceConversion>
                                              snapshot) {
                                        if (snapshot.hasData &&
                                            snapshot.data != null &&
                                            snapshot.data !=
                                                PriceConversion.HIDDEN) {
                                          return Container(
                                            child: RichText(
                                              textAlign: TextAlign.start,
                                              text: TextSpan(
                                                text: '',
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                    text: '(',
                                                    style: TextStyle(
                                                      color: StateContainer.of(
                                                              context)
                                                          .curTheme
                                                          .primary60,
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w100,
                                                      fontFamily: 'Montserrat',
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: _localCurrencyMode
                                                        ? StateContainer.of(
                                                                context)
                                                            .wallet
                                                            .getLocalCurrencyPrice(
                                                                StateContainer.of(
                                                                        context)
                                                                    .curCurrency,
                                                                locale: StateContainer.of(
                                                                        context)
                                                                    .currencyLocale)
                                                        : StateContainer.of(
                                                                context)
                                                            .wallet
                                                            .getAccountBalanceUCODisplay(),
                                                    style: TextStyle(
                                                      color: StateContainer.of(
                                                              context)
                                                          .curTheme
                                                          .primary60,
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontFamily: 'Montserrat',
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: _localCurrencyMode
                                                        ? ')'
                                                        : ' UCO)',
                                                    style: TextStyle(
                                                      color: StateContainer.of(
                                                              context)
                                                          .curTheme
                                                          .primary60,
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w100,
                                                      fontFamily: 'Montserrat',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                        return Container(
                                          child: const Text(
                                            '*******',
                                            style: TextStyle(
                                              color: Colors.transparent,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w100,
                                              fontFamily: 'Montserrat',
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    getEnterAmountContainer(),
                                    Container(
                                      alignment:
                                          const AlignmentDirectional(0, 0),
                                      margin: const EdgeInsets.only(top: 3),
                                      child: Text(_amountValidationText!,
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: StateContainer.of(context)
                                                .curTheme
                                                .primary,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w600,
                                          )),
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
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: StateContainer.of(context)
                                                .curTheme
                                                .primary,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w600,
                                          )),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      child: Text(
                                        '+ ' +
                                            AppLocalization.of(context).fees +
                                            ': ' +
                                            sl
                                                .get<AppService>()
                                                .getFeesEstimation()
                                                .toStringAsFixed(5) +
                                            ' UCO',
                                        style: TextStyle(
                                          color: StateContainer.of(context)
                                              .curTheme
                                              .primary60,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w100,
                                          fontFamily: 'Montserrat',
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: <Widget>[
                                        AppButton.buildAppButton(
                                            context,
                                            AppButtonType.PRIMARY,
                                            isInUcoTransferList()
                                                ? AppLocalization.of(context)
                                                    .update
                                                : AppLocalization.of(context)
                                                    .add,
                                            Dimens.BUTTON_TOP_DIMENS,
                                            onPressed: () {
                                          setState(() {
                                            validRequest = _validateRequest();
                                            String _to =
                                                _sendAddressController!.text;

                                            if (_sendAddressController!.text
                                                    .startsWith('@') &&
                                                validRequest) {
                                              // Need to make sure its a valid contact
                                              sl
                                                  .get<DBHelper>()
                                                  .getContactWithName(
                                                      _sendAddressController!
                                                          .text)
                                                  .then((Contact contact) {
                                                if (contact == null) {
                                                  setState(() {
                                                    _addressValidationText =
                                                        AppLocalization.of(
                                                                context)
                                                            .contactInvalid;
                                                    validRequest = false;
                                                  });
                                                } else {
                                                  _to = contact.address!;
                                                }

                                                if (validRequest) {
                                                  final double _amount =
                                                      double.tryParse(
                                                          _sendAmountController!
                                                              .text)!;

                                                  for (int i = 0;
                                                      i <
                                                          ucoTransferList
                                                              .length;
                                                      i++) {
                                                    if (ucoTransferList[i]
                                                            .to! ==
                                                        _to) {
                                                      ucoTransferList
                                                          .removeAt(i);
                                                      break;
                                                    }
                                                  }
                                                  final UCOTransfer
                                                      ucoTransfer = UCOTransfer(
                                                          to: _to,
                                                          amount: _amount);
                                                  ucoTransferList
                                                      .add(ucoTransfer);
                                                }
                                              });
                                            } else {
                                              if (validRequest) {
                                                double _amount =
                                                    double.tryParse(
                                                        _sendAmountController!
                                                            .text)!;

                                                for (int i = 0;
                                                    i < ucoTransferList.length;
                                                    i++) {
                                                  if (ucoTransferList[i].to! ==
                                                      _to) {
                                                    _amount = _amount +
                                                        ucoTransferList[i]
                                                            .amount!;
                                                    ucoTransferList.removeAt(i);
                                                    break;
                                                  }
                                                }
                                                final UCOTransfer ucoTransfer =
                                                    UCOTransfer(
                                                        to: _to,
                                                        amount: _amount);
                                                ucoTransferList
                                                    .add(ucoTransfer);
                                              }
                                            }
                                          });
                                        }),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    UcoTransferListWidget(
                                        displayContextMenu: true,
                                        listUcoTransfer: ucoTransferList,
                                        contacts: widget.contactsRef,
                                        onGet: (UCOTransfer _ucoTransfer) {
                                          setState(() {
                                            _sendAddressController!.text =
                                                _ucoTransfer.to!;
                                            for (Contact contact
                                                in widget.contactsRef!) {
                                              if (contact.address ==
                                                  _ucoTransfer.to!) {
                                                _sendAddressController!.text =
                                                    contact.name!;
                                              }
                                            }

                                            _sendAmountController!.text =
                                                _ucoTransfer.amount.toString();
                                          });
                                        },
                                        onDelete: () {
                                          setState(() {});
                                        }),
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
                          ucoTransferList.isEmpty
                              ? AppButtonType.PRIMARY_OUTLINE
                              : AppButtonType.PRIMARY,
                          widget.actionButtonTitle ??
                              AppLocalization.of(context).transferUCO,
                          Dimens.BUTTON_TOP_DIMENS, onPressed: () {
                        if (ucoTransferList.isNotEmpty) {
                          validRequest = _validateRequest();
                          if (_sendAddressController!.text.startsWith('@') &&
                              validRequest) {
                            // Need to make sure its a valid contact
                            sl
                                .get<DBHelper>()
                                .getContactWithName(
                                    _sendAddressController!.text)
                                .then((Contact contact) {
                              if (contact == null) {
                                setState(() {
                                  _addressValidationText =
                                      AppLocalization.of(context)
                                          .contactInvalid;
                                });
                              } else {
                                Sheets.showAppHeightNineSheet(
                                    context: context,
                                    widget: TransferConfirmSheet(
                                        ucoTransferList: ucoTransferList,
                                        contactsRef: widget.contactsRef,
                                        title: widget.title,
                                        typeTransfer: 'UCO',
                                        localCurrency: _localCurrencyMode
                                            ? _sendAmountController!.text
                                            : null));
                              }
                            });
                          } else if (validRequest) {
                            Sheets.showAppHeightNineSheet(
                                context: context,
                                widget: TransferConfirmSheet(
                                    ucoTransferList: ucoTransferList,
                                    contactsRef: widget.contactsRef,
                                    title: widget.title,
                                    typeTransfer: 'UCO',
                                    localCurrency: _localCurrencyMode
                                        ? _sendAmountController!.text
                                        : null));
                          }
                        }
                      }),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      // Scan QR Code Button
                      AppButton.buildAppButton(
                          context,
                          AppButtonType.PRIMARY,
                          AppLocalization.of(context).scanQrCode,
                          Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () async {
                        UIUtil.cancelLockEvent();
                        final String scanResult = await UserDataUtil.getQRData(
                            DataType.ADDRESS, context);
                        if (scanResult == null) {
                          UIUtil.showSnackbar(
                              AppLocalization.of(context).qrInvalidAddress,
                              context);
                        } else if (QRScanErrs.ERROR_LIST.contains(scanResult)) {
                          return;
                        } else {
                          // Is a URI
                          final Address address = Address(scanResult);
                          // See if this address belongs to a contact
                          final Contact contact = await sl
                              .get<DBHelper>()
                              .getContactWithAddress(address.address);
                          if (contact == null) {
                            // Not a contact
                            if (mounted) {
                              setState(() {
                                _isContact = false;
                                _addressValidationText = '';
                                _sendAddressStyle = AddressStyle.TEXT90;
                                _pasteButtonVisible = false;
                                _showContactButton = false;
                              });
                              _sendAddressController!.text = address.address;
                              _sendAddressFocusNode!.unfocus();
                              setState(() {
                                _addressValidAndUnfocused = true;
                              });
                            }
                          } else {
                            // Is a contact
                            if (mounted) {
                              setState(() {
                                _isContact = true;
                                _addressValidationText = '';
                                _sendAddressStyle = AddressStyle.PRIMARY;
                                _pasteButtonVisible = false;
                                _showContactButton = false;
                              });
                              _sendAddressController!.text = contact.name!;
                            }
                          }
                          // If amount is present, fill it and go to SendConfirm
                          if (address.amount != null) {
                            bool hasError = false;
                            final BigInt amountBigInt =
                                BigInt.tryParse(address.amount)!;
                            if (amountBigInt != null &&
                                amountBigInt < BigInt.from(10).pow(24)) {
                              hasError = true;
                              UIUtil.showSnackbar(
                                  AppLocalization.of(context)
                                      .minimumSend
                                      .replaceAll('%1', '0.000001'),
                                  context);
                            } else if (_localCurrencyMode && mounted) {
                              toggleLocalCurrency();
                              _sendAmountController!.text =
                                  NumberUtil.getRawAsUsableString(
                                      address.amount);
                            } else if (mounted) {
                              setState(() {
                                _rawAmount = address.amount;
                                // If raw amount has more precision than we support show a special indicator
                                if (NumberUtil.getRawAsUsableString(_rawAmount)
                                        .replaceAll(',', '') ==
                                    NumberUtil.getRawAsUsableDecimal(_rawAmount)
                                        .toString()) {
                                  _sendAmountController!.text =
                                      NumberUtil.getRawAsUsableString(
                                              _rawAmount)
                                          .replaceAll(',', '');
                                } else {
                                  _sendAmountController!
                                      .text = NumberUtil.truncateDecimal(
                                              NumberUtil.getRawAsUsableDecimal(
                                                  address.amount),
                                              digits: 6)
                                          .toStringAsFixed(6) +
                                      '~';
                                }
                              });
                              _sendAddressFocusNode!.unfocus();
                            }

                            if (!hasError) {
                              // Go to confirm sheet
                              Sheets.showAppHeightNineSheet(
                                  context: context,
                                  widget: TransferConfirmSheet(
                                      ucoTransferList: ucoTransferList,
                                      contactsRef: widget.contactsRef,
                                      title: widget.title,
                                      typeTransfer: 'UCO',
                                      localCurrency: _localCurrencyMode
                                          ? _sendAmountController!.text
                                          : null));
                            }
                          }
                        }
                      })
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  String _convertLocalCurrencyToCrypto() {
    String convertedAmt = _sendAmountController!.text.replaceAll(',', '.');
    convertedAmt = NumberUtil.sanitizeNumber(convertedAmt);
    if (convertedAmt.isEmpty) {
      return '';
    }
    final Decimal valueLocal = Decimal.parse(convertedAmt);
    final Decimal conversion = Decimal.parse(
        StateContainer.of(context).wallet.localCurrencyConversion);
    return NumberUtil.truncateDecimal(valueLocal / conversion).toString();
  }

  String _convertCryptoToLocalCurrency() {
    String convertedAmt = NumberUtil.sanitizeNumber(_sendAmountController!.text,
        maxDecimalDigits: 2);
    if (convertedAmt.isEmpty) {
      return '';
    }
    final Decimal valueCrypto = Decimal.parse(convertedAmt);
    final Decimal conversion = Decimal.parse(
        StateContainer.of(context).wallet.localCurrencyConversion);
    convertedAmt =
        NumberUtil.truncateDecimal(valueCrypto * conversion, digits: 2)
            .toString();
    convertedAmt =
        convertedAmt.replaceAll('.', _localCurrencyFormat!.symbols.DECIMAL_SEP);
    convertedAmt = _localCurrencyFormat!.currencySymbol + convertedAmt;
    return convertedAmt;
  }

  String _convertFeesToLocalCurrency() {
    String convertedAmt = NumberUtil.sanitizeNumber(
        sl.get<AppService>().getFeesEstimation().toStringAsFixed(5),
        maxDecimalDigits: 5);
    if (convertedAmt.isEmpty) {
      return '';
    }
    final Decimal valueCrypto = Decimal.parse(convertedAmt);
    final Decimal conversion = Decimal.parse(
        StateContainer.of(context).wallet.localCurrencyConversion);
    convertedAmt =
        NumberUtil.truncateDecimal(valueCrypto * conversion, digits: 5)
            .toString();
    convertedAmt =
        convertedAmt.replaceAll('.', _localCurrencyFormat!.symbols.DECIMAL_SEP);
    convertedAmt = _localCurrencyFormat!.currencySymbol + convertedAmt;
    return convertedAmt;
  }

  // Determine if this is a max send or not by comparing balances
  bool _isMaxSend() {
    // Sanitize commas
    if (_sendAmountController!.text.isEmpty) {
      return false;
    }
    try {
      String textField = _sendAmountController!.text;

      String balance;
      if (_localCurrencyMode) {
        balance = StateContainer.of(context).wallet.getLocalCurrencyPrice(
            StateContainer.of(context).curCurrency,
            locale: StateContainer.of(context).currencyLocale);
      } else {
        balance = StateContainer.of(context)
            .wallet
            .getAccountBalanceUCODisplay()
            .replaceAll(r',', '');
      }
      // Convert to Integer representations
      int textFieldInt;
      int balanceInt;
      if (_localCurrencyMode) {
        // Sanitize currency values into plain integer representations
        textField = textField.replaceAll(',', '.');
        final String sanitizedTextField = NumberUtil.sanitizeNumber(textField);
        balance =
            balance.replaceAll(_localCurrencyFormat!.symbols.GROUP_SEP, '');
        balance = balance.replaceAll(',', '.');
        final String sanitizedBalance = NumberUtil.sanitizeNumber(balance);
        textFieldInt = (Decimal.parse(sanitizedTextField) *
                Decimal.fromInt(pow(10, NumberUtil.maxDecimalDigits).toInt()))
            .toInt();
        balanceInt = (Decimal.parse(sanitizedBalance) *
                Decimal.fromInt(pow(10, NumberUtil.maxDecimalDigits).toInt()))
            .toInt();
      } else {
        textField = textField.replaceAll(',', '');
        textFieldInt = (Decimal.parse(textField) *
                Decimal.fromInt(pow(10, NumberUtil.maxDecimalDigits).toInt()))
            .toInt();
        balanceInt = (Decimal.parse(balance) *
                Decimal.fromInt(pow(10, NumberUtil.maxDecimalDigits).toInt()))
            .toInt();
      }

      final int estimationFeesInt =
          (Decimal.parse(sl.get<AppService>().getFeesEstimation().toString()) *
                  Decimal.fromInt(pow(10, NumberUtil.maxDecimalDigits).toInt()))
              .toInt();

      return textFieldInt + estimationFeesInt == balanceInt;
    } catch (e) {
      return false;
    }
  }

  void toggleLocalCurrency() {
    // Keep a cache of previous amounts because, it's kinda nice to see approx what cryptocurrency is worth
    // this way you can tap button and tap back and not end up with X.9993451 cryptocurrency
    if (_localCurrencyMode) {
      // Switching to crypto-mode
      String cryptoAmountStr;
      // Check out previous state
      if (_sendAmountController!.text == _lastLocalCurrencyAmount) {
        cryptoAmountStr = _lastCryptoAmount;
      } else {
        _lastLocalCurrencyAmount = _sendAmountController!.text;
        _lastCryptoAmount = _convertLocalCurrencyToCrypto();
        cryptoAmountStr = _lastCryptoAmount;
      }
      setState(() {
        _localCurrencyMode = false;
      });
      Future.delayed(const Duration(milliseconds: 50), () {
        _sendAmountController!.text = cryptoAmountStr;
        _sendAmountController!.selection = TextSelection.fromPosition(
            TextPosition(offset: cryptoAmountStr.length));
      });
    } else {
      // Switching to local-currency mode
      String localAmountStr;
      // Check our previous state
      if (_sendAmountController!.text == _lastCryptoAmount) {
        localAmountStr = _lastLocalCurrencyAmount;
      } else {
        _lastCryptoAmount = _sendAmountController!.text;
        _lastLocalCurrencyAmount = _convertCryptoToLocalCurrency();
        localAmountStr = _lastLocalCurrencyAmount;
      }
      setState(() {
        _localCurrencyMode = true;
      });
      Future.delayed(const Duration(milliseconds: 50), () {
        _sendAmountController!.text = localAmountStr;
        _sendAmountController!.selection = TextSelection.fromPosition(
            TextPosition(offset: localAmountStr.length));
      });
    }
  }

  // Build contact items for the list
  Widget _buildContactItem(Contact contact) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 42,
          width: double.infinity - 5,
          child: TextButton(
            onPressed: () {
              _sendAddressController!.text = contact.name!;
              _sendAddressFocusNode!.unfocus();
              setState(() {
                _isContact = true;
                _showContactButton = false;
                _pasteButtonVisible = false;
                _sendAddressStyle = AddressStyle.PRIMARY;
              });
            },
            child: Text(contact.name!,
                textAlign: TextAlign.center,
                style: AppStyles.textStyleSmallW100Primary(context)),
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
        _amountValidationText = AppLocalization.of(context).amountMissing;
      });
    } else {
      // Estimation of fees
      final double estimationFees = sl.get<AppService>().getFeesEstimation();

      final String amount = _localCurrencyMode
          ? _convertLocalCurrencyToCrypto()
          : _rawAmount == null
              ? _sendAmountController!.text
              : NumberUtil.getRawAsUsableString(_rawAmount);
      final double balanceRaw =
          StateContainer.of(context).wallet.accountBalance.uco!;
      final double sendAmount = double.tryParse(amount)!;
      if (sendAmount == null) {
        isValid = false;
        setState(() {
          _amountValidationText = AppLocalization.of(context).amountMissing;
        });
      } else if (sendAmount + estimationFees > balanceRaw) {
        isValid = false;
        setState(() {
          _amountValidationText =
              AppLocalization.of(context).insufficientBalance;
        });
      }
    }
    // Validate address
    final bool isContact = _sendAddressController!.text.startsWith('@');
    if (_sendAddressController!.text.trim().isEmpty) {
      isValid = false;
      setState(() {
        _addressValidationText = AppLocalization.of(context).addressMissing;
        _pasteButtonVisible = true;
      });
    } else if (!isContact && !Address(_sendAddressController!.text).isValid()) {
      isValid = false;
      setState(() {
        _addressValidationText = AppLocalization.of(context).invalidAddress;
        _pasteButtonVisible = true;
      });
    } else if (!isContact) {
      setState(() {
        _addressValidationText = '';
        _pasteButtonVisible = false;
      });
      _sendAddressFocusNode!.unfocus();
    }
    return isValid;
  }

  AppTextField getEnterAmountContainer() {
    return AppTextField(
      focusNode: _sendAmountFocusNode,
      controller: _sendAmountController,
      topMargin: 30,
      cursorColor: StateContainer.of(context).curTheme.primary,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16.0,
        color: StateContainer.of(context).curTheme.primary,
        fontFamily: 'Montserrat',
      ),
      inputFormatters: _rawAmount == null
          ? [
              LengthLimitingTextInputFormatter(16),
              if (_localCurrencyMode)
                CurrencyFormatter(
                    decimalSeparator: _localCurrencyFormat!.symbols.DECIMAL_SEP,
                    commaSeparator: _localCurrencyFormat!.symbols.GROUP_SEP,
                    maxDecimalDigits: 8)
              else
                CurrencyFormatter(
                    maxDecimalDigits: NumberUtil.maxDecimalDigits),
              LocalCurrencyFormatter(
                  active: _localCurrencyMode,
                  currencyFormat: _localCurrencyFormat)
            ]
          : [LengthLimitingTextInputFormatter(16)],
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
          _amountHint == null ? '' : AppLocalization.of(context).enterAmount,
      suffixButton: TextFieldButton(
        icon: AppIcons.max,
        onPressed: () {
          setState(() {
            _amountValidationText = '';
            // Reset the raw amount
            _rawAmount = null;
          });
          if (_isMaxSend()) {
            return;
          }

          if (!_localCurrencyMode) {
            final double estimationFees =
                sl.get<AppService>().getFeesEstimation();
            _sendAmountController!.text = StateContainer.of(context)
                .wallet
                .getAccountBalanceMoinsFeesDisplay(estimationFees)
                .replaceAll(r',', '');
            _sendAddressController!.selection = TextSelection.fromPosition(
                TextPosition(offset: _sendAddressController!.text.length));
          } else {
            String feeString = _convertFeesToLocalCurrency();
            feeString = feeString.replaceAll(
                _localCurrencyFormat!.symbols.GROUP_SEP, '');
            feeString = feeString.replaceAll(
                _localCurrencyFormat!.symbols.DECIMAL_SEP, '.');
            feeString = NumberUtil.sanitizeNumber(feeString)
                .replaceAll('.', _localCurrencyFormat!.symbols.DECIMAL_SEP);

            String localAmount = StateContainer.of(context)
                .wallet
                .getLocalCurrencyPriceMoinsFees(
                    StateContainer.of(context).curCurrency,
                    double.tryParse(feeString),
                    locale: StateContainer.of(context).currencyLocale);
            localAmount = localAmount.replaceAll(
                _localCurrencyFormat!.symbols.GROUP_SEP, '');
            localAmount = localAmount.replaceAll(
                _localCurrencyFormat!.symbols.DECIMAL_SEP, '.');
            localAmount = NumberUtil.sanitizeNumber(localAmount)
                .replaceAll('.', _localCurrencyFormat!.symbols.DECIMAL_SEP);
            _sendAmountController!.text =
                _localCurrencyFormat!.currencySymbol + localAmount;
            _sendAddressController!.selection = TextSelection.fromPosition(
                TextPosition(offset: _sendAddressController!.text.length));
          }
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
        inputFormatters: [
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
            : AppLocalization.of(context).enterAddress,
        prefixButton: TextFieldButton(
          icon: AppIcons.at,
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
          icon: AppIcons.paste,
          onPressed: () {
            if (!_pasteButtonVisible) {
              return;
            }
            Clipboard.getData('text/plain').then((ClipboardData? data) {
              if (data == null || data.text == null) {
                return;
              }
              final Address address = Address(data.text!);
              if (address.isValid()) {
                sl
                    .get<DBHelper>()
                    .getContactWithAddress(address.address)
                    .then((Contact contact) {
                  if (contact == null) {
                    setState(() {
                      _isContact = false;
                      _addressValidationText = '';
                      _sendAddressStyle = AddressStyle.TEXT90;
                      _pasteButtonVisible = false;
                      _showContactButton = false;
                    });
                    _sendAddressController!.text = address.address;
                    //_sendAddressFocusNode.unfocus();
                    setState(() {
                      //_addressValidAndUnfocused = true;
                    });
                  } else {
                    // Is a contact
                    setState(() {
                      _isContact = true;
                      _addressValidationText = '';
                      _sendAddressStyle = AddressStyle.PRIMARY;
                      _pasteButtonVisible = false;
                      _showContactButton = false;
                    });
                    _sendAddressController!.text = contact.name!;
                  }
                });
              }
            });
          },
        ),
        fadeSuffixOnCondition: true,
        suffixShowFirstCondition: _pasteButtonVisible,
        style: _sendAddressStyle == AddressStyle.TEXT60
            ? AppStyles.textStyleSmallW100Text60(context)
            : _sendAddressStyle == AddressStyle.TEXT90
                ? AppStyles.textStyleSmallW100Primary(context)
                : AppStyles.textStyleSmallW100Primary(context),
        onChanged: (String text) {
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
              _contacts = [];
            });
          }
          // Always reset the error message to be less annoying
          setState(() {
            _addressValidationText = '';
          });
          if (!isContact && Address(text).isValid()) {
            //_sendAddressFocusNode.unfocus();
            setState(() {
              _sendAddressStyle = AddressStyle.TEXT90;
              _addressValidationText = '';
              _pasteButtonVisible = true;
            });
          } else if (!isContact) {
            setState(() {
              _sendAddressStyle = AddressStyle.TEXT60;
              _pasteButtonVisible = true;
            });
          } else {
            sl.get<DBHelper>().getContactWithName(text).then((Contact contact) {
              if (contact == null) {
                setState(() {
                  _sendAddressStyle = AddressStyle.TEXT60;
                });
              } else {
                setState(() {
                  _pasteButtonVisible = false;
                  _addressValidationText = '';
                  _sendAddressStyle = AddressStyle.PRIMARY;
                });
              }
            });
          }
        },
        overrideTextFieldWidget: _addressValidAndUnfocused
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _addressValidAndUnfocused = false;
                    _addressValidationText = '';
                  });
                  Future.delayed(const Duration(milliseconds: 50), () {
                    FocusScope.of(context).requestFocus(_sendAddressFocusNode);
                  });
                },
                child: UIUtil.threeLinetextStyleSmallestW400Text(
                    context, _sendAddressController!.text))
            : null);
  }

  bool isInUcoTransferList() {
    bool inList = false;
    String contactAddress = '';
    for (Contact contact in widget.contactsRef!) {
      if (contact.name == _sendAddressController!.text) {
        contactAddress = contact.address!;
      }
    }

    for (int i = 0; i < ucoTransferList.length; i++) {
      if (ucoTransferList[i].to! == _sendAddressController!.text ||
          ucoTransferList[i].to! == contactAddress) {
        inList = true;
        break;
      }
    }
    return inList;
  }
}
