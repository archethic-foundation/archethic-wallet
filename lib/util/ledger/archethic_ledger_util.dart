import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:ledger_dart_lib/ledger_dart_lib.dart';

Uint8List getSignTxnAPDU(int hashType, int addressIndex, String payload) {
  return transport(0xe0, 0x08, hashType, addressIndex,
      Uint8List.fromList(hex.decode(payload)));
}

Uint8List getArchAddressAPDU(String payload) {
  return transport(
      0xe0, 0x04, 0x00, 0x00, Uint8List.fromList(hex.decode(payload)));
}

Uint8List getPubKeyAPDU() {
  return transport(
      0xe0, 0x02, 0x00, 0x00, Uint8List.fromList(hex.decode('00')));
}
