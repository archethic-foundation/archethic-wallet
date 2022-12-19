import 'dart:developer';

import 'package:aewallet/application/authentication/authentication.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/ui/views/authenticate/auth_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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

class _AutoLockGuardState extends ConsumerState<AutoLockGuard>
    with WidgetsBindingObserver {
  // Set to [true] when the app is coming to foreground
  // while checking if authentication is necessary.
  bool unlockPending = true;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    SchedulerBinding.instance.addPostFrameCallback(
      (_) => _forceAuthentIfNeeded(context, ref),
    );

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _forceAuthentIfNeeded(context, ref);
        break;
      case AppLifecycleState.inactive:
        if (unlockPending == true) return;
        setState(() {
          _LockMask.show(context);
          unlockPending = true;
        });

        break;
      case AppLifecycleState.paused:
        ref.read(AuthenticationProviders.autoLock.notifier).scheduleAutolock();
        break;
      case AppLifecycleState.detached:
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) => widget.child;

  Future<void> _forceAuthentIfNeeded(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final shouldLockOnStartup = await ref.read(
      AuthenticationProviders.shouldLockOnStartup.future,
    );

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
      _LockMask.hide(context);
      unlockPending = false;
    });
  }
}

class _LockMask extends ConsumerWidget {
  const _LockMask();
  static const routeName = 'LockMask';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return WillPopScope(
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
    );
  }

  static void show(BuildContext context) {
    log('Show', name: routeName);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const _LockMask(),
        settings: const RouteSettings(name: routeName),
      ),
    );
  }

  static void hide(BuildContext context) {
    log('Hide', name: routeName);
    Navigator.of(context).popUntil(
      (route) => route.settings.name != routeName,
    );
  }
}
