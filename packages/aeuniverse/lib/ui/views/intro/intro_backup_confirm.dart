/// SPDX-License-Identifier: AGPL-3.0-or-later

// ignore_for_file: always_specify_types

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/widgets/components/buttons.dart';
import 'package:aeuniverse/ui/widgets/components/icon_widget.dart';
import 'package:aeuniverse/ui/widgets/components/picker_item.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/localization.dart';
import 'package:core/model/authentication_method.dart';
import 'package:core/util/biometrics_util.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core_ui/ui/util/dimens.dart';

class IntroBackupConfirm extends StatefulWidget {
  const IntroBackupConfirm({super.key});

  @override
  State<IntroBackupConfirm> createState() => _IntroBackupConfirmState();
}

class _IntroBackupConfirmState extends State<IntroBackupConfirm> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
                        child: buildIconWidget(
                            context,
                            'packages/aeuniverse/assets/icons/writing.png',
                            90,
                            90),
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
                                  AppLocalization.of(context)!.ackBackedUp,
                                  style: AppStyles.textStyleSize20W700Warning(
                                      context),
                                ),
                              ),
                              Container(
                                margin: EdgeInsetsDirectional.only(
                                    start: 20, end: 20, top: 15.0),
                                child: AutoSizeText(
                                  AppLocalization.of(context)!.secretWarning,
                                  style: AppStyles.textStyleSize16W600Primary(
                                      context),
                                  textAlign: TextAlign.justify,
                                  maxLines: 6,
                                  stepGranularity: 0.5,
                                ),
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
                        AppButton.buildAppButton(
                            const Key('yes'),
                            context,
                            AppButtonType.primary,
                            AppLocalization.of(context)!.yes,
                            Dimens.buttonTopDimens, onPressed: () async {
                          bool biometricsAvalaible =
                              await sl.get<BiometricUtil>().hasBiometrics();
                          List<PickerItem> accessModes = [];
                          accessModes.add(PickerItem(
                              AuthenticationMethod(AuthMethod.pin)
                                  .getDisplayName(context),
                              AuthenticationMethod(AuthMethod.pin)
                                  .getDescription(context),
                              AuthenticationMethod.getIcon(AuthMethod.pin),
                              StateContainer.of(context).curTheme.icon,
                              AuthMethod.pin,
                              true));
                          accessModes.add(PickerItem(
                              AuthenticationMethod(AuthMethod.password)
                                  .getDisplayName(context),
                              AuthenticationMethod(AuthMethod.password)
                                  .getDescription(context),
                              AuthenticationMethod.getIcon(AuthMethod.password),
                              StateContainer.of(context).curTheme.icon,
                              AuthMethod.password,
                              true));
                          if (biometricsAvalaible) {
                            accessModes.add(PickerItem(
                                AuthenticationMethod(AuthMethod.biometrics)
                                    .getDisplayName(context),
                                AuthenticationMethod(AuthMethod.biometrics)
                                    .getDescription(context),
                                AuthenticationMethod.getIcon(
                                    AuthMethod.biometrics),
                                StateContainer.of(context).curTheme.icon,
                                AuthMethod.biometrics,
                                true));
                          }
                          accessModes.add(PickerItem(
                              AuthenticationMethod(AuthMethod.biometricsUniris)
                                  .getDisplayName(context),
                              AuthenticationMethod(AuthMethod.biometricsUniris)
                                  .getDescription(context),
                              AuthenticationMethod.getIcon(
                                  AuthMethod.biometricsUniris),
                              StateContainer.of(context).curTheme.icon,
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
                              StateContainer.of(context).curTheme.icon,
                              AuthMethod.yubikeyWithYubicloud,
                              true));
                          Navigator.of(context).pushNamed(
                              '/intro_configure_security',
                              arguments: accessModes);
                        }),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        AppButton.buildAppButton(
                            const Key('no'),
                            context,
                            AppButtonType.primary,
                            AppLocalization.of(context)!.no,
                            Dimens.buttonBottomDimens, onPressed: () {
                          Navigator.of(context).pop();
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
