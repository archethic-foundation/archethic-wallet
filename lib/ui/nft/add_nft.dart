// Flutter imports:
import 'dart:async';

import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:archethic_mobile_wallet/bus/events.dart';
import 'package:archethic_mobile_wallet/bus/nft_add_event.dart';
import 'package:archethic_mobile_wallet/global_var.dart';
import 'package:archethic_mobile_wallet/model/authentication_method.dart';
import 'package:archethic_mobile_wallet/model/vault.dart';
import 'package:archethic_mobile_wallet/service/app_service.dart';
import 'package:archethic_mobile_wallet/service_locator.dart';
import 'package:archethic_mobile_wallet/ui/nft/add_nft_confirm.dart';
import 'package:archethic_mobile_wallet/ui/transfer/transfer_complete_sheet.dart';
import 'package:archethic_mobile_wallet/ui/util/ui_util.dart';
import 'package:archethic_mobile_wallet/ui/widgets/dialog.dart';
import 'package:archethic_mobile_wallet/ui/widgets/pin_screen.dart';
import 'package:archethic_mobile_wallet/ui/widgets/sheet_util.dart';
import 'package:archethic_mobile_wallet/util/biometrics.dart';
import 'package:archethic_mobile_wallet/util/hapticutil.dart';
import 'package:archethic_mobile_wallet/util/sharedprefsutil.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/dimens.dart';
import 'package:archethic_mobile_wallet/localization.dart';
import 'package:archethic_mobile_wallet/styles.dart';
import 'package:archethic_mobile_wallet/ui/widgets/app_text_field.dart';
import 'package:archethic_mobile_wallet/ui/widgets/buttons.dart';
import 'package:archethic_mobile_wallet/ui/widgets/tap_outside_unfocus.dart';

class AddNFTSheet extends StatefulWidget {
  const AddNFTSheet({this.address}) : super();

  final String? address;

  @override
  _AddNFTSheetState createState() => _AddNFTSheetState();
}

class _AddNFTSheetState extends State<AddNFTSheet> {
  FocusNode? _nameFocusNode;
  FocusNode? _initialSupplyFocusNode;
  TextEditingController? _nameController;
  TextEditingController? _initialSupplyController;

  bool? _showNameHint;
  bool? _showInitialSupplyHint;
  String? _nameValidationText;
  String? _initialSupplyValidationText;

  bool? animationOpen;

  void _showSendingAnimation(BuildContext context) {
    animationOpen = true;
    Navigator.of(context).push(AnimationLoadingOverlay(
        AnimationType.SEND,
        StateContainer.of(context).curTheme.animationOverlayStrong,
        StateContainer.of(context).curTheme.animationOverlayMedium,
        onPoppedCallback: () => animationOpen = false));
  }

  @override
  void initState() {
    super.initState();
    _nameFocusNode = FocusNode();
    _initialSupplyFocusNode = FocusNode();
    _nameController = TextEditingController();
    _initialSupplyController = TextEditingController();
    _showNameHint = true;
    _showInitialSupplyHint = true;
    _nameValidationText = '';
    _initialSupplyValidationText = '';
    // Add focus listeners
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
    _initialSupplyFocusNode!.addListener(() {
      if (_initialSupplyFocusNode!.hasFocus) {
        setState(() {
          _showInitialSupplyHint = false;
        });
      } else {
        setState(() {
          _showInitialSupplyHint = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                height: 40,
              ),
              Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: 5,
                    width: MediaQuery.of(context).size.width * 0.15,
                    decoration: BoxDecoration(
                      color: StateContainer.of(context).curTheme.primary10,
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 60,
                height: 40,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AutoSizeText(
                AppLocalization.of(context).addNFTHeader,
                style: AppStyles.textStyleLargerW700Primary(context),
                textAlign: TextAlign.center,
                maxLines: 1,
                stepGranularity: 0.1,
              ),
            ],
          ),
          const SizedBox(height: 30),
          Expanded(
            child: KeyboardAvoider(
              duration: const Duration(milliseconds: 0),
              autoScroll: true,
              focusPadding: 40,
              child: Column(
                children: <Widget>[
                  Text(
                    AppLocalization.of(context).nftNameHint,
                    style: AppStyles.textStyleMediumW200Primary(context),
                  ),
                  AppTextField(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    focusNode: _nameFocusNode,
                    controller: _nameController,
                    textInputAction: TextInputAction.next,
                    hintText: _showNameHint!
                        ? AppLocalization.of(context).nftNameHint
                        : '',
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                      color: StateContainer.of(context).curTheme.primary,
                      fontFamily: 'Montserrat',
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(100),
                    ],
                  ),
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
                  const SizedBox(height: 30),
                  Text(
                    AppLocalization.of(context).nftInitialSupplyHint,
                    style: AppStyles.textStyleMediumW200Primary(context),
                  ),
                  AppTextField(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    focusNode: _initialSupplyFocusNode,
                    controller: _initialSupplyController,
                    textInputAction: TextInputAction.done,
                    hintText: _showInitialSupplyHint!
                        ? AppLocalization.of(context).nftInitialSupplyHint
                        : '',
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                      color: StateContainer.of(context).curTheme.primary,
                      fontFamily: 'Montserrat',
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(_initialSupplyValidationText!,
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
          Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    // Add Contact Button
                    AppButton.buildAppButton(
                        context,
                        AppButtonType.PRIMARY,
                        AppLocalization.of(context).addNFT,
                        Dimens.BUTTON_TOP_DIMENS, onPressed: () async {
                      if (await validateForm()) {
                        Sheets.showAppHeightNineSheet(
                            context: context,
                            widget: AddNFTConfirm(
                              nftName: _nameController!.text,
                              nftInitialSupply:
                                  int.tryParse(_initialSupplyController!.text),
                            ));
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
    setState(() {
      _nameValidationText = '';
      _initialSupplyValidationText = '';
    });
    if (_nameController!.text.isEmpty) {
      isValid = false;
      setState(() {
        _nameValidationText = AppLocalization.of(context).nftNameMissing;
      });
    }
    if (_initialSupplyController!.text.isEmpty) {
      isValid = false;
      setState(() {
        _initialSupplyValidationText =
            AppLocalization.of(context).nftInitialSupplyMissing;
      });
    } else {
      if (int.tryParse(_initialSupplyController!.text) == null ||
          int.tryParse(_initialSupplyController!.text)!.isNegative) {
        isValid = false;
        setState(() {
          _initialSupplyValidationText =
              AppLocalization.of(context).nftInitialSupplyPositive;
        });
      }
    }
    return isValid;
  }
}
