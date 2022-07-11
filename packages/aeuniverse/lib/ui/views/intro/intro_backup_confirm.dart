/// SPDX-License-Identifier: AGPL-3.0-or-later

// ignore_for_file: always_specify_types

// Flutter imports:
import 'package:aeuniverse/ui/util/ui_util.dart';
import 'package:core/util/mnemonics.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/localization.dart';
import 'package:core/model/authentication_method.dart';
import 'package:core/util/biometrics_util.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core_ui/ui/util/dimens.dart';

// Project imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/widgets/components/buttons.dart';
import 'package:aeuniverse/ui/widgets/components/picker_item.dart';

class IntroBackupConfirm extends StatefulWidget {
  final String? name;
  final String? seed;
  const IntroBackupConfirm({required this.name, required this.seed, super.key});

  @override
  State<IntroBackupConfirm> createState() => _IntroBackupConfirmState();
}

class _IntroBackupConfirmState extends State<IntroBackupConfirm> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> wordListSelected = List<String>.empty(growable: true);
  List<String> wordListToSelect = List<String>.empty(growable: true);
  List<String> originalWordsList = List<String>.empty(growable: true);
  @override
  void initState() {
    super.initState();
    wordListToSelect = AppMnemomics.seedToMnemonic(widget.seed!);
    wordListToSelect.shuffle();
    originalWordsList = AppMnemomics.seedToMnemonic(widget.seed!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  StateContainer.of(context).curTheme.background3Small!),
              fit: BoxFit.fitHeight),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsetsDirectional.only(start: 15),
                            height: 50,
                            width: 50,
                            child: BackButton(
                              key: const Key('back'),
                              color: StateContainer.of(context).curTheme.text,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsetsDirectional.only(
                                  start: 20,
                                  end: 20,
                                  top: 10,
                                ),
                                alignment: const AlignmentDirectional(-1, 0),
                                child: AutoSizeText(
                                  AppLocalization.of(context)!
                                      .confirmSecretPhrase,
                                  style: AppStyles.textStyleSize20W700Warning(
                                      context),
                                ),
                              ),
                              Container(
                                margin: EdgeInsetsDirectional.only(
                                    start: 20, end: 20, top: 15.0),
                                child: AutoSizeText(
                                  AppLocalization.of(context)!
                                      .confirmSecretPhraseExplanation,
                                  style: AppStyles.textStyleSize16W600Primary(
                                      context),
                                  textAlign: TextAlign.justify,
                                  maxLines: 6,
                                  stepGranularity: 0.5,
                                ),
                              ),
                              Container(
                                margin: EdgeInsetsDirectional.only(
                                    start: 20, end: 20, top: 15.0),
                                child: Wrap(
                                    alignment: WrapAlignment.start,
                                    children: wordListSelected
                                        .asMap()
                                        .entries
                                        .map((MapEntry entry) {
                                      return Padding(
                                          padding: const EdgeInsets.only(
                                              right: 5.0, left: 5.0),
                                          child: Chip(
                                            avatar: CircleAvatar(
                                              backgroundColor:
                                                  Colors.grey.shade800,
                                              child: Text(
                                                  (entry.key + 1).toString(),
                                                  style: AppStyles
                                                      .textStyleSize12W100Primary60(
                                                          context)),
                                            ),
                                            label: Text(entry.value,
                                                style: AppStyles
                                                    .textStyleSize12W400Primary(
                                                        context)),
                                            onDeleted: () {
                                              setState(() {
                                                wordListToSelect
                                                    .add(entry.value);
                                                wordListSelected
                                                    .removeAt(entry.key);
                                              });
                                            },
                                            deleteIconColor: Colors.white,
                                          ));
                                    }).toList()),
                              ),
                              Divider(
                                height: 0,
                                color:
                                    StateContainer.of(context).curTheme.text60,
                              ),
                              Container(
                                margin: EdgeInsetsDirectional.only(
                                    start: 20, end: 20, top: 15.0),
                                child: Wrap(
                                    alignment: WrapAlignment.center,
                                    children: wordListToSelect
                                        .asMap()
                                        .entries
                                        .map((MapEntry entry) {
                                      return Padding(
                                          padding: const EdgeInsets.only(
                                              right: 5.0, left: 5.0),
                                          child: GestureDetector(
                                              onTap: () {
                                                wordListSelected
                                                    .add(entry.value);
                                                wordListToSelect
                                                    .removeAt(entry.key);
                                                setState(() {});
                                              },
                                              child: Chip(
                                                label: Text(entry.value,
                                                    style: AppStyles
                                                        .textStyleSize12W400Primary(
                                                            context)),
                                              )));
                                    }).toList()),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        wordListSelected.length != 24
                            ? AppButton.buildAppButton(
                                const Key('confirm'),
                                context,
                                AppButtonType.primaryOutline,
                                AppLocalization.of(context)!.confirm,
                                Dimens.buttonBottomDimens,
                                onPressed: () {},
                              )
                            : AppButton.buildAppButton(
                                const Key('confirm'),
                                context,
                                AppButtonType.primary,
                                AppLocalization.of(context)!.confirm,
                                Dimens.buttonTopDimens, onPressed: () async {
                                bool biometricsAvalaible = await sl
                                    .get<BiometricUtil>()
                                    .hasBiometrics();
                                bool orderOk = true;

                                for (int i = 0;
                                    i < originalWordsList.length;
                                    i++) {
                                  if (originalWordsList[i] !=
                                      wordListSelected[i]) {
                                    orderOk = false;
                                  }
                                }
                                if (orderOk == false) {
                                  setState(() {
                                    UIUtil.showSnackbar(
                                        AppLocalization.of(context)!
                                            .confirmSecretPhraseKo,
                                        context,
                                        StateContainer.of(context)
                                            .curTheme
                                            .text!,
                                        StateContainer.of(context)
                                            .curTheme
                                            .snackBarShadow!);
                                  });
                                } else {
                                  List<PickerItem> accessModes = [];
                                  accessModes.add(PickerItem(
                                      AuthenticationMethod(AuthMethod.pin)
                                          .getDisplayName(context),
                                      AuthenticationMethod(AuthMethod.pin)
                                          .getDescription(context),
                                      AuthenticationMethod.getIcon(
                                          AuthMethod.pin),
                                      StateContainer.of(context)
                                          .curTheme
                                          .pickerItemIconEnabled,
                                      AuthMethod.pin,
                                      true));
                                  accessModes.add(PickerItem(
                                      AuthenticationMethod(AuthMethod.password)
                                          .getDisplayName(context),
                                      AuthenticationMethod(AuthMethod.password)
                                          .getDescription(context),
                                      AuthenticationMethod.getIcon(
                                          AuthMethod.password),
                                      StateContainer.of(context)
                                          .curTheme
                                          .pickerItemIconEnabled,
                                      AuthMethod.password,
                                      true));
                                  if (biometricsAvalaible) {
                                    accessModes.add(PickerItem(
                                        AuthenticationMethod(
                                                AuthMethod.biometrics)
                                            .getDisplayName(context),
                                        AuthenticationMethod(
                                                AuthMethod.biometrics)
                                            .getDescription(context),
                                        AuthenticationMethod.getIcon(
                                            AuthMethod.biometrics),
                                        StateContainer.of(context)
                                            .curTheme
                                            .pickerItemIconEnabled,
                                        AuthMethod.biometrics,
                                        true));
                                  }
                                  accessModes.add(PickerItem(
                                      AuthenticationMethod(
                                              AuthMethod.biometricsUniris)
                                          .getDisplayName(context),
                                      AuthenticationMethod(
                                              AuthMethod.biometricsUniris)
                                          .getDescription(context),
                                      AuthenticationMethod.getIcon(
                                          AuthMethod.biometricsUniris),
                                      StateContainer.of(context)
                                          .curTheme
                                          .pickerItemIconEnabled,
                                      AuthMethod.biometricsUniris,
                                      false));
                                  accessModes.add(PickerItem(
                                      AuthenticationMethod(
                                              AuthMethod.yubikeyWithYubicloud)
                                          .getDisplayName(context),
                                      AuthenticationMethod(
                                              AuthMethod.yubikeyWithYubicloud)
                                          .getDescription(context),
                                      AuthenticationMethod.getIcon(
                                          AuthMethod.yubikeyWithYubicloud),
                                      StateContainer.of(context)
                                          .curTheme
                                          .pickerItemIconEnabled,
                                      AuthMethod.yubikeyWithYubicloud,
                                      true));
                                  Navigator.of(context).pushNamed(
                                      '/intro_configure_security',
                                      arguments: {
                                        'accessModes': accessModes,
                                        'name': widget.name,
                                        'seed': widget.seed
                                      });
                                }
                              }),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
