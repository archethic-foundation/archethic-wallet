// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';

class AppStyles {
  static TextStyle textStyleMediumW200Primary(BuildContext context) {
    return TextStyle(
        fontFamily: 'Montserrat',
        fontSize: AppFontSizes.medium,
        fontWeight: FontWeight.w200,
        color: StateContainer.of(context).curTheme.primary);
  }

  static TextStyle textStyleMediumW700Primary(BuildContext context) {
    return TextStyle(
        fontFamily: 'Montserrat',
        fontSize: AppFontSizes.medium,
        fontWeight: FontWeight.w700,
        color: StateContainer.of(context).curTheme.primary);
  }

  static TextStyle textStyleMediumW100Primary60(BuildContext context) {
    return TextStyle(
        fontFamily: 'Montserrat',
        fontSize: AppFontSizes.medium,
        fontWeight: FontWeight.w100,
        color: StateContainer.of(context).curTheme.primary60);
  }

  static TextStyle textStyleSmallW200Primary(BuildContext context) {
    return TextStyle(
        fontFamily: 'Montserrat',
        fontSize: AppFontSizes.small,
        fontWeight: FontWeight.w200,
        color: StateContainer.of(context).curTheme.primary);
  }

  static TextStyle textStyleSmallW600Primary(BuildContext context) {
    return TextStyle(
        fontFamily: 'Montserrat',
        fontSize: AppFontSizes.small,
        fontWeight: FontWeight.w600,
        color: StateContainer.of(context).curTheme.primary);
  }

  static TextStyle textStyleSmallW700Background(BuildContext context) {
    return TextStyle(
        fontFamily: 'Montserrat',
        fontSize: AppFontSizes.small,
        fontWeight: FontWeight.w700,
        color: StateContainer.of(context).curTheme.background);
  }

  static TextStyle textStyleSmallW700ContextMenuPrimary(BuildContext context) {
    return TextStyle(
        fontFamily: 'Montserrat',
        fontSize: AppFontSizes.small,
        fontWeight: FontWeight.w700,
        color: StateContainer.of(context).curTheme.contextMenuText);
  }

  static TextStyle textStyleSmallW700ContextMenuTextRed(BuildContext context) {
    return TextStyle(
        fontFamily: 'Montserrat',
        fontSize: AppFontSizes.small,
        fontWeight: FontWeight.w700,
        color: StateContainer.of(context).curTheme.contextMenuTextRed);
  }

  static TextStyle textStyleLargeW700Background(BuildContext context) {
    return TextStyle(
        fontFamily: 'Montserrat',
        fontSize: AppFontSizes._large,
        fontWeight: FontWeight.w700,
        color: StateContainer.of(context).curTheme.background);
  }

  static TextStyle textStyleLargeW700Primary(BuildContext context) {
    return TextStyle(
        fontFamily: 'Montserrat',
        fontSize: AppFontSizes._large,
        fontWeight: FontWeight.w700,
        color: StateContainer.of(context).curTheme.primary);
  }

  static TextStyle textStyleSmallW700Primary(BuildContext context) {
    return TextStyle(
        fontFamily: 'Montserrat',
        fontSize: AppFontSizes.small,
        fontWeight: FontWeight.w700,
        color: StateContainer.of(context).curTheme.primary);
  }

  static TextStyle textStyleSmallW700Success(BuildContext context) {
    return TextStyle(
        fontFamily: 'Montserrat',
        fontSize: AppFontSizes.small,
        fontWeight: FontWeight.w700,
        color: StateContainer.of(context).curTheme.success);
  }

  static TextStyle textStyleSmallW700Primary60(BuildContext context) {
    return TextStyle(
        fontFamily: 'Montserrat',
        fontSize: AppFontSizes._large,
        fontWeight: FontWeight.w700,
        color: StateContainer.of(context).curTheme.primary60);
  }

  static TextStyle textStyleLargeW700Success(BuildContext context) {
    return TextStyle(
        fontFamily: 'Montserrat',
        fontSize: AppFontSizes._large,
        fontWeight: FontWeight.w700,
        color: StateContainer.of(context).curTheme.success);
  }

  static TextStyle textStyleSmallW100Sucess(BuildContext context) {
    return TextStyle(
      fontFamily: 'Montserrat',
      fontSize: AppFontSizes.small,
      fontWeight: FontWeight.w100,
      color: StateContainer.of(context).curTheme.success,
      height: 1.5,
    );
  }

  static TextStyle textStyleSmallW100Text60(BuildContext context) {
    return TextStyle(
      fontFamily: 'Montserrat',
      fontSize: AppFontSizes.small,
      fontWeight: FontWeight.w100,
      color: StateContainer.of(context).curTheme.primary60,
      height: 1.5,
    );
  }

  static TextStyle textStyleSmallW100Primary(BuildContext context) {
    return TextStyle(
      fontFamily: 'Montserrat',
      fontSize: AppFontSizes.small,
      fontWeight: FontWeight.w100,
      color: StateContainer.of(context).curTheme.primary,
      height: 1.5,
    );
  }

  static TextStyle textStyleSmallW600Text60(BuildContext context) {
    return TextStyle(
        fontFamily: 'Montserrat',
        fontSize: AppFontSizes.small,
        fontWeight: FontWeight.w600,
        color: StateContainer.of(context).curTheme.primary60);
  }

  static TextStyle textStyleLargestW900Primary(BuildContext context) {
    return TextStyle(
        fontFamily: 'Montserrat',
        fontSize: AppFontSizes._largest,
        fontWeight: FontWeight.w900,
        color: StateContainer.of(context).curTheme.primary);
  }

  static TextStyle textStyleSmallestW100PositiveValue(BuildContext context) {
    return TextStyle(
      fontFamily: 'Montserrat',
      fontSize: AppFontSizes.smallest,
      fontWeight: FontWeight.w100,
      color: StateContainer.of(context).curTheme.positiveValue,
    );
  }

  static TextStyle textStyleSmallestW100NegativeValue(BuildContext context) {
    return TextStyle(
      fontFamily: 'Montserrat',
      fontSize: AppFontSizes.smallest,
      fontWeight: FontWeight.w100,
      color: StateContainer.of(context).curTheme.negativeValue,
    );
  }

  static TextStyle textStyleSmallestW100Primary60(BuildContext context) {
    return TextStyle(
      fontFamily: 'Montserrat',
      color: StateContainer.of(context).curTheme.primary60,
      fontSize: AppFontSizes.smallest,
      fontWeight: FontWeight.w100,
    );
  }

  static TextStyle textStyleSmallestW100Primary(BuildContext context) {
    return TextStyle(
      fontFamily: 'Montserrat',
      color: StateContainer.of(context).curTheme.primary,
      fontSize: AppFontSizes.smallest,
      fontWeight: FontWeight.w100,
    );
  }

  static TextStyle textStyleSmallestW100Primary30(BuildContext context) {
    return TextStyle(
      fontFamily: 'Montserrat',
      color: StateContainer.of(context).curTheme.primary,
      fontSize: AppFontSizes.smallest,
      fontWeight: FontWeight.w100,
    );
  }

  static TextStyle textStyleTinyW100Primary60(BuildContext context) {
    return TextStyle(
      fontFamily: 'Montserrat',
      color: StateContainer.of(context).curTheme.primary60,
      fontSize: AppFontSizes.tiny,
      fontWeight: FontWeight.w100,
    );
  }

  static TextStyle textStyleTinyW100Primary(BuildContext context) {
    return TextStyle(
      fontFamily: 'Montserrat',
      color: StateContainer.of(context).curTheme.primary,
      fontSize: AppFontSizes.tiny,
      fontWeight: FontWeight.w100,
    );
  }

  static TextStyle textStyleSmallestW100Text60(BuildContext context) {
    return TextStyle(
      fontSize: AppFontSizes.smallest,
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w100,
      color: StateContainer.of(context).curTheme.primary60,
    );
  }

  static TextStyle textStyleMediumW600Primary(BuildContext context) {
    return TextStyle(
      fontFamily: 'Montserrat',
      fontSize: AppFontSizes.medium,
      fontWeight: FontWeight.w600,
      color: StateContainer.of(context).curTheme.primary,
    );
  }

  static TextStyle textStyleMediumW600Primary30(BuildContext context) {
    return TextStyle(
      fontFamily: 'Montserrat',
      fontSize: AppFontSizes.medium,
      fontWeight: FontWeight.w600,
      color: StateContainer.of(context).curTheme.primary30,
    );
  }

  static TextStyle textStyleMediumW600ChoiceOption(BuildContext context) {
    return TextStyle(
      fontFamily: 'Montserrat',
      fontSize: AppFontSizes.medium,
      fontWeight: FontWeight.w600,
      color: StateContainer.of(context).curTheme.choiceOption,
    );
  }

  static TextStyle textStyleSmallestW600Primary(BuildContext context) {
    return TextStyle(
      fontFamily: 'Montserrat',
      fontSize: AppFontSizes.smallest,
      fontWeight: FontWeight.w600,
      color: StateContainer.of(context).curTheme.primary,
    );
  }

  static TextStyle textStyleSmallW100Success(BuildContext context) {
    return TextStyle(
      fontSize: AppFontSizes.small,
      fontWeight: FontWeight.w100,
      fontFamily: 'Montserrat',
      color: StateContainer.of(context).curTheme.success,
      height: 1.5,
      letterSpacing: 1,
    );
  }

  static TextStyle textStyleLargerW700Primary(BuildContext context) {
    return TextStyle(
      fontFamily: 'Montserrat',
      fontSize: AppFontSizes.larger,
      fontWeight: FontWeight.w700,
      color: StateContainer.of(context).curTheme.primary,
    );
  }

  static TextStyle textStyleLargestW700Primary(BuildContext context) {
    return TextStyle(
      fontFamily: 'Montserrat',
      fontSize: AppFontSizes._largest,
      fontWeight: FontWeight.w700,
      color: StateContainer.of(context).curTheme.primary,
    );
  }

  static TextStyle textStyleMediumW600Text45(BuildContext context) {
    return TextStyle(
      fontFamily: 'Montserrat',
      fontSize: AppFontSizes.medium,
      fontWeight: FontWeight.w600,
      color: StateContainer.of(context).curTheme.primary45,
    );
  }

  static TextStyle textStyleSmallestW100Text30(BuildContext context) {
    return TextStyle(
      fontFamily: 'Montserrat',
      fontSize: AppFontSizes.smallest,
      fontWeight: FontWeight.w100,
      color: StateContainer.of(context).curTheme.primary30,
    );
  }

  static TextStyle textStyleSmallTextW100Primary(BuildContext context) {
    return TextStyle(
      fontFamily: 'Montserrat',
      fontSize: AppFontSizes.smallText(context),
      fontWeight: FontWeight.w100,
      color: StateContainer.of(context).curTheme.primary,
    );
  }

  static TextStyle textStyleSmallTextW100Success(BuildContext context) {
    return TextStyle(
      fontFamily: 'Montserrat',
      fontSize: AppFontSizes.smallText(context),
      fontWeight: FontWeight.w100,
      color: StateContainer.of(context).curTheme.success,
    );
  }

  static TextStyle textStyleSmallTextW100Text30(BuildContext context) {
    return TextStyle(
      fontFamily: 'Montserrat',
      fontSize: AppFontSizes.smallText(context),
      fontWeight: FontWeight.w100,
      color: StateContainer.of(context).curTheme.primary30,
    );
  }

  static TextStyle textStyleSmallestW400Primary(BuildContext context) {
    return TextStyle(
      fontFamily: 'Montserrat',
      fontSize: AppFontSizes.smallest,
      fontWeight: FontWeight.w400,
      color: StateContainer.of(context).curTheme.primary,
    );
  }
}

class AppFontSizes {
  static const double tiny = 10.0;
  static const double smallest = 12.0;
  static const double small = 14.0;
  static const double medium = 16.0;
  static const double _large = 20.0;
  static const double larger = 24.0;
  static const double _largest = 28.0;
  static const double largestc = 28.0;
  static const double _sslarge = 18.0;
  static const double _sslargest = 22.0;
  static double largest(BuildContext context) {
    if (smallScreen(context)) {
      return _sslargest;
    }
    return _largest;
  }

  static double large(BuildContext context) {
    if (smallScreen(context)) {
      return _sslarge;
    }
    return _large;
  }

  static double smallText(BuildContext context) {
    if (smallScreen(context)) {
      return smallest;
    }
    return small;
  }
}

bool smallScreen(BuildContext context) {
  if (MediaQuery.of(context).size.height < 667)
    return true;
  else
    return false;
}
