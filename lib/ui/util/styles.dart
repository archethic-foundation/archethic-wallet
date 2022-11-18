import 'package:aewallet/ui/themes/themes.dart';
import 'package:flutter/material.dart';

extension AppStyles on BaseTheme {
  TextStyle get textStyleSize16W200Primary {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size16,
      fontWeight: FontWeight.w200,
      color: text,
    );
  }

  TextStyle get textStyleSize16W400Primary {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size16,
      fontWeight: FontWeight.w400,
      color: text,
    );
  }

  TextStyle get textStyleSize16W400Primary60 {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size16,
      fontWeight: FontWeight.w400,
      color: text60,
    );
  }

  TextStyle get textStyleSize16W700Primary {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size16,
      fontWeight: FontWeight.w700,
      color: text,
    );
  }

  TextStyle get textStyleSize14W600Primary {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size14,
      fontWeight: FontWeight.w600,
      color: text,
    );
  }

  TextStyle get textStyleSize14W600EquinoxPrimary {
    return TextStyle(
      fontFamily: mainFont,
      fontSize: AppFontSizes.size14,
      fontWeight: FontWeight.w600,
      color: text,
    );
  }

  TextStyle get textStyleSize14W600EquinoxPrimaryDisabled {
    return TextStyle(
      fontFamily: mainFont,
      fontSize: AppFontSizes.size14,
      fontWeight: FontWeight.w600,
      color: text!.withOpacity(0.3),
    );
  }

  TextStyle get textStyleSize14W600PrimaryDisabled {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size14,
      fontWeight: FontWeight.w600,
      color: text!.withOpacity(0.3),
    );
  }

  TextStyle get textStyleSize18W600EquinoxMainButtonLabelDisabled {
    return TextStyle(
      fontFamily: mainFont,
      fontSize: AppFontSizes.size18,
      fontWeight: FontWeight.w600,
      color: mainButtonLabel!.withOpacity(0.3),
    );
  }

  TextStyle get textStyleSize12W400EquinoxMainButtonLabelDisabled {
    return TextStyle(
      fontFamily: mainFont,
      fontSize: AppFontSizes.size12,
      fontWeight: FontWeight.w400,
      color: mainButtonLabel!.withOpacity(0.3),
    );
  }

  TextStyle get textStyleSize14W700Background {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size14,
      fontWeight: FontWeight.w700,
      color: background,
    );
  }

  TextStyle get textStyleSize20W700Primary {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size20,
      fontWeight: FontWeight.w700,
      color: text,
    );
  }

  TextStyle get textStyleSize20W700EquinoxPrimary {
    return TextStyle(
      fontFamily: mainFont,
      fontSize: AppFontSizes.size20,
      fontWeight: FontWeight.w700,
      color: text,
    );
  }

  TextStyle get textStyleSize14W700Primary {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size14,
      fontWeight: FontWeight.w700,
      color: text,
    );
  }

  TextStyle get textStyleSize14W100Text60 {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size14,
      fontWeight: FontWeight.w100,
      color: text60,
    );
  }

  TextStyle get textStyleSize14W100Primary {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size14,
      fontWeight: FontWeight.w100,
      color: text,
    );
  }

  TextStyle get textStyleSize14W200Primary {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size14,
      fontWeight: FontWeight.w200,
      color: text,
    );
  }

  TextStyle get textStyleSize14W200Bakckground {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size12,
      fontWeight: FontWeight.w400,
      color: background,
    );
  }

  TextStyle get textStyleSize25W900EquinoxPrimary {
    return TextStyle(
      fontFamily: mainFont,
      fontSize: 25,
      fontWeight: FontWeight.w900,
      letterSpacing: 1,
      color: text,
    );
  }

  TextStyle get textStyleSize25W900EquinoxPrimary60 {
    return TextStyle(
      fontFamily: mainFont,
      fontSize: 25,
      fontWeight: FontWeight.w900,
      letterSpacing: 1,
      color: text!.withOpacity(0.6),
    );
  }

  TextStyle get textStyleSize35W900EquinoxPrimary {
    return TextStyle(
      fontFamily: mainFont,
      fontSize: 35,
      fontWeight: FontWeight.w900,
      color: text,
    );
  }

  TextStyle get textStyleSize12W100PositiveValue {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size12,
      fontWeight: FontWeight.w800,
      color: positiveValue,
    );
  }

  TextStyle get textStyleSize12W100NegativeValue {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size12,
      fontWeight: FontWeight.w800,
      color: negativeValue,
    );
  }

  TextStyle get textStyleSize12W100Primary60 {
    return TextStyle(
      fontFamily: secondaryFont,
      color: text60,
      fontSize: AppFontSizes.size12,
      fontWeight: FontWeight.w100,
    );
  }

  TextStyle get textStyleSize12W100Primary {
    return TextStyle(
      fontFamily: secondaryFont,
      color: text,
      fontSize: AppFontSizes.size12,
      fontWeight: FontWeight.w100,
    );
  }

  TextStyle get textStyleSize12W100Primary30 {
    return TextStyle(
      fontFamily: secondaryFont,
      color: text,
      fontSize: AppFontSizes.size12,
      fontWeight: FontWeight.w100,
    );
  }

  TextStyle get textStyleSize10W100Primary {
    return TextStyle(
      fontFamily: secondaryFont,
      color: text,
      fontSize: AppFontSizes.size10,
      fontWeight: FontWeight.w100,
    );
  }

  TextStyle get textStyleSize16W600Primary {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size16,
      fontWeight: FontWeight.w600,
      color: text,
    );
  }

  TextStyle get textStyleSize16W600EquinoxPrimary {
    return TextStyle(
      fontFamily: mainFont,
      fontSize: AppFontSizes.size16,
      fontWeight: FontWeight.w600,
      color: text,
    );
  }

  TextStyle get textStyleSize16W600EquinoxRed {
    return TextStyle(
      fontFamily: mainFont,
      fontSize: AppFontSizes.size16,
      fontWeight: FontWeight.w600,
      color: Colors.red,
    );
  }

  TextStyle get textStyleSize16W600EquinoxPrimary30 {
    return TextStyle(
      fontFamily: mainFont,
      fontSize: AppFontSizes.size16,
      fontWeight: FontWeight.w600,
      color: text30,
    );
  }

  TextStyle get textStyleSize12W600Primary {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size12,
      fontWeight: FontWeight.w600,
      color: text,
    );
  }

  TextStyle get textStyleSize12W600Primary60 {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size12,
      fontWeight: FontWeight.w600,
      color: text!.withOpacity(0.6),
    );
  }

  TextStyle get textStyleSize24W700EquinoxPrimary {
    return TextStyle(
      fontFamily: mainFont,
      fontSize: AppFontSizes.size24,
      fontWeight: FontWeight.w700,
      color: text,
    );
  }

  TextStyle get textStyleSize24W700EquinoxPrimaryRed {
    return TextStyle(
      fontFamily: mainFont,
      fontSize: AppFontSizes.size24,
      fontWeight: FontWeight.w700,
      color: Colors.red,
    );
  }

  TextStyle get textStyleSize28W700Primary {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size28,
      fontWeight: FontWeight.w700,
      color: text,
    );
  }

  TextStyle get textStyleSize20W700Warning {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size20,
      fontWeight: FontWeight.w700,
      color: warning,
    );
  }

  TextStyle get textStyleSize18W600EquinoxMainButtonLabel {
    return TextStyle(
      fontFamily: mainFont,
      fontSize: AppFontSizes.size18,
      fontWeight: FontWeight.w600,
      color: mainButtonLabel,
    );
  }

  TextStyle get textStyleSize12W400EquinoxMainButtonLabel {
    return TextStyle(
      fontFamily: mainFont,
      fontSize: AppFontSizes.size12,
      fontWeight: FontWeight.w400,
      color: mainButtonLabel,
    );
  }

  TextStyle get textStyleSize16W100Primary {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size16,
      fontWeight: FontWeight.w100,
      color: text,
    );
  }

  TextStyle get textStyleSize12W400Primary {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size12,
      fontWeight: FontWeight.w400,
      color: text,
    );
  }

  TextStyle get textStyleSize14W700Primary60 {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size14,
      fontWeight: FontWeight.w700,
      color: text60,
    );
  }
}

// ignore: avoid_classes_with_only_static_members
class AppFontSizes {
  static const double size10 = 10;
  static const double size12 = 12;
  static const double size14 = 14;
  static const double size16 = 16;
  static const double size18 = 18;
  static const double size20 = 20;
  static const double size22 = 22;
  static const double size24 = 24;
  static const double size28 = 28;

  static double largest(BuildContext context) {
    if (smallScreen(context)) {
      return size22;
    }
    return size28;
  }

  static double large(BuildContext context) {
    if (smallScreen(context)) {
      return size18;
    }
    return size20;
  }

  static double smallText(BuildContext context) {
    if (smallScreen(context)) {
      return size12;
    }
    return size14;
  }
}

bool smallScreen(BuildContext context) {
  if (MediaQuery.of(context).size.height < 800) {
    return true;
  } else {
    return false;
  }
}
