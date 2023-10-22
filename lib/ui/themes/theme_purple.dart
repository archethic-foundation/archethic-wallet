/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/ui/themes/themes.dart';
import 'package:aewallet/ui/themes/wallet_theme_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_borders/gradient_borders.dart';

class PurpleTheme implements BaseTheme {
  @override
  String? displayName = 'Purple';

  // Fonts
  @override
  String? mainFont = 'Telegraf';
  @override
  String? secondaryFont = 'Telegraf';

  // Main Buttons
  @override
  Color? mainButtonLabel = ArchethicThemeBase.neutral0;
  @override
  Color? middleButtonLabel = ArchethicThemeBase.neutral0;
  @override
  Gradient? gradientMainButton = ArchethicThemeBase.gradientPinkPurple500;

  // IconData Widget
  @override
  Color? iconDataWidgetIconBackground =
      ArchethicThemeBase.neutral0.withOpacity(0.1);

  // Menu
  @override
  Color? iconDrawer = ArchethicThemeBase.neutral0;
  @override
  Color? iconDrawerBackground = ArchethicThemeBase.neutral0.withOpacity(0.2);
  @override
  Color? drawerBackground = ArchethicThemeBase.neutral800;

  // Icons Picker Items
  @override
  Color? pickerItemIconEnabled = ArchethicThemeBase.neutral0;
  @override
  Color? pickerItemIconDisabled = ArchethicThemeBase.neutral0.withOpacity(0.6);

  // Icons TextField
  @override
  Color? textFieldIcon = ArchethicThemeBase.neutral0;

  // Texts
  @override
  Color? text = ArchethicThemeBase.neutral0;
  @override
  Color? text60 = ArchethicThemeBase.neutral0.withOpacity(0.6);
  @override
  Color? text45 = ArchethicThemeBase.neutral0.withOpacity(0.45);
  @override
  Color? text30 = ArchethicThemeBase.neutral0.withOpacity(0.3);
  @override
  Color? text20 = ArchethicThemeBase.neutral0.withOpacity(0.2);
  @override
  Color? text15 = ArchethicThemeBase.neutral0.withOpacity(0.15);
  @override
  Color? text10 = ArchethicThemeBase.neutral0.withOpacity(0.1);
  @override
  Color? text05 = ArchethicThemeBase.neutral0.withOpacity(0.05);
  @override
  Color? text03 = ArchethicThemeBase.neutral0.withOpacity(0.03);
  @override
  Color? positiveValue = ArchethicThemeBase.systemPositive500;
  @override
  Color? negativeValue = ArchethicThemeBase.systemDanger500;
  @override
  Color? positiveAmount = ArchethicThemeBase.systemPositive500;
  @override
  Color? negativeAmount = ArchethicThemeBase.systemDanger500;
  @override
  Color? warning = ArchethicThemeBase.systemWarning500;

  @override
  Color? textDark = ArchethicThemeBase.neutral0;

  // Sheet
  @override
  Color? sheetBackground = ArchethicThemeBase.neutral900.withOpacity(0.7);

  // SnackBar
  @override
  Color? snackBarShadow = ArchethicThemeBase.neutral900.withOpacity(0.8);

  // Background
  @override
  Color? backgroundMainTop = ArchethicThemeBase.neutral900;
  @override
  Color? backgroundMainBottom = ArchethicThemeBase.neutral900;
  @override
  Color? background = ArchethicThemeBase.neutral900;
  @override
  Color? background40 = ArchethicThemeBase.neutral900.withOpacity(0.4);
  @override
  Color? backgroundDark = ArchethicThemeBase.neutral900;
  @override
  Color? backgroundDark00 = ArchethicThemeBase.neutral600;
  @override
  Color? backgroundDarkest = ArchethicThemeBase.neutral0;

  @override
  Color? backgroundAccountsListCard = Colors.transparent;
  @override
  Color? backgroundAccountsListCardSelected =
      ArchethicThemeBase.neutral0.withOpacity(0.1);
  @override
  Color? backgroundRecentTxListCardTransferOutput =
      ArchethicThemeBase.neutral0.withOpacity(0.2);
  @override
  Color? backgroundRecentTxListCardTokenCreation =
      ArchethicThemeBase.blue800.withOpacity(0.4);
  @override
  Color? backgroundRecentTxListCardTransferInput =
      ArchethicThemeBase.raspberry500.withOpacity(0.4);
  @override
  Color? backgroundFungiblesTokensListCard =
      ArchethicThemeBase.neutral0.withOpacity(0.1);
  @override
  Color? backgroundTransferListCard = Colors.transparent;
  @override
  Color? backgroundTransferListTotalCard =
      ArchethicThemeBase.neutral0.withOpacity(0.1);
  @override
  Color? backgroundTransferListOutline =
      ArchethicThemeBase.neutral0.withOpacity(0.1);

  // Bottom Bar
  @override
  num? bottomBarBackgroundColorOpacity = 0.2;
  @override
  Color? bottomBarActiveIconColor = ArchethicThemeBase.neutral900;
  @override
  Color? bottomBarActiveTitleColor =
      ArchethicThemeBase.neutral0.withOpacity(0.8);
  @override
  Color? bottomBarActiveColor = ArchethicThemeBase.neutral0;
  @override
  Color? bottomBarInactiveIcon = ArchethicThemeBase.neutral0;

  @override
  String? background1Small = 'assets/themes/purple/main-background.jpg';
  @override
  String? background2Small = 'assets/themes/purple/main-background.jpg';
  @override
  String? background3Small = 'assets/themes/purple/main-background.jpg';
  @override
  String? background4Small = 'assets/themes/purple/main-background.jpg';
  @override
  String? background5Small = 'assets/themes/purple/main-background.jpg';

  // Animation Overlay
  @override
  Color? animationOverlayMedium = const Color(0xFF000000).withOpacity(0.7);
  @override
  Color? animationOverlayStrong = const Color(0xFF000000).withOpacity(0.85);

  @override
  Color? overlay30 = const Color(0xFF000000).withOpacity(0.3);

  @override
  Color? numMnemonicBackground = Colors.grey.shade800;

  @override
  Color? activeTrackColorSwitch = const Color(0xFFFFFFFF);
  @override
  Color? inactiveTrackColorSwitch = const Color(0xFFFFFFFF);
  @override
  Color? activeColorSwitch = Colors.green;

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
  String? assetsFolder = 'assets/themes/purple/';
  @override
  String? logo = 'logo';
  @override
  String? logoAlone = 'logo_alone';

  @override
  Gradient? gradient = ArchethicThemeBase.gradientPinkPurple500;

  @override
  Decoration getDecorationBalance() {
    return BoxDecoration(
      border: GradientBoxBorder(
        gradient: ArchethicThemeBase.gradientPinkPurple500,
      ),
      borderRadius: BorderRadius.circular(10),
    );
  }

  @override
  Decoration getDecorationSheet() {
    return const BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      image: DecorationImage(
        image: AssetImage('assets/themes/purple/sheet-background.png'),
        fit: BoxFit.fill,
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
