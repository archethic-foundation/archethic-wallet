// @dart=2.9

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class BaseTheme {
  Color primary;
  Color primary60;
  Color primary45;
  Color primary30;
  Color primary20;
  Color primary15;
  Color primary10;

  Color icon;
  Color icon45;
  Color icon60;

  Color success;
  Color success60;
  Color success30;
  Color success15;
  Color successDark;
  Color successDark30;

  Color background;
  Color background40;
  Color background00;

  Color backgroundDark;
  Color backgroundDark00;

  Color backgroundDarkest;

  Color text;
  Color text60;
  Color text45;
  Color text30;
  Color text20;
  Color text15;
  Color text10;
  Color text05;
  Color text03;

  Color overlay20;
  Color overlay30;
  Color overlay50;
  Color overlay70;
  Color overlay80;
  Color overlay85;
  Color overlay90;

  Color animationOverlayMedium;
  Color animationOverlayStrong;

  Color positiveValue;
  Color negativeValue;

  Color choiceOption;

  Brightness brightness;
  SystemUiOverlayStyle statusBar;

  BoxShadow boxShadow;
  BoxShadow boxShadowButton;

  // App icon (iOS only)
  AppIconEnum appIcon;
}

class UnirisTheme extends BaseTheme {
  static const orange = Color(0xFFfc9034);

  static const orangeDark = Color(0xFFf9852b);

  static const blue = Color(0xFF1ba5d9);

  static const blueDark = Color(0xFF106fcf);

  static const blueDarktest = Color(0xFF06347c);

  static const white = Color(0xFFFFFFFF);

  static const black = Color(0xFF000000);

  static const grey = Color(0xFF4b4b4b);

  Color primary = white;
  Color primary60 = white.withOpacity(0.6);
  Color primary45 = white.withOpacity(0.45);
  Color primary30 = white.withOpacity(0.3);
  Color primary20 = white.withOpacity(0.2);
  Color primary15 = white.withOpacity(0.15);
  Color primary10 = white.withOpacity(0.1);

  Color icon = white;
  Color icon45 = white.withOpacity(0.45);
  Color icon60 = white.withOpacity(0.60);

  Color success = orange;
  Color success60 = orange.withOpacity(0.6);
  Color success30 = orange.withOpacity(0.3);
  Color success15 = orange.withOpacity(0.15);

  Color successDark = orangeDark;
  Color successDark30 = orangeDark.withOpacity(0.3);

  Color background = blue;
  Color background40 = blue.withOpacity(0.4);
  Color background00 = blue.withOpacity(0.0);

  Color backgroundDark = blueDark;
  Color backgroundDark00 = blueDark.withOpacity(0.0);

  Color backgroundDarkest = blueDarktest;

  Color text = white.withOpacity(0.9);
  Color text60 = white.withOpacity(0.6);
  Color text45 = white.withOpacity(0.45);
  Color text30 = white.withOpacity(0.3);
  Color text20 = white.withOpacity(0.2);
  Color text15 = white.withOpacity(0.15);
  Color text10 = white.withOpacity(0.1);
  Color text05 = white.withOpacity(0.05);
  Color text03 = white.withOpacity(0.03);

  Color overlay90 = black.withOpacity(0.9);
  Color overlay85 = black.withOpacity(0.85);
  Color overlay80 = black.withOpacity(0.8);
  Color overlay70 = black.withOpacity(0.7);
  Color overlay50 = black.withOpacity(0.5);
  Color overlay30 = black.withOpacity(0.3);
  Color overlay20 = black.withOpacity(0.2);

  Color animationOverlayMedium = black.withOpacity(0.7);
  Color animationOverlayStrong = black.withOpacity(0.85);

  Color positiveValue = Colors.lightGreenAccent[400];
  Color negativeValue = Colors.red[300];

  Color choiceOption = Colors.lightGreenAccent[400];

  Brightness brightness = Brightness.dark;
  SystemUiOverlayStyle statusBar =
      SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent);

  BoxShadow boxShadow = BoxShadow(color: Colors.transparent);
  BoxShadow boxShadowButton = BoxShadow(color: Colors.transparent);

  AppIconEnum appIcon = AppIconEnum.UNIRIS;
}

enum AppIconEnum { UNIRIS }

class AppIcon {
  static const _channel = const MethodChannel('fappchannel');

  static Future<void> setAppIcon() async {
    if (!Platform.isIOS) {
      return null;
    }
    final Map<String, dynamic> params = <String, dynamic>{
      'icon': "uniris",
    };
    return await _channel.invokeMethod('changeIcon', params);
  }
}
