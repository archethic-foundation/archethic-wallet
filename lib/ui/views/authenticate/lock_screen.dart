import 'package:aewallet/application/authentication/authentication.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

abstract class DurationFormatters {
  static String _twoDigitsFormatter(int value) =>
      value.toString().padLeft(2, '0');

  static String hhmmss(Duration duration) =>
      '${_twoDigitsFormatter(duration.inHours)}:${_twoDigitsFormatter(duration.inMinutes % 60)}:${_twoDigitsFormatter(duration.inSeconds % 60)}';
}

abstract class AppLockScreenProviders {
  static final remainingLockSeconds = FutureProvider.autoDispose<String>(
    (ref) async {
      final remainingDuration = await ref.watch(
        AuthenticationProviders.lockCountdown.future,
      );

      return DurationFormatters.hhmmss(remainingDuration);
    },
  );
}

class AppLockScreen extends ConsumerWidget {
  const AppLockScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final activeVibrations = ref.watch(
      SettingsProviders.settings.select((value) => value.activeVibrations),
    );
    final isLocked =
        ref.watch(AuthenticationProviders.isLockCountdownRunning).valueOrNull ??
            true;
    final countDownString = ref
            .watch(
              AppLockScreenProviders.remainingLockSeconds,
            )
            .valueOrNull ??
        '';

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ArchethicTheme.backgroundDarkest,
        body: Stack(
          children: <Widget>[
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      ArchethicTheme.backgroundSmall,
                    ),
                    fit: BoxFit.fitHeight,
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      ArchethicTheme.backgroundDark,
                      ArchethicTheme.background,
                    ],
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
                          if (isLocked)
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: Text(
                                localizations.locked,
                                style: ArchethicThemeStyles
                                    .textStyleSize24W700Primary,
                              ),
                            ),
                          Container(
                            width: MediaQuery.of(context).size.width - 100,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 50,
                              vertical: 20,
                            ),
                            child: Text(
                              localizations.tooManyFailedAttempts,
                              style: ArchethicThemeStyles
                                  .textStyleSize14W600Primary,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AppButtonTiny(
                          AppButtonTinyType.primary,
                          isLocked ? countDownString : localizations.unlock,
                          Dimens.buttonBottomDimens,
                          key: const Key('unlock'),
                          onPressed: () {
                            if (isLocked) return;

                            sl.get<HapticUtil>().feedback(
                                  FeedbackType.light,
                                  activeVibrations,
                                );
                            Navigator.pop(context);
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
      ),
    );
  }
}
