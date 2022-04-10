// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/views/yubikey_screen.dart';
import 'package:aeuniverse/ui/widgets/components/app_text_field.dart';
import 'package:aeuniverse/ui/widgets/components/buttons.dart';
import 'package:aeuniverse/ui/widgets/components/icon_widget.dart';
import 'package:core/localization.dart';
import 'package:core/util/vault.dart';
import 'package:core_ui/ui/util/dimens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IntroYubikey extends StatefulWidget {
  IntroYubikey();
  @override
  _IntroYubikeyState createState() => _IntroYubikeyState();
}

class _IntroYubikeyState extends State<IntroYubikey> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FocusNode? _clientIDFocusNode;
  FocusNode? _clientAPIKeyFocusNode;

  TextEditingController? _clientIDController;
  TextEditingController? _clientAPIKeyController;

  String _clientIDValidationText = '';
  String _clientAPIKeyValidationText = '';

  @override
  void initState() {
    super.initState();
    _clientAPIKeyFocusNode = FocusNode();
    _clientIDFocusNode = FocusNode();
    _clientAPIKeyController = TextEditingController();
    _clientIDController = TextEditingController();
  }

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
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: FaIcon(
                                          FontAwesomeIcons.chevronLeft,
                                          color: StateContainer.of(context)
                                              .curTheme
                                              .primary,
                                          size: 24)),
                                ),
                              ],
                            ),
                            Container(
                              child: buildIconWidget(
                                  context,
                                  'packages/aeuniverse/assets/icons/key-ring.png',
                                  90,
                                  90),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      child: getClientIDContainer(),
                                    ),
                                    Container(
                                      alignment:
                                          const AlignmentDirectional(0, 0),
                                      margin: const EdgeInsets.only(top: 3),
                                      child: Text(
                                        _clientIDValidationText,
                                        style: AppStyles
                                            .textStyleSize14W600Primary(
                                                context),
                                      ),
                                    ),
                                    Container(
                                      child: getClientAPIKeyContainer(),
                                    ),
                                    Container(
                                      alignment:
                                          const AlignmentDirectional(0, 0),
                                      margin: const EdgeInsets.only(top: 3),
                                      child: Text(
                                        _clientAPIKeyValidationText,
                                        style: AppStyles
                                            .textStyleSize14W600Primary(
                                                context),
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
                              // Next Button
                              AppButton.buildAppButton(
                                  const Key('confirm'),
                                  context,
                                  AppButtonType.primary,
                                  AppLocalization.of(context)!.confirm,
                                  Dimens.buttonTopDimens, onPressed: () async {
                                await validate();
                              }),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
      ),
    );
  }

  Column getClientIDContainer() {
    return Column(
      children: <Widget>[
        AppTextField(
          leftMargin: 10,
          rightMargin: 10,
          topMargin: 10,
          focusNode: _clientIDFocusNode,
          controller: _clientIDController,
          cursorColor: StateContainer.of(context).curTheme.primary,
          style: AppStyles.textStyleSize14W100Primary(context),
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
          hintText: AppLocalization.of(context)!.enterYubikeyClientID,
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
          leftMargin: 10,
          rightMargin: 10,
          topMargin: 10,
          focusNode: _clientAPIKeyFocusNode,
          controller: _clientAPIKeyController,
          cursorColor: StateContainer.of(context).curTheme.primary,
          style: AppStyles.textStyleSize14W100Primary(context),
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
          hintText: AppLocalization.of(context)!.enterYubikeyClientAPIKey,
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
        Vault _vault = await Vault.getInstance();
        _vault.setYubikeyClientAPIKey(_clientAPIKeyController!.text);
        _vault.setYubikeyClientID(_clientIDController!.text);
        authenticateWithYubikey();
      }
    }
  }

  Future<void> authenticateWithYubikey() async {
    // Yubikey Authentication
    final bool auth = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return const YubikeyScreen();
    })) as bool;
    if (auth) {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      StateContainer.of(context).getSeed().then((String seed) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/home',
          (Route<dynamic> route) => false,
        );
      });
    }
  }
}
