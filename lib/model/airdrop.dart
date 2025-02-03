import 'package:freezed_annotation/freezed_annotation.dart';

part 'airdrop.freezed.dart';

@freezed
class Airdrop with _$Airdrop {
  const factory Airdrop({
    @Default(0.0) double personalLPAmount,
    @Default(0.0) double personalLPFlexibleAmount,
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
  if (1 <= x && x < 5) {
    return 1;
  } else if (5 <= x && x < 20) {
    return 2;
  } else if (20 <= x && x < 60) {
    return 3;
  } else if (60 <= x && x < 150) {
    return 5;
  } else if (150 <= x && x < 300) {
    return 8;
  } else if (300 <= x && x < 500) {
    return 13;
  } else if (500 <= x && x < 750) {
    return 21;
  } else if (750 <= x && x < 1000) {
    return 34;
  } else if (x >= 1000) {
    return 55;
  } else {
    return null;
  }
}
