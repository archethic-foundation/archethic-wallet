import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:aewallet/modules/aeswap/infrastructure/hive/db_helper.hive.dart';
import 'package:hive/hive.dart';

part 'dex_token.hive.g.dart';

@HiveType(typeId: HiveTypeIds.dexToken)
class DexTokenHive extends HiveObject {
  DexTokenHive({
    required this.name,
    required this.address,
    required this.icon,
    required this.symbol,
    required this.balance,
    required this.verified,
    required this.isLpToken,
  });

  factory DexTokenHive.fromModel(DexToken dexToken) {
    return DexTokenHive(
      name: dexToken.name,
      address: dexToken.address,
      icon: dexToken.icon,
      symbol: dexToken.symbol,
      balance: dexToken.balance,
      verified: dexToken.isVerified,
      isLpToken: dexToken.isLpToken,
    );
  }
  @HiveField(0)
  String name;

  @HiveField(1)
  String? address;

  @HiveField(2)
  String? icon;

  @HiveField(3)
  String symbol;

  @HiveField(4)
  double balance;

  // @HiveField(5)
  // double reserve;

  // @HiveField(6)
  // double supply;

  @HiveField(7)
  bool verified;

  @HiveField(8)
  bool? isLpToken;

  DexToken toModel() {
    return DexToken(
      name: name,
      address: address ??
          kUCOAddress, // Migration workaround to ensure we always have an address for a token
      icon: icon,
      symbol: symbol,
      balance: balance,
      isVerified: verified,
      isLpToken: isLpToken ?? false,
    );
  }
}

extension DexTokenHiveConversionExt on DexToken {
  DexTokenHive toHive() => DexTokenHive(
        address: address,
        balance: balance,
        icon: icon,
        name: name,
        symbol: symbol,
        verified: isVerified,
        isLpToken: isLpToken,
      );
}
