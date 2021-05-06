// @dart=2.9

import 'dart:convert';
import 'dart:typed_data';

import 'package:uniris_mobile_wallet/util/base85/base_85_codec.dart';

var ASCII85_ENC_START = '<~';
var ASCII85_ENC_END = '~>';

class Base85Encoder extends Converter<Uint8List, String> {
  final String alphabet;
  final AlgoType algo;

  Base85Encoder(this.alphabet, this.algo);

  @override

  /// Encodes the specified data. If algo is [AlgoType.ascii85],
  /// the encoded data will be prepended with <~ and appended with ~>.
  /// The [bytes] to encode, may be a [Uint8List]
  /// return A String with the encoded [bytes].
  String convert(Uint8List bytes) {
    if (bytes.length % 4 != 0) {
      throw FormatException('Wrong length');
    }
    var padding = (bytes.length % 4 == 0) ? 0 : 4 - bytes.length % 4;

    var result = '';
    for (var i = 0; i < bytes.length; i += 4) {
      /// 32 bit number of the current 4 bytes (padded with 0 as necessary)
      var num = ((bytes[i] << 24).toUnsigned(32)) +
          (((i + 1 > bytes.length ? 0 : bytes[i + 1]) << 16).toUnsigned(32)) +
          (((i + 2 > bytes.length ? 0 : bytes[i + 2]) << 8).toUnsigned(32)) +
          (((i + 3 > bytes.length ? 0 : bytes[i + 3]) << 0).toUnsigned(32));

      /// Create 5 characters from '!' to 'u' alphabet
      var block = <String>[];
      for (var j = 0; j < 5; ++j) {
        block.insert(0, alphabet[num % 85]);
        num = num ~/ 85;
      }

      var r = block.join('');
      if (r == '!!!!!' && algo == AlgoType.ascii85) {
        r = 'z';
      }

      /// And append them to the result
      result += r;
    }

    return ((algo == AlgoType.ascii85) ? ASCII85_ENC_START : '') +
        result.substring(0, result.length - padding) +
        ((algo == AlgoType.ascii85) ? ASCII85_ENC_END : '');
  }
}
