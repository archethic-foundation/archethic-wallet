import 'dart:typed_data';

import 'package:aewallet/infrastructure/datasources/vault/vault.dart';
import 'package:aewallet/ui/views/authenticate/set_yubikey_screen.dart';
import 'package:aewallet/ui/views/authenticate/yubikey_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class YubikeyOTPCipherDelegate implements VaultCipherDelegate {
  YubikeyOTPCipherDelegate({required this.context});

  final BuildContext context;

  @override
  Future<Uint8List?> decode(Uint8List payload, bool userCancelable) =>
      YubikeyAuthScreenOverlay(
        canNavigateBack: userCancelable,
        challenge: payload,
      ).show(context);

  @override
  Future<Uint8List?> encode(Uint8List payload, bool userCancelable) =>
      context.push<Uint8List>(
        SetYubikey.routerPage,
        extra: {
          'challenge': payload,
        },
      );
}
