/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/ui/themes/archethic_theme_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ArchethicTheme {
  // Fonts
  static String addressFont = 'Roboto';

  // Main Buttons
  static Color mainButtonLabel = ArchethicThemeBase.neutral0;
  static Color middleButtonLabel = ArchethicThemeBase.neutral0;
  static Gradient gradientMainButton = LinearGradient(
    colors: <Color>[
      ArchethicThemeBase.blue400,
      ArchethicThemeBase.blue600,
    ],
  );
  static Color maxButtonColor = ArchethicThemeBase.raspberry500;

  // IconData Widget
  static Color iconDataWidgetIconBackground =
      ArchethicThemeBase.neutral0.withOpacity(0.1);

  // Menu
  static Color iconDrawer = ArchethicThemeBase.neutral0;
  static Color iconDrawerBackground =
      ArchethicThemeBase.neutral0.withOpacity(0.2);
  static Color drawerBackground = ArchethicThemeBase.neutral800;

  // Icons Picker Items
  static Color pickerItemIconEnabled = ArchethicThemeBase.neutral0;
  static Color pickerItemIconDisabled =
      ArchethicThemeBase.neutral0.withOpacity(0.6);

  // Icons TextField
  static Color textFieldIcon = ArchethicThemeBase.neutral0;

  // Texts
  static Color text = ArchethicThemeBase.neutral0;
  static Color text60 = ArchethicThemeBase.neutral0.withOpacity(0.6);
  static Color text45 = ArchethicThemeBase.neutral0.withOpacity(0.45);
  static Color text30 = ArchethicThemeBase.neutral0.withOpacity(0.3);
  static Color text20 = ArchethicThemeBase.neutral0.withOpacity(0.2);
  static Color text15 = ArchethicThemeBase.neutral0.withOpacity(0.15);
  static Color text10 = ArchethicThemeBase.neutral0.withOpacity(0.1);
  static Color text05 = ArchethicThemeBase.neutral0.withOpacity(0.05);
  static Color text03 = ArchethicThemeBase.neutral0.withOpacity(0.03);
  static Color positiveValue = ArchethicThemeBase.systemPositive500;
  static Color negativeValue = ArchethicThemeBase.systemDanger500;
  static Color positiveAmount = ArchethicThemeBase.systemPositive500;
  static Color negativeAmount = ArchethicThemeBase.systemDanger500;
  static Color warning = ArchethicThemeBase.systemWarning500;
  static Color textDark = ArchethicThemeBase.neutral0;

  // Sheet
  static Color sheetBackground = ArchethicThemeBase.brightPurpleBackground;
  static Color sheetBorder = ArchethicThemeBase.brightPurpleBorder;

  // SnackBar
  static Color snackBarShadow = ArchethicThemeBase.neutral900.withOpacity(0.8);

  // Background
  static Color backgroundMainTop = ArchethicThemeBase.neutral900;
  static Color backgroundMainBottom = ArchethicThemeBase.neutral900;
  static Color background = ArchethicThemeBase.neutral900;
  static Color background40 = ArchethicThemeBase.neutral900.withOpacity(0.4);
  static Color backgroundDark = ArchethicThemeBase.neutral900;
  static Color backgroundDark00 = ArchethicThemeBase.neutral600;
  static Color backgroundDarkest = ArchethicThemeBase.neutral0;
  static Color backgroundAccountsListCard = Colors.transparent;
  static Color backgroundAccountsListCardSelected =
      ArchethicThemeBase.neutral0.withOpacity(0.1);
  static Color backgroundRecentTxListCardTransferOutput =
      ArchethicThemeBase.purple500.withOpacity(0.2);
  static Color backgroundRecentTxListCardTokenCreation =
      ArchethicThemeBase.blue700.withOpacity(0.4);
  static Color backgroundRecentTxListCardTransferInput =
      ArchethicThemeBase.raspberry500.withOpacity(0.4);
  static Color backgroundFungiblesTokensListCard =
      ArchethicThemeBase.neutral0.withOpacity(0.1);
  static Color backgroundTransferListCard = Colors.transparent;
  static Color backgroundTransferListTotalCard =
      ArchethicThemeBase.neutral0.withOpacity(0.1);
  static Color backgroundTransferListOutline =
      ArchethicThemeBase.neutral0.withOpacity(0.1);
  static Color backgroundPopupColor = ArchethicThemeBase.purple500;
  static Color divider = ArchethicThemeBase.blue700.withOpacity(0.1);

  // Bottom Bar
  static num bottomBarBackgroundColorOpacity = 0.2;
  static Color bottomBarActiveIconColor = ArchethicThemeBase.neutral900;
  static Color bottomBarActiveTitleColor =
      ArchethicThemeBase.neutral0.withOpacity(0.8);
  static Color bottomBarActiveColor = ArchethicThemeBase.neutral0;
  static Color bottomBarInactiveIcon = ArchethicThemeBase.neutral0;
  static String backgroundSmall = 'assets/themes/archethic/main-background.png';
  static String backgroundWelcome =
      'assets/themes/archethic/background_welcome.png';
  static String backgroundAESwap =
      'assets/themes/archethic/background_aeSwap.png';
  static String backgroundAirdrop =
      'assets/themes/archethic/background-airdrop.png';

  // Animation Overlay
  static Color animationOverlayMedium =
      const Color(0xFF000000).withOpacity(0.7);
  static Color animationOverlayStrong =
      const Color(0xFF000000).withOpacity(0.85);
  static Color overlay30 = const Color(0xFF000000).withOpacity(0.3);
  static Color seedInfoBackground = Colors.grey.shade800.withOpacity(0.5);
  static Color activeTrackColorSwitch = const Color(0xFFFFFFFF);
  static Color inactiveTrackColorSwitch = const Color(0xFFFFFFFF);
  static Color activeColorSwitch = Colors.green;
  static Brightness brightness = Brightness.dark;
  static SystemUiOverlayStyle statusBar =
      SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent);
  static BoxShadow boxShadow = const BoxShadow(color: Colors.transparent);
  static BoxShadow boxShadowButton = const BoxShadow(color: Colors.transparent);
  static String assetsFolder = 'assets/themes/archethic/';
  static Gradient gradient = LinearGradient(
    colors: <Color>[
      ArchethicThemeBase.blue400,
      ArchethicThemeBase.blue600,
    ],
  );

  static Decoration getDecorationSheet() {
    return const BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      image: DecorationImage(
        image: AssetImage('assets/themes/archethic/sheet-background.png'),
        fit: BoxFit.fitHeight,
      ),
    );
  }

  static Gradient gradientInputFormBackground = LinearGradient(
    colors: [
      ArchethicThemeBase.neutral900.withOpacity(1),
      ArchethicThemeBase.neutral900.withOpacity(0.3),
    ],
    stops: const [0, 1],
  );

  static Color favoriteIconColor = const Color(0xFF00A4DB);

  // Banner connectivity
  static Color bannerColor = Colors.red;
  static Color bannerShadowColor = Colors.white.withOpacity(0.8);
  static Color bannerTextColor = Colors.white;
}
