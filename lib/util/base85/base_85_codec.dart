// @dart=2.9

import 'dart:convert';
import 'dart:typed_data';
import 'package:uniris_mobile_wallet/util/base85/base_85_decoder.dart';
import 'package:uniris_mobile_wallet/util/base85/base_85_encoder.dart';

enum AlgoType { ascii85, z85, rfc1924 }

class Base85Codec extends Codec<Uint8List, String> {
  String alphabet;
  Base85Encoder _encoder;
  Base85Decoder _decoder;
  AlgoType algo;

  Base85Codec(this.alphabet, [this.algo = AlgoType.z85]);

  @override
  Converter<Uint8List, String> get encoder {
    _encoder ??= Base85Encoder(alphabet, this.algo);
    return _encoder;
  }

  @override
  Converter<String, Uint8List> get decoder {
    _decoder ??= Base85Decoder(alphabet, this.algo);
    return _decoder;
  }
}
