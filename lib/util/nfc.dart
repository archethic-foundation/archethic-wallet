// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:nfc_manager/nfc_manager.dart';
import 'package:yubidart/yubidart.dart';

// Project imports:
import 'package:archethic_mobile_wallet/localization.dart';
import 'package:archethic_mobile_wallet/service_locator.dart';
import 'package:archethic_mobile_wallet/util/sharedprefsutil.dart';

class NFCUtil {
  ///
  /// hasNFC()
  ///
  /// @returns [true] if device has NFC available, [false] otherwise
  Future<bool> hasNFC() async {
    if (Platform.isIOS || Platform.isAndroid) {
      return await NfcManager.instance.isAvailable();
    } else {
      return false;
    }
  }

  ///
  /// authenticateWithNFCYubikey()
  ///
  /// @param [message] Message shown to user in NFC popup
  /// @returns [true] if successfully authenticated, [false] otherwise
  Future<String> authenticateWithNFCYubikey(BuildContext context) async {
    VerificationResponse verificationResponse = VerificationResponse();
    final bool hasNFCEnrolled = await hasNFC();
    if (hasNFCEnrolled) {
      await NfcManager.instance.startSession(
          alertMessage: 'Approach your Yubikey',
          onDiscovered: (NfcTag tag) async {
            String yubikeyClientAPIKey =
                await sl.get<SharedPrefsUtil>().getYubikeyClientAPIKey();
            String yubikeyClientID =
                await sl.get<SharedPrefsUtil>().getYubikeyClientID();
            verificationResponse = await YubicoService()
                .verifyOTPFromYubiKeyNFC(
                    tag, yubikeyClientAPIKey, yubikeyClientID);
            await NfcManager.instance
                .stopSession(alertMessage: verificationResponse.status);
          });
    } else {
      verificationResponse.status = 'NO_NFC';
    }
    switch (verificationResponse.status) {
      case 'BAD_OTP':
        return AppLocalization.of(context)!.yubikeyError_BAD_OTP;
      case 'BACKEND_ERROR':
        return AppLocalization.of(context)!.yubikeyError_BACKEND_ERROR;
      case 'BAD_SIGNATURE':
        return AppLocalization.of(context)!.yubikeyError_BAD_SIGNATURE;
      case 'MISSING_PARAMETER':
        return AppLocalization.of(context)!.yubikeyError_MISSING_PARAMETER;
      case 'NOT_ENOUGH_ANSWERS':
        return AppLocalization.of(context)!.yubikeyError_NOT_ENOUGH_ANSWERS;
      case 'NO_SUCH_CLIENT':
        return AppLocalization.of(context)!.yubikeyError_NO_SUCH_CLIENT;
      case 'OPERATION_NOT_ALLOWED':
        return AppLocalization.of(context)!.yubikeyError_OPERATION_NOT_ALLOWED;
      case 'REPLAYED_OTP':
        return AppLocalization.of(context)!.yubikeyError_REPLAYED_OTP;
      case 'REPLAYED_REQUEST':
        return AppLocalization.of(context)!.yubikeyError_REPLAYED_REQUEST;
      case 'RESPONSE_KO':
        return AppLocalization.of(context)!.yubikeyError_RESPONSE_KO;
      case 'OTP_NOT_FOUND':
        return AppLocalization.of(context)!.yubikeyError_OTP_NOT_FOUND;
      default:
        return verificationResponse.status;
    }
  }
}
