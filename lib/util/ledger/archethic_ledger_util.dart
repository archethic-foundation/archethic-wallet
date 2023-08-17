/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:developer';
import 'dart:typed_data';

// Package imports:
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:convert/convert.dart';
import 'package:ledger_dart_lib/ledger_dart_lib.dart';

Uint8List getSignTxnAPDU(
  OnChainWalletData onChainWalletData,
  Transaction transaction,
  int hashType,
  int addressIndex,
) {
  var payload = concatUint8List([
    hexToUint8List(onChainWalletData.encodedWalletKey!),
    hexToUint8List(onChainWalletData.encryptedWallet!),
  ]);
  log(uint8ListToHex(transaction.originSignaturePayload()));
  payload = concatUint8List([transaction.originSignaturePayload(), payload]);
  final payloadLength = hexToUint8List(payload.lengthInBytes.toRadixString(16));
  final signPayload = concatUint8List([payloadLength, payload]);
  var cla = Uint8List(2);
  cla = hexToUint8List('E0');
  var ins = Uint8List(2);
  ins = hexToUint8List('08');
  return concatUint8List(
    [cla, ins, toByteArray(addressIndex, length: 4), signPayload],
  );
}

Uint8List getArchAddressAPDU(OnChainWalletData onChainWalletData) {
  final payload = concatUint8List([
    hexToUint8List(onChainWalletData.encodedWalletKey!),
    hexToUint8List(onChainWalletData.encryptedWallet!),
  ]);
  final payloadLength = hexToUint8List(payload.lengthInBytes.toRadixString(16));
  final addressPayload = concatUint8List([payloadLength, payload]);
  return transport(0xe0, 0x04, 0x00, 0x00, addressPayload);
}

Uint8List getPubKeyAPDU() {
  return transport(
    0xe0,
    0x02,
    0x00,
    0x00,
    Uint8List.fromList(hex.decode('00')),
  );
}
