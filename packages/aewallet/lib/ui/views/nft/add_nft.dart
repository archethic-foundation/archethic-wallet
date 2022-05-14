/// SPDX-License-Identifier: AGPL-3.0-or-later
// ignore_for_file: avoid_unnecessary_containers

// Dart imports:
import 'dart:async';
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/widgets/components/app_text_field.dart';
import 'package:aeuniverse/ui/widgets/components/buttons.dart';
import 'package:aeuniverse/ui/widgets/components/icon_widget.dart';
import 'package:aeuniverse/ui/widgets/components/sheet_util.dart';
import 'package:aeuniverse/ui/widgets/components/tap_outside_unfocus.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' show ApiService;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/localization.dart';
import 'package:core/model/available_networks.dart';
import 'package:core/service/app_service.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core_ui/ui/util/dimens.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:aewallet/ui/views/nft/add_nft_confirm.dart';

class AddNFTSheet extends StatefulWidget {
  const AddNFTSheet({super.key, this.address});

  final String? address;

  @override
  State<AddNFTSheet> createState() => _AddNFTSheetState();
}

class _AddNFTSheetState extends State<AddNFTSheet> {
  FocusNode? _nameFocusNode;
  FocusNode? _initialSupplyFocusNode;
  TextEditingController? _nameController;
  TextEditingController? _initialSupplyController;

  String? _nameValidationText;
  String? _initialSupplyValidationText;

  bool? animationOpen;
  double feeEstimation = 0.0;
  bool? _isPressed;
  bool validRequest = true;

  @override
  void initState() {
    super.initState();
    _isPressed = false;
    _nameFocusNode = FocusNode();
    _initialSupplyFocusNode = FocusNode();
    _nameController = TextEditingController();
    _initialSupplyController = TextEditingController();
    _nameValidationText = '';
    _initialSupplyValidationText = '';
  }

  @override
  Widget build(BuildContext context) {
    final double bottom = MediaQuery.of(context).viewInsets.bottom;
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
                            AppLocalization.of(context)!.addNFTHeader,
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
                        _nameFocusNode!.unfocus();
                        _initialSupplyFocusNode!.unfocus();
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: const SizedBox.expand(),
                        constraints: const BoxConstraints.expand(),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: bottom + 80),
                        child: Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    StateContainer.of(context).showBalance
                                        ? Container(
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
                                                      text: StateContainer.of(
                                                              context)
                                                          .wallet!
                                                          .accountBalance
                                                          .getNetworkAccountBalanceDisplay(
                                                              networkCryptoCurrencyLabel:
                                                                  StateContainer.of(
                                                                          context)
                                                                      .curNetwork
                                                                      .getNetworkCryptoCurrencyLabel()),
                                                      style: AppStyles
                                                          .textStyleSize14W700Primary(
                                                              context)),
                                                  TextSpan(
                                                      text: ')',
                                                      style: AppStyles
                                                          .textStyleSize14W100Primary(
                                                              context)),
                                                ],
                                              ),
                                            ),
                                          )
                                        : const SizedBox(),
                                    AppTextField(
                                      topMargin: 30,
                                      focusNode: _nameFocusNode,
                                      controller: _nameController,
                                      cursorColor: StateContainer.of(context)
                                          .curTheme
                                          .primary,
                                      textInputAction: TextInputAction.next,
                                      labelText: AppLocalization.of(context)!
                                          .nftNameHint,
                                      keyboardType: TextInputType.text,
                                      style:
                                          AppStyles.textStyleSize16W600Primary(
                                              context),
                                      inputFormatters: <
                                          LengthLimitingTextInputFormatter>[
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
                                      margin: const EdgeInsets.only(
                                          top: 5, bottom: 5),
                                      child: Text(_nameValidationText!,
                                          style: AppStyles
                                              .textStyleSize14W600Primary(
                                                  context)),
                                    ),
                                    AppTextField(
                                      focusNode: _initialSupplyFocusNode,
                                      controller: _initialSupplyController,
                                      cursorColor: StateContainer.of(context)
                                          .curTheme
                                          .primary,
                                      textInputAction: TextInputAction.next,
                                      labelText: AppLocalization.of(context)!
                                          .nftInitialSupplyHint,
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              signed: false, decimal: false),
                                      style:
                                          AppStyles.textStyleSize16W600Primary(
                                              context),
                                      inputFormatters: <
                                          LengthLimitingTextInputFormatter>[
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
                                      margin: const EdgeInsets.only(
                                          top: 5, bottom: 5),
                                      child: Text(
                                        _initialSupplyValidationText!,
                                        style: AppStyles
                                            .textStyleSize14W600Primary(
                                                context),
                                      ),
                                    ),
                                    feeEstimation > 0
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                left: 30, right: 30),
                                            child: Text(
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
                                              textAlign: TextAlign.justify,
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                left: 30, right: 30),
                                            child: Text(
                                              AppLocalization.of(context)!
                                                  .estimatedFeesAddNFTNote,
                                              style: AppStyles
                                                  .textStyleSize14W100Primary(
                                                      context),
                                              textAlign: TextAlign.justify,
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
                      _isPressed == true
                          ? AppButton.buildAppButton(
                              const Key('addNFT'),
                              context,
                              AppButtonType.primaryOutline,
                              AppLocalization.of(context)!.addNFT,
                              Dimens.buttonTopDimens,
                              onPressed: () {},
                            )
                          : AppButton.buildAppButton(
                              const Key('addNFT'),
                              context,
                              AppButtonType.primary,
                              AppLocalization.of(context)!.addNFT,
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
                                    widget: AddNFTConfirm(
                                      nftName: _nameController!.text,
                                      feeEstimation: feeEstimation,
                                      nftInitialSupply: int.tryParse(
                                          _initialSupplyController!.text),
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

  Future<bool> _validateRequest() async {
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
      final String originPrivateKey = await sl.get<ApiService>().getOriginKey();
      fee = await sl.get<AppService>().getFeesEstimationAddNFT(
          originPrivateKey,
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
