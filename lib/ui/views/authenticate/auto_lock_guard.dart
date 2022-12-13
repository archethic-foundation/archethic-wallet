import 'dart:developer';

import 'package:aewallet/application/authentication/authentication.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/ui/util/app_lifecycle_recognizer.dart';
import 'package:aewallet/ui/views/authenticate/auth_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Handles navigation to the lock screen
mixin LockGuardMixin {
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
      await Navigator.of(context).pushNamed(
        '/lock_screen_transition',
      );
    }
  }
}

/// Listens to app state changes and schedules autoLock
/// accordingly.
/// Checks if lock is required on startup.
///
/// An hiding overlay is displayed as soon as the app becomes [AppLifecycleState.inactive].
/// Overlay is dismissed after checking if user authentication is necessary.
/// This behavior ensures the sensible content's hiding before unlocking.
class AutoLockGuard extends ConsumerStatefulWidget {
  const AutoLockGuard({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AutoLockGuardState();
}

class _AutoLockGuardState extends ConsumerState<AutoLockGuard> {
  // Set to [true] when the app is coming to foreground
  // while checking if authentication is necessary.
  bool unlockPending = true;

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return AppLifecycleStateListener(
      recognizers: [
        AppBecomeInactiveRecognizer(
          onRecognize: () {
            if (unlockPending == true) return;
            setState(() {
              unlockPending = true;
            });
          },
        ),
        AppStartupRecognizer(
          onRecognize: () => _forceAuthentIfNeeded(context, ref),
        ),
        AppResumeFromBackgroundRecognizer(
          onRecognize: () => _forceAuthentIfNeeded(context, ref),
        ),
        AppToBackgroundRecognizer(
          onRecognize: ref
              .read(AuthenticationProviders.autoLock.notifier)
              .scheduleAutolock,
        ),
      ],
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: unlockPending
            ? WillPopScope(
                onWillPop: () async => false,
                child: SizedBox.expand(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          theme.background3Small!,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              )
            : widget.child,
      ),
    );
  }

  Future<void> _forceAuthentIfNeeded(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final shouldLockOnStartup = await ref.read(
      AuthenticationProviders.shouldLockOnStartup.future,
    );
    log('LOCK : will show lock : $shouldLockOnStartup');

    if (shouldLockOnStartup) {
      await AuthFactory.forceAuthenticate(
        context,
        ref,
        authMethod: ref.read(
          AuthenticationProviders.settings.select(
            (authSettings) => AuthenticationMethod(
              authSettings.authenticationMethod,
            ),
          ),
        ),
        canCancel: false,
      );
    }
    await ref
        .read(AuthenticationProviders.autoLock.notifier)
        .unscheduleAutolock();

    setState(() {
      unlockPending = false;
    });
  }
}
