import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/model/data/account_token.dart';

abstract class FungibleTokensLocalRepositoryInterface {
  Future<Result<List<AccountToken>, Failure>> getFungibleTokens({
    required String accountName,
  });

  Future<VoidResult<Failure>> saveFungibleTokens({
    required String accountName,
    required String lastAddress,
    required List<AccountToken> tokens,
  });
}
