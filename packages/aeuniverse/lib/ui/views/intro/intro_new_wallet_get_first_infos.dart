/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:aeuniverse/ui/widgets/components/dialog.dart';
import 'package:core_ui/ui/util/formatters.dart';
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
  final RegExp validCharacters = RegExp(r'^[A-Z0-9_]+$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  StateContainer.of(context).curTheme.background2Small!),
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
                                color: StateContainer.of(context).curTheme.text,
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
                                    UpperCaseTextFormatter(),
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
                        if (validCharacters.hasMatch(nameController.text) ==
                            false) {
                          setState(() {
                            nameError = AppLocalization.of(context)!
                                .introNewWalletGetFirstInfosNameRegExp;
                            FocusScope.of(context).requestFocus(nameFocusNode);
                          });
                        } else {
                          AppDialogs.showConfirmDialog(
                              context,
                              AppLocalization.of(context)!.newAccount,
                              AppLocalization.of(context)!
                                  .newAccountConfirmation
                                  .replaceAll('%1', nameController.text),
                              AppLocalization.of(context)!.yes.toUpperCase(),
                              () async {
                            Navigator.of(context).pushNamed(
                                '/intro_backup_safety',
                                arguments: nameController.text);
                          },
                              cancelText: AppLocalization.of(context)!
                                  .no
                                  .toUpperCase());
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
}
