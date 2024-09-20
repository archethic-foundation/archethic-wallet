/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dex_blockchain.freezed.dart';
part 'dex_blockchain.g.dart';

@freezed
class DexBlockchain with _$DexBlockchain {
  const factory DexBlockchain({
    @Default('') String name,
    @Default('') String env,
    @Default('') String icon,
    @Default('') String urlExplorerAddress,
    @Default('') String urlExplorerTransaction,
    @Default('') String urlExplorerChain,
    @Default('') String nativeCurrency,
  }) = _DexBlockchain;

  const DexBlockchain._();

  factory DexBlockchain.fromJson(Map<String, dynamic> json) =>
      _$DexBlockchainFromJson(json);
}
