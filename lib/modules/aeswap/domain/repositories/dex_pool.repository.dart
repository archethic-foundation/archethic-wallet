import 'package:aewallet/modules/aeswap/domain/models/dex_pool.dart';

abstract class DexPoolRepository {
  Future<DexPool?> getPool(
    String poolAddress,
    List<String> tokenVerifiedList,
  );
}
