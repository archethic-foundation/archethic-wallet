import 'package:aewallet/application/authentication/authentication.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/util/dimens.dart';
import 'package:aewallet/ui/views/main/components/sheet_appbar.dart';
import 'package:aewallet/ui/widgets/components/app_button_tiny.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton_interface.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:go_router/go_router.dart';

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

class AppLockScreen extends ConsumerWidget implements SheetSkeletonInterface {
  const AppLockScreen({super.key});

  static const routerPage = '/lock_screen_transition';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SheetSkeleton(
      appBar: getAppBar(context, ref),
      floatingActionButton: getFloatingActionButton(context, ref),
      sheetContent: getSheetContent(context, ref),
    );
  }

  @override
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref) {
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
    return Row(
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
            context.pop();
          },
          disabled: isLocked,
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final isLocked =
        ref.watch(AuthenticationProviders.isLockCountdownRunning).valueOrNull ??
            true;
    return SheetAppBar(
      title: isLocked ? localizations.locked : ' ',
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    return PopScope(
      onPopInvoked: (didPop) async => false,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Text(
          localizations.tooManyFailedAttempts,
          style: ArchethicThemeStyles.textStyleSize14W600Primary,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
