import 'dart:developer';

import 'package:aewallet/application/authentication/authentication.dart';
import 'package:aewallet/model/privacy_mask_option.dart';
import 'package:aewallet/ui/views/authenticate/auto_lock_guard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Listens to app state changes and displays
/// [LockMaskOverlay] accordingly.
/// Checks if lock is required on startup.
class PrivacyMaskGuard extends ConsumerStatefulWidget {
  const PrivacyMaskGuard({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AutoLockGuardState();
}

class _AutoLockGuardState extends ConsumerState<PrivacyMaskGuard>
    with WidgetsBindingObserver {
  static const _logName = 'PrivacyMask-Widget';

  @override
  Widget build(BuildContext context) => widget.child;

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
    _hideMask();
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
        _hideMask();
        break;
      case AppLifecycleState.inactive:
        _showMask();
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

  void _showMask() {
    if (_isMaskDisabled) return;

    log(
      'Show lock mask',
      name: _logName,
    );

    LockMaskOverlay.instance().show(context);
  }

  void _hideMask() {
    // Do not use `ref` here. This would cause an error
    // when widget is disposed.
    log(
      'Hide lock mask',
      name: _logName,
    );

    LockMaskOverlay.instance().hide();
  }
}
