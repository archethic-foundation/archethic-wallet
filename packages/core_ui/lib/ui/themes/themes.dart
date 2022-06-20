/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class BaseTheme {
  String? displayName;

  // Main Buttons
  Color? mainButtonLabel;
  Color? middleButtonLabel;
  Gradient? gradientMainButton;

  // IconData Widget
  Color? iconDataWidgetBoxShadow;
  Color? iconDataWidgetIconGradientLeft;
  Color? iconDataWidgetIconGradientRight;
  Color? iconDataWidgetIconBackground;
  Color? iconDataWidgetIcon;

  // Menu
  Color? iconDrawer;
  Color? iconDrawerBackground;
  Color? drawerBackground;

  // Icons Picker Items
  Color? pickerItemIconEnabled;
  Color? pickerItemIconDisabled;

  // Icons TextField
  Color? textFieldIcon;

  // Texts
  Color? text;
  Color? text60;
  Color? text45;
  Color? text30;
  Color? text20;
  Color? text15;
  Color? text10;
  Color? text05;
  Color? text03;
  Color? positiveValue;
  Color? negativeValue;
  Color? positiveAmount;
  Color? negativeAmount;
  Color? warning;

  // Sheet
  Color? sheetBackground;

  // SnackBar
  Color? snackBarShadow;

  // Background
  Color? backgroundMainTop;
  Color? backgroundMainBottom;
  Color? background;
  Color? background40;
  Color? backgroundDark;
  Color? backgroundDark00;
  Color? backgroundDarkest;

  String? background1Small;
  String? background2Small;
  String? background3Small;
  String? background4Small;
  String? background5Small;

  // Animation Overlay
  Color? animationOverlayMedium;
  Color? animationOverlayStrong;

  Color? overlay30;

  Color? activeTrackColorSwitch;
  Color? inactiveTrackColorSwitch;

  Brightness? brightness;

  SystemUiOverlayStyle? statusBar;

  BoxShadow? boxShadow;

  BoxShadow? boxShadowButton;

  String? assetsFolder;

  String? logo;
  String? logoAlone;

  Widget? getBackgroundScreen(BuildContext context);

  Gradient? gradient;

  Decoration getDecorationBalance();

  Decoration getDecorationSheet();
}
