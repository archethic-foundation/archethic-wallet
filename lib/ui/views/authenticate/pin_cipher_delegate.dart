// Project imports:
import 'dart:async';

import 'package:aewallet/infrastructure/datasources/vault/vault.dart';
import 'package:aewallet/ui/views/authenticate/pin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PinCipherDelegate implements VaultCipherDelegate {
  PinCipherDelegate(this.context);

  BuildContext context;

  @override
  Future<Uint8List?> decode(Uint8List payload, bool userCancelable) =>
      PinAuthScreenOverlay(
        canNavigateBack: userCancelable,
        challenge: payload,
        action: CipherDelegateAction.decode,
        type: PinOverlayType.enterPin,
      ).show(context);

  @override
  Future<Uint8List?> encode(Uint8List payload, bool userCancelable) =>
      SetPinScreenOverlay(
        canNavigateBack: userCancelable,
        challenge: payload,
        action: CipherDelegateAction.decode,
        type: PinOverlayType.enterPin,
      ).show(context);
}
