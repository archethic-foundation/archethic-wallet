import 'package:freezed_annotation/freezed_annotation.dart';

part 'airdrop.freezed.dart';

@freezed
class Airdrop with _$Airdrop {
  const factory Airdrop({
    @Default(0.0) double personalLPAmount,
    @Default(false) bool isMailFilled,
    @Default(false) bool isMailConfirmed,
  }) = _Airdrop;
  const Airdrop._();

  int get personalMultiplier =>
      _airdropPersonalMultiplier(personalLPAmount) ?? 0;

  static String get messageToSign =>
      'I confirm that I am participating in the Archethic UCO airdrop. This signature is solely used to verify my participation and does not authorize the transfer of funds or any other actions involving my wallet.';
}

int? _airdropPersonalMultiplier(double x) {
  const multiplierRanges = {
    1: 1,
    5: 2,
    20: 3,
    60: 5,
    150: 8,
    300: 13,
    500: 21,
    750: 34,
    1000: 55,
  };

  for (final threshold in multiplierRanges.keys) {
    if (x >= threshold) {
      return multiplierRanges[threshold];
    }
  }
  return null;
}
