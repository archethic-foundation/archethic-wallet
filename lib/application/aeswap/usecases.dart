import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/session/session.dart';
import 'package:aewallet/application/transaction_repository.dart';
import 'package:aewallet/domain/usecases/aeswap/add_liquidity.usecase.dart';
import 'package:aewallet/domain/usecases/aeswap/claim_farm_lock.usecase.dart';
import 'package:aewallet/domain/usecases/aeswap/deposit_farm_lock.usecase.dart';
import 'package:aewallet/domain/usecases/aeswap/level_up_farm_lock.usecase.dart';
import 'package:aewallet/domain/usecases/aeswap/remove_liquidity.usecase.dart';
import 'package:aewallet/domain/usecases/aeswap/swap.usecase.dart';
import 'package:aewallet/domain/usecases/aeswap/withdraw_farm_lock.usecase.dart';
import 'package:aewallet/modules/aeswap/application/api_service.dart';
import 'package:aewallet/modules/aeswap/application/notification.dart';
import 'package:aewallet/modules/aeswap/application/verified_tokens.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'usecases.g.dart';

@Riverpod(keepAlive: true)
AddLiquidityCase addLiquidityCase(
  AddLiquidityCaseRef ref,
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
            AccountProviders.accounts,
          )
          .value!
          .selectedAccount!,
    );

@Riverpod(keepAlive: true)
ClaimFarmLockCase claimFarmLockCase(
  ClaimFarmLockCaseRef ref,
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
            AccountProviders.accounts,
          )
          .value!
          .selectedAccount!,
    );

@Riverpod(keepAlive: true)
DepositFarmLockCase depositFarmLockCase(
  DepositFarmLockCaseRef ref,
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
            AccountProviders.accounts,
          )
          .value!
          .selectedAccount!,
    );

@Riverpod(keepAlive: true)
LevelUpFarmLockCase levelUpFarmLockCase(
  LevelUpFarmLockCaseRef ref,
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
            AccountProviders.accounts,
          )
          .value!
          .selectedAccount!,
    );

@Riverpod(keepAlive: true)
RemoveLiquidityCase removeLiquidityCase(
  RemoveLiquidityCaseRef ref,
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
            AccountProviders.accounts,
          )
          .value!
          .selectedAccount!,
    );

@Riverpod(keepAlive: true)
SwapCase swapCase(
  SwapCaseRef ref,
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
            AccountProviders.accounts,
          )
          .value!
          .selectedAccount!,
    );

@Riverpod(keepAlive: true)
WithdrawFarmLockCase withdrawFarmLockCase(
  WithdrawFarmLockCaseRef ref,
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
            AccountProviders.accounts,
          )
          .value!
          .selectedAccount!,
    );
