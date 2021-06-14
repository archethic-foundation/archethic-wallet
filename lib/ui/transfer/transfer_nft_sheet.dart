// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:decimal/decimal.dart';
import 'package:uniris_lib_dart/transaction_builder.dart';
import 'package:uniris_lib_dart/utils.dart';

// Project imports:
import 'package:uniris_mobile_wallet/app_icons.dart';
import 'package:uniris_mobile_wallet/appstate_container.dart';
import 'package:uniris_mobile_wallet/dimens.dart';
import 'package:uniris_mobile_wallet/localization.dart';
import 'package:uniris_mobile_wallet/model/address.dart';
import 'package:uniris_mobile_wallet/model/db/appdb.dart';
import 'package:uniris_mobile_wallet/model/db/contact.dart';
import 'package:uniris_mobile_wallet/service/app_service.dart';
import 'package:uniris_mobile_wallet/service_locator.dart';
import 'package:uniris_mobile_wallet/styles.dart';
import 'package:uniris_mobile_wallet/ui/transfer/nft_transfer_list.dart';
import 'package:uniris_mobile_wallet/ui/transfer/transfer_confirm_sheet.dart';
import 'package:uniris_mobile_wallet/ui/util/formatters.dart';
import 'package:uniris_mobile_wallet/ui/util/ui_util.dart';
import 'package:uniris_mobile_wallet/ui/widgets/app_text_field.dart';
import 'package:uniris_mobile_wallet/ui/widgets/buttons.dart';
import 'package:uniris_mobile_wallet/ui/widgets/sheet_util.dart';
import 'package:uniris_mobile_wallet/util/numberutil.dart';
import 'package:uniris_mobile_wallet/util/sharedprefsutil.dart';
import 'package:uniris_mobile_wallet/util/user_data_util.dart';

class TransferNftSheet extends StatefulWidget {
  const TransferNftSheet({
    this.contact,
    this.address,
    this.quickSendAmount,
    this.title,
    this.actionButtonTitle,
    this.contactsRef,
  }) : super();

  final List<Contact>? contactsRef;
  final Contact? contact;
  final String? address;
  final String? quickSendAmount;
  final String? title;
  final String? actionButtonTitle;

  @override
  _TransferNftSheetState createState() => _TransferNftSheetState();
}

enum AddressStyle { TEXT60, TEXT90, PRIMARY }

class _TransferNftSheetState extends State<TransferNftSheet> {
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

  String? _rawAmount;
  bool validRequest = true;

  List<NftTransfer> nftTransferList = List<NftTransfer>.empty(growable: true);

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
      _sendAddressController!.text = widget.contact!.name;
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
                        color: StateContainer.of(context).curTheme.text10,
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
                            style: AppStyles.textStyleHeader(context),
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
                                                    text: StateContainer.of(
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
                                                    text: ' UCO)',
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
                                                  _to = contact.address;
                                                }

                                                if (validRequest) {
                                                  final double _amount =
                                                      double.tryParse(
                                                          _sendAmountController!
                                                              .text)!;

                                                  for (int i = 0;
                                                      i <
                                                          nftTransferList
                                                              .length;
                                                      i++) {
                                                    if (uint8ListToHex(
                                                            nftTransferList[i]
                                                                .to!) ==
                                                        _to) {
                                                      nftTransferList
                                                          .removeAt(i);
                                                      break;
                                                    }
                                                  }
                                                  final NftTransfer
                                                      nftTransfer = NftTransfer(
                                                          to: hexToUint8List(
                                                              _to),
                                                          amount: _amount);
                                                  nftTransferList
                                                      .add(nftTransfer);
                                                }
                                              });
                                            } else {
                                              if (validRequest) {
                                                double _amount =
                                                    double.tryParse(
                                                        _sendAmountController!
                                                            .text)!;

                                                for (int i = 0;
                                                    i < nftTransferList.length;
                                                    i++) {
                                                  if (uint8ListToHex(
                                                          nftTransferList[i]
                                                              .to!) ==
                                                      _to) {
                                                    _amount = _amount +
                                                        nftTransferList[i]
                                                            .amount!;
                                                    nftTransferList.removeAt(i);
                                                    break;
                                                  }
                                                }
                                                final NftTransfer nftTransfer =
                                                    NftTransfer(
                                                        to: hexToUint8List(_to),
                                                        amount: _amount);
                                                nftTransferList
                                                    .add(nftTransfer);
                                              }
                                            }
                                          });
                                        }),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    NftTransferListWidget(
                                        displayContextMenu: true,
                                        listNftTransfer: nftTransferList,
                                        contacts: widget.contactsRef,
                                        onGet: (NftTransfer _nftTransfer) {
                                          setState(() {
                                            _sendAddressController!.text =
                                                uint8ListToHex(
                                                    _nftTransfer.to!);
                                            for (Contact contact
                                                in widget.contactsRef!) {
                                              if (contact.address ==
                                                  uint8ListToHex(
                                                      _nftTransfer.to!)) {
                                                _sendAddressController!.text =
                                                    contact.name;
                                              }
                                            }

                                            _sendAmountController!.text =
                                                _nftTransfer.amount.toString();
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
                          nftTransferList.isEmpty
                              ? AppButtonType.PRIMARY_OUTLINE
                              : AppButtonType.PRIMARY,
                          widget.actionButtonTitle ??
                              AppLocalization.of(context).transferUCO,
                          Dimens.BUTTON_TOP_DIMENS, onPressed: () {
                        if (nftTransferList.isNotEmpty) {
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
                                        nftTransferList: nftTransferList,
                                        contactsRef: widget.contactsRef,
                                        title: widget.title,
                                        typeTransfer: 'NFT',
                                        localCurrency: null));
                              }
                            });
                          } else if (validRequest) {
                            Sheets.showAppHeightNineSheet(
                                context: context,
                                widget: TransferConfirmSheet(
                                    nftTransferList: nftTransferList,
                                    contactsRef: widget.contactsRef,
                                    title: widget.title,
                                    typeTransfer: 'NFT',
                                    localCurrency: null));
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
                              _sendAddressController!.text = contact.name;
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
                                      nftTransferList: nftTransferList,
                                      contactsRef: widget.contactsRef,
                                      title: widget.title,
                                      typeTransfer: 'NFT',
                                      localCurrency: null));
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

  // Determine if this is a max send or not by comparing balances
  bool _isMaxSend() {
    // Sanitize commas
    if (_sendAmountController!.text.isEmpty) {
      return false;
    }
    try {
      String textField = _sendAmountController!.text;

      String balance;

      balance = StateContainer.of(context)
          .wallet
          .getAccountBalanceUCODisplay()
          .replaceAll(r',', '');

      // Convert to Integer representations
      int textFieldInt;
      int balanceInt;

      textField = textField.replaceAll(',', '');
      textFieldInt = (Decimal.parse(textField) *
              Decimal.fromInt(pow(10, NumberUtil.maxDecimalDigits).toInt()))
          .toInt();
      balanceInt = (Decimal.parse(balance) *
              Decimal.fromInt(pow(10, NumberUtil.maxDecimalDigits).toInt()))
          .toInt();

      final int estimationFeesInt =
          (Decimal.parse(sl.get<AppService>().getFeesEstimation().toString()) *
                  Decimal.fromInt(pow(10, NumberUtil.maxDecimalDigits).toInt()))
              .toInt();

      return textFieldInt + estimationFeesInt == balanceInt;
    } catch (e) {
      return false;
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
              _sendAddressController!.text = contact.name;
              _sendAddressFocusNode!.unfocus();
              setState(() {
                _isContact = true;
                _showContactButton = false;
                _pasteButtonVisible = false;
                _sendAddressStyle = AddressStyle.PRIMARY;
              });
            },
            child: Text(contact.name,
                textAlign: TextAlign.center,
                style: AppStyles.textStyleAddressText90(context)),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          height: 1,
          color: StateContainer.of(context).curTheme.text03,
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

      final String amount = _rawAmount == null
          ? _sendAmountController!.text
          : NumberUtil.getRawAsUsableString(_rawAmount);
      final double balanceRaw =
          StateContainer.of(context).wallet.accountBalance.uco!;
      final int sendAmount = int.tryParse(amount)!;
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
        _addressValidationText = AppLocalization.of(context).addressMising;
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
              CurrencyFormatter(maxDecimalDigits: 4),
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

          final double estimationFees =
              sl.get<AppService>().getFeesEstimation();
          _sendAmountController!.text = StateContainer.of(context)
              .wallet
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
                    _sendAddressController!.text = contact.name;
                  }
                });
              }
            });
          },
        ),
        fadeSuffixOnCondition: true,
        suffixShowFirstCondition: _pasteButtonVisible,
        style: _sendAddressStyle == AddressStyle.TEXT60
            ? AppStyles.textStyleAddressText60(context)
            : _sendAddressStyle == AddressStyle.TEXT90
                ? AppStyles.textStyleAddressText90(context)
                : AppStyles.textStyleAddressText90(context),
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
                child: UIUtil.threeLineAddressText(
                    context, _sendAddressController!.text))
            : null);
  }

  bool isInUcoTransferList() {
    bool inList = false;
    String contactAddress = '';
    for (Contact contact in widget.contactsRef!) {
      if (contact.name == _sendAddressController!.text) {
        contactAddress = contact.address;
      }
    }

    for (int i = 0; i < nftTransferList.length; i++) {
      if (uint8ListToHex(nftTransferList[i].to!) ==
              _sendAddressController!.text ||
          uint8ListToHex(nftTransferList[i].to!) == contactAddress) {
        inList = true;
        break;
      }
    }
    return inList;
  }
}
