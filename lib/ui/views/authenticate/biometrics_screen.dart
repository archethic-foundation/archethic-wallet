import 'dart:typed_data';

import 'package:aewallet/ui/views/authenticate/auth_screen_overlay.dart';
import 'package:aewallet/ui/views/authenticate/auto_lock_guard.dart';
import 'package:aewallet/util/biometrics_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BiometricsScreenOverlay extends AuthScreenOverlay {
  BiometricsScreenOverlay({
    required bool canNavigateBack,
    required Uint8List challenge,
  }) : super(
          name: 'BiometricsScreenOverlay',
          widgetBuilder: (context, onDone) => _BiometricsScreen(
            challenge: challenge,
            canNavigateBack: canNavigateBack,
            onDone: onDone,
          ),
        );
}

class _BiometricsScreen extends ConsumerStatefulWidget {
  const _BiometricsScreen({
    super.key,
    required this.challenge,
    required this.canNavigateBack,
    required this.onDone,
  });

  final bool canNavigateBack;
  final Uint8List challenge;
  final void Function(Uint8List? result) onDone;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BiometricsScreenState();
}

class _BiometricsScreenState extends ConsumerState<_BiometricsScreen> {
  @override
  Widget build(BuildContext context) => PopScope(
        canPop: widget.canNavigateBack,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            widget.onDone(null);
          }
        },
        child: const LockMask(),
      );

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.canNavigateBack) {
        await _auth();
        return;
      }
      await _forceAuth();
    });

    super.initState();
  }

  Future<void> _auth() async {
    final auth = await sl.get<BiometricUtil>().authenticateWithBiometrics(
          context,
          AppLocalizations.of(context)!.unlockBiometrics,
        );
    if (auth) {
      widget.onDone(widget.challenge);
      return;
    }

    widget.onDone(null);
  }

  Future<void> _forceAuth() async {
    var auth = false;
    while (!auth) {
      auth = await sl.get<BiometricUtil>().authenticateWithBiometrics(
            context,
            AppLocalizations.of(context)!.unlockBiometrics,
          );
    }
    widget.onDone(widget.challenge);
  }
}
