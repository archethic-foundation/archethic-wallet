import 'package:aewallet/application/authentication/authentication.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/ui/views/authenticate/auth_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Handles navigation to the lock screen
mixin LockGuardMixin {
  void listenLockEvents(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<bool>>(
      AuthenticationProviders.isLocked,
      (previous, next) async {
        final isLocked = next.valueOrNull;
        if (isLocked == null) return;

        if (previous?.value == next.value) {
          return;
        }

        if (next.value == true) {
          await Navigator.of(context).pushNamed(
            '/lock_screen_transition',
          );
        }
      },
    );
  }

  /// Displays lock screen (with the timer) if
  /// application should be locked (too much authentication failures).
  ///
  /// This must be called when check is needed.
  Future<void> showLockScreenIfNeeded(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final shouldLock = await ref.read(
      AuthenticationProviders.isLocked.future,
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
class AutoLockGuard extends ConsumerStatefulWidget {
  const AutoLockGuard({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  ConsumerState<AutoLockGuard> createState() => LockGuardState();
}

class LockGuardState extends ConsumerState<AutoLockGuard>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _forceAuthentIfNeeded();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        ref.read(AuthenticationProviders.autoLock.notifier).scheduleAutolock();
        break;
      case AppLifecycleState.resumed:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  Future<void> _forceAuthentIfNeeded() async {
    final shouldAutolock = (await ref.read(
      AuthenticationProviders.autoLock.future,
    ))
        .shouldLock;
    final isLocked = await ref.read(AuthenticationProviders.isLocked.future);

    if (isLocked || shouldAutolock) {
      await AuthFactory.forceAuthenticate(
        context,
        ref,
        authMethod: ref.read(
          AuthenticationProviders.settings.select(
            (authSettings) =>
                AuthenticationMethod(authSettings.authenticationMethod),
          ),
        ),
        canCancel: false,
      );
    }
    await ref
        .read(AuthenticationProviders.autoLock.notifier)
        .unscheduleAutolock();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
