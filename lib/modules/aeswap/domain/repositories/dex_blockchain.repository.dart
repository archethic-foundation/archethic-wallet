import 'package:aewallet/modules/aeswap/domain/models/dex_blockchain.dart';

abstract class DexBlockchainsRepository {
  Future<List<DexBlockchain>> getBlockchainsListConf();

  List<DexBlockchain> getBlockchainsList(
    List<DexBlockchain> blockchainsList,
  );

  Future<DexBlockchain?> getBlockchainFromEnv(
    List<DexBlockchain> blockchainsList,
    String env,
  );
}
