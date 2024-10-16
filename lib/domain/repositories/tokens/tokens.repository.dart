import 'package:aewallet/modules/aeswap/domain/models/util/get_pool_list_response.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;

abstract class TokensRepository {
  Future<Map<String, archethic.Token>> getToken(
    List<String> addresses,
    archethic.ApiService apiService,
  );

  Future<List<AEToken>> getTokensList(
    String userGenesisAddress,
    archethic.ApiService apiService,
    List<GetPoolListResponse> poolsListRaw,
    Environment environment, {
    bool withVerified = true,
    bool withLPToken = true,
    bool withNotVerified = true,
  });
}
