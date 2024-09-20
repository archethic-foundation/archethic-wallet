/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/modules/aeswap/domain/enum/dex_action_type.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dex_pool_tx.freezed.dart';
part 'dex_pool_tx.g.dart';

@freezed
class DexPoolTx with _$DexPoolTx {
  const factory DexPoolTx({
    String? addressTx,
    DexActionType? typeTx,
    DexToken? token1,
    DexToken? token2,
    double? totalValue,
    double? token1Amount,
    double? token2Amount,
    String? addressAccount,
    DateTime? time,
  }) = _DexPoolTx;
  const DexPoolTx._();

  factory DexPoolTx.fromJson(Map<String, dynamic> json) =>
      _$DexPoolTxFromJson(json);
}
