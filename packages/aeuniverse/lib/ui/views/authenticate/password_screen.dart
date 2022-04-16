// Dart imports:
// ignore_for_file: always_specify_types

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/widgets/components/app_text_field.dart';
import 'package:aeuniverse/ui/widgets/components/buttons.dart';
import 'package:aeuniverse/ui/widgets/components/icon_widget.dart';
import 'package:aeuniverse/util/preferences.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/localization.dart';
import 'package:core/util/string_encryption.dart';
import 'package:core/util/vault.dart';
import 'package:core_ui/ui/util/dimens.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({Key? key}) : super(key: key);

  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  FocusNode? enterPasswordFocusNode;
  TextEditingController? enterPasswordController;

  String? passwordError;

  @override
  void initState() {
    super.initState();

    enterPasswordFocusNode = FocusNode();
    enterPasswordController = TextEditingController();
  }

  Future<void> _verifyPassword() async {
    final Vault _vault = await Vault.getInstance();
    final Preferences _preferences = await Preferences.getInstance();

    if (enterPasswordController!.text ==
        stringDecryptBase64(_vault.getPassword()!,
            await StateContainer.of(context).getSeed())) {
      _preferences.resetLockAttempts();
      Navigator.of(context).pop(true);
    } else {
      if (mounted) {
        setState(() {
          passwordError = AppLocalization.of(context)!.invalidPassword;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          ),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) =>
                SafeArea(
              minimum: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.035,
                top: MediaQuery.of(context).size.height * 0.10,
              ),
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
                                margin: EdgeInsetsDirectional.only(start: 15),
                                height: 50,
                                width: 50,
                                child: BackButton(
                                  key: const Key('back'),
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .primary,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                          buildIconWidget(
                              context,
                              'packages/aeuniverse/assets/icons/password.png',
                              90,
                              90),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            child: AutoSizeText(
                              AppLocalization.of(context)!.yubikeyConnectInvite,
                              style:
                                  AppStyles.textStyleSize16W400Primary(context),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              stepGranularity: 0.1,
                            ),
                          ),
                          AppTextField(
                            topMargin: 30,
                            padding:
                                EdgeInsetsDirectional.only(start: 16, end: 16),
                            focusNode: enterPasswordFocusNode,
                            controller: enterPasswordController,
                            textInputAction: TextInputAction.go,
                            autofocus: true,
                            onChanged: (String newText) {
                              if (passwordError != null) {
                                setState(() {
                                  passwordError = null;
                                });
                              }
                            },
                            onSubmitted: (value) async {
                              FocusScope.of(context).unfocus();
                            },
                            hintText:
                                AppLocalization.of(context)!.enterPasswordHint,
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            textAlign: TextAlign.center,
                            style:
                                AppStyles.textStyleSize16W700Primary(context),
                          ),
                          // Error Container
                          Container(
                            alignment: AlignmentDirectional(0, 0),
                            margin: EdgeInsets.only(top: 3),
                            child: Text(
                                passwordError == null ? '' : passwordError!,
                                style: AppStyles.textStyleSize14W600Primary(
                                    context)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          // Next Button
                          AppButton.buildAppButton(
                              const Key('confirm'),
                              context,
                              AppButtonType.primary,
                              AppLocalization.of(context)!.confirm,
                              Dimens.buttonTopDimens, onPressed: () async {
                            await _verifyPassword();
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
    );
  }
}
