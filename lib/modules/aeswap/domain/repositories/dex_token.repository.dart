import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';

abstract class DexTokenRepository {
  Future<DexToken?> getToken(
    String address,
  );

  Future<List<DexToken>> getTokensFromAccount(
    String accountAddress,
  );

  Future<List<DexToken>> getLocalTokensDescriptions();
}
