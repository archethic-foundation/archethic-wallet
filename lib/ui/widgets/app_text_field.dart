// @dart=2.9

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';

/// TextField button
class TextFieldButton extends StatelessWidget {
  const TextFieldButton({@required this.icon, this.onPressed});

  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 48,
        width: 48,
        child: TextButton(
          onPressed: () {
            onPressed != null ? onPressed() : null;
          },
          child: FaIcon(icon,
              size: 20, color: StateContainer.of(context).curTheme.icon),
        ));
  }
}

/// A widget for our custom textfields
class AppTextField extends StatefulWidget {
  const AppTextField(
      {this.focusNode,
      this.controller,
      this.cursorColor,
      this.inputFormatters,
      this.textInputAction,
      this.hintText,
      this.prefixButton,
      this.suffixButton,
      this.fadePrefixOnCondition,
      this.prefixShowFirstCondition,
      this.fadeSuffixOnCondition,
      this.suffixShowFirstCondition,
      this.overrideTextFieldWidget,
      this.keyboardType,
      this.onSubmitted,
      this.onChanged,
      this.style,
      this.leftMargin,
      this.rightMargin,
      this.obscureText = false,
      this.textAlign = TextAlign.center,
      this.keyboardAppearance = Brightness.dark,
      this.autocorrect = true,
      this.maxLines = 1,
      this.padding = EdgeInsets.zero,
      this.buttonFadeDurationMs = 100,
      this.topMargin = 0,
      this.autofocus = false});

  final TextAlign textAlign;
  final FocusNode focusNode;
  final TextEditingController controller;
  final Color cursorColor;
  final Brightness keyboardAppearance;
  final List<TextInputFormatter> inputFormatters;
  final TextInputAction textInputAction;
  final int maxLines;
  final bool autocorrect;
  final String hintText;
  final TextFieldButton prefixButton;
  final TextFieldButton suffixButton;
  final bool fadePrefixOnCondition;
  final bool prefixShowFirstCondition;
  final bool fadeSuffixOnCondition;
  final bool suffixShowFirstCondition;
  final EdgeInsetsGeometry padding;
  final Widget overrideTextFieldWidget;
  final int buttonFadeDurationMs;
  final TextInputType keyboardType;
  final Function onSubmitted;
  final Function onChanged;
  final double topMargin;
  final double leftMargin;
  final double rightMargin;
  final TextStyle style;
  final bool obscureText;
  final bool autofocus;

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
          left: widget.leftMargin ?? MediaQuery.of(context).size.width * 0.105,
          right:
              widget.rightMargin ?? MediaQuery.of(context).size.width * 0.105,
          top: widget.topMargin,
        ),
        padding: widget.padding,
        width: double.infinity,
        decoration: BoxDecoration(
          color: StateContainer.of(context).curTheme.backgroundDarkest,
          borderRadius: BorderRadius.circular(10),
        ),
        child: widget.overrideTextFieldWidget ??
            Stack(alignment: AlignmentDirectional.center, children: <Widget>[
              TextField(
                  // User defined fields
                  textAlign: widget.textAlign,
                  keyboardAppearance: widget.keyboardAppearance,
                  autocorrect: widget.autocorrect,
                  maxLines: widget.maxLines,
                  focusNode: widget.focusNode,
                  controller: widget.controller,
                  cursorColor: widget.cursorColor ??
                      StateContainer.of(context).curTheme.primary,
                  inputFormatters: widget.inputFormatters,
                  textInputAction: widget.textInputAction,
                  keyboardType: widget.keyboardType,
                  obscureText: widget.obscureText,
                  autofocus: widget.autofocus,
                  onSubmitted: widget.onSubmitted ??
                      (String text) {
                        if (widget.textInputAction == TextInputAction.done) {
                          FocusScope.of(context).unfocus();
                        }
                      },
                  onChanged: widget.onChanged,
                  // Style
                  style: widget.style,
                  // Input decoration
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      // Hint
                      hintText: widget.hintText ?? '',
                      hintStyle: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w100,
                        fontFamily: 'Montserrat',
                        color: StateContainer.of(context).curTheme.primary20,
                      ),
                      // First button
                      prefixIcon: widget.prefixButton == null
                          ? Container(width: 0, height: 0)
                          : Container(width: 48, height: 48),
                      suffixIcon: widget.suffixButton == null
                          ? Container(width: 0, height: 0)
                          : Container(width: 48, height: 48))),
              // Buttons
              Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        if (widget.fadePrefixOnCondition != null &&
                            widget.prefixButton != null)
                          AnimatedCrossFade(
                            duration: Duration(
                                milliseconds: widget.buttonFadeDurationMs),
                            firstChild: widget.prefixButton,
                            secondChild: const SizedBox(height: 48, width: 48),
                            crossFadeState: widget.prefixShowFirstCondition
                                ? CrossFadeState.showFirst
                                : CrossFadeState.showSecond,
                          )
                        else
                          widget.prefixButton ?? const SizedBox(),
                        // Second (suffix) button
                        if (widget.fadeSuffixOnCondition != null &&
                            widget.suffixButton != null)
                          AnimatedCrossFade(
                            duration: Duration(
                                milliseconds: widget.buttonFadeDurationMs),
                            firstChild: widget.suffixButton,
                            secondChild: const SizedBox(height: 48, width: 48),
                            crossFadeState: widget.suffixShowFirstCondition
                                ? CrossFadeState.showFirst
                                : CrossFadeState.showSecond,
                          )
                        else
                          widget.suffixButton ?? const SizedBox()
                      ])
                ],
              )
            ]));
  }
}
