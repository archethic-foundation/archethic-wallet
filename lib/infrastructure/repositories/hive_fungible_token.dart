import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/repositories/fungible_tokens_local.dart';
import 'package:aewallet/model/data/account_token.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/util/get_it_instance.dart';

class HiveFungibleTokens implements FungibleTokensLocalRepositoryInterface {
  final DBHelper _dbHelper = sl.get<DBHelper>();

  @override
  Future<Result<List<AccountToken>, Failure>> getFungibleTokens({
    required String accountName,
  }) async {
    final localAccount = await _dbHelper.getAccount(accountName);
    if (localAccount == null) {
      return const Result.failure(Failure.invalidValue());
    }

    return Result.success(
      localAccount.accountTokens ?? [],
    );
  }

  @override
  Future<VoidResult<Failure>> saveFungibleTokens({
    required String lastAddress,
    required String accountName,
    required List<AccountToken> tokens,
  }) async {
    final localAccount = await _dbHelper.getAccount(accountName);

    if (localAccount == null) {
      return const VoidResult.failure(
        Failure.invalidValue(),
      );
    }

    await _dbHelper.updateAccount(
      localAccount.copyWith(
        lastAddress: lastAddress,
        accountTokens: tokens,
      ),
    );
    return const VoidResult.success();
  }
}
