// @dart=2.9

import 'dart:typed_data';
import 'package:uniris_mobile_wallet/util/base85/base_85_codec.dart';

class Base85Decode {
  static const RFC1924 =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!#\$%&()*+-;<=>?@^_`{|}~';

  String encode(String buffer)
  {
    try
    {
        if(buffer != null)
        {
            var codec = Base85Codec(RFC1924, AlgoType.rfc1924);
            return codec.encode(Uint8List.fromList(buffer.codeUnits)); 
        }
        else
        {
          return "";
        }
    }
    catch(e)
    {
      return "";
    }
  }

  String decode(String buffer) {
    try {
      if (buffer != null && buffer.trim().length > 0) {
        var codec = Base85Codec(RFC1924, AlgoType.rfc1924);
        Uint8List bufferDecoded = codec.decode(buffer);
        return String.fromCharCodes(bufferDecoded);
      } else {
        return "";
      }
    } catch (e) {
      //print(e);
      return "";
    }
  }
}
