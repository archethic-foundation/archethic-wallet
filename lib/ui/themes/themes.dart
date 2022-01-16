// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class BaseTheme {
  String? displayName;

  Color? primary;
  Color? primary60;
  Color? primary45;
  Color? primary30;
  Color? primary20;
  Color? primary15;
  Color? primary10;
  Color? primary05;
  Color? primary03;

  Color? icon;
  Color? icon45;
  Color? icon60;

  Color? success;
  Color? success60;
  Color? success30;
  Color? success15;
  Color? successDark;
  Color? successDark30;

  Color? background;
  Color? background40;
  Color? background00;

  Color? backgroundDark;
  Color? backgroundDark00;

  Color? backgroundDarkest;

  Color? overlay20;
  Color? overlay30;
  Color? overlay50;
  Color? overlay70;
  Color? overlay80;
  Color? overlay85;
  Color? overlay90;

  Color? animationOverlayMedium;
  Color? animationOverlayStrong;

  Color? positiveValue;
  Color? negativeValue;

  Color? contextMenuText;
  Color? contextMenuTextRed;

  Color? choiceOption;

  Color? warning;

  Color? positiveAmount;
  Color? negativeAmount;

  Brightness? brightness;
  SystemUiOverlayStyle? statusBar;

  BoxShadow? boxShadow;
  BoxShadow? boxShadowButton;

  String? assetsFolder;
  String? logo;
  String? logoAlone;

  Widget? getBackgroundScreen(BuildContext context);
}
