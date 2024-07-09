// Project imports:
import 'package:aewallet/infrastructure/datasources/vault/vault.dart';
import 'package:aewallet/ui/views/authenticate/pin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class PinCipherDelegate implements VaultCipherDelegate {
  PinCipherDelegate(this.context);

  BuildContext context;

  @override
  Future<Uint8List?> decode(Uint8List payload, bool userCancelable) =>
      context.push<Uint8List>(
        PinScreen.routerPage,
        extra: {
          'type': PinOverlayType.enterPin.name,
          'canNavigateBack': userCancelable,
          'action': CipherDelegateAction.decode.name,
          'challenge': payload,
        },
      );

  @override
  Future<Uint8List?> encode(Uint8List payload, bool userCancelable) =>
      context.push<Uint8List>(
        PinScreen.routerPage,
        extra: {
          'type': PinOverlayType.newPin.name,
          'canNavigateBack': userCancelable,
          'action': CipherDelegateAction.encode.name,
          'challenge': payload,
        },
      );
}
