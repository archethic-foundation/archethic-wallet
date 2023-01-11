/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:math';

// Project imports:
import 'package:aewallet/ui/themes/themes.dart';
import 'package:aewallet/ui/widgets/components/gradient_shadow_box_decoration.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlatTheme implements BaseTheme {
  @override
  String? displayName = 'Flat';

  // Fonts
  @override
  String? mainFont = 'OpenSans';
  @override
  String? secondaryFont = 'OpenSans';

  // Main Buttons
  @override
  Color? mainButtonLabel = const Color(0xFFFFFFFF);
  @override
  Color? middleButtonLabel = const Color(0xFFFFFFFF);
  @override
  Gradient? gradientMainButton = const LinearGradient(
    colors: <Color>[
      Color.fromARGB(255, 43, 43, 43),
      Color.fromARGB(255, 43, 43, 43)
    ],
    transform: GradientRotation(pi / 9),
  );

  // IconData Widget
  @override
  Color? iconDataWidgetIconBackground =
      const Color(0xFFFFFFFF).withOpacity(0.1);

  // Menu
  @override
  Color? iconDrawer = const Color.fromARGB(255, 88, 88, 88);
  @override
  Color? iconDrawerBackground = const Color(0xFFFFFFFF).withOpacity(0.2);
  @override
  Color? drawerBackground = const Color(0xFFFFFFFF);

  // Icons Picker Items
  @override
  Color? pickerItemIconEnabled = const Color.fromARGB(255, 88, 88, 88);
  @override
  Color? pickerItemIconDisabled =
      const Color.fromARGB(255, 88, 88, 88).withOpacity(0.6);

  // Icons TextField
  @override
  Color? textFieldIcon = const Color.fromARGB(255, 88, 88, 88);

  // Texts
  @override
  Color? text = const Color.fromARGB(255, 88, 88, 88);
  @override
  Color? text60 = const Color.fromARGB(255, 88, 88, 88).withOpacity(0.6);
  @override
  Color? text45 = const Color.fromARGB(255, 88, 88, 88).withOpacity(0.45);
  @override
  Color? text30 = const Color.fromARGB(255, 88, 88, 88).withOpacity(0.3);
  @override
  Color? text20 = const Color.fromARGB(255, 88, 88, 88).withOpacity(0.2);
  @override
  Color? text15 = const Color.fromARGB(255, 88, 88, 88).withOpacity(0.15);
  @override
  Color? text10 = const Color.fromARGB(255, 88, 88, 88).withOpacity(0.1);
  @override
  Color? text05 = const Color.fromARGB(255, 88, 88, 88).withOpacity(0.05);
  @override
  Color? text03 = const Color.fromARGB(255, 88, 88, 88).withOpacity(0.03);
  @override
  Color? positiveValue = Colors.green;
  @override
  Color? negativeValue = Colors.red;
  @override
  Color? positiveAmount = Colors.green;
  @override
  Color? negativeAmount = Colors.red;
  @override
  Color? warning = Colors.redAccent[400];

  @override
  Color? textDark = const Color(0xFF000000);

  // Sheet
  @override
  Color? sheetBackground = const Color(0xFFFFFFFF).withOpacity(0.7);

  // SnackBar
  @override
  Color? snackBarShadow = const Color(0xFFFFFFFF).withOpacity(0.8);

  // Background
  @override
  Color? backgroundMainTop = const Color(0xFFFFFFFF);
  @override
  Color? backgroundMainBottom = const Color(0xFFFFFFFF);
  @override
  Color? background = const Color(0xFFFFFFFF);
  @override
  Color? background40 = const Color(0xFFFFFFFF).withOpacity(0.4);
  @override
  Color? backgroundDark = const Color(0xFFFFFFFF);
  @override
  Color? backgroundDark00 = const Color(0xFFFFFFFF).withOpacity(0);
  @override
  Color? backgroundDarkest = const Color.fromARGB(255, 88, 88, 88);

  @override
  Color? backgroundAccountsListCard = Colors.transparent;
  @override
  Color? backgroundAccountsListCardSelected = Colors.grey.withOpacity(0.1);
  @override
  Color? backgroundRecentTxListCardTransferOutput =
      Colors.grey.withOpacity(0.1);
  @override
  Color? backgroundRecentTxListCardTokenCreation =
      Colors.blueAccent[100]!.withOpacity(0.1);
  @override
  Color? backgroundRecentTxListCardTransferInput =
      Colors.green.withOpacity(0.1);
  @override
  Color? backgroundFungiblesTokensListCard = Colors.grey.withOpacity(0.1);
  @override
  Color? backgroundTransferListCard = Colors.transparent;
  @override
  Color? backgroundTransferListTotalCard = Colors.grey.withOpacity(0.5);
  @override
  Color? backgroundTransferListOutline = Colors.grey.withOpacity(0.5);

  // Bottom Bar
  @override
  num? bottomBarBackgroundColorOpacity = 0.2;
  @override
  Color? bottomBarActiveIconColor = const Color(0xFF000000);
  @override
  Color? bottomBarActiveTitleColor = const Color(0xFF000000).withOpacity(0.8);
  @override
  Color? bottomBarActiveColor = const Color(0xFF000000);
  @override
  Color? bottomBarInactiveIcon = const Color(0xFF000000);

  @override
  String? background1Small = 'assets/themes/flat/bk-white.jpg';
  @override
  String? background2Small = 'assets/themes/flat/bk-white.jpg';
  @override
  String? background3Small = 'assets/themes/flat/bk-white.jpg';
  @override
  String? background4Small = 'assets/themes/flat/bk-white.jpg';
  @override
  String? background5Small = 'assets/themes/flat/bk-white.jpg';

  // Animation Overlay
  @override
  Color? animationOverlayMedium = const Color(0xFFFFFFFF).withOpacity(0.7);
  @override
  Color? animationOverlayStrong = const Color(0xFFFFFFFF).withOpacity(0.85);

  @override
  Color? overlay30 = const Color(0xFFFFFFFF).withOpacity(0.3);

  @override
  Color? numMnemonicBackground = const Color(0xFFFFFFFF);

  @override
  Color? activeTrackColorSwitch = Colors.green[100];
  @override
  Color? inactiveTrackColorSwitch = Colors.grey;
  @override
  Color? activeColorSwitch = Colors.green;

  @override
  Brightness? brightness = Brightness.light;
  @override
  SystemUiOverlayStyle? statusBar =
      SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent);

  @override
  BoxShadow? boxShadow = const BoxShadow(color: Colors.transparent);
  @override
  BoxShadow? boxShadowButton = const BoxShadow(color: Colors.transparent);

  @override
  String? assetsFolder = 'assets/themes/flat/';
  @override
  String? logo = 'logo';
  @override
  String? logoAlone = 'logo_alone';

  @override
  Gradient? gradient = const LinearGradient(
    colors: <Color>[
      Color.fromARGB(255, 88, 88, 88),
      Color.fromARGB(255, 88, 88, 88)
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
          Colors.transparent,
          Colors.transparent,
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
      ),
    );
  }

  @override
  Color? favoriteIconColor = const Color.fromARGB(255, 88, 88, 88);

  // Banner connectivity
  @override
  Color? bannerColor = Colors.red;
  @override
  Color? bannerShadowColor = Colors.white.withOpacity(0.8);
  @override
  Color? bannerTextColor = Colors.white;
}
