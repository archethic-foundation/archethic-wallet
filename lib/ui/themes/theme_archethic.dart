// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Project imports:
import 'package:archethic_mobile_wallet/ui/themes/themes.dart';

class ArchEthicTheme implements BaseTheme {
  @override
  String? displayName = 'Archethic';

  static const Color orange = Color(0xFFfc9034);

  static const Color orangeDark = Color(0xFFf9852b);

  static const Color blue = Color(0xFF1ba5d9);

  static const Color blackDark = Color(0xFF000000);

  static const Color blueDarktest = Color(0xFF06347c);

  static const Color white = Color(0xFFFFFFFF);

  static const Color black = Color(0xFF000000);

  static const Color grey = Color(0xFF4b4b4b);

  @override
  Color? primary = white;
  @override
  Color? primary60 = white.withOpacity(0.6);
  @override
  Color? primary45 = white.withOpacity(0.45);
  @override
  Color? primary30 = white.withOpacity(0.3);
  @override
  Color? primary20 = white.withOpacity(0.2);
  @override
  Color? primary15 = white.withOpacity(0.15);
  @override
  Color? primary10 = white.withOpacity(0.1);
  @override
  Color? primary05 = white.withOpacity(0.05);
  @override
  Color? primary03 = white.withOpacity(0.03);

  @override
  Color? icon = white;
  @override
  Color? icon45 = white.withOpacity(0.45);
  @override
  Color? icon60 = white.withOpacity(0.60);

  @override
  Color? success = orange;
  @override
  Color? success60 = orange.withOpacity(0.6);
  @override
  Color? success30 = orange.withOpacity(0.3);
  @override
  Color? success15 = orange.withOpacity(0.15);

  @override
  Color? successDark = orangeDark;
  @override
  Color? successDark30 = orangeDark.withOpacity(0.3);

  @override
  Color? background = black;
  @override
  Color? background40 = black.withOpacity(0.4);
  @override
  Color? background00 = black.withOpacity(0.0);
  @override
  Color? backgroundDark = blackDark;
  @override
  Color? backgroundDark00 = blackDark.withOpacity(0.0);

  @override
  Color? backgroundDarkest = blue;

  @override
  Color? overlay90 = black.withOpacity(0.9);
  @override
  Color? overlay85 = black.withOpacity(0.85);
  @override
  Color? overlay80 = black.withOpacity(0.8);
  @override
  Color? overlay70 = black.withOpacity(0.7);
  @override
  Color? overlay50 = black.withOpacity(0.5);
  @override
  Color? overlay30 = black.withOpacity(0.3);
  @override
  Color? overlay20 = black.withOpacity(0.2);

  @override
  Color? animationOverlayMedium = black.withOpacity(0.7);
  @override
  Color? animationOverlayStrong = black.withOpacity(0.85);

  @override
  Color? positiveValue = Colors.lightGreenAccent[400];
  @override
  Color? negativeValue = Colors.red[300];

  @override
  Color? contextMenuText = blue;
  @override
  Color? contextMenuTextRed = Colors.red[300];

  @override
  Color? choiceOption = Colors.lightGreenAccent[400];

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
  String? assetsFolder = 'assets/themes/archethic/';
  @override
  String? logo = 'logo.svg';
  @override
  String? logoAlone = 'logo_alone.svg';

  @override
  Widget? getBackgroundScreen(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/themes/archethic/background.jpg'),
            fit: BoxFit.cover),
      ),
    );
  }
}
