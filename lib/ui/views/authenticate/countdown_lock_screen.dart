part of 'auto_lock_guard.dart';

/// Handles navigation to the lock screen
mixin CountdownLockMixin {
  static final _logger = Logger('AuthenticationGuard-Mixin');

  /// Displays lock screen (with the timer) if
  /// application should be locked (too much authentication failures).
  ///
  /// This must be called when check is needed.
  Future<void> showLockCountdownScreenIfNeeded(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final shouldLock = await ref.read(
      AuthenticationProviders.isLockCountdownRunning.future,
    );
    if (shouldLock) {
      _logger.info('Show countdown screen');
      CountdownLockOverlay.instance().show(context);
    }
  }
}

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

class CountdownLockOverlay with LockOverlayMixin {
  factory CountdownLockOverlay.instance() =>
      _instance ?? (_instance = CountdownLockOverlay._());
  CountdownLockOverlay._();
  static CountdownLockOverlay? _instance;

  @override
  Widget get child => const _CountdownLockScreen();
}

class _CountdownLockScreen extends ConsumerWidget
    implements SheetSkeletonInterface {
  const _CountdownLockScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      canPop: false,
      child: SheetSkeleton(
        appBar: getAppBar(context, ref),
        floatingActionButton: getFloatingActionButton(context, ref),
        sheetContent: getSheetContent(context, ref),
      ),
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
            CountdownLockOverlay.instance().hide();
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

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Text(
        localizations.tooManyFailedAttempts,
        style: ArchethicThemeStyles.textStyleSize14W600Primary,
        textAlign: TextAlign.center,
      ),
    );
  }
}
