/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// TextField button
class TextFieldButton extends StatelessWidget {
  const TextFieldButton({@required this.icon, this.onPressed, Key? key})
      : super(key: key);

  final IconData? icon;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 48,
        width: 48,
        child: TextButton(
          onPressed: () {
            if (onPressed != null) {
              onPressed!();
            }
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
      this.labelText,
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
      this.autofocus = false,
      Key? key})
      : super(key: key);

  final TextAlign? textAlign;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final Color? cursorColor;
  final Brightness? keyboardAppearance;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final bool? autocorrect;
  final String? hintText;
  final String? labelText;
  final TextFieldButton? prefixButton;
  final TextFieldButton? suffixButton;
  final bool? fadePrefixOnCondition;
  final bool? prefixShowFirstCondition;
  final bool? fadeSuffixOnCondition;
  final bool? suffixShowFirstCondition;
  final EdgeInsetsGeometry? padding;
  final Widget? overrideTextFieldWidget;
  final int? buttonFadeDurationMs;
  final TextInputType? keyboardType;
  final Function? onSubmitted;
  final Function(String)? onChanged;
  final double? topMargin;
  final double? leftMargin;
  final double? rightMargin;
  final TextStyle? style;
  final bool? obscureText;
  final bool? autofocus;

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: widget.leftMargin ?? MediaQuery.of(context).size.width * 0.105,
        right: widget.rightMargin ?? MediaQuery.of(context).size.width * 0.105,
        top: widget.topMargin!,
      ),
      padding: widget.padding,
      width: double.infinity,
      child: widget.overrideTextFieldWidget ??
          Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              TextField(
                // User defined fields
                textAlign: widget.textAlign!,
                keyboardAppearance: widget.keyboardAppearance,
                autocorrect: widget.autocorrect!,
                maxLines: widget.maxLines,
                focusNode: widget.focusNode,
                controller: widget.controller,
                cursorColor: widget.cursorColor ??
                    StateContainer.of(context).curTheme.primary,
                inputFormatters: widget.inputFormatters,
                textInputAction: widget.textInputAction,
                keyboardType: widget.keyboardType,
                obscureText: widget.obscureText!,
                autofocus: widget.autofocus!,
                onSubmitted: (String text) {
                  if (widget.textInputAction == TextInputAction.done) {
                    FocusScope.of(context).unfocus();
                  }
                },
                onChanged: widget.onChanged,
                // Style
                style: widget.style,
                // Input decoration

                decoration: InputDecoration(
                  // Hint
                  labelText: widget.labelText ?? '',
                  labelStyle: AppStyles.textStyleSize16W400Primary60(context),
                  // First button
                  prefixIcon: widget.prefixButton == null
                      ? const SizedBox()
                      : const SizedBox(width: 48, height: 48),
                  suffixIcon: widget.suffixButton == null
                      ? const SizedBox()
                      : const SizedBox(width: 48, height: 48),
                ),
              ),
              Positioned(
                bottom: 1,
                child: Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: StateContainer.of(context).curTheme.gradient!,
                  ),
                ),
              ),
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
                              milliseconds: widget.buttonFadeDurationMs!),
                          firstChild: widget.prefixButton!,
                          secondChild: const SizedBox(height: 48, width: 48),
                          crossFadeState: widget.prefixShowFirstCondition!
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
                              milliseconds: widget.buttonFadeDurationMs!),
                          firstChild: widget.suffixButton!,
                          secondChild: const SizedBox(height: 48, width: 48),
                          crossFadeState: widget.suffixShowFirstCondition!
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                        )
                      else
                        widget.suffixButton ?? const SizedBox()
                    ],
                  ),
                ],
              ),
            ],
          ),
    );
  }
}
