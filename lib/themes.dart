import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class BaseTheme {
  Color? primary;
  Color? primary60;
  Color? primary45;
  Color? primary30;
  Color? primary20;
  Color? primary15;
  Color? primary10;

  Color? icon;
  Color? icon45;
  Color? icon60;

  Color? success;
  Color? success60;
  Color? success30;
  Color? success15;
  Color? successDark;
  Color? successDark30;

  Color? background;
  Color? background40;
  Color? background00;

  Color? backgroundDark;
  Color? backgroundDark00;

  Color? backgroundDarkest;

  Color? text;
  Color? text60;
  Color? text45;
  Color? text30;
  Color? text20;
  Color? text15;
  Color? text10;
  Color? text05;
  Color? text03;

  Color? overlay20;
  Color? overlay30;
  Color? overlay50;
  Color? overlay70;
  Color? overlay80;
  Color? overlay85;
  Color? overlay90;

  Color? animationOverlayMedium;
  Color? animationOverlayStrong;

  Color? positiveValue;
  Color? negativeValue;

  Color? contextMenuText;
  Color? contextMenuTextRed;

  Color? choiceOption;

  Brightness? brightness;
  SystemUiOverlayStyle? statusBar;

  BoxShadow? boxShadow;
  BoxShadow? boxShadowButton;

  // App icon (iOS only)
  AppIconEnum? appIcon;
}

class UnirisTheme extends BaseTheme {
  static const Color orange = Color(0xFFfc9034);

  static const Color orangeDark = Color(0xFFf9852b);

  static const Color blue = Color(0xFF1ba5d9);

  static const Color blueDark = Color(0xFF106fcf);

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
  Color? background = blue;
  @override
  Color? background40 = blue.withOpacity(0.4);
  @override
  Color? background00 = blue.withOpacity(0.0);
  @override
  Color? backgroundDark = blueDark;
  @override
  Color? backgroundDark00 = blueDark.withOpacity(0.0);

  @override
  Color? backgroundDarkest = blueDarktest;

  @override
  Color? text = white.withOpacity(0.9);
  @override
  Color? text60 = white.withOpacity(0.6);
  @override
  Color? text45 = white.withOpacity(0.45);
  @override
  Color? text30 = white.withOpacity(0.3);
  @override
  Color? text20 = white.withOpacity(0.2);
  @override
  Color? text15 = white.withOpacity(0.15);
  @override
  Color? text10 = white.withOpacity(0.1);
  @override
  Color? text05 = white.withOpacity(0.05);
  @override
  Color? text03 = white.withOpacity(0.03);

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
  AppIconEnum? appIcon = AppIconEnum.UNIRIS;
}

enum AppIconEnum { UNIRIS }

class AppIcon {
  static const MethodChannel _channel = MethodChannel('fappchannel');

  static Future<void> setAppIcon() async {
    if (!Platform.isIOS) {
      return null;
    }
    final Map<String, dynamic> params = <String, dynamic>{
      'icon': 'uniris',
    };
    return await _channel.invokeMethod('changeIcon', params);
  }
}
