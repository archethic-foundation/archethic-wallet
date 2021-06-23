// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

// Project imports:
import 'package:archethic_mobile_wallet/app_icons.dart';
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/bus/events.dart';
import 'package:archethic_mobile_wallet/dimens.dart';
import 'package:archethic_mobile_wallet/localization.dart';
import 'package:archethic_mobile_wallet/model/address.dart';
import 'package:archethic_mobile_wallet/model/db/appdb.dart';
import 'package:archethic_mobile_wallet/model/db/contact.dart';
import 'package:archethic_mobile_wallet/service_locator.dart';
import 'package:archethic_mobile_wallet/styles.dart';
import 'package:archethic_mobile_wallet/ui/util/formatters.dart';
import 'package:archethic_mobile_wallet/ui/util/ui_util.dart';
import 'package:archethic_mobile_wallet/ui/widgets/app_text_field.dart';
import 'package:archethic_mobile_wallet/ui/widgets/buttons.dart';
import 'package:archethic_mobile_wallet/ui/widgets/tap_outside_unfocus.dart';
import 'package:archethic_mobile_wallet/util/user_data_util.dart';

class AddContactSheet extends StatefulWidget {
  const AddContactSheet({this.address}) : super();

  final String? address;

  @override
  _AddContactSheetState createState() => _AddContactSheetState();
}

class _AddContactSheetState extends State<AddContactSheet> {
  FocusNode? _nameFocusNode;
  FocusNode? _addressFocusNode;
  TextEditingController? _nameController;
  TextEditingController? _addressController;

  // State variables
  bool? _addressValid;
  bool? _showPasteButton;
  bool? _showNameHint;
  bool? _showAddressHint;
  bool? _addressValidAndUnfocused;
  String? _nameValidationText;
  String? _addressValidationText;

  @override
  void initState() {
    super.initState();
    // Text field initialization
    _nameFocusNode = FocusNode();
    _addressFocusNode = FocusNode();
    _nameController = TextEditingController();
    _addressController = TextEditingController();
    // State initializationrue;
    _addressValid = false;
    _showPasteButton = true;
    _showNameHint = true;
    _showAddressHint = true;
    _addressValidAndUnfocused = false;
    _nameValidationText = '';
    _addressValidationText = '';
    // Add focus listeners
    // On name focus change
    _nameFocusNode!.addListener(() {
      if (_nameFocusNode!.hasFocus) {
        setState(() {
          _showNameHint = false;
        });
      } else {
        setState(() {
          _showNameHint = true;
        });
      }
    });
    // On address focus change
    _addressFocusNode!.addListener(() {
      if (_addressFocusNode!.hasFocus) {
        setState(() {
          _showAddressHint = false;
          _addressValidAndUnfocused = false;
        });
        _addressController!.selection = TextSelection.fromPosition(
            TextPosition(offset: _addressController!.text.length));
      } else {
        setState(() {
          _showAddressHint = true;
          if (Address(_addressController!.text).isValid()) {
            _addressValidAndUnfocused = true;
          }
        });
      }
    });
  }

  /// Return true if textfield should be shown, false if colorized should be shown
  bool _shouldShowTextField() {
    if (widget.address != null) {
      return false;
    } else if (_addressValidAndUnfocused!) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return TapOutsideUnfocus(
        child: SafeArea(
      minimum:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.035),
      child: Column(
        children: <Widget>[
          // Top row of the sheet which contains the header and the scan qr button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                width: 60,
                height: 40,
              ),
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
                ],
              ), // Empty SizedBox
              const SizedBox(
                width: 60,
                height: 40,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // The header of the sheet
              AutoSizeText(
                AppLocalization.of(context).addContact,
                style: AppStyles.textStyleHeader(context),
                textAlign: TextAlign.center,
                maxLines: 1,
                stepGranularity: 0.1,
              ),
            ],
          ),
          const SizedBox(height: 30),
          Container(
            margin: const EdgeInsets.only(left: 30, right: 30),
            child: AutoSizeText(
              AppLocalization.of(context).addressBookDesc,
              style: AppStyles.textStyleParagraph(context),
              textAlign: TextAlign.center,
              maxLines: 1,
              stepGranularity: 0.1,
            ),
          ),

          // The main container that holds "Enter Name" and "Enter Address" text fields
          Expanded(
            child: KeyboardAvoider(
              duration: const Duration(milliseconds: 0),
              autoScroll: true,
              focusPadding: 40,
              child: Column(
                children: <Widget>[
                  // Enter Name Container
                  AppTextField(
                    topMargin: MediaQuery.of(context).size.height * 0.14,
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    focusNode: _nameFocusNode,
                    controller: _nameController,
                    textInputAction: widget.address != null
                        ? TextInputAction.done
                        : TextInputAction.next,
                    hintText: _showNameHint!
                        ? AppLocalization.of(context).contactNameHint
                        : '',
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                      color: StateContainer.of(context).curTheme.text,
                      fontFamily: 'Montserrat',
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(20),
                      ContactInputFormatter()
                    ],
                    onSubmitted: (String text) {
                      if (widget.address == null) {
                        if (!Address(_addressController!.text).isValid()) {
                          FocusScope.of(context)
                              .requestFocus(_addressFocusNode);
                        } else {
                          FocusScope.of(context).unfocus();
                        }
                      } else {
                        FocusScope.of(context).unfocus();
                      }
                    },
                  ),
                  // Enter Name Error Container
                  Container(
                    margin: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(_nameValidationText!,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: StateContainer.of(context).curTheme.primary,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                  // Enter Address container
                  AppTextField(
                    padding: !_shouldShowTextField()
                        ? const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 15.0)
                        : EdgeInsets.zero,
                    focusNode: _addressFocusNode,
                    controller: _addressController,
                    style: _addressValid!
                        ? AppStyles.textStyleAddressText90(context)
                        : AppStyles.textStyleAddressText60(context),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(66),
                    ],
                    textInputAction: TextInputAction.done,
                    maxLines: null,
                    autocorrect: false,
                    hintText: _showAddressHint!
                        ? AppLocalization.of(context).addressHint
                        : '',
                    prefixButton: TextFieldButton(
                        icon: AppIcons.scan,
                        onPressed: () async {
                          UIUtil.cancelLockEvent();
                          final String scanResult =
                              await UserDataUtil.getQRData(
                                  DataType.ADDRESS, context);
                          if (!QRScanErrs.ERROR_LIST.contains(scanResult)) {
                            if (mounted) {
                              setState(() {
                                _addressController!.text = scanResult;
                                _addressValidationText = '';
                                _addressValid = true;
                                _addressValidAndUnfocused = true;
                              });
                              _addressFocusNode!.unfocus();
                            }
                          }
                        }),
                    fadePrefixOnCondition: true,
                    prefixShowFirstCondition: _showPasteButton,
                    suffixButton: TextFieldButton(
                      icon: AppIcons.paste,
                      onPressed: () async {
                        if (!_showPasteButton!) {
                          return;
                        }
                        final String data = await UserDataUtil.getClipboardText(
                            DataType.ADDRESS);
                        if (data != null) {
                          setState(() {
                            _addressValid = true;
                            _showPasteButton = false;
                            _addressController!.text = data;
                            _addressValidAndUnfocused = true;
                          });
                          _addressFocusNode!.unfocus();
                        } else {
                          setState(() {
                            _showPasteButton = true;
                            _addressValid = false;
                          });
                        }
                      },
                    ),
                    fadeSuffixOnCondition: true,
                    suffixShowFirstCondition: _showPasteButton,
                    onChanged: (String text) {
                      /*Address address = Address(text);
                      if (address.isValid()) {
                            setState(() {
                              _addressValid = true;
                              _showPasteButton = true;
                              _addressController.text =
                                  address.address;
                            });
                            _addressFocusNode.unfocus();
                          } else {
                            setState(() {
                              _showPasteButton = true;
                              _addressValid = false;
                            });
                          }*/
                      setState(() {
                        _showPasteButton = true;
                        _addressValid = false;
                      });
                    },
                    overrideTextFieldWidget: !_shouldShowTextField()
                        ? GestureDetector(
                            onTap: () {
                              if (widget.address != null) {
                                return;
                              }
                              setState(() {
                                _addressValidAndUnfocused = false;
                              });
                              Future.delayed(const Duration(milliseconds: 50),
                                  () {
                                FocusScope.of(context)
                                    .requestFocus(_addressFocusNode);
                              });
                            },
                            child: UIUtil.threeLineAddressText(context,
                                widget.address ?? _addressController!.text))
                        : null,
                  ),
                  // Enter Address Error Container
                  Container(
                    margin: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(_addressValidationText!,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: StateContainer.of(context).curTheme.primary,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                ],
              ),
            ),
          ),
          //A column with "Add Contact" and "Close" buttons
          Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    // Add Contact Button
                    AppButton.buildAppButton(
                        context,
                        AppButtonType.PRIMARY,
                        AppLocalization.of(context).addContact,
                        Dimens.BUTTON_TOP_DIMENS, onPressed: () async {
                      if (await validateForm()) {
                        final Contact newContact = Contact(
                            name: _nameController!.text,
                            address:
                                widget.address ?? _addressController!.text);
                        await sl.get<DBHelper>().saveContact(newContact);

                        EventTaxiImpl.singleton()
                            .fire(ContactAddedEvent(contact: newContact));
                        UIUtil.showSnackbar(
                            AppLocalization.of(context)
                                .contactAdded
                                .replaceAll('%1', newContact.name),
                            context);
                        EventTaxiImpl.singleton()
                            .fire(ContactModifiedEvent(contact: newContact));
                        Navigator.of(context).pop();
                      }
                    }),
                  ],
                ),
                Row(
                  children: <Widget>[
                    // Close Button
                    AppButton.buildAppButton(
                        context,
                        AppButtonType.PRIMARY,
                        AppLocalization.of(context).close,
                        Dimens.BUTTON_BOTTOM_DIMENS, onPressed: () {
                      Navigator.pop(context);
                    }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Future<bool> validateForm() async {
    bool isValid = true;
    // Address Validations
    // Don't validate address if it came pre-filled in
    if (widget.address == null) {
      if (_addressController!.text.isEmpty) {
        isValid = false;
        setState(() {
          _addressValidationText = AppLocalization.of(context).addressMising;
        });
      } else if (!Address(_addressController!.text).isValid()) {
        isValid = false;
        setState(() {
          _addressValidationText = AppLocalization.of(context).invalidAddress;
        });
      } else {
        _addressFocusNode!.unfocus();
        final bool addressExists = await sl
            .get<DBHelper>()
            .contactExistsWithAddress(_addressController!.text);
        if (addressExists) {
          setState(() {
            isValid = false;
            _addressValidationText = AppLocalization.of(context).contactExists;
          });
        }
      }
    }
    // Name Validations
    if (_nameController!.text.isEmpty) {
      isValid = false;
      setState(() {
        _nameValidationText = AppLocalization.of(context).contactNameMissing;
      });
    } else {
      final bool nameExists =
          await sl.get<DBHelper>().contactExistsWithName(_nameController!.text);
      if (nameExists) {
        setState(() {
          isValid = false;
          _nameValidationText = AppLocalization.of(context).contactExists;
        });
      }
    }
    return isValid;
  }
}
