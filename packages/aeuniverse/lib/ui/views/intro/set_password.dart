// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/widgets/components/app_text_field.dart';
import 'package:aeuniverse/ui/widgets/components/buttons.dart';
import 'package:aeuniverse/ui/widgets/components/icon_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/localization.dart';
import 'package:core/util/string_encryption.dart';
import 'package:core/util/vault.dart';
import 'package:core_ui/ui/util/dimens.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SetPassword extends StatefulWidget {
  final String? header;
  final String? description;

  const SetPassword({Key? key, this.header, this.description})
      : super(key: key);
  @override
  _SetPasswordState createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  FocusNode? setPasswordFocusNode;
  TextEditingController? setPasswordController;
  FocusNode? confirmPasswordFocusNode;
  TextEditingController? confirmPasswordController;

  String? passwordError;
  bool? passwordsMatch;

  @override
  void initState() {
    super.initState();
    passwordsMatch = false;
    setPasswordFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();
    setPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
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
                                  'packages/aeuniverse/assets/icons/password.png',
                                  90,
                                  90),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (widget.header != null)
                                      Container(
                                        margin: EdgeInsetsDirectional.only(
                                          start: 20,
                                          end: 20,
                                          top: 10,
                                        ),
                                        alignment:
                                            const AlignmentDirectional(-1, 0),
                                        child: AutoSizeText(
                                          widget.header!,
                                          style: AppStyles
                                              .textStyleSize20W700Warning(
                                                  context),
                                        ),
                                      ),
                                    if (widget.description != null)
                                      Container(
                                        margin: EdgeInsetsDirectional.only(
                                            start: 20, end: 20, top: 15.0),
                                        child: Text(
                                          widget.description!,
                                          style: AppStyles
                                              .textStyleSize16W600Primary(
                                                  context),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                    AppTextField(
                                      topMargin: 30,
                                      cursorColor: StateContainer.of(context)
                                          .curTheme
                                          .primary,
                                      focusNode: setPasswordFocusNode,
                                      controller: setPasswordController,
                                      textInputAction: TextInputAction.next,
                                      maxLines: 1,
                                      autocorrect: false,
                                      onChanged: (String newText) {
                                        if (passwordError != null) {
                                          setState(() {
                                            passwordError = null;
                                          });
                                        }
                                        if (confirmPasswordController!.text ==
                                            setPasswordController!.text) {
                                          if (mounted) {
                                            setState(() {
                                              passwordsMatch = true;
                                            });
                                          }
                                        } else {
                                          if (mounted) {
                                            setState(() {
                                              passwordsMatch = false;
                                            });
                                          }
                                        }
                                      },
                                      hintText: AppLocalization.of(context)!
                                          .createPasswordHint,
                                      keyboardType: TextInputType.text,
                                      obscureText: true,
                                      textAlign: TextAlign.center,
                                      style:
                                          AppStyles.textStyleSize16W700Primary(
                                              context),
                                      onSubmitted: (text) {
                                        confirmPasswordFocusNode!
                                            .requestFocus();
                                      },
                                    ),
                                    // Confirm Password Text Field
                                    AppTextField(
                                      topMargin: 20,
                                      focusNode: confirmPasswordFocusNode,
                                      controller: confirmPasswordController,
                                      textInputAction: TextInputAction.done,
                                      maxLines: 1,
                                      autocorrect: false,
                                      onChanged: (String newText) {
                                        if (passwordError != null) {
                                          setState(() {
                                            passwordError = null;
                                          });
                                        }
                                        if (confirmPasswordController!.text ==
                                            setPasswordController!.text) {
                                          if (mounted) {
                                            setState(() {
                                              passwordsMatch = true;
                                            });
                                          }
                                        } else {
                                          if (mounted) {
                                            setState(() {
                                              passwordsMatch = false;
                                            });
                                          }
                                        }
                                      },
                                      hintText: AppLocalization.of(context)!
                                          .confirmPasswordHint,
                                      keyboardType: TextInputType.text,
                                      obscureText: true,
                                      textAlign: TextAlign.center,
                                      style:
                                          AppStyles.textStyleSize16W700Primary(
                                              context),
                                    ),
                                    // Error Text
                                    Container(
                                      alignment: AlignmentDirectional(0, 0),
                                      margin: EdgeInsets.only(top: 3),
                                      child: Text(
                                          this.passwordError == null
                                              ? ''
                                              : passwordError!,
                                          style: AppStyles
                                              .textStyleSize14W600Primary(
                                                  context)),
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

  Future<void> validate() async {
    if (setPasswordController!.text.isEmpty ||
        confirmPasswordController!.text.isEmpty) {
      if (mounted) {
        setState(() {
          passwordError = AppLocalization.of(context)!.passwordBlank;
        });
      }
    } else if (setPasswordController!.text != confirmPasswordController!.text) {
      if (mounted) {
        setState(() {
          passwordError = AppLocalization.of(context)!.passwordsDontMatch;
        });
      }
    } else {
      Vault _vault = await Vault.getInstance();
      _vault.setPassword(stringEncryptBase64(setPasswordController!.text,
          await StateContainer.of(context).getSeed()));

      Navigator.of(context).pushNamedAndRemoveUntil(
        '/home',
        (Route<dynamic> route) => false,
      );
    }
  }
}
