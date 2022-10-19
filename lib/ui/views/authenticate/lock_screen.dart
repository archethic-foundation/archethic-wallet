/// SPDX-License-Identifier: AGPL-3.0-or-later
// Project imports:
import 'package:aewallet/application/authentication/authentication.dart';
import 'package:aewallet/application/language.dart';
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/available_themes.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/authenticate/auth_factory.dart';
import 'package:aewallet/ui/widgets/components/app_button.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/util/case_converter.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Package imports:
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

abstract class DurationFormatters {
  static String _twoDigitsFormatter(int value) =>
      value.toString().padLeft(2, '0');

  // ignore: non_constant_identifier_names
  static String HHmmss(Duration duration) =>
      '${_twoDigitsFormatter(duration.inHours)}:${_twoDigitsFormatter(duration.inMinutes % 59)}:${_twoDigitsFormatter(duration.inSeconds % 59)}';
}

abstract class AppLockScreenProviders {
  static final remainingLockSeconds = Provider.autoDispose<String>(
    (ref) {
      final remainingDuration = ref
          .watch(
            AuthenticationProviders.lockCountdown,
          )
          .valueOrNull;

      if (remainingDuration == null) return '';

      return DurationFormatters.HHmmss(remainingDuration);
    },
  );
}

class AppLockScreen extends ConsumerStatefulWidget {
  const AppLockScreen({super.key});

  @override
  ConsumerState<AppLockScreen> createState() => _AppLockScreenState();
}

class _AppLockScreenState extends ConsumerState<AppLockScreen> {
  Future<void> _goHome() async {
    StateContainer.of(context).appWallet =
        await sl.get<DBHelper>().getAppWallet();
    if (StateContainer.of(context).appWallet == null) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/',
        (Route<dynamic> route) => false,
      );
    }
    final preferences = await Preferences.getInstance();
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

  Future<void> _authenticate({bool transitions = false}) async {
    final authMethod = ref.read(
      AuthenticationProviders.preferedAuthMethod,
    );
    final auth = await AuthFactory.authenticate(
      context,
      ref,
      authMethod,
      transitions: transitions,
    );
    if (auth) {
      _goHome();
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _authenticate(),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final activeVibrations = ref.watch(
      SettingsProviders.settings.select((value) => value.activeVibrations),
    );
    final isLocked = ref.read(AuthenticationProviders.isLocked);
    final countDownString = ref.watch(
      AppLockScreenProviders.remainingLockSeconds,
    );
    ref.listen<bool>(
      AuthenticationProviders.isLocked,
      (_, isLocked) {
        if (!isLocked) _goHome();
      },
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.backgroundDarkest,
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: DecoratedBox(
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
          ),
          LayoutBuilder(
            builder: (
              BuildContext context,
              BoxConstraints constraints,
            ) =>
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
                                  final language = ref
                                      .read(LanguageProviders.selectedLanguage);
                                  AppDialogs.showConfirmDialog(
                                      context,
                                      ref,
                                      CaseChange.toUpperCase(
                                        localizations.warning,
                                        language.getLocaleString(),
                                      ),
                                      localizations.removeWalletDetail,
                                      localizations.removeWalletAction
                                          .toUpperCase(), () {
                                    // Show another confirm dialog
                                    AppDialogs.showConfirmDialog(
                                      context,
                                      ref,
                                      localizations.areYouSure,
                                      localizations.removeWalletReassurance,
                                      localizations.yes,
                                      () async {
                                        // TODO(Chralu): move that behavior to `logOut` usecase.
                                        await ref
                                            .read(ThemeProviders
                                                .selectedThemeOption.notifier)
                                            .selectTheme(
                                              ThemeOptions.dark,
                                            );
                                        await StateContainer.of(context)
                                            .logOut();
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
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
                        if (isLocked)
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                              localizations.locked,
                              style: theme.textStyleSize24W700EquinoxPrimary,
                            ),
                          ),
                        if (isLocked)
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
                      AppButton(
                        AppButtonType.primary,
                        isLocked ? countDownString : localizations.unlock,
                        Dimens.buttonBottomDimens,
                        key: const Key('unlock'),
                        onPressed: () {
                          if (isLocked) return;

                          sl.get<HapticUtil>().feedback(
                                FeedbackType.light,
                                activeVibrations,
                              );
                          _authenticate();
                        },
                        disabled: isLocked,
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
