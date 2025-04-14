import 'package:aewallet/application/account/accounts_notifier.dart';
import 'package:aewallet/application/api_service.dart';
import 'package:aewallet/application/session/session.dart';
import 'package:aewallet/application/transaction_repository.dart';
import 'package:aewallet/domain/usecases/aeswap/add_funds_beginner.usecase.dart';
import 'package:aewallet/domain/usecases/aeswap/add_liquidity.usecase.dart';
import 'package:aewallet/domain/usecases/aeswap/claim_farm_lock.usecase.dart';
import 'package:aewallet/domain/usecases/aeswap/deposit_farm_lock.usecase.dart';
import 'package:aewallet/domain/usecases/aeswap/level_up_farm_lock.usecase.dart';
import 'package:aewallet/domain/usecases/aeswap/remove_liquidity.usecase.dart';
import 'package:aewallet/domain/usecases/aeswap/swap.usecase.dart';
import 'package:aewallet/domain/usecases/aeswap/withdraw_farm_lock.usecase.dart';
import 'package:aewallet/domain/usecases/aeswap/withdraw_funds_beginner.usecase.dart';
import 'package:aewallet/modules/aeswap/application/notification.dart';
import 'package:aewallet/modules/aeswap/application/verified_tokens.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'usecases.g.dart';

@riverpod
AddLiquidityCase addLiquidityCase(
  Ref ref,
  int blockchainTxVersion,
) =>
    AddLiquidityCase(
      apiService: ref.watch(apiServiceProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      transactionRepository: ref.watch(archethicTransactionRepositoryProvider),
      keychainSecuredInfos: ref
          .watch(sessionNotifierProvider)
          .loggedIn!
          .wallet
          .keychainSecuredInfos,
      selectedAccount: ref
          .watch(
            accountsNotifierProvider,
          )
          .value!
          .selectedAccount!,
      blockchainTxVersion: blockchainTxVersion,
    );

@riverpod
ClaimFarmLockCase claimFarmLockCase(
  Ref ref,
  int blockchainTxVersion,
) =>
    ClaimFarmLockCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      transactionRepository: ref.watch(archethicTransactionRepositoryProvider),
      keychainSecuredInfos: ref
          .watch(sessionNotifierProvider)
          .loggedIn!
          .wallet
          .keychainSecuredInfos,
      selectedAccount: ref
          .watch(
            accountsNotifierProvider,
          )
          .value!
          .selectedAccount!,
      blockchainTxVersion: blockchainTxVersion,
    );

@riverpod
DepositFarmLockCase depositFarmLockCase(
  Ref ref,
  int blockchainTxVersion,
) =>
    DepositFarmLockCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      transactionRepository: ref.watch(archethicTransactionRepositoryProvider),
      keychainSecuredInfos: ref
          .watch(sessionNotifierProvider)
          .loggedIn!
          .wallet
          .keychainSecuredInfos,
      selectedAccount: ref
          .watch(
            accountsNotifierProvider,
          )
          .value!
          .selectedAccount!,
      blockchainTxVersion: blockchainTxVersion,
    );

@riverpod
LevelUpFarmLockCase levelUpFarmLockCase(
  Ref ref,
  int blockchainTxVersion,
) =>
    LevelUpFarmLockCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      transactionRepository: ref.watch(archethicTransactionRepositoryProvider),
      keychainSecuredInfos: ref
          .watch(sessionNotifierProvider)
          .loggedIn!
          .wallet
          .keychainSecuredInfos,
      selectedAccount: ref
          .watch(
            accountsNotifierProvider,
          )
          .value!
          .selectedAccount!,
      blockchainTxVersion: blockchainTxVersion,
    );

@riverpod
RemoveLiquidityCase removeLiquidityCase(
  Ref ref,
  int blockchainTxVersion,
) =>
    RemoveLiquidityCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      transactionRepository: ref.watch(archethicTransactionRepositoryProvider),
      keychainSecuredInfos: ref
          .watch(sessionNotifierProvider)
          .loggedIn!
          .wallet
          .keychainSecuredInfos,
      selectedAccount: ref
          .watch(
            accountsNotifierProvider,
          )
          .value!
          .selectedAccount!,
      blockchainTxVersion: blockchainTxVersion,
    );

@riverpod
SwapCase swapCase(
  Ref ref,
  int blockchainTxVersion,
) =>
    SwapCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      transactionRepository: ref.watch(archethicTransactionRepositoryProvider),
      keychainSecuredInfos: ref
          .watch(sessionNotifierProvider)
          .loggedIn!
          .wallet
          .keychainSecuredInfos,
      selectedAccount: ref
          .watch(
            accountsNotifierProvider,
          )
          .value!
          .selectedAccount!,
      blockchainTxVersion: blockchainTxVersion,
    );

@riverpod
WithdrawFarmLockCase withdrawFarmLockCase(
  Ref ref,
  int blockchainTxVersion,
) =>
    WithdrawFarmLockCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      transactionRepository: ref.watch(archethicTransactionRepositoryProvider),
      keychainSecuredInfos: ref
          .watch(sessionNotifierProvider)
          .loggedIn!
          .wallet
          .keychainSecuredInfos,
      selectedAccount: ref
          .watch(
            accountsNotifierProvider,
          )
          .value!
          .selectedAccount!,
      blockchainTxVersion: blockchainTxVersion,
    );

@riverpod
AddFundsBeginnerCase addFundsBeginnerCase(
  Ref ref,
  int blockchainTxVersion,
) =>
    AddFundsBeginnerCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      transactionRepository: ref.watch(archethicTransactionRepositoryProvider),
      keychainSecuredInfos: ref
          .watch(sessionNotifierProvider)
          .loggedIn!
          .wallet
          .keychainSecuredInfos,
      selectedAccount: ref
          .watch(
            accountsNotifierProvider,
          )
          .value!
          .selectedAccount!,
      blockchainTxVersion: blockchainTxVersion,
    );

@riverpod
WithdrawFundsBeginnerCase withdrawFundsBeginnerCase(
  Ref ref,
  int blockchainTxVersion,
) =>
    WithdrawFundsBeginnerCase(
      apiService: ref.watch(apiServiceProvider),
      verifiedTokensRepository: ref.watch(verifiedTokensRepositoryProvider),
      notificationService: ref.watch(NotificationProviders.notificationService),
      transactionRepository: ref.watch(archethicTransactionRepositoryProvider),
      keychainSecuredInfos: ref
          .watch(sessionNotifierProvider)
          .loggedIn!
          .wallet
          .keychainSecuredInfos,
      selectedAccount: ref
          .watch(
            accountsNotifierProvider,
          )
          .value!
          .selectedAccount!,
      blockchainTxVersion: blockchainTxVersion,
    );
