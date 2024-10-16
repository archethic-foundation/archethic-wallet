import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/model/data/account_token.dart';
import 'package:aewallet/modules/aeswap/domain/models/util/get_pool_list_response.dart';

abstract class FungibleTokensRemoteRepositoryInterface {
  Future<Result<List<AccountToken>, Failure>> getFungibleTokens({
    required String accountLastTransactionAddress,
    required List<GetPoolListResponse> poolsListRaw,
  });
}
