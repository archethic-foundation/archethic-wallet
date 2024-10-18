import 'dart:async';
import 'dart:typed_data';

import 'package:aewallet/infrastructure/datasources/vault/vault.dart';
import 'package:aewallet/ui/views/authenticate/biometrics_screen.dart';
import 'package:aewallet/ui/views/authenticate/set_biometrics_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class BiometricsCipherDelegate implements VaultCipherDelegate {
  BiometricsCipherDelegate({required this.context});

  final BuildContext context;

  @override
  Future<Uint8List?> decode(Uint8List payload, bool userCancelable) =>
      BiometricsScreenOverlay(
        challenge: payload,
      ).show(context);

  @override
  Future<Uint8List?> encode(Uint8List payload, bool userCancelable) =>
      context.push(
        SetBiometricsScreen.routerPage,
        extra: {
          'challenge': payload,
        },
      );
}
