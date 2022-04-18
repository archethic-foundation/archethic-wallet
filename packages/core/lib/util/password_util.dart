import 'dart:typed_data';

import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:http/http.dart' as http;

/// Validator class hold the RegExp for requested validation
class PasswordUtil {
  /// Checks if password has minLength
  static bool hasMinLength(String password, int minLength) {
    return password.length >= minLength ? true : false;
  }

  /// Checks if password has at least normal char letter matches
  static bool hasMinNormalChar(String password, int normalCount) {
    String pattern = '^(.*?[A-Z]){' + normalCount.toString() + ',}';
    return password.toUpperCase().contains(new RegExp(pattern));
  }

  /// Checks if password has at least uppercaseCount uppercase letter matches
  static bool hasMinUppercase(String password, int uppercaseCount) {
    String pattern = '^(.*?[A-Z]){' + uppercaseCount.toString() + ',}';
    return password.contains(new RegExp(pattern));
  }

  /// Checks if password has at least numericCount numeric character matches
  static bool hasMinNumericChar(String password, int numericCount) {
    String pattern = '^(.*?[0-9]){' + numericCount.toString() + ',}';
    return password.contains(new RegExp(pattern));
  }

  /// Checks if password has at least specialCount special character matches
  static bool hasMinSpecialChar(String password, int specialCount) {
    String pattern =
        r"^(.*?[$&+,\:;/=?@#|'<>.^*()_%!-]){" + specialCount.toString() + ",}";
    return password.contains(new RegExp(pattern));
  }

  /// Checks if password is compromised
  static Future<bool> isPasswordCompromised(String password) async {
    if (password.isEmpty) return false;
    final Digest sha1 = Digest('SHA-1');
    String digest =
        uint8ListToHex(sha1.process(Uint8List.fromList(password.codeUnits)))
            .toUpperCase();
    String firstFiveCarac = digest.substring(0, 5);

    final response = await http.read(
        Uri.parse('https://api.pwnedpasswords.com/range/$firstFiveCarac'));

    return response
        .split('\r\n')
        .any((o) => firstFiveCarac + o.split(':')[0] == digest);
  }
}
