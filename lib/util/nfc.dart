// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:event_taxi/event_taxi.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:yubidart/yubidart.dart';

// Project imports:
import 'package:archethic_wallet/bus/otp_event.dart';

class NFCUtil {
  /// hasNFC()
  /// @returns [true] if device has NFC available, [false] otherwise
  Future<bool> hasNFC() async {
    if (Platform.isIOS || Platform.isAndroid) {
      return await NfcManager.instance.isAvailable();
    } else {
      return false;
    }
  }

  /// authenticateWithNFCYubikey()
  Future<void> authenticateWithNFCYubikey(BuildContext context) async {
    String otp = '';
    final bool hasNFCEnrolled = await hasNFC();
    if (hasNFCEnrolled) {
      await NfcManager.instance.startSession(
          alertMessage: 'Yubikey OTP Validation',
          onDiscovered: (NfcTag tag) async {
            otp = YubicoService().getOTPFromYubiKeyNFC(tag);
            EventTaxiImpl.singleton().fire(OTPReceiveEvent(otp: otp));
            await NfcManager.instance.stopSession();
          });
    }
  }
}
