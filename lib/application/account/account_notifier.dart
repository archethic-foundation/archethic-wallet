/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:async';

import 'package:aewallet/application/app_service.dart';
import 'package:aewallet/application/nft/nft.dart';
import 'package:aewallet/application/refresh_in_progress.dart';
import 'package:aewallet/application/session/session.dart';
import 'package:aewallet/infrastructure/datasources/account.hive.dart';
import 'package:aewallet/infrastructure/repositories/local_account.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/account_balance.dart';
import 'package:aewallet/modules/aeswap/application/pool/dex_pool.dart';
import 'package:aewallet/modules/aeswap/application/session/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:decimal/decimal.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account_notifier.g.dart';

typedef _RefreshOperation = ({
  String name, // for logging purpose
  Future<Account> Function(
    Account account,
  ) operation, // perform the update operation
});

@riverpod
class AccountNotifier extends _$AccountNotifier {
  final _logger = Logger('AccountNotifier');

  @override
  FutureOr<Account?> build(String accountName) async {
    return await AccountLocalRepository().getAccount(accountName);
  }

  /// Updates the account in Hive and handles errors consistently
  Future<void> _saveLocally(Account account) async {
    try {
      await AccountHiveDatasource.instance().updateAccount(account);
      _logger.fine('Account locally saved successfully');
    } catch (error, stack) {
      _logger.severe('Failed to locally save account', error, stack);
    }
  }

  /// Executes a refresh operation with proper error handling and state management
  Future<void> _performOperations(
    Iterable<_RefreshOperation> operations,
  ) =>
      update(
        (account) async {
          if (account == null) {
            _logger.warning('Account refresh : No account available');
            return null;
          }
          ref
              .read(refreshInProgressNotifierProvider.notifier)
              .refreshInProgress = true;

          var updatedAccount = account;
          for (final operation in operations) {
            final logName = 'Refresh ${operation.name}(${account.name})';
            _logger.fine('Starting $logName');
            try {
              updatedAccount = await operation.operation(updatedAccount);

              _logger.fine('$logName successful');
            } catch (e, stack) {
              _logger.severe('$logName failed', e, stack);
            }
          }

          await _saveLocally(updatedAccount);
          ref
              .read(refreshInProgressNotifierProvider.notifier)
              .refreshInProgress = false;
          return updatedAccount;
        },
      );

  Future<void> _performOperation(
    _RefreshOperation operation,
  ) =>
      _performOperations([operation]);

  Future<void> refreshRecentTransactions() =>
      _performOperation(_updateRecentTransactionsOperation);

  Future<void> refreshFungibleTokens() => _performOperations([
        _updateFungibleTokensOperation,
        _updateBalanceOperation,
      ]);

  Future<void> refreshNFT() => _performOperations([
        _updateNFTOperation,
        _updateBalanceOperation,
      ]);

  Future<void> refreshBalance() => _performOperation(_updateBalanceOperation);

  Future<void> refreshAll() => _performOperations([
        _updateFungibleTokensOperation,
        _updateNFTOperation,
        _updateBalanceOperation,
      ]);

  _RefreshOperation get _updateBalanceOperation => (
        name: 'Balance',
        operation: (Account account) async {
          final balanceGetResponseMap = await ref
              .read(appServiceProvider)
              .getBalanceGetResponse([account.genesisAddress]);

          if (balanceGetResponseMap[account.genesisAddress] == null) {
            _logger.warning(
              'No balance response for address: ${account.genesisAddress}',
            );
            return account;
          }

          final ucidsTokens = await ref.read(
            aedappfm.UcidsTokensProviders.ucidsTokens(
              environment: ref.read(environmentProvider),
            ).future,
          );

          final cryptoPrice = ref.read(aedappfm.CoinPriceProviders.coinPrices);
          final balanceGetResponse =
              balanceGetResponseMap[account.genesisAddress]!;

          final accountBalance = await _calculateAccountBalance(
            balanceGetResponse,
            ucidsTokens,
            cryptoPrice,
          );

          return account.copyWith(balance: accountBalance);
        }
      );

  Future<AccountBalance> _calculateAccountBalance(
    Balance balanceGetResponse,
    Map<String, int> ucidsTokens,
    aedappfm.CryptoPrice cryptoPrice,
  ) async {
    final ucoAmount = fromBigInt(balanceGetResponse.uco).toDouble();
    var accountBalance = AccountBalance(
      nativeTokenName: AccountBalance.cryptoCurrencyLabel,
      nativeTokenValue: ucoAmount,
    );

    var totalUSD = 0.0;

    if (balanceGetResponse.uco > 0) {
      accountBalance = accountBalance.copyWith(
        tokensFungiblesNb: accountBalance.tokensFungiblesNb + 1,
      );

      final archethicOracleUCO = await ref.read(
        aedappfm.ArchethicOracleUCOProviders.archethicOracleUCO.future,
      );
      totalUSD = (Decimal.parse(totalUSD.toString()) +
              Decimal.parse(ucoAmount.toString()) *
                  Decimal.parse(archethicOracleUCO.usd.toString()))
          .toDouble();
    }

    final (tokensValue, updatedAccountBalance) = await _calculateTokensValue(
      balanceGetResponse.token,
      accountBalance,
      ucidsTokens,
      cryptoPrice,
    );

    totalUSD += tokensValue;

    return updatedAccountBalance.copyWith(
      totalUSD: totalUSD,
    );
  }

  Future<(double, AccountBalance)> _calculateTokensValue(
    List<TokenBalance> tokens,
    AccountBalance accountBalance,
    Map<String, int> ucidsTokens,
    aedappfm.CryptoPrice cryptoPrice,
  ) async {
    var totalUSD = 0.0;
    var tokensFungiblesNb = accountBalance.tokensFungiblesNb;
    var nftNb = accountBalance.nftNb;

    for (final token in tokens) {
      if (token.tokenId != null) {
        if (token.tokenId == 0) {
          tokensFungiblesNb++;

          final ucidsToken = ucidsTokens[token.address];
          if (ucidsToken != null && ucidsToken != 0) {
            final amountTokenUSD =
                (Decimal.parse(fromBigInt(token.amount).toString()) *
                        Decimal.parse(
                          aedappfm.CoinPriceRepositoryImpl()
                              .getPriceFromUcid(ucidsToken, cryptoPrice)
                              .toString(),
                        ))
                    .toDouble();
            totalUSD += amountTokenUSD;
          }
        } else {
          nftNb++;
        }
      }
    }

    final updatedAccountBalance = accountBalance.copyWith(
      tokensFungiblesNb: tokensFungiblesNb,
      nftNb: nftNb,
    );

    return (totalUSD, updatedAccountBalance);
  }

  _RefreshOperation get _updateFungibleTokensOperation => (
        name: 'Fungible Tokens',
        operation: (Account account) async {
          final appService = ref.read(appServiceProvider);
          final poolsListRaw =
              await ref.read(DexPoolProviders.getPoolListRaw.future);

          final fungiblesTokensList = await appService.getFungiblesTokensList(
            account.genesisAddress,
            poolsListRaw,
          );

          return account.copyWith(accountTokens: fungiblesTokensList);
        }
      );

  _RefreshOperation get _updateRecentTransactionsOperation => (
        name: 'Recent Transactions',
        operation: (Account account) async {
          // TODO(reddwarf03): Supp ?
          /* ref.invalidate(
            recentTransactionsProvider(
              account.genesisAddress,
            ),
          );*/
          return account;
        },
      );

  _RefreshOperation get _updateNFTOperation => (
        name: 'NFT',
        operation: (Account account) async {
          final session = ref.read(sessionNotifierProvider).loggedIn!;
          final tokenInformation = await ref.read(
            NFTProviders.getNFTList(
              account.genesisAddress,
              account.name,
              session.wallet.keychainSecuredInfos,
            ).future,
          );

          return account.copyWith(
            accountNFT: tokenInformation.$1,
            accountNFTCollections: tokenInformation.$2,
          );
        }
      );

  Future<void> addCustomTokenAddress(
    Account account,
    String tokenAddress,
  ) async {
    _logger.fine('Adding custom token address');
    try {
      if (Address(address: tokenAddress).isValid() == false) {
        _logger.warning('Invalid token address: $tokenAddress');
        return;
      }
      final updatedAccount = account.copyWith(
        customTokenAddressList: [
          ...account.customTokenAddressList ?? [],
          tokenAddress.toUpperCase(),
        ],
      );
      state = AsyncData(updatedAccount);
      await _saveLocally(updatedAccount);

      _logger.fine('Custom token address added successfully');
    } catch (e, stack) {
      _logger.severe('Failed to add custom token address', e, stack);
    }
  }

  Future<void> removeCustomTokenAddress(
    Account account,
    String tokenAddress,
  ) async {
    _logger.fine('Removing custom token address');
    try {
      if (Address(address: tokenAddress).isValid() == false) {
        _logger.warning('Invalid token address: $tokenAddress');
        return;
      }

      final customTokenAddressList = account.customTokenAddressList;
      if (customTokenAddressList == null) {
        _logger.warning('No custom token addresses found');
        return;
      }

      final updatedAccount = account.copyWith(
        customTokenAddressList: customTokenAddressList
            .where(
              (element) => element != tokenAddress.toUpperCase(),
            )
            .toList(),
      );
      state = AsyncData(updatedAccount);
      await _saveLocally(updatedAccount);

      _logger.fine('Custom token address removed successfully');
    } catch (e, stack) {
      _logger.severe('Failed to remove custom token address', e, stack);
    }
  }

  Future<bool> checkCustomTokenAddress(String tokenAddress) async {
    try {
      final account = await future;
      if (account == null) {
        _logger.warning('Account not found for token address check');
        return false;
      }

      if (Address(address: tokenAddress).isValid() == false) {
        _logger.warning('Invalid token address: $tokenAddress');
        return false;
      }

      return (account.customTokenAddressList ?? [])
          .contains(tokenAddress.toUpperCase());
    } catch (e, stack) {
      _logger.severe('Failed to check custom token address', e, stack);
      return false;
    }
  }
}
