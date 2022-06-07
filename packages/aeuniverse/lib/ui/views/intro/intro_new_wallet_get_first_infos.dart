/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/localization.dart';
import 'package:core_ui/ui/util/dimens.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/model/available_networks.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/widgets/components/app_text_field.dart';
import 'package:aeuniverse/ui/widgets/components/buttons.dart';
import 'package:aeuniverse/ui/widgets/components/picker_item.dart';
import 'package:aeuniverse/util/preferences.dart';
import 'package:aeuniverse/util/service_locator.dart';

class IntroNewWalletGetFirstInfos extends StatefulWidget {
  const IntroNewWalletGetFirstInfos({super.key});

  @override
  State<IntroNewWalletGetFirstInfos> createState() =>
      _IntroNewWalletDisclaimerState();
}

class _IntroNewWalletDisclaimerState
    extends State<IntroNewWalletGetFirstInfos> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  FocusNode nameFocusNode = FocusNode();
  TextEditingController nameController = TextEditingController();
  String? nameError;
  NetworksSetting _curNetworksSetting =
      NetworksSetting(AvailableNetworks.ArchethicTestNet);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              StateContainer.of(context).curTheme.backgroundDark!,
              StateContainer.of(context).curTheme.background!
            ],
          ),
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) =>
              SafeArea(
            minimum: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.035,
                top: MediaQuery.of(context).size.height * 0.075),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsetsDirectional.only(
                                  start: smallScreen(context) ? 15 : 20),
                              height: 50,
                              width: 50,
                              child: BackButton(
                                key: const Key('back'),
                                color:
                                    StateContainer.of(context).curTheme.primary,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsetsDirectional.only(
                              start: 20, end: 20, top: 15.0),
                          alignment: Alignment.bottomLeft,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                const SizedBox(
                                  height: 30,
                                ),
                                AutoSizeText(
                                  AppLocalization.of(context)!
                                      .introNewWalletGetFirstInfosWelcome,
                                  style: AppStyles.textStyleSize20W700Primary(
                                      context),
                                  textAlign: TextAlign.left,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                AutoSizeText(
                                  AppLocalization.of(context)!
                                      .introNewWalletGetFirstInfosNameRequest,
                                  style: AppStyles.textStyleSize16W600Primary(
                                      context),
                                  textAlign: TextAlign.left,
                                ),
                                AppTextField(
                                  topMargin: 0,
                                  leftMargin: 0,
                                  rightMargin: 0,
                                  focusNode: nameFocusNode,
                                  autocorrect: false,
                                  controller: nameController,
                                  keyboardType: TextInputType.text,
                                  style: AppStyles.textStyleSize14W600Primary(
                                      context),
                                  inputFormatters: <TextInputFormatter>[
                                    LengthLimitingTextInputFormatter(20),
                                  ],
                                ),
                                nameError != null
                                    ? Container(
                                        height: 40,
                                        child: Text(nameError!,
                                            style: AppStyles
                                                .textStyleSize14W600Primary(
                                                    context)),
                                      )
                                    : const SizedBox(
                                        height: 40,
                                      ),
                                AutoSizeText(
                                  AppLocalization.of(context)!
                                      .introNewWalletGetFirstInfosNameInfos,
                                  style: AppStyles.textStyleSize14W600Primary(
                                      context),
                                  textAlign: TextAlign.justify,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),

                // Next Screen Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AppButton.buildAppButton(
                        const Key('okButton'),
                        context,
                        AppButtonType.primary,
                        AppLocalization.of(context)!.ok,
                        Dimens.buttonBottomDimens, onPressed: () async {
                      nameError = '';
                      if (nameController.text.isEmpty) {
                        setState(() {
                          nameError = AppLocalization.of(context)!
                              .introNewWalletGetFirstInfosNameBlank;
                          FocusScope.of(context).requestFocus(nameFocusNode);
                        });
                      } else {
                        if (nameController.text.contains('/') == true) {
                          setState(() {
                            nameError = AppLocalization.of(context)!
                                .introNewWalletGetFirstInfosNameSlash;
                            FocusScope.of(context).requestFocus(nameFocusNode);
                          });
                        } else {
                          await _networkDialog();
                          Navigator.of(context).pushNamed(
                              '/intro_backup_safety',
                              arguments: nameController.text);
                        }
                      }
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _networkDialog() async {
    FocusNode endpointFocusNode = FocusNode();
    TextEditingController endpointController = TextEditingController();
    String? endpointError;

    final Preferences preferences = await Preferences.getInstance();
    final List<PickerItem> pickerItemsList =
        List<PickerItem>.empty(growable: true);
    for (var value in AvailableNetworks.values) {
      pickerItemsList.add(PickerItem(
          NetworksSetting(value).getDisplayName(context),
          await NetworksSetting(value).getLink(),
          'packages/core_ui/assets/themes/dark/logo_alone.png',
          NetworksSetting(value).getColor(),
          value,
          value == AvailableNetworks.ArchethicMainNet ? false : true));
    }

    final AvailableNetworks? selection = await showDialog<AvailableNetworks>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Column(
                children: [
                  Text(
                    AppLocalization.of(context)!
                        .introNewWalletGetFirstInfosNetworkHeader,
                    style: AppStyles.textStyleSize20W700Primary(context),
                  ),
                ],
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                side: BorderSide(
                    color: StateContainer.of(context).curTheme.primary45!)),
            content: PickerWidget(
              pickerItems: pickerItemsList,
              selectedIndex: _curNetworksSetting.getIndex(),
              onSelected: (value) {
                Navigator.pop(context, value.value);
              },
            ),
          );
        });
    if (selection != null) {
      preferences.setNetwork(NetworksSetting(selection));
      setState(() {
        _curNetworksSetting = NetworksSetting(selection);
        StateContainer.of(context).curNetwork = _curNetworksSetting;
      });
      if (selection == AvailableNetworks.ArchethicDevNet) {
        endpointController.text = preferences.getNetworkDevEndpoint();
        final AvailableNetworks? endpoint = await showDialog<AvailableNetworks>(
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return AlertDialog(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Column(children: [
                        SvgPicture.asset(
                          StateContainer.of(context).curTheme.assetsFolder! +
                              StateContainer.of(context).curTheme.logoAlone! +
                              '.svg',
                          color: Colors.orange,
                          height: 15,
                        ),
                        Text(
                            StateContainer.of(context)
                                .curNetwork
                                .getDisplayName(context),
                            style:
                                AppStyles.textStyleSize10W100Primary(context)),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          AppLocalization.of(context)!.enterEndpointHeader,
                          style: AppStyles.textStyleSize16W400Primary(context),
                        ),
                      ]),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16.0)),
                        side: BorderSide(
                            color: StateContainer.of(context)
                                .curTheme
                                .primary45!)),
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            AppTextField(
                              leftMargin: 0,
                              rightMargin: 0,
                              focusNode: endpointFocusNode,
                              controller: endpointController,
                              labelText:
                                  AppLocalization.of(context)!.enterEndpoint,
                              keyboardType: TextInputType.text,
                              style:
                                  AppStyles.textStyleSize14W600Primary(context),
                              inputFormatters: <TextInputFormatter>[
                                LengthLimitingTextInputFormatter(28),
                              ],
                            ),
                            Text(
                              'http://xxx.xxx.xxx.xxx:xxxx',
                              style:
                                  AppStyles.textStyleSize12W400Primary(context),
                            ),
                            endpointError != null
                                ? Container(
                                    margin: const EdgeInsets.only(
                                        top: 5, bottom: 5),
                                    child: Text(endpointError!,
                                        style: AppStyles
                                            .textStyleSize14W600Primary(
                                                context)),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                        Row(
                          children: [
                            AppButton.buildAppButton(
                              const Key('addEndpoint'),
                              context,
                              AppButtonType.primary,
                              AppLocalization.of(context)!.ok,
                              Dimens.buttonTopDimens,
                              onPressed: () async {
                                endpointError = '';
                                if (endpointController.text.isEmpty) {
                                  setState(() {
                                    endpointError = AppLocalization.of(context)!
                                        .enterEndpointBlank;
                                    FocusScope.of(context)
                                        .requestFocus(endpointFocusNode);
                                  });
                                } else {
                                  if (Uri.parse(endpointController.text)
                                          .isAbsolute ==
                                      false) {
                                    setState(() {
                                      endpointError =
                                          AppLocalization.of(context)!
                                              .enterEndpointNotValid;
                                      FocusScope.of(context)
                                          .requestFocus(endpointFocusNode);
                                    });
                                  } else {
                                    preferences.setNetworkDevEndpoint(
                                        endpointController.text);
                                    Navigator.pop(context);
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            });
      }
      setupServiceLocator();
    }
  }
}
