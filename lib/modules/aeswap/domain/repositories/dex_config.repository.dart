import 'package:aewallet/modules/aeswap/domain/models/dex_config.dart';

abstract class DexConfigRepository {
  Future<DexConfig> getDexConfig();
}
