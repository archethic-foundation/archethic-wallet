// ignore_for_file: cancel_subscriptions

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:core/bus/disable_lock_timeout_event.dart';
import 'package:core_ui/ui/util/exceptions.dart';
import 'package:core_ui/util/app_util.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';

enum ThreeLineAddressTextType { primary60, primary, success, successFull }
enum OneLineAddressTextType { primary60, primary, success }

// ignore: avoid_classes_with_only_static_members
class UIUtil {
  static Widget threeLinetextStyleSmallestW400Text(
      BuildContext context, String address,
      {ThreeLineAddressTextType type = ThreeLineAddressTextType.primary,
      String? contactName}) {
    String stringPartOne = '';
    String stringPartTwo = '';
    String stringPartThree = '';
    String stringPartFour = '';
    String stringPartFive = '';
    if (address.length >= 12) {
      stringPartOne = address.substring(0, 12);
    } else {
      stringPartOne = address.substring(0, address.length);
    }
    if (address.length >= 22) {
      stringPartTwo = address.substring(12, 22);
    } else {
      if (address.length > 12 && address.length < 22) {
        stringPartTwo = address.substring(12, address.length);
      }
    }
    if (address.length >= 44) {
      stringPartThree = address.substring(22, 44);
    } else {
      if (address.length > 22 && address.length < 44) {
        stringPartThree = address.substring(22, address.length);
      }
    }
    if (address.length >= 59) {
      stringPartFour = address.substring(44, 59);
    } else {
      if (address.length > 44 && address.length < 59) {
        stringPartFour = address.substring(44, address.length);
      } else {}
    }
    if (address.length >= 60) {
      stringPartFive = address.substring(59);
    }

    switch (type) {
      case ThreeLineAddressTextType.primary60:
        return Column(
          children: <Widget>[
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                children: <InlineSpan>[
                  TextSpan(
                    text: stringPartOne,
                    style: AppStyles.textStyleSize14W100Text60(context),
                  ),
                  TextSpan(
                    text: stringPartTwo,
                    style: AppStyles.textStyleSize14W100Text60(context),
                  ),
                ],
              ),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                children: <InlineSpan>[
                  TextSpan(
                    text: stringPartThree,
                    style: AppStyles.textStyleSize14W100Text60(context),
                  ),
                ],
              ),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                children: <InlineSpan>[
                  TextSpan(
                    text: stringPartFour,
                    style: AppStyles.textStyleSize14W100Text60(context),
                  ),
                  TextSpan(
                      text: stringPartFive,
                      style: AppStyles.textStyleSize14W100Text60(context)),
                ],
              ),
            )
          ],
        );
      case ThreeLineAddressTextType.primary:
        final Widget contactWidget = contactName != null
            ? RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: contactName,
                    style: AppStyles.textStyleSize14W100Primary(context)))
            : const SizedBox();
        return Column(
          children: <Widget>[
            contactWidget,
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                children: <InlineSpan>[
                  TextSpan(
                    text: stringPartOne,
                    style: AppStyles.textStyleSize14W100Primary(context),
                  ),
                  TextSpan(
                    text: stringPartTwo,
                    style: AppStyles.textStyleSize14W100Primary(context),
                  ),
                ],
              ),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                children: <InlineSpan>[
                  TextSpan(
                    text: stringPartThree,
                    style: AppStyles.textStyleSize14W100Primary(context),
                  ),
                ],
              ),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                children: <InlineSpan>[
                  TextSpan(
                    text: stringPartFour,
                    style: AppStyles.textStyleSize14W100Primary(context),
                  ),
                  TextSpan(
                    text: stringPartFive,
                    style: AppStyles.textStyleSize14W100Primary(context),
                  ),
                ],
              ),
            )
          ],
        );
      case ThreeLineAddressTextType.success:
        final Widget contactWidget = contactName != null
            ? RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: contactName,
                    style: AppStyles.textStyleSize14W100Sucess(context)))
            : const SizedBox();
        return Column(
          children: <Widget>[
            contactWidget,
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                children: <InlineSpan>[
                  TextSpan(
                    text: stringPartOne,
                    style: AppStyles.textStyleSize14W100Primary(context),
                  ),
                  TextSpan(
                    text: stringPartTwo,
                    style: AppStyles.textStyleSize14W100Primary(context),
                  ),
                ],
              ),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                children: <InlineSpan>[
                  TextSpan(
                    text: stringPartThree,
                    style: AppStyles.textStyleSize14W100Primary(context),
                  ),
                ],
              ),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                children: <InlineSpan>[
                  TextSpan(
                    text: stringPartFour,
                    style: AppStyles.textStyleSize14W100Primary(context),
                  ),
                  TextSpan(
                    text: stringPartFive,
                    style: AppStyles.textStyleSize14W100Primary(context),
                  ),
                ],
              ),
            )
          ],
        );
      case ThreeLineAddressTextType.successFull:
        return Column(
          children: <Widget>[
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                children: <InlineSpan>[
                  TextSpan(
                    text: stringPartOne,
                    style: AppStyles.textStyleSize14W100Primary(context),
                  ),
                  TextSpan(
                    text: stringPartTwo,
                    style: AppStyles.textStyleSize14W100Primary(context),
                  ),
                ],
              ),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                children: <InlineSpan>[
                  TextSpan(
                    text: stringPartThree,
                    style: AppStyles.textStyleSize14W100Primary(context),
                  ),
                ],
              ),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                children: <InlineSpan>[
                  TextSpan(
                    text: stringPartFour,
                    style: AppStyles.textStyleSize14W100Primary(context),
                  ),
                  TextSpan(
                    text: stringPartFive,
                    style: AppStyles.textStyleSize14W100Primary(context),
                  ),
                ],
              ),
            )
          ],
        );
      default:
        throw UIException('Invalid threeLineAddressText Type $type');
    }
  }

  static Widget oneLinetextStyleSmallestW400Text(
      BuildContext context, String address,
      {OneLineAddressTextType type = OneLineAddressTextType.primary}) {
    final String stringPartOne = address.substring(0, 12);
    final String stringPartFive = address.substring(59);
    switch (type) {
      case OneLineAddressTextType.primary60:
        return Column(
          children: <Widget>[
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                children: <InlineSpan>[
                  TextSpan(
                    text: stringPartOne,
                    style: AppStyles.textStyleSize14W100Text60(context),
                  ),
                  TextSpan(
                    text: '...',
                    style: AppStyles.textStyleSize14W100Text60(context),
                  ),
                  TextSpan(
                    text: stringPartFive,
                    style: AppStyles.textStyleSize14W100Text60(context),
                  ),
                ],
              ),
            ),
          ],
        );
      case OneLineAddressTextType.primary:
        return Column(
          children: <Widget>[
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                children: <InlineSpan>[
                  TextSpan(
                    text: stringPartOne,
                    style: AppStyles.textStyleSize14W100Primary(context),
                  ),
                  TextSpan(
                    text: '...',
                    style: AppStyles.textStyleSize14W100Primary(context),
                  ),
                  TextSpan(
                    text: stringPartFive,
                    style: AppStyles.textStyleSize14W100Primary(context),
                  ),
                ],
              ),
            ),
          ],
        );
      case OneLineAddressTextType.success:
        return Column(
          children: <Widget>[
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                children: <InlineSpan>[
                  TextSpan(
                    text: stringPartOne,
                    style: AppStyles.textStyleSize14W100Sucess(context),
                  ),
                  TextSpan(
                    text: '...',
                    style: AppStyles.textStyleSize14W100Primary(context),
                  ),
                  TextSpan(
                    text: stringPartFive,
                    style: AppStyles.textStyleSize14W100Sucess(context),
                  ),
                ],
              ),
            ),
          ],
        );
      default:
        throw UIException('Invalid oneLineAddressText Type $type');
    }
  }

  static Widget threeLineSeedText(BuildContext context, String address,
      {TextStyle? textStyle}) {
    textStyle = textStyle ?? AppStyles.textStyleSize14W100Primary(context);
    final String stringPartOne = address.substring(0, 22);
    final String stringPartTwo = address.substring(22, 44);
    final String stringPartThree = address.substring(44, 64);
    return Column(
      children: <Widget>[
        Text(
          stringPartOne,
          style: textStyle,
        ),
        Text(
          stringPartTwo,
          style: textStyle,
        ),
        Text(
          stringPartThree,
          style: textStyle,
        ),
      ],
    );
  }

  static double drawerWidth(BuildContext context) {
    if (AppUtil.isDesktopMode()) {
      return MediaQuery.of(context).size.width * 0.2;
    } else {
      if (MediaQuery.of(context).size.width < 375) {
        return MediaQuery.of(context).size.width * 0.94;
      } else {
        return MediaQuery.of(context).size.width * 0.85;
      }
    }
  }

  static void showSnackbar(String content, BuildContext context,
      Color boxDecorationColor, Color boxShadowColor,
      {Duration duration = const Duration(milliseconds: 3500)}) {
    showToastWidget(
      Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.05,
              horizontal: 14),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          width: MediaQuery.of(context).size.width - 30,
          decoration: BoxDecoration(
            color: boxDecorationColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: boxShadowColor,
                  offset: const Offset(0, 15),
                  blurRadius: 30,
                  spreadRadius: -5),
            ],
          ),
          child: Text(
            content,
            style: AppStyles.textStyleSize14W700Background(context),
            textAlign: TextAlign.start,
          ),
        ),
      ),
      dismissOtherToast: true,
      duration: duration,
    );
  }

  static StreamSubscription<dynamic>? _lockDisableSub;

  static Future<void> cancelLockEvent() async {
    // Cancel auto-lock event, usually if we are launching another intent
    if (_lockDisableSub != null) {
      _lockDisableSub!.cancel();
    }
    EventTaxiImpl.singleton().fire(DisableLockTimeoutEvent(disable: true));
    final Future<dynamic> delayed =
        Future<void>.delayed(const Duration(seconds: 10));
    delayed.then((_) {
      return true;
    });
    _lockDisableSub = delayed.asStream().listen((_) {
      EventTaxiImpl.singleton().fire(DisableLockTimeoutEvent(disable: false));
    });
  }

  static bool smallScreen(BuildContext context) {
    if (MediaQuery.of(context).size.height < 667) {
      return true;
    } else {
      return false;
    }
  }

  static Future<void> showWebview(
      BuildContext context, String url, String title) async {
    await launch(url);
  }
}
