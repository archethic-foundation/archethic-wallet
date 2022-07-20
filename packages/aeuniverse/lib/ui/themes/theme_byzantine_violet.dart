/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:core_ui/ui/themes/themes.dart';

// Project imports:
import 'package:aeuniverse/ui/widgets/components/gradient_shadow_box_decoration.dart';

class ByzantineVioletTheme implements BaseTheme {
  @override
  String? displayName = 'Byzantine violet';

  // Main Buttons
  @override
  Color? mainButtonLabel = Color(0xFFFFFFFF);
  @override
  Color? middleButtonLabel = Color(0xFFFFFFFF);
  @override
  Gradient? gradientMainButton = const LinearGradient(
    colors: <Color>[
      Color(0xFF00A4DB),
      Color(0xFFCC00FF),
    ],
    begin: Alignment(-1.0, 0.0),
    end: Alignment(1.0, 0.0),
    transform: GradientRotation(pi / 9),
  );

  // IconData Widget
  @override
  Color? iconDataWidgetBoxShadow = Color(0xFFFFFFFF).withOpacity(0.5);
  @override
  Color? iconDataWidgetIconGradientLeft = Color(0xFF00A4DB);
  @override
  Color? iconDataWidgetIconGradientRight = Color(0xFFCC00FF);
  @override
  Color? iconDataWidgetIconBackground = Color(0xFFFFFFFF);

  // Menu
  @override
  Color? iconDrawer = Color(0xFFCD195B);
  @override
  Color? iconDrawerBackground = Color(0xFFFFFFFF);
  @override
  Color? drawerBackground = Color(0xFF571150);

  // Icons Picker Items
  @override
  Color? pickerItemIconEnabled = Color(0xFFFFFFFF);
  @override
  Color? pickerItemIconDisabled = Color(0xFFFFFFFF).withOpacity(0.6);

  // Icons TextField
  Color? textFieldIcon = Color(0xFFFFFFFF);

  // Texts
  @override
  Color? text = Color(0xFFFFFFFF);
  @override
  Color? text60 = Color(0xFFFFFFFF).withOpacity(0.6);
  @override
  Color? text45 = Color(0xFFFFFFFF).withOpacity(0.45);
  @override
  Color? text30 = Color(0xFFFFFFFF).withOpacity(0.3);
  @override
  Color? text20 = Color(0xFFFFFFFF).withOpacity(0.2);
  @override
  Color? text15 = Color(0xFFFFFFFF).withOpacity(0.15);
  @override
  Color? text10 = Color(0xFFFFFFFF).withOpacity(0.1);
  @override
  Color? text05 = Color(0xFFFFFFFF).withOpacity(0.05);
  @override
  Color? text03 = Color(0xFFFFFFFF).withOpacity(0.03);
  @override
  Color? positiveValue = Colors.lightGreenAccent[400];
  @override
  Color? negativeValue = Colors.red[300];
  @override
  Color? positiveAmount = Colors.greenAccent[400];
  @override
  Color? negativeAmount = Colors.redAccent[400];
  @override
  Color? warning = Colors.yellow[600];

  // Sheet
  @override
  Color? sheetBackground = Color(0xFF571150).withOpacity(0.7);

  // SnackBar
  @override
  Color? snackBarShadow = Color(0xFF571150).withOpacity(0.8);

  // Background
  @override
  Color? backgroundMainTop = Color(0xFF571150);
  @override
  Color? backgroundMainBottom = Color(0xFF571150);
  @override
  Color? background = Color(0xFF571150);
  @override
  Color? background40 = Color(0xFF571150).withOpacity(0.4);
  @override
  Color? backgroundDark = Color(0xFF571150);
  @override
  Color? backgroundDark00 = Color(0xFF571150).withOpacity(0.0);
  @override
  Color? backgroundDarkest = Color(0xFFCD195B);

  @override
  String? background1Small =
      'packages/core_ui/assets/themes/byzantine_violet/v01-waves-1100.jpg';
  @override
  String? background2Small =
      'packages/core_ui/assets/themes/byzantine_violet/v02-waves-1100.jpg';
  @override
  String? background3Small =
      'packages/core_ui/assets/themes/byzantine_violet/v03-waves-1100.jpg';
  @override
  String? background4Small =
      'packages/core_ui/assets/themes/byzantine_violet/v04-waves-1100.jpg';
  @override
  String? background5Small =
      'packages/core_ui/assets/themes/byzantine_violet/v05-waves-1100.jpg';

  // Animation Overlay
  @override
  Color? animationOverlayMedium = Color(0xFF571150).withOpacity(0.7);
  @override
  Color? animationOverlayStrong = Color(0xFF571150).withOpacity(0.85);

  @override
  Color? overlay30 = Color(0xFF571150).withOpacity(0.3);

  @override
  Color? numMnemonicBackground = Color(0xFF571150);

  @override
  Color? activeTrackColorSwitch = Color(0xFFFFFFFF);
  @override
  Color? inactiveTrackColorSwitch = Color(0xFFFFFFFF);

  @override
  Brightness? brightness = Brightness.dark;
  @override
  SystemUiOverlayStyle? statusBar =
      SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent);

  @override
  BoxShadow? boxShadow = const BoxShadow(color: Colors.transparent);
  @override
  BoxShadow? boxShadowButton = const BoxShadow(color: Colors.transparent);

  @override
  String? assetsFolder = 'packages/core_ui/assets/themes/byzantine_violet/';
  @override
  String? logo = 'logo';
  @override
  String? logoAlone = 'logo_alone';

  @override
  Gradient? gradient = const LinearGradient(
    colors: <Color>[
      Color(0xFF00A4DB),
      Color(0xFFCC00FF),
    ],
    begin: Alignment(-1.0, 0.0),
    end: Alignment(1.0, 0.0),
    transform: GradientRotation(pi / 9),
  );

  @override
  Decoration getDecorationBalance() {
    return GradientShadowBoxDecoration(
      image: DecorationImage(
        image: AssetImage(background2Small!),
        fit: BoxFit.cover,
      ),
      backgroundBlendMode: BlendMode.dstIn,
      gradient: LinearGradient(
        colors: <Color>[
          Color(0xFF571150),
          Color(0xFFCD195B),
        ],
        begin: Alignment(-1.0, 0.0),
        end: Alignment(1.0, 0.0),
        transform: GradientRotation(pi / 9),
      ),
    );
  }

  @override
  Decoration getDecorationSheet() {
    return BoxDecoration(
      color: text60,
      borderRadius: BorderRadius.only(
        topLeft: const Radius.circular(40.0),
        topRight: const Radius.circular(40.0),
      ),
      image: DecorationImage(
          image: AssetImage(background2Small!),
          fit: BoxFit.fitHeight,
          opacity: 0.8),
    );
  }
}
