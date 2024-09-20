import 'package:aewallet/modules/aeswap/domain/models/dex_pair.dart';
import 'package:aewallet/modules/aeswap/infrastructure/hive/db_helper.hive.dart';
import 'package:aewallet/modules/aeswap/infrastructure/hive/dex_token.hive.dart';
import 'package:hive/hive.dart';

part 'dex_pair.hive.g.dart';

@HiveType(typeId: HiveTypeIds.dexPair)
class DexPairHive extends HiveObject {
  DexPairHive({
    required this.token1,
    required this.token2,
  });

  factory DexPairHive.fromModel(DexPair dexPair) {
    return DexPairHive(
      token1: DexTokenHive.fromModel(dexPair.token1),
      token2: DexTokenHive.fromModel(dexPair.token2),
    );
  }
  @HiveField(0)
  DexTokenHive token1;

  @HiveField(1)
  DexTokenHive token2;

  DexPair toModel() {
    return DexPair(
      token1: token1.toModel(),
      token2: token2.toModel(),
    );
  }
}
