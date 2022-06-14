/// SPDX-License-Identifier: AGPL-3.0-or-later
// ignore_for_file: avoid_unnecessary_containers

// Flutter imports:
import 'package:aeuniverse/model/available_networks.dart';
import 'package:aeuniverse/ui/widgets/components/app_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aeuniverse/ui/widgets/components/picker_item.dart';
import 'package:aeuniverse/util/preferences.dart';
import 'package:aeuniverse/util/service_locator.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/localization.dart';
import 'package:core_ui/ui/util/dimens.dart';

// Project imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/util/ui_util.dart';
import 'package:aeuniverse/ui/widgets/components/buttons.dart';
import 'package:flutter/services.dart';

class IntroWelcome extends StatefulWidget {
  const IntroWelcome({super.key});

  @override
  State<IntroWelcome> createState() => _IntroWelcomeState();
}

class _IntroWelcomeState extends State<IntroWelcome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool checkedValue = false;
  NetworksSetting _curNetworksSetting =
      NetworksSetting(AvailableNetworks.ArchethicTestNet);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          Container(
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
            child: StateContainer.of(context)
                .curTheme
                .getBackgroundScreen(context)!,
          ),
          LayoutBuilder(
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20.0),
                                child: SizedBox(
                                  height: 200,
                                  child: AspectRatio(
                                      aspectRatio: 3 / 1,
                                      child: Image.asset(
                                        StateContainer.of(context)
                                                .curTheme
                                                .assetsFolder! +
                                            StateContainer.of(context)
                                                .curTheme
                                                .logo! +
                                            '.png',
                                        height: 200,
                                      )),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 20, right: 20, left: 20),
                            child: AutoSizeText(
                              AppLocalization.of(context)!.welcomeText,
                              maxLines: 5,
                              style:
                                  AppStyles.textStyleSize20W700Primary(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 15, right: 15),
                                  child: CheckboxListTile(
                                    title: Text(
                                        AppLocalization.of(context)!
                                            .welcomeDisclaimerChoice,
                                        style: AppStyles
                                            .textStyleSize14W600Primary(
                                                context)),
                                    value: checkedValue,
                                    tristate: false,
                                    onChanged: (newValue) {
                                      setState(() {
                                        checkedValue = newValue!;
                                      });
                                    },
                                    checkColor: StateContainer.of(context)
                                        .curTheme
                                        .background,
                                    activeColor: StateContainer.of(context)
                                        .curTheme
                                        .text,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    secondary: IconButton(
                                        icon: Icon(Icons.read_more),
                                        iconSize: 30,
                                        color: StateContainer.of(context)
                                            .curTheme
                                            .backgroundDarkest,
                                        onPressed: () {
                                          UIUtil.showWebview(
                                              context,
                                              'https://archethic.net',
                                              AppLocalization.of(context)!
                                                  .welcomeDisclaimerLink);
                                        }),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          AppButton.buildAppButton(
                            const Key('newWallet'),
                            context,
                            checkedValue
                                ? AppButtonType.primary
                                : AppButtonType.primaryOutline,
                            AppLocalization.of(context)!.newWallet,
                            Dimens.buttonTopDimens,
                            onPressed: () async {
                              if (checkedValue) {
                                await _networkDialog();
                                Navigator.of(context).pushNamed(
                                  '/intro_welcome_get_first_infos',
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          // Import Wallet Button
                          AppButton.buildAppButton(
                            const Key('importWallet'),
                            context,
                            checkedValue
                                ? AppButtonType.primary
                                : AppButtonType.primaryOutline,
                            AppLocalization.of(context)!.importWallet,
                            Dimens.buttonBottomDimens,
                            onPressed: () async {
                              if (checkedValue) {
                                await _networkDialog();
                                Navigator.of(context)
                                    .pushNamed('/intro_import');
                              }
                            },
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
                    color: StateContainer.of(context).curTheme.text45!)),
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
                            color:
                                StateContainer.of(context).curTheme.text45!)),
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
