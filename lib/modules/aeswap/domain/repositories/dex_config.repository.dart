import 'package:aewallet/modules/aeswap/domain/models/dex_config.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;

abstract class DexConfigRepository {
  Future<DexConfig> getDexConfig(
    aedappfm.Environment? environment,
  );
}
