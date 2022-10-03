/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
class AppStyles {
  static TextStyle textStyleSize18W400EquinoxPrimary(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.mainFont,
      fontSize: AppFontSizes.size18,
      fontWeight: FontWeight.w700,
      color: StateContainer.of(context).curTheme.text!.withOpacity(0.7),
    );
  }

  static TextStyle textStyleSize16W200Primary(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size16,
      fontWeight: FontWeight.w200,
      color: StateContainer.of(context).curTheme.text,
    );
  }

  static TextStyle textStyleSize16W400Primary(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size16,
      fontWeight: FontWeight.w400,
      color: StateContainer.of(context).curTheme.text,
    );
  }

  static TextStyle textStyleSize16W400Primary60(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size16,
      fontWeight: FontWeight.w400,
      color: StateContainer.of(context).curTheme.text60,
    );
  }

  static TextStyle textStyleSize16W700Primary(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size16,
      fontWeight: FontWeight.w700,
      color: StateContainer.of(context).curTheme.text,
    );
  }

  static TextStyle textStyleSize16W100Primary60(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size16,
      fontWeight: FontWeight.w100,
      color: StateContainer.of(context).curTheme.text60,
    );
  }

  static TextStyle textStyleSize14W600Primary(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size14,
      fontWeight: FontWeight.w600,
      color: StateContainer.of(context).curTheme.text,
    );
  }

  static TextStyle textStyleSize12W400TextDark(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size12,
      fontWeight: FontWeight.w400,
      color: StateContainer.of(context).curTheme.textDark,
    );
  }

  static TextStyle textStyleSize14W600Primary60(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size14,
      fontWeight: FontWeight.w600,
      color: StateContainer.of(context).curTheme.text!.withOpacity(0.6),
    );
  }

  static TextStyle textStyleSize14W600EquinoxPrimary(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.mainFont,
      fontSize: AppFontSizes.size14,
      fontWeight: FontWeight.w600,
      color: StateContainer.of(context).curTheme.text,
    );
  }

  static TextStyle textStyleSize10W600Primary(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size10,
      fontWeight: FontWeight.w600,
      color: StateContainer.of(context).curTheme.text,
    );
  }

  static TextStyle textStyleSize14W600EquinoxMiddleButtonLabel(
    BuildContext context,
  ) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.mainFont,
      fontSize: AppFontSizes.size14,
      fontWeight: FontWeight.w600,
      color: StateContainer.of(context).curTheme.middleButtonLabel,
    );
  }

  static TextStyle textStyleSize14W600EquinoxPrimaryDisabled(
    BuildContext context,
  ) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.mainFont,
      fontSize: AppFontSizes.size14,
      fontWeight: FontWeight.w600,
      color: StateContainer.of(context).curTheme.text!.withOpacity(0.3),
    );
  }

  static TextStyle textStyleSize14W600PrimaryDisabled(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size14,
      fontWeight: FontWeight.w600,
      color: StateContainer.of(context).curTheme.text!.withOpacity(0.3),
    );
  }

  static TextStyle textStyleSize12W400PrimaryDisabled(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size12,
      fontWeight: FontWeight.w400,
      color: StateContainer.of(context).curTheme.text!.withOpacity(0.3),
    );
  }

  static TextStyle textStyleSize18W600PrimaryDisabled(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size18,
      fontWeight: FontWeight.w600,
      color: StateContainer.of(context).curTheme.text!.withOpacity(0.3),
    );
  }

  static TextStyle textStyleSize18W600EquinoxPrimaryDisabled(
    BuildContext context,
  ) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.mainFont,
      fontSize: AppFontSizes.size18,
      fontWeight: FontWeight.w600,
      color: StateContainer.of(context).curTheme.text!.withOpacity(0.3),
    );
  }

  static TextStyle textStyleSize18W600EquinoxMainButtonLabelDisabled(
    BuildContext context,
  ) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.mainFont,
      fontSize: AppFontSizes.size18,
      fontWeight: FontWeight.w600,
      color:
          StateContainer.of(context).curTheme.mainButtonLabel!.withOpacity(0.3),
    );
  }

  static TextStyle textStyleSize12W400EquinoxMainButtonLabelDisabled(
    BuildContext context,
  ) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.mainFont,
      fontSize: AppFontSizes.size12,
      fontWeight: FontWeight.w400,
      color:
          StateContainer.of(context).curTheme.mainButtonLabel!.withOpacity(0.3),
    );
  }

  static TextStyle textStyleSize12W100PrimaryDisabled(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size12,
      fontWeight: FontWeight.w100,
      color: StateContainer.of(context).curTheme.text!.withOpacity(0.3),
    );
  }

  static TextStyle textStyleSize24W600Primary(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size24,
      fontWeight: FontWeight.w600,
      color: StateContainer.of(context).curTheme.text,
    );
  }

  static TextStyle textStyleSize14W600BackgroundDarkest(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size14,
      fontWeight: FontWeight.w600,
      color: StateContainer.of(context).curTheme.backgroundDarkest,
    );
  }

  static TextStyle textStyleSize16W700BackgroundDarkest(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size16,
      fontWeight: FontWeight.w700,
      color: StateContainer.of(context).curTheme.backgroundDarkest,
    );
  }

  static TextStyle textStyleSize14W700Background(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size14,
      fontWeight: FontWeight.w700,
      color: StateContainer.of(context).curTheme.background,
    );
  }

  static TextStyle textStyleSize20W700Background(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size20,
      fontWeight: FontWeight.w700,
      color: StateContainer.of(context).curTheme.background,
    );
  }

  static TextStyle textStyleSize20W700Primary(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size20,
      fontWeight: FontWeight.w700,
      color: StateContainer.of(context).curTheme.text,
    );
  }

  static TextStyle textStyleSize20W700EquinoxPrimary(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.mainFont,
      fontSize: AppFontSizes.size20,
      fontWeight: FontWeight.w700,
      color: StateContainer.of(context).curTheme.text,
    );
  }

  static TextStyle textStyleSize20W700Green(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size20,
      fontWeight: FontWeight.w700,
      color: StateContainer.of(context).curTheme.positiveAmount,
    );
  }

  static TextStyle textStyleSize20W700Red(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size20,
      fontWeight: FontWeight.w700,
      color: StateContainer.of(context).curTheme.negativeAmount,
    );
  }

  static TextStyle textStyleSize14W700Primary(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size14,
      fontWeight: FontWeight.w700,
      color: StateContainer.of(context).curTheme.text,
    );
  }

  static TextStyle textStyleSize20W700Primary60(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size20,
      fontWeight: FontWeight.w700,
      color: StateContainer.of(context).curTheme.text60,
    );
  }

  static TextStyle textStyleSize14W100Text60(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size14,
      fontWeight: FontWeight.w100,
      color: StateContainer.of(context).curTheme.text60,
    );
  }

  static TextStyle textStyleSize14W700Text60(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size14,
      fontWeight: FontWeight.w700,
      color: StateContainer.of(context).curTheme.text60,
    );
  }

  static TextStyle textStyleSize14W100Primary(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size14,
      fontWeight: FontWeight.w100,
      color: StateContainer.of(context).curTheme.text,
    );
  }

  static TextStyle textStyleSize14W200Primary(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size14,
      fontWeight: FontWeight.w200,
      color: StateContainer.of(context).curTheme.text,
    );
  }

  static TextStyle textStyleSize14W600Text60(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size14,
      fontWeight: FontWeight.w600,
      color: StateContainer.of(context).curTheme.text60,
    );
  }

  static TextStyle textStyleSize28W900Primary(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size28,
      fontWeight: FontWeight.w900,
      color: StateContainer.of(context).curTheme.text,
    );
  }

  static TextStyle textStyleSize40W900Primary(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: 40,
      fontWeight: FontWeight.w900,
      color: StateContainer.of(context).curTheme.text,
    );
  }

  static TextStyle textStyleSize25W900EquinoxPrimary(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.mainFont,
      fontSize: 25,
      fontWeight: FontWeight.w900,
      letterSpacing: 1,
      color: StateContainer.of(context).curTheme.text,
    );
  }

  static TextStyle textStyleSize25W900EquinoxPrimary60(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.mainFont,
      fontSize: 25,
      fontWeight: FontWeight.w900,
      letterSpacing: 1,
      color: StateContainer.of(context).curTheme.text!.withOpacity(0.6),
    );
  }

  static TextStyle textStyleSize25W900EquinoxPrimary30(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.mainFont,
      fontSize: 25,
      fontWeight: FontWeight.w900,
      letterSpacing: 1,
      color: StateContainer.of(context).curTheme.text30,
    );
  }

  static TextStyle textStyleSize35W900EquinoxPrimary(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.mainFont,
      fontSize: 35,
      fontWeight: FontWeight.w900,
      color: StateContainer.of(context).curTheme.text,
    );
  }

  static TextStyle textStyleSize12W100PositiveValue(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size12,
      fontWeight: FontWeight.w800,
      color: StateContainer.of(context).curTheme.positiveValue,
    );
  }

  static TextStyle textStyleSize16W100PositiveValue(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size16,
      fontWeight: FontWeight.w800,
      color: StateContainer.of(context).curTheme.positiveValue,
    );
  }

  static TextStyle textStyleSize12W100NegativeValue(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size12,
      fontWeight: FontWeight.w800,
      color: StateContainer.of(context).curTheme.negativeValue,
    );
  }

  static TextStyle textStyleSize16W100NegativeValue(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size16,
      fontWeight: FontWeight.w800,
      color: StateContainer.of(context).curTheme.negativeValue,
    );
  }

  static TextStyle textStyleSize12W100Primary60(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      color: StateContainer.of(context).curTheme.text60,
      fontSize: AppFontSizes.size12,
      fontWeight: FontWeight.w100,
    );
  }

  static TextStyle textStyleSize12W100Primary(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      color: StateContainer.of(context).curTheme.text,
      fontSize: AppFontSizes.size12,
      fontWeight: FontWeight.w100,
    );
  }

  static TextStyle textStyleSize12W100Primary30(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      color: StateContainer.of(context).curTheme.text,
      fontSize: AppFontSizes.size12,
      fontWeight: FontWeight.w100,
    );
  }

  static TextStyle textStyleSize10W100Primary60(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      color: StateContainer.of(context).curTheme.text60,
      fontSize: AppFontSizes.size10,
      fontWeight: FontWeight.w100,
    );
  }

  static TextStyle textStyleSize10W100Primary(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      color: StateContainer.of(context).curTheme.text,
      fontSize: AppFontSizes.size10,
      fontWeight: FontWeight.w100,
    );
  }

  static TextStyle textStyleSize10W100Transparent(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      color: Colors.transparent,
      fontSize: AppFontSizes.size10,
      fontWeight: FontWeight.w100,
    );
  }

  static TextStyle textStyleSize12W100Text60(BuildContext context) {
    return TextStyle(
      fontSize: AppFontSizes.size12,
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontWeight: FontWeight.w100,
      color: StateContainer.of(context).curTheme.text60,
    );
  }

  static TextStyle textStyleSize16W600Primary(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size16,
      fontWeight: FontWeight.w600,
      color: StateContainer.of(context).curTheme.text,
    );
  }

  static TextStyle textStyleSize16W600EquinoxPrimary(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.mainFont,
      fontSize: AppFontSizes.size16,
      fontWeight: FontWeight.w600,
      color: StateContainer.of(context).curTheme.text,
    );
  }

  static TextStyle textStyleSize16W400PrimarySuccess(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size16,
      fontWeight: FontWeight.w400,
      color: StateContainer.of(context).curTheme.positiveValue,
    );
  }

  static TextStyle textStyleSize16W600Red(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size16,
      fontWeight: FontWeight.w600,
      color: Colors.red,
    );
  }

  static TextStyle textStyleSize16W600EquinoxRed(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.mainFont,
      fontSize: AppFontSizes.size16,
      fontWeight: FontWeight.w600,
      color: Colors.red,
    );
  }

  static TextStyle textStyleSize16W600Primary30(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size16,
      fontWeight: FontWeight.w600,
      color: StateContainer.of(context).curTheme.text30,
    );
  }

  static TextStyle textStyleSize16W600EquinoxPrimary30(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.mainFont,
      fontSize: AppFontSizes.size16,
      fontWeight: FontWeight.w600,
      color: StateContainer.of(context).curTheme.text30,
    );
  }

  static TextStyle textStyleSize16W200Primary30(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size16,
      fontWeight: FontWeight.w200,
      color: StateContainer.of(context).curTheme.text30,
    );
  }

  static TextStyle textStyleSize12W600Primary(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size12,
      fontWeight: FontWeight.w600,
      color: StateContainer.of(context).curTheme.text,
    );
  }

  static TextStyle textStyleSize12W600Primary60(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size12,
      fontWeight: FontWeight.w600,
      color: StateContainer.of(context).curTheme.text!.withOpacity(0.6),
    );
  }

  static TextStyle textStyleSize12W400PrimaryRed(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size12,
      fontWeight: FontWeight.w400,
      color: StateContainer.of(context).curTheme.text,
    );
  }

  static TextStyle textStyleSize12W400PrimaryGreen(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size12,
      fontWeight: FontWeight.w400,
      color: StateContainer.of(context).curTheme.text,
    );
  }

  static TextStyle textStyleSize12W600Primary30(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size12,
      fontWeight: FontWeight.w600,
      color: StateContainer.of(context).curTheme.text30,
    );
  }

  static TextStyle textStyleSize24W700Primary(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size24,
      fontWeight: FontWeight.w700,
      color: StateContainer.of(context).curTheme.text,
    );
  }

  static TextStyle textStyleSize24W700EquinoxPrimary(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.mainFont,
      fontSize: AppFontSizes.size24,
      fontWeight: FontWeight.w700,
      color: StateContainer.of(context).curTheme.text,
    );
  }

  static TextStyle textStyleSize28W700Primary(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size28,
      fontWeight: FontWeight.w700,
      color: StateContainer.of(context).curTheme.text,
    );
  }

  static TextStyle textStyleSize20W700Warning(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size20,
      fontWeight: FontWeight.w700,
      color: StateContainer.of(context).curTheme.warning,
    );
  }

  static TextStyle textStyleSize28W700Warning(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size28,
      fontWeight: FontWeight.w700,
      color: StateContainer.of(context).curTheme.warning,
    );
  }

  static TextStyle textStyleSize80W700Primary15(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: 80,
      fontWeight: FontWeight.w700,
      color: StateContainer.of(context).curTheme.text15,
    );
  }

  static TextStyle textStyleSize16W600Text45(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size16,
      fontWeight: FontWeight.w600,
      color: StateContainer.of(context).curTheme.text45,
    );
  }

  static TextStyle textStyleSize12W100Text30(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size12,
      fontWeight: FontWeight.w100,
      color: StateContainer.of(context).curTheme.text30,
    );
  }

  static TextStyle textStyleSmallTextW100Primary(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.smallText(context),
      fontWeight: FontWeight.w100,
      color: StateContainer.of(context).curTheme.text,
    );
  }

  static TextStyle textStyleSize18W600Primary(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size18,
      fontWeight: FontWeight.w600,
      color: StateContainer.of(context).curTheme.text,
    );
  }

  static TextStyle textStyleSize18W600EquinoxPrimary(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.mainFont,
      fontSize: AppFontSizes.size18,
      fontWeight: FontWeight.w600,
      color: StateContainer.of(context).curTheme.text,
    );
  }

  static TextStyle textStyleSize18W600EquinoxMainButtonLabel(
    BuildContext context,
  ) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.mainFont,
      fontSize: AppFontSizes.size18,
      fontWeight: FontWeight.w600,
      color: StateContainer.of(context).curTheme.mainButtonLabel,
    );
  }

  static TextStyle textStyleSize12W400EquinoxMainButtonLabel(
    BuildContext context,
  ) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.mainFont,
      fontSize: AppFontSizes.size12,
      fontWeight: FontWeight.w400,
      color: StateContainer.of(context).curTheme.mainButtonLabel,
    );
  }

  static TextStyle textStyleSmallTextW100Text30(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.smallText(context),
      fontWeight: FontWeight.w100,
      color: StateContainer.of(context).curTheme.text30,
    );
  }

  static TextStyle textStyleSize16W100Primary(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size16,
      fontWeight: FontWeight.w100,
      color: StateContainer.of(context).curTheme.text,
    );
  }

  static TextStyle textStyleSize12W400Primary(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size12,
      fontWeight: FontWeight.w400,
      color: StateContainer.of(context).curTheme.text,
    );
  }

  static TextStyle textStyleSize14W700Primary60(BuildContext context) {
    return TextStyle(
      fontFamily: StateContainer.of(context).curTheme.secondaryFont,
      fontSize: AppFontSizes.size14,
      fontWeight: FontWeight.w700,
      color: StateContainer.of(context).curTheme.text60,
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
