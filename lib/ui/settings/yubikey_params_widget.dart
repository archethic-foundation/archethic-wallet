// ignore_for_file: must_be_immutable

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'package:archethic_wallet/appstate_container.dart';
import 'package:archethic_wallet/localization.dart';
import 'package:archethic_wallet/service_locator.dart';
import 'package:archethic_wallet/styles.dart';
import 'package:archethic_wallet/ui/widgets/app_text_field.dart';
import 'package:archethic_wallet/util/sharedprefsutil.dart';

class YubikeyParams extends StatefulWidget {
  YubikeyParams(this.animationController, this.open);

  final AnimationController animationController;
  bool open;

  @override
  _YubikeyParamsState createState() => _YubikeyParamsState();
}

class _YubikeyParamsState extends State<YubikeyParams> {
  FocusNode? _clientIDFocusNode;
  FocusNode? _clientAPIKeyFocusNode;

  TextEditingController? _clientIDController;
  TextEditingController? _clientAPIKeyController;

  String _clientIDValidationText = '';
  String _clientAPIKeyValidationText = '';

  Future<void> initControllerText() async {
    _clientIDController!.text =
        await sl.get<SharedPrefsUtil>().getYubikeyClientID();
    _clientAPIKeyController!.text =
        await sl.get<SharedPrefsUtil>().getYubikeyClientAPIKey();
  }

  Future<void> updateClientID() async {
    await sl
        .get<SharedPrefsUtil>()
        .setYubikeyClientID(_clientIDController!.text);
    await setupServiceLocator();
    setState(() {});
  }

  Future<void> updateClientAPIKey() async {
    await sl
        .get<SharedPrefsUtil>()
        .setYubikeyClientAPIKey(_clientAPIKeyController!.text);
    await setupServiceLocator();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _clientAPIKeyFocusNode = FocusNode();
    _clientIDFocusNode = FocusNode();
    _clientAPIKeyController = TextEditingController();
    _clientIDController = TextEditingController();

    initControllerText();
  }

  @override
  Widget build(BuildContext context) {
    final double bottom = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      decoration: BoxDecoration(
        color: StateContainer.of(context).curTheme.backgroundDark,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: StateContainer.of(context).curTheme.overlay30!,
              offset: const Offset(-5, 0),
              blurRadius: 20),
        ],
      ),
      child: SafeArea(
        minimum: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.035,
          top: 60,
        ),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 10.0, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(children: <Widget>[
                    //Back button
                    Container(
                      height: 40,
                      width: 40,
                      margin: const EdgeInsets.only(right: 10, left: 10),
                      child: TextButton(
                          onPressed: () {
                            setState(() {
                              widget.open = false;
                            });
                            widget.animationController.reverse();
                          },
                          child: FaIcon(FontAwesomeIcons.chevronLeft,
                              color:
                                  StateContainer.of(context).curTheme.primary,
                              size: 24)),
                    ),
                    Text(
                      AppLocalization.of(context)!.yubikeyParamsHeader,
                      style: AppStyles.textStyleSize28W700Primary(context),
                    ),
                  ]),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: 30, bottom: bottom + 30),
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  AutoSizeText(
                                    AppLocalization.of(context)!
                                        .yubikeyParamsDesc,
                                    style: AppStyles.textStyleSize16W700Primary(
                                        context),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                child: getClientIDContainer(),
                              ),
                              Container(
                                alignment: const AlignmentDirectional(0, 0),
                                margin: const EdgeInsets.only(top: 3),
                                child: Text(
                                  _clientIDValidationText,
                                  style: AppStyles.textStyleSize14W600Primary(
                                      context),
                                ),
                              ),
                              Container(
                                child: getClientAPIKeyContainer(),
                              ),
                              Container(
                                alignment: const AlignmentDirectional(0, 0),
                                margin: const EdgeInsets.only(top: 3),
                                child: Text(
                                  _clientAPIKeyValidationText,
                                  style: AppStyles.textStyleSize14W600Primary(
                                      context),
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
            ),
          ],
        ),
      ),
    );
  }

  Column getClientIDContainer() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppLocalization.of(context)!.enterYubikeyClientID,
              style: AppStyles.textStyleSize16W200Primary(context),
            ),
          ],
        ),
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
            updateClientID();
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppLocalization.of(context)!.enterYubikeyClientAPIKey,
              style: AppStyles.textStyleSize16W200Primary(context),
            ),
          ],
        ),
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
            updateClientAPIKey();
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
}
