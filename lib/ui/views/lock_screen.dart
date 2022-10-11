/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/application/language.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/available_themes.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/authenticate/auth_factory.dart';
import 'package:aewallet/ui/widgets/components/buttons.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/util/case_converter.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Package imports:
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppLockScreen extends ConsumerStatefulWidget {
  const AppLockScreen({super.key});

  @override
  ConsumerState<AppLockScreen> createState() => _AppLockScreenState();
}

class _AppLockScreenState extends ConsumerState<AppLockScreen> {
  bool _lockedOut = true;
  String _countDownTxt = '';

  Future<void> _goHome() async {
    StateContainer.of(context).appWallet = await sl.get<DBHelper>().getAppWallet();
    if (StateContainer.of(context).appWallet == null) {
      Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
    final preferences = await Preferences.getInstance();
    StateContainer.of(context).bottomBarCurrentPage = preferences.getMainScreenCurrentPage();
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
      var secondsStr = count.toString();
      if (count < 10) {
        secondsStr = '0$secondsStr';
      }
      return '00:$secondsStr';
    } else if (count > 60 && count <= 3600) {
      // Minutes:Seconds
      var minutesStr = '';
      final minutes = count ~/ 60;
      if (minutes < 10) {
        minutesStr = '0$minutes';
      } else {
        minutesStr = minutes.toString();
      }
      var secondsStr = '';
      final seconds = count % 60;
      if (seconds < 10) {
        secondsStr = '0$seconds';
      } else {
        secondsStr = seconds.toString();
      }
      return '$minutesStr:$secondsStr';
    } else {
      // Hours:Minutes:Seconds
      var hoursStr = '';
      final hours = count ~/ 3600;
      if (hours < 10) {
        hoursStr = '0$hours';
      } else {
        hoursStr = hours.toString();
      }
      final remainingSeconds = count % 3600;
      var minutesStr = '';
      final minutes = remainingSeconds ~/ 60;
      if (minutes < 10) {
        minutesStr = '0$minutes';
      } else {
        minutesStr = minutes.toString();
      }
      var secondsStr = '';
      final seconds = count % 60;
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
    final preferences = await Preferences.getInstance();
    final lockUntil = preferences.getLockDate();
    if (lockUntil != null) {
      final countDown = lockUntil.difference(DateTime.now().toUtc()).inSeconds;
      if (countDown > 0) {
        _runCountdown(countDown);
        return;
      }
    }
    setState(() {
      _lockedOut = false;
    });
    final authMethod = preferences.getAuthMethod();
    final auth = await AuthFactory.authenticate(
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
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.backgroundDarkest,
      body: Stack(
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  theme.background3Small!,
                ),
                fit: BoxFit.fitHeight,
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[theme.backgroundDark!, theme.background!],
              ),
            ),
          ),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) => SafeArea(
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
                                  final language = ref.read(LanguageProviders.selectedLanguage);
                                  AppDialogs.showConfirmDialog(
                                      context,
                                      ref,
                                      CaseChange.toUpperCase(
                                        localizations.warning,
                                        language.getLocaleString(),
                                      ),
                                      localizations.removeWalletDetail,
                                      localizations.removeWalletAction.toUpperCase(), () {
                                    // Show another confirm dialog
                                    AppDialogs.showConfirmDialog(
                                      context,
                                      ref,
                                      localizations.removeWalletAreYouSure,
                                      localizations.removeWalletReassurance,
                                      localizations.yes,
                                      () async {
                                        await StateContainer.of(context).logOut();
                                        // TODO(Chralu): move that behavior to `logOut` usecase.
                                        await ref.read(
                                          ThemeProviders.selectTheme(theme: ThemeOptions.dark).future,
                                        );
                                        Navigator.of(context).pushNamedAndRemoveUntil(
                                          '/',
                                          (Route<dynamic> route) => false,
                                        );
                                      },
                                    );
                                  });
                                },
                                child: Row(
                                  children: <Widget>[
                                    FaIcon(
                                      FontAwesomeIcons.rightFromBracket,
                                      size: 16,
                                      color: theme.text,
                                    ),
                                    Container(
                                      margin: const EdgeInsetsDirectional.only(
                                        start: 4,
                                      ),
                                      child: Text(
                                        localizations.removeWallet,
                                        style: theme.textStyleSize14W600Primary,
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
                              localizations.locked,
                              style: theme.textStyleSize24W700EquinoxPrimary,
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
                              localizations.tooManyFailedAttempts,
                              style: theme.textStyleSize14W600Primary,
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
                        ref,
                        AppButtonType.primary,
                        _lockedOut ? _countDownTxt : localizations.unlock,
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
