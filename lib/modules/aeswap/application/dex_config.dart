/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/modules/aeswap/domain/repositories/dex_config.repository.dart';
import 'package:aewallet/modules/aeswap/infrastructure/dex_config.repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dex_config.g.dart';

@Riverpod(keepAlive: true)
DexConfigRepository _dexConfigRepository(
  _DexConfigRepositoryRef ref,
) =>
    DexConfigRepositoryImpl();

abstract class DexConfigProviders {
  static final dexConfigRepository = _dexConfigRepositoryProvider;
}
