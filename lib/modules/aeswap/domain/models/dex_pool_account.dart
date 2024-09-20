/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/modules/aeswap/domain/models/dex_pool.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dex_pool_account.freezed.dart';

@freezed
class DexPoolAccount with _$DexPoolAccount {
  const factory DexPoolAccount({
    @Default('') DexPool pool,
    @Default(0.0) double token1Amount,
    @Default(0.0) double token2Amount,
  }) = _DexPoolAccount;
}
