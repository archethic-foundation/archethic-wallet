import 'dart:typed_data';

import 'package:aewallet/ui/views/authenticate/auto_lock_guard.dart';
import 'package:aewallet/util/biometrics_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SetBiometricsScreen extends ConsumerStatefulWidget {
  const SetBiometricsScreen({
    super.key,
    required this.challenge,
  });

  static const routerPage = '/set_biometrics';

  final Uint8List challenge;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BiometricsScreenState();
}

class _BiometricsScreenState extends ConsumerState<SetBiometricsScreen> {
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
        context.pop();
        return;
      }

      context.pop(widget.challenge);
    });

    super.initState();
  }
}
