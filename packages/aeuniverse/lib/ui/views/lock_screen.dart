/// SPDX-License-Identifier: AGPL-3.0-or-later

// Flutter imports:
import 'package:core/util/haptic_util.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/views/authenticate/auth_factory.dart';
import 'package:aeuniverse/ui/widgets/components/buttons.dart';
import 'package:aeuniverse/ui/widgets/components/dialog.dart';
import 'package:aeuniverse/ui/widgets/components/icon_widget.dart';
import 'package:aeuniverse/util/preferences.dart';
import 'package:core/localization.dart';
import 'package:core/model/authentication_method.dart';
import 'package:core/model/data/appdb.dart';
import 'package:core/model/data/hive_db.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core/util/vault.dart';
import 'package:core_ui/ui/util/dimens.dart';
import 'package:core_ui/util/app_util.dart';
import 'package:core_ui/util/case_converter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class AppLockScreen extends StatefulWidget {
  const AppLockScreen({super.key});

  @override
  State<AppLockScreen> createState() => _AppLockScreenState();
}

class _AppLockScreenState extends State<AppLockScreen> {
  bool _lockedOut = true;
  String _countDownTxt = '';

  Future<void> _goHome() async {
    if (StateContainer.of(context).wallet == null) {
      Account? selectedAcct = await AppUtil()
          .loginAccount(await StateContainer.of(context).getSeed(), context);
      StateContainer.of(context).requestUpdate(account: selectedAcct);
    }
    StateContainer.of(context)
        .requestUpdate(account: StateContainer.of(context).selectedAccount);
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
        secondsStr = '0' + secondsStr;
      }
      return '00:' + secondsStr;
    } else if (count > 60 && count <= 3600) {
      // Minutes:Seconds
      String minutesStr = '';
      final int minutes = count ~/ 60;
      if (minutes < 10) {
        minutesStr = '0' + minutes.toString();
      } else {
        minutesStr = minutes.toString();
      }
      String secondsStr = '';
      final int seconds = count % 60;
      if (seconds < 10) {
        secondsStr = '0' + seconds.toString();
      } else {
        secondsStr = seconds.toString();
      }
      return minutesStr + ':' + secondsStr;
    } else {
      // Hours:Minutes:Seconds
      String hoursStr = '';
      final int hours = count ~/ 3600;
      if (hours < 10) {
        hoursStr = '0' + hours.toString();
      } else {
        hoursStr = hours.toString();
      }
      count = count % 3600;
      String minutesStr = '';
      final int minutes = count ~/ 60;
      if (minutes < 10) {
        minutesStr = '0' + minutes.toString();
      } else {
        minutesStr = minutes.toString();
      }
      String secondsStr = '';
      final int seconds = count % 60;
      if (seconds < 10) {
        secondsStr = '0' + seconds.toString();
      } else {
        secondsStr = seconds.toString();
      }
      return hoursStr + ':' + minutesStr + ':' + secondsStr;
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
    final Preferences _preferences = await Preferences.getInstance();
    final DateTime? lockUntil = _preferences.getLockDate();
    if (lockUntil == null) {
      _preferences.resetLockAttempts();
    } else {
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
    final AuthenticationMethod authMethod = _preferences.getAuthMethod();
    bool auth = await AuthFactory.authenticate(context, authMethod,
        transitions: transitions);
    if (auth) {
      _goHome();
    }
  }

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: StateContainer.of(context).curTheme.backgroundDarkest,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
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
                  top: MediaQuery.of(context).size.height * 0.075),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsetsDirectional.only(
                                  start: smallScreen(context) ? 15 : 20),
                              height: 50,
                              width: 150,
                              child: TextButton(
                                onPressed: () {
                                  sl
                                      .get<HapticUtil>()
                                      .feedback(FeedbackType.light);
                                  AppDialogs.showConfirmDialog(
                                      context,
                                      CaseChange.toUpperCase(
                                          AppLocalization.of(context)!.warning,
                                          StateContainer.of(context)
                                              .curLanguage
                                              .getLocaleString()),
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
                                        CaseChange.toUpperCase(
                                            AppLocalization.of(context)!.yes,
                                            StateContainer.of(context)
                                                .curLanguage
                                                .getLocaleString()), () {
                                      // Delete all data
                                      sl.get<DBHelper>().dropAll();
                                      Vault.getInstance().then((Vault _vault) {
                                        _vault.deleteAll();
                                      });
                                      Preferences.getInstance()
                                          .then((Preferences _preferences) {
                                        _preferences.deleteAll();
                                        StateContainer.of(context).logOut();
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                '/',
                                                (Route<dynamic> route) =>
                                                    false);
                                      });
                                    });
                                  });
                                },
                                child: Row(
                                  children: <Widget>[
                                    FaIcon(FontAwesomeIcons.rightFromBracket,
                                        size: 16,
                                        color: StateContainer.of(context)
                                            .curTheme
                                            .primary),
                                    Container(
                                      margin: const EdgeInsetsDirectional.only(
                                          start: 4),
                                      child: Text(
                                          AppLocalization.of(context)!
                                              .removeWallet,
                                          style: AppStyles
                                              .textStyleSize14W600Primary(
                                                  context)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        buildIconWidget(
                            context,
                            'packages/aeuniverse/assets/icons/lock.png',
                            90,
                            90),
                        Container(
                          child: Text(
                            CaseChange.toUpperCase(
                                AppLocalization.of(context)!.locked,
                                StateContainer.of(context)
                                    .curLanguage
                                    .getLocaleString()),
                            style:
                                AppStyles.textStyleSize28W700Primary(context),
                          ),
                          margin: const EdgeInsets.only(top: 10),
                        ),
                        if (!_lockedOut)
                          Container(
                            width: MediaQuery.of(context).size.width - 100,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 20),
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
                          Dimens.buttonBottomDimens, onPressed: () {
                        if (!_lockedOut) {
                          sl.get<HapticUtil>().feedback(FeedbackType.light);
                          _authenticate(transitions: true);
                        }
                      }, disabled: _lockedOut),
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
