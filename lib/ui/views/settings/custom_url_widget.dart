// ignore_for_file: must_be_immutable

// Flutter imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'package:archethic_wallet/appstate_container.dart';
import 'package:archethic_wallet/localization.dart';
import 'package:archethic_wallet/util/service_locator.dart';
import 'package:archethic_wallet/ui/util/styles.dart';
import 'package:archethic_wallet/ui/widgets/components/app_text_field.dart';
import 'package:archethic_wallet/util/preferences.dart';

class CustomUrl extends StatefulWidget {
  CustomUrl(this.customUrlController, this.customUrlOpen, {Key? key})
      : super(key: key);

  final AnimationController customUrlController;
  bool customUrlOpen;

  @override
  _CustomUrlState createState() => _CustomUrlState();
}

class _CustomUrlState extends State<CustomUrl> {
  FocusNode? _endpointFocusNode;
  TextEditingController? _endpointController;

  String _endpointValidationText = '';

  Future<void> initControllerText() async {
    final Preferences _preferences = await Preferences.getInstance();
    _endpointController!.text = _preferences.getEndpoint();
  }

  Future<void> updateEndpoint() async {
    final Preferences _preferences = await Preferences.getInstance();
    _preferences.setEndpoint(_endpointController!.text);
    await setupServiceLocator();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _endpointFocusNode = FocusNode();
    _endpointController = TextEditingController();

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
                  Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(right: 10, left: 10),
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            widget.customUrlOpen = false;
                          });
                          widget.customUrlController.reverse();
                        },
                        child: FaIcon(FontAwesomeIcons.chevronLeft,
                            color: StateContainer.of(context).curTheme.primary,
                            size: 24)),
                  ),
                  Expanded(
                    child: AutoSizeText(
                      AppLocalization.of(context)!.customUrlHeader,
                      style: AppStyles.textStyleSize28W700Primary(context),
                      maxLines: 2,
                    ),
                  ),
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
                              Container(
                                child: getEndpointContainer(),
                              ),
                              Container(
                                alignment: const AlignmentDirectional(0, 0),
                                margin: const EdgeInsets.only(top: 3),
                                child: Text(
                                  _endpointValidationText,
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

  Column getEndpointContainer() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppLocalization.of(context)!.enterEndpoint,
              style: AppStyles.textStyleSize16W200Primary(context),
            ),
          ],
        ),
        AppTextField(
          leftMargin: 10,
          rightMargin: 10,
          topMargin: 10,
          focusNode: _endpointFocusNode,
          controller: _endpointController,
          cursorColor: StateContainer.of(context).curTheme.primary,
          style: AppStyles.textStyleSize14W100Primary(context),
          inputFormatters: <LengthLimitingTextInputFormatter>[
            LengthLimitingTextInputFormatter(150)
          ],
          onChanged: (String text) {
            updateEndpoint();
            setState(() {
              _endpointValidationText = '';
            });
          },
          textInputAction: TextInputAction.next,
          maxLines: null,
          autocorrect: false,
          hintText: AppLocalization.of(context)!.enterEndpoint,
          keyboardType: TextInputType.multiline,
          textAlign: TextAlign.left,
          onSubmitted: (String text) {
            FocusScope.of(context).unfocus();
          },
        ),
      ],
    );
  }
}
