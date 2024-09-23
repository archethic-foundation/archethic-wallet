/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/session/session.dart';
import 'package:aewallet/domain/repositories/transaction_remote.dart';
import 'package:aewallet/domain/repositories/transaction_validation_ratios.dart';
import 'package:aewallet/modules/aeswap/application/contracts/archethic_contract.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_notification.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:aewallet/modules/aeswap/util/notification_service/task_notification_service.dart'
    as ns;
import 'package:aewallet/modules/aeswap/util/string_util.dart';
import 'package:aewallet/ui/views/aeswap_liquidity_add/bloc/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class AddLiquidityCase with aedappfm.TransactionMixin {
  Future<void> run(
    TransactionRemoteRepositoryInterface transactionRepository,
    WidgetRef ref,
    BuildContext context,
    ns.TaskNotificationService<DexNotification, aedappfm.Failure>
        notificationService,
    String poolGenesisAddress,
    DexToken token1,
    double token1Amount,
    DexToken token2,
    double token2Amount,
    double slippage,
    DexToken lpToken,
  ) async {
    final operationId = const Uuid().v4();
    final archethicContract = ArchethicContract();
    final liquidityAddNotifier =
        ref.read(LiquidityAddFormProvider.liquidityAddForm.notifier);

    archethic.Transaction? transactionAddLiquidity;
    liquidityAddNotifier.setFinalAmount(null);

    try {
      final transactionAddLiquiditylMap =
          await archethicContract.getAddLiquidityTx(
        token1,
        token1Amount,
        token2,
        token2Amount,
        poolGenesisAddress,
        slippage,
      );

      transactionAddLiquiditylMap.map(
        success: (success) {
          transactionAddLiquidity = success;
        },
        failure: (failure) {
          liquidityAddNotifier
            ..setFailure(failure)
            ..setProcessInProgress(false);
          throw failure;
        },
      );
    } catch (e) {
      throw aedappfm.Failure.fromError(e);
    }

    liquidityAddNotifier.setCurrentStep(2);
    try {
      final keychainSecuredInfos = ref
          .read(sessionNotifierProvider)
          .loggedIn!
          .wallet
          .keychainSecuredInfos;

      final selectedAccount = await ref
          .read(
            AccountProviders.accounts.future,
          )
          .selectedAccount;

      final transationSignedRaw =
          await transactionRepository.buildTransactionRaw(
        keychainSecuredInfos,
        transactionAddLiquidity!,
        selectedAccount!.lastAddress!,
        selectedAccount.name,
      );

      liquidityAddNotifier.setTransactionAddLiquidity(transationSignedRaw);

      await transactionRepository.sendSignedRaw(
        transactionSignedRaw: transationSignedRaw,
        onConfirmation: (sender, confirmation) async {
          if (archethic.TransactionConfirmation.isEnoughConfirmations(
            confirmation.nbConfirmations,
            confirmation.maxConfirmations,
            TransactionValidationRatios.addLiquidity,
          )) {
            sender.close();

            liquidityAddNotifier
              ..setResumeProcess(false)
              ..setProcessInProgress(false)
              ..setLiquidityAddOk(true);

            notificationService.start(
              operationId,
              DexNotification.addLiquidity(
                txAddress: transationSignedRaw.address!.address,
              ),
            );

            final amount = await aedappfm.PeriodicFuture.periodic<double>(
              () => getAmountFromTxInput(
                transationSignedRaw.address!.address!,
                lpToken.address,
                aedappfm.sl.get<archethic.ApiService>(),
              ),
              sleepDuration: const Duration(seconds: 3),
              until: (amount) => amount > 0,
              timeout: const Duration(minutes: 1),
            );

            liquidityAddNotifier.setFinalAmount(amount);

            notificationService.succeed(
              operationId,
              DexNotification.addLiquidity(
                txAddress: transationSignedRaw.address!.address,
                lpToken: lpToken,
                amount: amount,
              ),
            );

            unawaited(() async {
              await refreshCurrentAccountInfoWallet();
            }());
          }
        },
        onError: (sender, error) async {
          notificationService.failed(
            operationId,
            aedappfm.Failure.fromError(error.messageLabel),
          );
        },
      );
    } catch (e) {
      if (e is aedappfm.Failure) {
        liquidityAddNotifier.setFailure(e);
        throw aedappfm.Failure.fromError(e);
      }
      liquidityAddNotifier.setFailure(
        aedappfm.Failure.other(
          cause: e.toString().replaceAll('Exception: ', '').capitalize(),
        ),
      );

      notificationService.failed(
        operationId,
        aedappfm.Failure.fromError(e),
      );
      throw aedappfm.Failure.fromError(e);
    }
  }

  Future<double> estimateFees(
    String poolGenesisAddress,
    DexToken token1,
    double token1Amount,
    DexToken token2,
    double token2Amount,
    double slippage,
  ) async {
    final archethicContract = ArchethicContract();
    archethic.Transaction? transactionAddLiquidity;

    try {
      final transactionAddLiquiditylMap =
          await archethicContract.getAddLiquidityTx(
        token1,
        token1Amount,
        token2,
        token2Amount,
        poolGenesisAddress,
        slippage,
      );

      transactionAddLiquiditylMap.map(
        success: (success) {
          transactionAddLiquidity = success;
          // Add fake signature and address to allow estimation by node
          transactionAddLiquidity = transactionAddLiquidity!.copyWith(
            address: const archethic.Address(
              address:
                  '00000000000000000000000000000000000000000000000000000000000000000000',
            ),
            previousPublicKey:
                '00000000000000000000000000000000000000000000000000000000000000000000',
          );
        },
        failure: (failure) {
          return 0.0;
        },
      );
    } catch (e) {
      return 0.0;
    }

    final fees = await calculateFees(
      transactionAddLiquidity!,
      aedappfm.sl.get<archethic.ApiService>(),
    );
    return fees;
  }

  String getAEStepLabel(
    BuildContext context,
    int step,
  ) {
    switch (step) {
      case 1:
        return AppLocalizations.of(context)!.addLiquidityProcessStep1;
      case 2:
        return AppLocalizations.of(context)!.addLiquidityProcessStep2;
      case 3:
        return AppLocalizations.of(context)!.addLiquidityProcessStep3;
      default:
        return AppLocalizations.of(context)!.addLiquidityProcessStep0;
    }
  }
}
