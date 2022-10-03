/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/authenticate/auth_factory.dart';
import 'package:aewallet/ui/widgets/components/app_text_field.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';
import 'package:aewallet/ui/widgets/components/icon_widget.dart';
import 'package:aewallet/ui/widgets/components/tap_outside_unfocus.dart';
import 'package:aewallet/util/vault.dart';

class SetYubikey extends StatefulWidget {
  const SetYubikey({
    super.key,
    this.header,
    this.description,
    this.apiKey,
    this.clientID,
  });
  final String? header;
  final String? description;
  final String? apiKey;
  final String? clientID;

  @override
  State<SetYubikey> createState() => _SetYubikeyState();
}

class _SetYubikeyState extends State<SetYubikey> {
  FocusNode? _clientIDFocusNode;
  TextEditingController? _clientIDController;
  FocusNode? _clientAPIKeyFocusNode;
  TextEditingController? _clientAPIKeyController;
  bool? animationOpen;
  String _clientIDValidationText = '';
  String _clientAPIKeyValidationText = '';

  @override
  void initState() {
    super.initState();
    _clientAPIKeyFocusNode = FocusNode();
    _clientIDFocusNode = FocusNode();
    _clientAPIKeyController = TextEditingController();
    _clientIDController = TextEditingController();
    if (widget.apiKey != null) {
      _clientAPIKeyController!.text = widget.apiKey!;
    }
    if (widget.clientID != null) {
      _clientIDController!.text = widget.clientID!;
    }
    animationOpen = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              StateContainer.of(context).curTheme.background3Small!,
            ),
            fit: BoxFit.fitHeight,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              StateContainer.of(context).curTheme.backgroundDark!,
              StateContainer.of(context).curTheme.background!
            ],
          ),
        ),
        child: TapOutsideUnfocus(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) =>
                SafeArea(
              minimum: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.035,
                top: MediaQuery.of(context).size.height * 0.075,
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              margin:
                                  const EdgeInsetsDirectional.only(start: 15),
                              height: 50,
                              width: 50,
                              child: BackButton(
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                              ),
                            ),
                          ],
                        ),
                        Container(
                          child: IconWidget.build(
                            context,
                            'assets/icons/digital-key.png',
                            90,
                            90,
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (widget.header != null)
                                  Container(
                                    margin: const EdgeInsetsDirectional.only(
                                      start: 20,
                                      end: 20,
                                      top: 10,
                                    ),
                                    alignment: AlignmentDirectional.centerStart,
                                    child: AutoSizeText(
                                      widget.header!,
                                      style:
                                          AppStyles.textStyleSize20W700Warning(
                                        context,
                                      ),
                                    ),
                                  ),
                                if (widget.description != null)
                                  Container(
                                    margin: const EdgeInsetsDirectional.only(
                                      start: 20,
                                      end: 20,
                                      top: 15,
                                    ),
                                    child: Text(
                                      widget.description!,
                                      style:
                                          AppStyles.textStyleSize16W600Primary(
                                        context,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                Container(
                                  child: getClientIDContainer(),
                                ),
                                Container(
                                  alignment: AlignmentDirectional.center,
                                  margin: const EdgeInsets.only(top: 3),
                                  child: Text(
                                    _clientIDValidationText,
                                    style: AppStyles.textStyleSize14W600Primary(
                                      context,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: getClientAPIKeyContainer(),
                                ),
                                Container(
                                  alignment: AlignmentDirectional.center,
                                  margin: const EdgeInsets.only(top: 3),
                                  child: Text(
                                    _clientAPIKeyValidationText,
                                    style: AppStyles.textStyleSize14W600Primary(
                                      context,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
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
                            Dimens.buttonTopDimens,
                            onPressed: () async {
                              await validate();
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
        ),
      ),
    );
  }

  Column getClientIDContainer() {
    return Column(
      children: <Widget>[
        AppTextField(
          topMargin: 30,
          focusNode: _clientIDFocusNode,
          controller: _clientIDController,
          cursorColor: StateContainer.of(context).curTheme.text,
          style: AppStyles.textStyleSize16W700Primary(context),
          inputFormatters: <LengthLimitingTextInputFormatter>[
            LengthLimitingTextInputFormatter(10)
          ],
          onChanged: (String text) {
            setState(() {
              _clientIDValidationText = '';
            });
          },
          textInputAction: TextInputAction.next,
          maxLines: null,
          autocorrect: false,
          labelText: AppLocalization.of(context)!.enterYubikeyClientID,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.left,
          onSubmitted: (String text) {
            FocusScope.of(context).unfocus();
          },
        ),
      ],
    );
  }

  Column getClientAPIKeyContainer() {
    return Column(
      children: <Widget>[
        AppTextField(
          topMargin: 10,
          focusNode: _clientAPIKeyFocusNode,
          controller: _clientAPIKeyController,
          cursorColor: StateContainer.of(context).curTheme.text,
          style: AppStyles.textStyleSize16W700Primary(context),
          inputFormatters: <LengthLimitingTextInputFormatter>[
            LengthLimitingTextInputFormatter(40)
          ],
          onChanged: (String text) {
            setState(() {
              _clientAPIKeyValidationText = '';
            });
          },
          textInputAction: TextInputAction.next,
          maxLines: null,
          autocorrect: false,
          labelText: AppLocalization.of(context)!.enterYubikeyClientAPIKey,
          keyboardType: TextInputType.text,
          textAlign: TextAlign.left,
          onSubmitted: (String text) {
            FocusScope.of(context).unfocus();
          },
        ),
      ],
    );
  }

  Future<void> validate() async {
    if (_clientIDController!.text.isEmpty) {
      if (mounted) {
        setState(() {
          _clientIDValidationText = AppLocalization.of(context)!.passwordBlank;
        });
      }
    } else {
      if (_clientAPIKeyController!.text.isEmpty) {
        if (mounted) {
          setState(() {
            _clientIDValidationText =
                AppLocalization.of(context)!.passwordBlank;
          });
        }
      } else {
        final vault = await Vault.getInstance();
        vault.setYubikeyClientAPIKey(_clientAPIKeyController!.text);
        vault.setYubikeyClientID(_clientIDController!.text);

        final auth = await AuthFactory.authenticate(
          context,
          AuthenticationMethod(AuthMethod.yubikeyWithYubicloud),
          activeVibrations: StateContainer.of(context).activeVibrations,
        );
        if (auth) {
          Navigator.of(context).pop(true);
        }
      }
    }
  }
}
