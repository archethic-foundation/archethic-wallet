import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';
import 'package:aewallet/domain/repositories/fungible_tokens_local.dart';
import 'package:aewallet/infrastructure/datasources/account.hive.dart';
import 'package:aewallet/model/data/account_token.dart';

class HiveFungibleTokens implements FungibleTokensLocalRepositoryInterface {
  final _accountDatasource = AccountHiveDatasource.instance();

  @override
  Future<Result<List<AccountToken>, Failure>> getFungibleTokens({
    required String accountName,
  }) async {
    final localAccount = await _accountDatasource.getAccount(accountName);
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
    final localAccount = await _accountDatasource.getAccount(accountName);

    if (localAccount == null) {
      return const VoidResult.failure(
        Failure.invalidValue(),
      );
    }

    await _accountDatasource.updateAccount(
      localAccount.copyWith(
        lastAddress: lastAddress,
        accountTokens: tokens,
      ),
    );
    return const VoidResult.success();
  }
}
