/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/ui/themes/theme_dark.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/authenticate/auth_factory.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/util/case_converter.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/preferences.dart';

class AppLockScreen extends StatefulWidget {
  const AppLockScreen({super.key});

  @override
  State<AppLockScreen> createState() => _AppLockScreenState();
}

class _AppLockScreenState extends State<AppLockScreen> {
  bool _lockedOut = true;
  String _countDownTxt = '';

  Future<void> _goHome() async {
    StateContainer.of(context).appWallet =
        await sl.get<DBHelper>().getAppWallet();
    if (StateContainer.of(context).appWallet == null) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
    final Preferences preferences = await Preferences.getInstance();
    StateContainer.of(context).bottomBarCurrentPage =
        preferences.getMainScreenCurrentPage();
    StateContainer.of(context).bottomBarPageController = PageController(
      initialPage: StateContainer.of(context).bottomBarCurrentPage,
    );

    StateContainer.of(context).requestUpdate();
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/home_transition',
      (Route<dynamic> route) => false,
    );
  }

  String _formatCountDisplay(int count) {
    if (count <= 60) {
      // Seconds only
      String secondsStr = count.toString();
      if (count < 10) {
        secondsStr = '0$secondsStr';
      }
      return '00:$secondsStr';
    } else if (count > 60 && count <= 3600) {
      // Minutes:Seconds
      String minutesStr = '';
      final int minutes = count ~/ 60;
      if (minutes < 10) {
        minutesStr = '0$minutes';
      } else {
        minutesStr = minutes.toString();
      }
      String secondsStr = '';
      final int seconds = count % 60;
      if (seconds < 10) {
        secondsStr = '0$seconds';
      } else {
        secondsStr = seconds.toString();
      }
      return '$minutesStr:$secondsStr';
    } else {
      // Hours:Minutes:Seconds
      String hoursStr = '';
      final int hours = count ~/ 3600;
      if (hours < 10) {
        hoursStr = '0$hours';
      } else {
        hoursStr = hours.toString();
      }
      final int remainingSeconds = count % 3600;
      String minutesStr = '';
      final int minutes = remainingSeconds ~/ 60;
      if (minutes < 10) {
        minutesStr = '0$minutes';
      } else {
        minutesStr = minutes.toString();
      }
      String secondsStr = '';
      final int seconds = count % 60;
      if (seconds < 10) {
        secondsStr = '0$seconds';
      } else {
        secondsStr = seconds.toString();
      }
      return '$hoursStr:$minutesStr:$secondsStr';
    }
  }

  Future<void> _runCountdown(int count) async {
    if (count >= 1) {
      if (mounted) {
        setState(() {
          _lockedOut = true;
          _countDownTxt = _formatCountDisplay(count);
        });
      }
      Future<void>.delayed(const Duration(seconds: 1), () {
        _runCountdown(count - 1);
      });
    } else {
      if (mounted) {
        setState(() {
          _lockedOut = false;
        });
      }
    }
  }

  Future<void> _authenticate({bool transitions = false}) async {
    final Preferences preferences = await Preferences.getInstance();
    final DateTime? lockUntil = preferences.getLockDate();
    if (lockUntil != null) {
      final int countDown =
          lockUntil.difference(DateTime.now().toUtc()).inSeconds;
      if (countDown > 0) {
        _runCountdown(countDown);
        return;
      }
    }
    setState(() {
      _lockedOut = false;
    });
    final AuthenticationMethod authMethod = preferences.getAuthMethod();
    final bool auth = await AuthFactory.authenticate(
      context,
      authMethod,
      transitions: transitions,
    );
    if (auth) {
      _goHome();
    }
  }

  @override
  void initState() {
    _authenticate();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: StateContainer.of(context).curTheme.backgroundDarkest,
      body: Stack(
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  StateContainer.of(context).curTheme.background3Small!,
                ),
                fit: BoxFit.fitHeight,
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  StateContainer.of(context).curTheme.backgroundDark!,
                  StateContainer.of(context).curTheme.background!
                ],
              ),
            ),
          ),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) =>
                SafeArea(
              minimum: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.035,
                top: MediaQuery.of(context).size.height * 0.075,
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsetsDirectional.only(
                                start: smallScreen(context) ? 15 : 20,
                              ),
                              height: 50,
                              child: TextButton(
                                onPressed: () {
                                  AppDialogs.showConfirmDialog(
                                      context,
                                      CaseChange.toUpperCase(
                                        AppLocalization.of(context)!.warning,
                                        StateContainer.of(context)
                                            .curLanguage
                                            .getLocaleString(),
                                      ),
                                      AppLocalization.of(context)!
                                          .removeWalletDetail,
                                      AppLocalization.of(context)!
                                          .removeWalletAction
                                          .toUpperCase(), () {
                                    // Show another confirm dialog
                                    AppDialogs.showConfirmDialog(
                                        context,
                                        AppLocalization.of(context)!
                                            .removeWalletAreYouSure,
                                        AppLocalization.of(context)!
                                            .removeWalletReassurance,
                                        AppLocalization.of(context)!.yes,
                                        () async {
                                      await StateContainer.of(context).logOut();
                                      StateContainer.of(context).curTheme =
                                          DarkTheme();
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                        '/',
                                        (Route<dynamic> route) => false,
                                      );
                                    });
                                  });
                                },
                                child: Row(
                                  children: <Widget>[
                                    FaIcon(
                                      FontAwesomeIcons.rightFromBracket,
                                      size: 16,
                                      color: StateContainer.of(context)
                                          .curTheme
                                          .text,
                                    ),
                                    Container(
                                      margin: const EdgeInsetsDirectional.only(
                                        start: 4,
                                      ),
                                      child: Text(
                                        AppLocalization.of(context)!
                                            .removeWallet,
                                        style: AppStyles
                                            .textStyleSize14W600Primary(
                                          context,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (_lockedOut)
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                              AppLocalization.of(context)!.locked,
                              style:
                                  AppStyles.textStyleSize24W700EquinoxPrimary(
                                context,
                              ),
                            ),
                          ),
                        if (_lockedOut)
                          Container(
                            width: MediaQuery.of(context).size.width - 100,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 50,
                              vertical: 20,
                            ),
                            child: Text(
                              AppLocalization.of(context)!
                                  .tooManyFailedAttempts,
                              style:
                                  AppStyles.textStyleSize14W600Primary(context),
                              textAlign: TextAlign.center,
                            ),
                          )
                        else
                          const SizedBox(),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AppButton.buildAppButton(
                        const Key('unlock'),
                        context,
                        AppButtonType.primary,
                        _lockedOut
                            ? _countDownTxt
                            : AppLocalization.of(context)!.unlock,
                        Dimens.buttonBottomDimens,
                        onPressed: () {
                          if (!_lockedOut) {
                            sl.get<HapticUtil>().feedback(
                                  FeedbackType.light,
                                  StateContainer.of(context).activeVibrations,
                                );
                            _authenticate();
                          }
                        },
                        disabled: _lockedOut,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
