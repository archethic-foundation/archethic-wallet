/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:freezed_annotation/freezed_annotation.dart';

part 'airdrop.freezed.dart';

@freezed
class Airdrop with _$Airdrop {
  const factory Airdrop({
    @Default(false) isFarming,
    @Default(false) isMailFilled,
    int? currentStep,
    int? personalMultiplier,
    @Default(0) double currentAirdropValue,
  }) = _Airdrop;
  const Airdrop._();

  static String get messageToSign =>
      'I confirm that I am participating in the Archethic UCO airdrop. This signature is solely used to verify my participation and does not authorize the transfer of funds or any other actions involving my wallet.';
}
