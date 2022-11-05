/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:math';

// Project imports:
import 'package:aewallet/ui/themes/themes.dart';
import 'package:aewallet/ui/widgets/components/gradient_shadow_box_decoration.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ByzantineVioletTheme implements BaseTheme {
  @override
  String? displayName = 'Byzantine violet';

  // Fonts
  @override
  String? mainFont = 'Equinox';
  @override
  String? secondaryFont = 'Montserrat';

  // Main Buttons
  @override
  Color? mainButtonLabel = const Color(0xFFFFFFFF);
  @override
  Color? middleButtonLabel = const Color(0xFFFFFFFF);
  @override
  Gradient? gradientMainButton = const LinearGradient(
    colors: <Color>[
      Color(0xFF00A4DB),
      Color(0xFFCC00FF),
    ],
    transform: GradientRotation(pi / 9),
  );

  // IconData Widget
  @override
  Color? iconDataWidgetBoxShadow = const Color(0xFFFFFFFF).withOpacity(0.5);
  @override
  Color? iconDataWidgetIconGradientLeft = const Color(0xFF00A4DB);
  @override
  Color? iconDataWidgetIconGradientRight = const Color(0xFFCC00FF);
  @override
  Color? iconDataWidgetIconBackground = const Color(0xFFFFFFFF);

  // Menu
  @override
  Color? iconDrawer = const Color(0xFFCD195B);
  @override
  Color? iconDrawerBackground = const Color(0xFFFFFFFF);
  @override
  Color? drawerBackground = const Color(0xFF571150);

  // Icons Picker Items
  @override
  Color? pickerItemIconEnabled = const Color(0xFFFFFFFF);
  @override
  Color? pickerItemIconDisabled = const Color(0xFFFFFFFF).withOpacity(0.6);

  // Icons TextField
  @override
  Color? textFieldIcon = const Color(0xFFFFFFFF);

  // Texts
  @override
  Color? text = const Color(0xFFFFFFFF);
  @override
  Color? text60 = const Color(0xFFFFFFFF).withOpacity(0.6);
  @override
  Color? text45 = const Color(0xFFFFFFFF).withOpacity(0.45);
  @override
  Color? text30 = const Color(0xFFFFFFFF).withOpacity(0.3);
  @override
  Color? text20 = const Color(0xFFFFFFFF).withOpacity(0.2);
  @override
  Color? text15 = const Color(0xFFFFFFFF).withOpacity(0.15);
  @override
  Color? text10 = const Color(0xFFFFFFFF).withOpacity(0.1);
  @override
  Color? text05 = const Color(0xFFFFFFFF).withOpacity(0.05);
  @override
  Color? text03 = const Color(0xFFFFFFFF).withOpacity(0.03);
  @override
  Color? positiveValue = Colors.lightGreenAccent[400];
  @override
  Color? negativeValue = Colors.red[100];
  @override
  Color? positiveAmount = Colors.greenAccent[400];
  @override
  Color? negativeAmount = Colors.red[100];
  @override
  Color? warning = Colors.yellow[600];

  @override
  Color? textDark = const Color(0xFFFFFFFF);

  // Sheet
  @override
  Color? sheetBackground = const Color(0xFF571150).withOpacity(0.7);

  // SnackBar
  @override
  Color? snackBarShadow = const Color(0xFF571150).withOpacity(0.8);

  // Background
  @override
  Color? backgroundMainTop = const Color(0xFF571150);
  @override
  Color? backgroundMainBottom = const Color(0xFF571150);
  @override
  Color? background = const Color(0xFF571150);
  @override
  Color? background40 = const Color(0xFF571150).withOpacity(0.4);
  @override
  Color? backgroundDark = const Color(0xFF571150);
  @override
  Color? backgroundDark00 = const Color(0xFF571150).withOpacity(0);
  @override
  Color? backgroundDarkest = const Color(0xFFCD195B);

  @override
  Color? backgroundAccountsListCard = Colors.transparent;
  @override
  Color? backgroundAccountsListCardSelected = Colors.white.withOpacity(0.1);
  @override
  Color? backgroundRecentTxListCardTransferOutput =
      Colors.white.withOpacity(0.1);
  @override
  Color? backgroundRecentTxListCardTokenCreation =
      Colors.blueAccent[100]!.withOpacity(0.1);
  @override
  Color? backgroundRecentTxListCardTransferInput =
      Colors.greenAccent[100]!.withOpacity(0.1);
  @override
  Color? backgroundFungiblesTokensListCard = Colors.white.withOpacity(0.1);
  @override
  Color? backgroundTransferListCard = Colors.transparent;
  @override
  Color? backgroundTransferListTotalCard = Colors.white.withOpacity(0.1);
  @override
  Color? backgroundTransferListOutline = Colors.white.withOpacity(0.1);

  // Bottom Bar
  @override
  num? bottomBarBackgroundColorOpacity = 0.2;
  @override
  Color? bottomBarActiveIconColor = const Color(0xFF571150);
  @override
  Color? bottomBarActiveTitleColor = const Color(0xFFFFFFFF).withOpacity(0.8);
  @override
  Color? bottomBarActiveColor = const Color(0xFFFFFFFF);
  @override
  Color? bottomBarInactiveIcon = const Color(0xFFFFFFFF);

  @override
  String? background1Small =
      'assets/themes/byzantine_violet/v01-waves-1100.jpg';
  @override
  String? background2Small =
      'assets/themes/byzantine_violet/v02-waves-1100.jpg';
  @override
  String? background3Small =
      'assets/themes/byzantine_violet/v03-waves-1100.jpg';
  @override
  String? background4Small =
      'assets/themes/byzantine_violet/v04-waves-1100.jpg';
  @override
  String? background5Small =
      'assets/themes/byzantine_violet/v05-waves-1100.jpg';

  // Animation Overlay
  @override
  Color? animationOverlayMedium = const Color(0xFF571150).withOpacity(0.7);
  @override
  Color? animationOverlayStrong = const Color(0xFF571150).withOpacity(0.85);

  @override
  Color? overlay30 = const Color(0xFF571150).withOpacity(0.3);

  @override
  Color? numMnemonicBackground = const Color(0xFF571150);

  @override
  Color? activeTrackColorSwitch = const Color(0xFFFFFFFF);
  @override
  Color? inactiveTrackColorSwitch = const Color(0xFFFFFFFF);

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
  String? assetsFolder = 'assets/themes/byzantine_violet/';
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
      gradient: const LinearGradient(
        colors: <Color>[
          Color(0xFF571150),
          Color(0xFFCD195B),
        ],
        transform: GradientRotation(pi / 9),
      ),
    );
  }

  @override
  Decoration getDecorationSheet() {
    return BoxDecoration(
      color: text20,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      image: DecorationImage(
        image: AssetImage(background2Small!),
        fit: BoxFit.fitHeight,
        opacity: 0.8,
      ),
    );
  }

  @override
  Color? favoriteIconColor = Colors.yellow[800];
}
