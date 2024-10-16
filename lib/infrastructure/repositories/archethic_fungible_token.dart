import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/repositories/fungible_tokens_remote.dart';
import 'package:aewallet/model/data/account_token.dart';
import 'package:aewallet/modules/aeswap/domain/models/util/get_pool_list_response.dart';
import 'package:aewallet/service/app_service.dart';
import 'package:aewallet/util/get_it_instance.dart';

class ArchethicFungibleTokens
    implements FungibleTokensRemoteRepositoryInterface {
  @override
  Future<Result<List<AccountToken>, Failure>> getFungibleTokens({
    required String accountLastTransactionAddress,
    required List<GetPoolListResponse> poolsListRaw,
  }) async {
    return Result.guard(
      () => sl.get<AppService>().getFungiblesTokensList(
            accountLastTransactionAddress,
            poolsListRaw,
          ),
    );
  }
}
