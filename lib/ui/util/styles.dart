import 'package:aewallet/ui/themes/themes.dart';
import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
extension AppStyles on BaseTheme {
  TextStyle get textStyleSize18W400EquinoxPrimary {
    return TextStyle(
      fontFamily: mainFont,
      fontSize: AppFontSizes.size18,
      fontWeight: FontWeight.w700,
      color: text!.withOpacity(0.7),
    );
  }

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

  TextStyle get textStyleSize16W100Primary60 {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size16,
      fontWeight: FontWeight.w100,
      color: text60,
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

  TextStyle get textStyleSize12W400TextDark {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size12,
      fontWeight: FontWeight.w400,
      color: textDark,
    );
  }

  TextStyle get textStyleSize14W600Primary60 {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size14,
      fontWeight: FontWeight.w600,
      color: text!.withOpacity(0.6),
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

  TextStyle get textStyleSize10W600Primary {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size10,
      fontWeight: FontWeight.w600,
      color: text,
    );
  }

  TextStyle get textStyleSize14W600EquinoxMiddleButtonLabel {
    return TextStyle(
      fontFamily: mainFont,
      fontSize: AppFontSizes.size14,
      fontWeight: FontWeight.w600,
      color: middleButtonLabel,
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

  TextStyle get textStyleSize12W400PrimaryDisabled {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size12,
      fontWeight: FontWeight.w400,
      color: text!.withOpacity(0.3),
    );
  }

  TextStyle get textStyleSize18W600PrimaryDisabled {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size18,
      fontWeight: FontWeight.w600,
      color: text!.withOpacity(0.3),
    );
  }

  TextStyle get textStyleSize18W600EquinoxPrimaryDisabled {
    return TextStyle(
      fontFamily: mainFont,
      fontSize: AppFontSizes.size18,
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

  TextStyle get textStyleSize12W100PrimaryDisabled {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size12,
      fontWeight: FontWeight.w100,
      color: text!.withOpacity(0.3),
    );
  }

  TextStyle get textStyleSize24W600Primary {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size24,
      fontWeight: FontWeight.w600,
      color: text,
    );
  }

  TextStyle get textStyleSize14W600BackgroundDarkest {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size14,
      fontWeight: FontWeight.w600,
      color: backgroundDarkest,
    );
  }

  TextStyle get textStyleSize16W700BackgroundDarkest {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size16,
      fontWeight: FontWeight.w700,
      color: backgroundDarkest,
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

  TextStyle get textStyleSize20W700Background {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size20,
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

  TextStyle get textStyleSize20W700Green {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size20,
      fontWeight: FontWeight.w700,
      color: positiveAmount,
    );
  }

  TextStyle get textStyleSize20W700Red {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size20,
      fontWeight: FontWeight.w700,
      color: negativeAmount,
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

  TextStyle get textStyleSize20W700Primary60 {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size20,
      fontWeight: FontWeight.w700,
      color: text60,
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

  TextStyle get textStyleSize14W700Text60 {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size14,
      fontWeight: FontWeight.w700,
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

  TextStyle get textStyleSize14W600Text60 {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size14,
      fontWeight: FontWeight.w600,
      color: text60,
    );
  }

  TextStyle get textStyleSize28W900Primary {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size28,
      fontWeight: FontWeight.w900,
      color: text,
    );
  }

  TextStyle get textStyleSize40W900Primary {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: 40,
      fontWeight: FontWeight.w900,
      color: text,
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

  TextStyle get textStyleSize25W900EquinoxPrimary30 {
    return TextStyle(
      fontFamily: mainFont,
      fontSize: 25,
      fontWeight: FontWeight.w900,
      letterSpacing: 1,
      color: text30,
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

  TextStyle get textStyleSize16W100PositiveValue {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size16,
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

  TextStyle get textStyleSize16W100NegativeValue {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size16,
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

  TextStyle get textStyleSize10W100Primary60 {
    return TextStyle(
      fontFamily: secondaryFont,
      color: text60,
      fontSize: AppFontSizes.size10,
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

  TextStyle get textStyleSize10W100Transparent {
    return TextStyle(
      fontFamily: secondaryFont,
      color: Colors.transparent,
      fontSize: AppFontSizes.size10,
      fontWeight: FontWeight.w100,
    );
  }

  TextStyle get textStyleSize12W100Text60 {
    return TextStyle(
      fontSize: AppFontSizes.size12,
      fontFamily: secondaryFont,
      fontWeight: FontWeight.w100,
      color: text60,
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

  TextStyle get textStyleSize16W400PrimarySuccess {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size16,
      fontWeight: FontWeight.w400,
      color: positiveValue,
    );
  }

  TextStyle get textStyleSize16W600Red {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size16,
      fontWeight: FontWeight.w600,
      color: Colors.red,
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

  TextStyle get textStyleSize16W600Primary30 {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size16,
      fontWeight: FontWeight.w600,
      color: text30,
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

  TextStyle get textStyleSize16W200Primary30 {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size16,
      fontWeight: FontWeight.w200,
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

  TextStyle get textStyleSize12W400PrimaryRed {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size12,
      fontWeight: FontWeight.w400,
      color: text,
    );
  }

  TextStyle get textStyleSize12W400PrimaryGreen {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size12,
      fontWeight: FontWeight.w400,
      color: text,
    );
  }

  TextStyle get textStyleSize12W600Primary30 {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size12,
      fontWeight: FontWeight.w600,
      color: text30,
    );
  }

  TextStyle get textStyleSize24W700Primary {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size24,
      fontWeight: FontWeight.w700,
      color: text,
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

  TextStyle get textStyleSize28W700Warning {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size28,
      fontWeight: FontWeight.w700,
      color: warning,
    );
  }

  TextStyle get textStyleSize80W700Primary15 {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: 80,
      fontWeight: FontWeight.w700,
      color: text15,
    );
  }

  TextStyle get textStyleSize16W600Text45 {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size16,
      fontWeight: FontWeight.w600,
      color: text45,
    );
  }

  TextStyle get textStyleSize12W100Text30 {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size12,
      fontWeight: FontWeight.w100,
      color: text30,
    );
  }

  TextStyle textStyleSmallTextW100Primary(BuildContext context) {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.smallText(context),
      fontWeight: FontWeight.w100,
      color: text,
    );
  }

  TextStyle get textStyleSize18W600Primary {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.size18,
      fontWeight: FontWeight.w600,
      color: text,
    );
  }

  TextStyle get textStyleSize18W600EquinoxPrimary {
    return TextStyle(
      fontFamily: mainFont,
      fontSize: AppFontSizes.size18,
      fontWeight: FontWeight.w600,
      color: text,
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

  TextStyle textStyleSmallTextW100Text30(BuildContext context) {
    return TextStyle(
      fontFamily: secondaryFont,
      fontSize: AppFontSizes.smallText(context),
      fontWeight: FontWeight.w100,
      color: text30,
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
