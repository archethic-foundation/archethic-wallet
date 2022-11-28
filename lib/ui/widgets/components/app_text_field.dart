/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Package imports:
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// TextField button
class TextFieldButton extends ConsumerWidget {
  const TextFieldButton({@required this.icon, this.onPressed, super.key});

  final IconData? icon;
  final Function? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    return SizedBox(
      height: 48,
      width: 48,
      child: TextButton(
        onPressed: () {
          onPressed?.call();
        },
        child: FaIcon(
          icon,
          size: 20,
          color: theme.textFieldIcon,
        ),
      ),
    );
  }
}

/// A widget for our custom textfields
class AppTextField extends ConsumerStatefulWidget {
  const AppTextField({
    this.focusNode,
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
    super.key,
  });

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
  ConsumerState<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends ConsumerState<AppTextField> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
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
              TextFormField(
                textAlign: widget.textAlign!,
                keyboardAppearance: widget.keyboardAppearance,
                autocorrect: widget.autocorrect!,
                maxLines: widget.maxLines,
                focusNode: widget.focusNode,
                controller: widget.controller,
                cursorColor: widget.cursorColor ?? theme.text,
                inputFormatters: widget.inputFormatters,
                textInputAction: widget.textInputAction,
                keyboardType: widget.keyboardType,
                obscureText: widget.obscureText!,
                autofocus: widget.autofocus!,
                onFieldSubmitted: (String text) {
                  if (widget.textInputAction == TextInputAction.done) {
                    FocusScope.of(context).unfocus();
                  }
                },
                onChanged: widget.onChanged,
                style: widget.style,
                decoration: widget.prefixButton == null &&
                        widget.suffixButton == null
                    ? InputDecoration(
                        labelText: widget.labelText ?? '',
                        labelStyle: theme.textStyleSize16W400Primary60,
                        prefixIcon: const SizedBox(width: 48, height: 48),
                        suffixIcon: const SizedBox(width: 48, height: 48),
                      )
                    : widget.prefixButton != null && widget.suffixButton == null
                        ? InputDecoration(
                            contentPadding: const EdgeInsets.only(right: 48),
                            labelText: widget.labelText ?? '',
                            labelStyle: theme.textStyleSize16W400Primary60,
                            prefixIcon: const SizedBox(width: 48, height: 48),
                          )
                        : widget.prefixButton == null &&
                                widget.suffixButton != null
                            ? InputDecoration(
                                contentPadding: const EdgeInsets.only(left: 48),
                                labelText: widget.labelText ?? '',
                                labelStyle: theme.textStyleSize16W400Primary60,
                                suffixIcon:
                                    const SizedBox(width: 48, height: 48),
                              )
                            : InputDecoration(
                                labelText: widget.labelText ?? '',
                                labelStyle: theme.textStyleSize16W400Primary60,
                                prefixIconConstraints: const BoxConstraints(
                                  minWidth: 48,
                                  maxHeight: 48,
                                ),
                                prefixIcon:
                                    const SizedBox(width: 48, height: 48),
                                suffixIcon:
                                    const SizedBox(width: 48, height: 48),
                              ),
              ),
              Positioned(
                bottom: 1,
                child: Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: theme.gradient,
                  ),
                ),
              ),
              // Buttons
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      if (widget.fadePrefixOnCondition != null &&
                          widget.prefixButton != null)
                        AnimatedCrossFade(
                          duration: Duration(
                            milliseconds: widget.buttonFadeDurationMs!,
                          ),
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
                            milliseconds: widget.buttonFadeDurationMs!,
                          ),
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
