// @dart=2.9

import 'dart:convert';
import 'dart:math';

import 'dart:typed_data';

import 'package:uniris_mobile_wallet/util/base85/base_85_codec.dart';
import 'package:uniris_mobile_wallet/util/base85/base_85_encoder.dart';

/// Characters to allow (and ignore) in an encoded buffer
const List<int> _IGNORE_CHARS = <int>[0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x20];

/// num max value
var NUM_MAX_VALUE = pow(2, 32) - 1;

/// quad 85
var QUAD85 = pow(85, 4);

/// trio 85
var TRIO85 = pow(85, 3);

/// duo 85
var DUO85 = pow(85, 2);

/// sign 85
var SING85 = 85;

class Base85Decoder extends Converter<String, Uint8List> {
  String alphabet;
  AlgoType algo;
  Uint8List _baseMap;

  Base85Decoder(this.alphabet, this.algo) {
    _baseMap = Uint8List(256);
    _baseMap.fillRange(0, _baseMap.length, 255);
    for (var i = 0; i < alphabet.length; i++) {
      var xc = alphabet.codeUnitAt(i);
      if (_baseMap[xc] != 255) {
        throw FormatException('${alphabet[i]} is ambiguous');
      }
      _baseMap[xc] = i;
    }
  }

  @override

  /// Decodes the specified data. If encoding is ascii85, the data is
  /// expected to start with <~ and and end with ~>.
  /// No checks are actually made for this,
  /// but output will be unexpected if this is not the case.
  ///
  /// The [input] to decode. May be a String.
  /// If ascii85, it is expected to be enclosed in <~ and ~>.
  Uint8List convert(String input) {
    if (input?.isEmpty ?? true) {
      return Uint8List(0);
    }
    var bytes = Uint8List.fromList(input.codeUnits);
    var dataLength = bytes.length;
    if (algo == AlgoType.ascii85) {
      dataLength -= (ASCII85_ENC_START.length + ASCII85_ENC_END.length);
    }

    if (algo == AlgoType.z85 && dataLength % 5 != 0) {
      throw FormatException('Wrong length');
    }

    var padding = (dataLength % 5 == 0) ? 0 : 5 - dataLength % 5;

    var bufferStart = (algo == AlgoType.ascii85) ? ASCII85_ENC_START.length : 0;
    var bufferEnd = bufferStart + dataLength;

    var result = Uint8List(4 * ((bufferEnd - bufferStart) / 5).ceil());

    var nextValidByte = (index) {
      if (index < bufferEnd) {
        while (_IGNORE_CHARS.contains(bytes[index])) {
          padding = (padding + 1) % 5;
          index++; // skip newline character
        }
      }
      return index;
    };

    var writeIndex = 0;
    for (var i = bufferStart; i < bufferEnd;) {
      var num = 0;
      var starti = i;

      i = nextValidByte(i);
      num = (_baseMap[bytes[i]]) * QUAD85;

      i = nextValidByte(i + 1);
      num += (i >= bufferEnd ? 84 : _baseMap[bytes[i]]) * TRIO85;

      i = nextValidByte(i + 1);
      num += (i >= bufferEnd ? 84 : _baseMap[bytes[i]]) * DUO85;

      i = nextValidByte(i + 1);
      num += (i >= bufferEnd ? 84 : _baseMap[bytes[i]]) * SING85;

      i = nextValidByte(i + 1);
      num += (i >= bufferEnd ? 84 : _baseMap[bytes[i]]);

      i = nextValidByte(i + 1);

      if (algo == AlgoType.z85 && starti + 5 != i) {
        throw FormatException('Wrong length');
      }

      if (num > NUM_MAX_VALUE || num < 0) {
        throw FormatException('Bogus data');
      }
      result[writeIndex] = (num >> 24);
      result[writeIndex + 1] = (num >> 16);
      result[writeIndex + 2] = (num >> 8);
      result[writeIndex + 3] = (num & 0xff);
      writeIndex += 4;
    }

    return result.sublist(0, writeIndex - padding);
  }
}
