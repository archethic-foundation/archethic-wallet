/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ArchethicTheme {
  // Fonts
  static String addressFont = 'Roboto';

  // Main Buttons
  static Color mainButtonLabel = aedappfm.ArchethicThemeBase.neutral0;
  static Color middleButtonLabel = aedappfm.ArchethicThemeBase.neutral0;
  static Gradient gradientMainButton = LinearGradient(
    colors: <Color>[
      aedappfm.ArchethicThemeBase.blue400,
      aedappfm.ArchethicThemeBase.blue600,
    ],
  );
  static Color maxButtonColor = aedappfm.ArchethicThemeBase.raspberry500;

  // IconData Widget
  static Color iconDataWidgetIconBackground =
      aedappfm.ArchethicThemeBase.neutral0.withOpacity(0.1);

  // Menu
  static Color iconDrawer = aedappfm.ArchethicThemeBase.neutral0;
  static Color iconDrawerBackground =
      aedappfm.ArchethicThemeBase.neutral0.withOpacity(0.2);
  static Color drawerBackground = aedappfm.ArchethicThemeBase.neutral800;

  // Icons Picker Items
  static Color pickerItemIconEnabled = aedappfm.ArchethicThemeBase.neutral0;
  static Color pickerItemIconDisabled =
      aedappfm.ArchethicThemeBase.neutral0.withOpacity(0.6);

  // Icons TextField
  static Color textFieldIcon = aedappfm.ArchethicThemeBase.neutral0;

  // Texts
  static Color text = aedappfm.ArchethicThemeBase.neutral0;
  static Color text60 = aedappfm.ArchethicThemeBase.neutral0.withOpacity(0.6);
  static Color text45 = aedappfm.ArchethicThemeBase.neutral0.withOpacity(0.45);
  static Color text30 = aedappfm.ArchethicThemeBase.neutral0.withOpacity(0.3);
  static Color text20 = aedappfm.ArchethicThemeBase.neutral0.withOpacity(0.2);
  static Color text15 = aedappfm.ArchethicThemeBase.neutral0.withOpacity(0.15);
  static Color text10 = aedappfm.ArchethicThemeBase.neutral0.withOpacity(0.1);
  static Color text05 = aedappfm.ArchethicThemeBase.neutral0.withOpacity(0.05);
  static Color text03 = aedappfm.ArchethicThemeBase.neutral0.withOpacity(0.03);
  static Color positiveValue = aedappfm.ArchethicThemeBase.systemPositive500;
  static Color negativeValue = aedappfm.ArchethicThemeBase.systemDanger500;
  static Color positiveAmount = aedappfm.ArchethicThemeBase.systemPositive500;
  static Color negativeAmount = aedappfm.ArchethicThemeBase.systemDanger500;
  static Color warning = aedappfm.ArchethicThemeBase.systemWarning500;
  static Color textDark = aedappfm.ArchethicThemeBase.neutral0;

  // Sheet
  static Color sheetBackground =
      aedappfm.ArchethicThemeBase.brightPurpleBackground;
  static Color sheetBorder = aedappfm.ArchethicThemeBase.brightPurpleBorder;

  // SnackBar
  static Color snackBarShadow =
      aedappfm.ArchethicThemeBase.neutral900.withOpacity(0.8);

  // Background
  static Color backgroundMainTop = aedappfm.ArchethicThemeBase.neutral900;
  static Color backgroundMainBottom = aedappfm.ArchethicThemeBase.neutral900;
  static Color background = aedappfm.ArchethicThemeBase.neutral900;
  static Color background40 =
      aedappfm.ArchethicThemeBase.neutral900.withOpacity(0.4);
  static Color backgroundDark = aedappfm.ArchethicThemeBase.neutral900;
  static Color backgroundDark00 = aedappfm.ArchethicThemeBase.neutral600;
  static Color backgroundDarkest = aedappfm.ArchethicThemeBase.neutral0;
  static Color backgroundAccountsListCard = Colors.transparent;
  static Color backgroundAccountsListCardSelected =
      aedappfm.ArchethicThemeBase.neutral0.withOpacity(0.1);
  static Color backgroundRecentTxListCardTransferOutput =
      aedappfm.ArchethicThemeBase.purple500.withOpacity(0.2);
  static Color backgroundRecentTxListCardTokenCreation =
      aedappfm.ArchethicThemeBase.blue700.withOpacity(0.4);
  static Color backgroundRecentTxListCardTransferInput =
      aedappfm.ArchethicThemeBase.raspberry500.withOpacity(0.4);
  static Color backgroundFungiblesTokensListCard =
      aedappfm.ArchethicThemeBase.neutral0.withOpacity(0.1);
  static Color backgroundTransferListCard = Colors.transparent;
  static Color backgroundTransferListTotalCard =
      aedappfm.ArchethicThemeBase.neutral0.withOpacity(0.1);
  static Color backgroundTransferListOutline =
      aedappfm.ArchethicThemeBase.neutral0.withOpacity(0.1);
  static Color backgroundPopupColor = aedappfm.ArchethicThemeBase.purple500;
  static Color divider = aedappfm.ArchethicThemeBase.blue700.withOpacity(0.1);

  // Bottom Bar
  static num bottomBarBackgroundColorOpacity = 0.2;
  static Color bottomBarActiveIconColor =
      aedappfm.ArchethicThemeBase.neutral900;
  static Color bottomBarActiveTitleColor =
      aedappfm.ArchethicThemeBase.neutral0.withOpacity(0.8);
  static Color bottomBarActiveColor = aedappfm.ArchethicThemeBase.neutral0;
  static Color bottomBarInactiveIcon = aedappfm.ArchethicThemeBase.neutral0;
  static String backgroundSmall = 'assets/themes/archethic/main-background.png';
  static String backgroundWelcome =
      'assets/themes/archethic/background_welcome.png';
  static String backgroundAESwap =
      'assets/themes/archethic/background_aeSwap.png';
  static String backgroundBlocLogo =
      'assets/themes/archethic/background-bloclogo.png';

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
      aedappfm.ArchethicThemeBase.blue400,
      aedappfm.ArchethicThemeBase.blue600,
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
      aedappfm.ArchethicThemeBase.neutral900.withOpacity(1),
      aedappfm.ArchethicThemeBase.neutral900.withOpacity(0.3),
    ],
    stops: const [0, 1],
  );

  static Color favoriteIconColor = const Color(0xFF00A4DB);

  // Banner connectivity
  static Color bannerColor = Colors.red;
  static Color bannerShadowColor = Colors.white.withOpacity(0.8);
  static Color bannerTextColor = Colors.white;
}
