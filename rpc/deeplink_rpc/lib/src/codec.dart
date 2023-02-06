import 'dart:convert';
import 'dart:io';

const deeplinkRpc = DeeplinkRpcCodec();

class DeeplinkRpcCodec {
  const DeeplinkRpcCodec();

  String encode(dynamic data) {
    final jsonPayload = json.encode(data);
    final stringPayload = utf8.encode(jsonPayload);
    final gzippedPayload = gzip.encode(stringPayload);
    return base64.encode(gzippedPayload);
  }

  Map<String, dynamic> decode(String data) {
    final gzippedPayload = base64.decode(data);
    final rawPayload = gzip.decode(gzippedPayload);
    final stringPayload = utf8.decode(rawPayload);
    return json.decode(stringPayload);
  }
}
