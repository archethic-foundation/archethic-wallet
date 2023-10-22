// ignore_for_file: use_is_even_rather_than_modulo

part of '../encrypt.dart';

Uint8List decodeHexString(String input) {
  assert(input.length % 2 == 0, 'Input needs to be an even length.');

  return Uint8List.fromList(
    List.generate(
      input.length ~/ 2,
      (i) => int.parse(input.substring(i * 2, (i * 2) + 2), radix: 16),
    ).toList(),
  );
}
