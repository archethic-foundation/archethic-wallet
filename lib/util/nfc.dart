/// SPDX-License-Identifier: AGPL-3.0-or-later

// Project imports:
import 'package:aewallet/bus/otp_event.dart';
import 'package:aewallet/util/universal_platform.dart';
// Package imports:
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:yubidart/yubidart.dart';

class NFCUtil {
  /// hasNFC()
  /// @returns true if device has NFC available, false otherwise
  Future<bool> hasNFC() async {
    if (UniversalPlatform.isMobile) {
      return NfcManager.instance.isAvailable();
    } else {
      return false;
    }
  }

  /// authenticateWithNFCYubikey()
  Future<void> authenticateWithNFCYubikey(BuildContext context) async {
    var otp = '';
    final hasNFCEnrolled = await hasNFC();
    if (hasNFCEnrolled) {
      await NfcManager.instance.startSession(
        alertMessage: 'Yubikey OTP Validation',
        onDiscovered: (NfcTag tag) async {
          otp = Yubidart().otp.getOTPFromYubiKeyNFC(tag);
          EventTaxiImpl.singleton().fire(OTPReceiveEvent(otp: otp));
          await NfcManager.instance.stopSession();
        },
      );
    }
  }
}
