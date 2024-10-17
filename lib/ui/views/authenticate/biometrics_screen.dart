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
    required Uint8List challenge,
  }) : super(
          name: 'BiometricsScreenOverlay',
          widgetBuilder: (context, onDone) => _BiometricsScreen(
            challenge: challenge,
            onDone: onDone,
          ),
        );
}

class _BiometricsScreen extends ConsumerStatefulWidget {
  const _BiometricsScreen({
    super.key,
    required this.challenge,
    required this.onDone,
  });

  final Uint8List challenge;
  final void Function(Uint8List? result) onDone;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BiometricsScreenState();
}

class _BiometricsScreenState extends ConsumerState<_BiometricsScreen> {
  @override
  Widget build(BuildContext context) => const LockMask();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final auth = await sl.get<BiometricUtil>().authenticateWithBiometrics(
            context,
            AppLocalizations.of(context)!.unlockBiometrics,
          );
      if (!auth) {
        widget.onDone(null);
        return;
      }

      widget.onDone(widget.challenge);
    });

    super.initState();
  }
}
