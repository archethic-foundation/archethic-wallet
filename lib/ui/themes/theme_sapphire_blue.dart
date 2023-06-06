/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:math';

// Project imports:
import 'package:aewallet/ui/themes/themes.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_borders/gradient_borders.dart';

class SapphireBlueTheme implements BaseTheme {
  @override
  String? displayName = 'Sapphire blue';

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
  Color? iconDataWidgetIconBackground = const Color(0xFFFFFFFF);

  // Menu
  @override
  Color? iconDrawer = const Color(0xFFFFFFFF);
  @override
  Color? iconDrawerBackground = const Color(0xFFFFFFFF);
  @override
  Color? drawerBackground = const Color(0xFF1B55A7);

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
  Color? negativeValue = Colors.redAccent[200];
  @override
  Color? positiveAmount = Colors.greenAccent[400];
  @override
  Color? negativeAmount = Colors.redAccent[200];
  @override
  Color? warning = Colors.yellow[600];

  @override
  Color? textDark = const Color(0xFFFFFFFF);

  // Sheet
  @override
  Color? sheetBackground = const Color(0xFF1B55A7).withOpacity(0.7);

  // SnackBar
  @override
  Color? snackBarShadow = const Color(0xFF1B55A7).withOpacity(0.8);

  // Background
  @override
  Color? backgroundMainTop = const Color(0xFF1B55A7);
  @override
  Color? backgroundMainBottom = const Color(0xFF1B55A7);
  @override
  Color? background = const Color(0xFF1B55A7);
  @override
  Color? background40 = const Color(0xFF1B55A7).withOpacity(0.4);
  @override
  Color? backgroundDark = const Color(0xFF1B55A7);
  @override
  Color? backgroundDark00 = const Color(0xFF1B55A7).withOpacity(0);
  @override
  Color? backgroundDarkest = const Color(0xFF0688E8);

  @override
  Color? backgroundAccountsListCard = Colors.transparent;
  @override
  Color? backgroundAccountsListCardSelected = Colors.white.withOpacity(0.1);
  @override
  Color? backgroundRecentTxListCardTransferOutput = Colors.redAccent[400]!.withOpacity(0.3);
  @override
  Color? backgroundRecentTxListCardTokenCreation = Colors.blueAccent[100]!.withOpacity(0.2);
  @override
  Color? backgroundRecentTxListCardTransferInput = Colors.greenAccent[400]!.withOpacity(0.3);
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
  Color? bottomBarActiveIconColor = const Color(0xFF1B55A7);
  @override
  Color? bottomBarActiveTitleColor = const Color(0xFFFFFFFF).withOpacity(0.8);
  @override
  Color? bottomBarActiveColor = const Color(0xFFFFFFFF);
  @override
  Color? bottomBarInactiveIcon = const Color(0xFFFFFFFF);

  @override
  String? background1Small = 'assets/themes/sapphire_blue/v01-waves.jpg';
  @override
  String? background2Small = 'assets/themes/sapphire_blue/v02-waves.jpg';
  @override
  String? background3Small = 'assets/themes/sapphire_blue/v03-waves.jpg';
  @override
  String? background4Small = 'assets/themes/sapphire_blue/v04-waves.jpg';
  @override
  String? background5Small = 'assets/themes/sapphire_blue/v05-waves.jpg';

  // Animation Overlay
  @override
  Color? animationOverlayMedium = const Color(0xFF1B55A7).withOpacity(0.7);
  @override
  Color? animationOverlayStrong = const Color(0xFF1B55A7).withOpacity(0.85);

  @override
  Color? overlay30 = const Color(0xFF1B55A7).withOpacity(0.3);

  @override
  Color? numMnemonicBackground = const Color(0xFF1B55A7);

  @override
  Color? activeTrackColorSwitch = const Color(0xFFFFFFFF);
  @override
  Color? inactiveTrackColorSwitch = const Color(0xFFFFFFFF);
  @override
  Color? activeColorSwitch = Colors.green;

  @override
  Brightness? brightness = Brightness.dark;
  @override
  SystemUiOverlayStyle? statusBar = SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent);

  @override
  BoxShadow? boxShadow = const BoxShadow(color: Colors.transparent);
  @override
  BoxShadow? boxShadowButton = const BoxShadow(color: Colors.transparent);

  @override
  String? assetsFolder = 'assets/themes/sapphire_blue/';
  @override
  String? logo = 'logo';
  @override
  String? logoAlone = 'logo_alone';

  @override
  Gradient? gradient = const LinearGradient(
    colors: <Color>[
      Color(0xFFFFFFFF),
      Color(0xFFFFFFFF),
    ],
    transform: GradientRotation(pi / 9),
  );

  @override
  Decoration getDecorationBalance() {
    return BoxDecoration(
      border: GradientBoxBorder(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF0688E8),
            const Color(0xFF0688E8).withOpacity(0.3),
            const Color(0xFF1B55A7).withOpacity(0.5),
          ],
          stops: const [0.6, 0.8, 1],
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          transform: const GradientRotation(4),
        ),
      ),
      borderRadius: BorderRadius.circular(10),
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
  Color? favoriteIconColor = const Color(0xFF00A4DB);

  // Banner connectivity
  @override
  Color? bannerColor = Colors.red;
  @override
  Color? bannerShadowColor = Colors.white.withOpacity(0.8);
  @override
  Color? bannerTextColor = Colors.white;
}
