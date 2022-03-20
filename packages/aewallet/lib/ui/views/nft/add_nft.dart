// Dart imports:
// ignore_for_file: avoid_unnecessary_containers

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:aewallet/ui/views/nft/add_nft_confirm.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/localization.dart';
import 'package:core/service/app_service.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core/util/global_var.dart';
import 'package:core_ui/ui/util/dimens.dart';
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/widgets/components/app_text_field.dart';
import 'package:aeuniverse/ui/widgets/components/buttons.dart';
import 'package:aeuniverse/ui/widgets/components/sheet_util.dart';
import 'package:aeuniverse/ui/widgets/components/tap_outside_unfocus.dart';

class AddNFTSheet extends StatefulWidget {
  const AddNFTSheet({Key? key, this.address}) : super(key: key);

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
  double feeEstimation = 0.0;

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
                      color: StateContainer.of(context).curTheme.primary60,
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
                AppLocalization.of(context)!.addNFTHeader,
                style: AppStyles.textStyleSize24W700Primary(context),
                textAlign: TextAlign.center,
                maxLines: 1,
                stepGranularity: 0.1,
              ),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                text: '',
                children: <InlineSpan>[
                  TextSpan(
                    text: '(',
                    style: AppStyles.textStyleSize14W100Primary(context),
                  ),
                  TextSpan(
                      text: StateContainer.of(context)
                          .wallet!
                          .getAccountBalanceUCODisplay(),
                      style: AppStyles.textStyleSize14W700Primary(context)),
                  TextSpan(
                      text: ' UCO)',
                      style: AppStyles.textStyleSize14W100Primary(context)),
                ],
              ),
            ),
          ),
          feeEstimation > 0
              ? Text(
                  AppLocalization.of(context)!.estimatedFees +
                      ': ' +
                      feeEstimation.toString() +
                      ' UCO',
                  style: AppStyles.textStyleSize14W100Primary(context))
              : Text(AppLocalization.of(context)!.estimatedFeesAddNFTNote,
                  style: AppStyles.textStyleSize14W100Primary(context)),
          const SizedBox(height: 30),
          Expanded(
            child: Column(
              children: <Widget>[
                Text(
                  AppLocalization.of(context)!.nftNameHint,
                  style: AppStyles.textStyleSize16W200Primary(context),
                ),
                AppTextField(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  focusNode: _nameFocusNode,
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  hintText: _showNameHint!
                      ? AppLocalization.of(context)!.nftNameHint
                      : '',
                  keyboardType: TextInputType.text,
                  style: AppStyles.textStyleSize16W600Primary(context),
                  inputFormatters: <LengthLimitingTextInputFormatter>[
                    LengthLimitingTextInputFormatter(100),
                  ],
                  onChanged: (_) async {
                    double _fee = await getFee();
                    // Always reset the error message to be less annoying
                    setState(() {
                      feeEstimation = _fee;
                    });
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(_nameValidationText!,
                      style: AppStyles.textStyleSize14W600Primary(context)),
                ),
                const SizedBox(height: 30),
                Text(
                  AppLocalization.of(context)!.nftInitialSupplyHint,
                  style: AppStyles.textStyleSize16W200Primary(context),
                ),
                AppTextField(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  focusNode: _initialSupplyFocusNode,
                  controller: _initialSupplyController,
                  textInputAction: TextInputAction.done,
                  hintText: _showInitialSupplyHint!
                      ? AppLocalization.of(context)!.nftInitialSupplyHint
                      : '',
                  keyboardType: TextInputType.number,
                  style: AppStyles.textStyleSize16W600Primary(context),
                  inputFormatters: <LengthLimitingTextInputFormatter>[
                    LengthLimitingTextInputFormatter(10),
                  ],
                  onChanged: (_) async {
                    double _fee = await getFee();
                    // Always reset the error message to be less annoying
                    setState(() {
                      feeEstimation = _fee;
                    });
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    _initialSupplyValidationText!,
                    style: AppStyles.textStyleSize14W600Primary(context),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    // Add Contact Button
                    AppButton.buildAppButton(
                        const Key('addNFT'),
                        context,
                        AppButtonType.primary,
                        AppLocalization.of(context)!.addNFT,
                        Dimens.buttonTopDimens, onPressed: () async {
                      if (await validateForm()) {
                        Sheets.showAppHeightNineSheet(
                            context: context,
                            widget: AddNFTConfirm(
                              nftName: _nameController!.text,
                              feeEstimation: feeEstimation,
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
                        const Key('close'),
                        context,
                        AppButtonType.primary,
                        AppLocalization.of(context)!.close,
                        Dimens.buttonBottomDimens, onPressed: () {
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
        _nameValidationText = AppLocalization.of(context)!.nftNameMissing;
      });
    }
    if (_initialSupplyController!.text.isEmpty) {
      isValid = false;
      setState(() {
        _initialSupplyValidationText =
            AppLocalization.of(context)!.nftInitialSupplyMissing;
      });
    } else {
      if (int.tryParse(_initialSupplyController!.text) == null ||
          int.tryParse(_initialSupplyController!.text)! < 0) {
        isValid = false;
        setState(() {
          _initialSupplyValidationText =
              AppLocalization.of(context)!.nftInitialSupplyPositive;
        });
      }
    }
    // Estimation of fees
    feeEstimation = await getFee();
    return isValid;
  }

  Future<double> getFee() async {
    double fee = 0;
    if (_initialSupplyController!.text.isEmpty ||
        _nameController!.text.isEmpty) {
      return fee;
    }
    try {
      final String transactionChainSeed =
          await StateContainer.of(context).getSeed();

      fee = await sl.get<AppService>().getFeesEstimationAddNFT(
          globalVarOriginPrivateKey,
          transactionChainSeed,
          StateContainer.of(context).selectedAccount.lastAddress!,
          _nameController!.text,
          int.tryParse(_initialSupplyController!.text)!);
    } catch (e) {
      fee = 0;
    }
    return fee;
  }
}
