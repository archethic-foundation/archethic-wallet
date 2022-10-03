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
  Uint8List payload = concatUint8List([
    hexToUint8List(onChainWalletData.encodedWalletKey!),
    hexToUint8List(onChainWalletData.encryptedWallet!)
  ]);
  log(uint8ListToHex(transaction.originSignaturePayload()));
  payload = concatUint8List([transaction.originSignaturePayload(), payload]);
  Uint8List payloadLength =
      hexToUint8List(payload.lengthInBytes.toRadixString(16));
  Uint8List signPayload = concatUint8List([payloadLength, payload]);
  Uint8List cla = Uint8List(2);
  cla = hexToUint8List('E0');
  Uint8List ins = Uint8List(2);
  ins = hexToUint8List('08');
  return concatUint8List(
    [cla, ins, toByteArray(addressIndex, length: 4), signPayload],
  );
}

Uint8List getArchAddressAPDU(OnChainWalletData onChainWalletData) {
  Uint8List payload = concatUint8List([
    hexToUint8List(onChainWalletData.encodedWalletKey!),
    hexToUint8List(onChainWalletData.encryptedWallet!)
  ]);
  Uint8List payloadLength =
      hexToUint8List(payload.lengthInBytes.toRadixString(16));
  Uint8List addressPayload = concatUint8List([payloadLength, payload]);
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
