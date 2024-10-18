import 'package:aewallet/modules/aeswap/domain/models/dex_pool.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;

abstract class DexPoolRepository {
  Future<DexPool?> getPool(
    String poolAddress,
    List<String> tokenVerifiedList,
    aedappfm.Environment environment,
  );
}
