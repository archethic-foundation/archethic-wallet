import 'package:flutter/foundation.dart';

extension StringExt on String {
  String decode() {
    var decodedString = this;
    try {
      decodedString = Uri.decodeFull(this);
    } catch (_) {
      debugPrint('string decoding error');
    }
    return decodedString;
  }
}
