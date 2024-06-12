import 'package:aewallet/ui/views/authenticate/auto_lock_guard.dart';
import 'package:aewallet/util/biometrics_util.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BiometricsScreen extends ConsumerStatefulWidget {
  const BiometricsScreen({super.key});

  static const routerPage = '/biometrics';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BiometricsScreenState();
}

class _BiometricsScreenState extends ConsumerState<BiometricsScreen> {
  @override
  Widget build(BuildContext context) => const LockMask();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final auth = await sl.get<BiometricUtil>().authenticateWithBiometrics(
            context,
            AppLocalizations.of(context)!.unlockBiometrics,
          );
      context.pop(auth);
    });

    super.initState();
  }
}
