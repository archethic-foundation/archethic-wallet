import 'dart:developer';

import 'package:aewallet/application/authentication/authentication.dart';
import 'package:aewallet/model/privacy_mask_option.dart';
import 'package:aewallet/ui/views/authenticate/auto_lock_guard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Listens to app state changes and displays
/// [LockMask] on top of screen accordingly.
/// Checks if lock is required on startup.
class PrivacyMaskGuard extends ConsumerStatefulWidget {
  const PrivacyMaskGuard({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PrivacyMaskGuardState();
}

class _PrivacyMaskGuardState extends ConsumerState<PrivacyMaskGuard>
    with WidgetsBindingObserver {
  static const _logName = 'PrivacyMask-Widget';
  bool maskVisible = false;

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          widget.child,
          if (maskVisible) const LockMask(),
        ],
      );

  @override
  void initState() {
    super.initState();
    log(
      'Init state',
      name: _logName,
    );

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log(
      'AppLifecycleState : $state',
      name: _logName,
    );
    switch (state) {
      case AppLifecycleState.resumed:
        setState(
          () {
            maskVisible = false;
          },
        );
        break;
      case AppLifecycleState.inactive:
        if (_isMaskDisabled) return;

        setState(
          () {
            maskVisible = true;
          },
        );
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  bool get _isMaskDisabled => ref.read(
        AuthenticationProviders.settings.select(
          (authSettings) =>
              authSettings.privacyMask == PrivacyMaskOption.disabled,
        ),
      );
}
