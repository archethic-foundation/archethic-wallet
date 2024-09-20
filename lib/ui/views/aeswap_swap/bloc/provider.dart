import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/domain/repositories/transaction_remote.dart';
import 'package:aewallet/infrastructure/repositories/transaction/archethic_transaction.dart';
import 'package:aewallet/modules/aeswap/application/balance.dart';
import 'package:aewallet/modules/aeswap/application/dex_config.dart';
import 'package:aewallet/modules/aeswap/application/notification.dart';
import 'package:aewallet/modules/aeswap/application/pool/dex_pool.dart';
import 'package:aewallet/modules/aeswap/application/router_factory.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_pool.dart';
import 'package:aewallet/modules/aeswap/domain/models/dex_token.dart';
import 'package:aewallet/modules/aeswap/domain/usecases/swap.usecase.dart';
import 'package:aewallet/modules/aeswap/infrastructure/pool_factory.repository.dart';
import 'package:aewallet/modules/aeswap/util/browser_util_desktop.dart'
    if (dart.library.js) 'package:aewallet/modules/aeswap/util/browser_util_web.dart';
import 'package:aewallet/ui/views/aeswap_swap/bloc/state.dart';
import 'package:aewallet/ui/views/aeswap_swap/layouts/components/swap_confirm_sheet.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:decimal/decimal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final _swapFormProvider = NotifierProvider<SwapFormNotifier, SwapFormState>(
  () {
    return SwapFormNotifier();
  },
);

class SwapFormNotifier extends Notifier<SwapFormState>
    with aedappfm.TransactionMixin {
  SwapFormNotifier();

  @override
  SwapFormState build() => const SwapFormState();

  aedappfm.CancelableTask<
      ({
        double outputAmount,
        double fees,
        double priceImpact,
        double protocolFees,
        bool cancel,
      })>? _calculateSwapInfosTask;

  Future<void> getPool() async {
    var pool = await ref
        .read(DexPoolProviders.getPool(state.poolGenesisAddress).future);
    pool = await ref.read(DexPoolProviders.loadPoolCard(pool!).future);

    setPool(pool);
  }

  void setPool(DexPool? pool) {
    state = state.copyWith(pool: pool);
  }

  Future<void> setTokenToSwap(
    DexToken tokenToSwap,
  ) async {
    state = state.copyWith(
      failure: null,
      messageMaxHalfUCO: false,
      calculationInProgress: true,
      tokenToSwap: tokenToSwap,
    );

    final apiService = aedappfm.sl.get<archethic.ApiService>();
    final accountSelected = ref.watch(
      AccountProviders.accounts.select(
        (accounts) => accounts.valueOrNull?.selectedAccount,
      ),
    );
    final balance = await ref.read(
      getBalanceProvider(
        accountSelected!.genesisAddress,
        state.tokenToSwap!.isUCO ? 'UCO' : state.tokenToSwap!.address!,
        apiService,
      ).future,
    );
    state = state.copyWith(tokenToSwapBalance: balance);

    if (state.tokenSwapped != null) {
      if (state.tokenToSwap!.address == state.tokenSwapped!.address) {
        setFailure(
          const aedappfm.Failure.other(cause: "You can't swap the same tokens"),
        );
        state = state.copyWith(
          ratio: 0,
          pool: null,
          calculationInProgress: false,
        );
        return;
      }

      final dexConfig =
          await ref.read(DexConfigProviders.dexConfigRepository).getDexConfig();
      final apiService = aedappfm.sl.get<archethic.ApiService>();
      if (state.tokenToSwap != null) {
        final routerFactory =
            RouterFactory(dexConfig.routerGenesisAddress, apiService);
        final poolInfosResult = await routerFactory.getPoolAddresses(
          state.tokenToSwap!.isUCO ? 'UCO' : state.tokenToSwap!.address!,
          state.tokenSwapped!.isUCO ? 'UCO' : state.tokenSwapped!.address!,
        );
        await poolInfosResult.map(
          success: (success) async {
            if (success != null && success['address'] != null) {
              setPoolAddress(success['address']);
              await setTokenToSwapAmount(state.tokenToSwapAmount);
              await getRatio();
              await getPool();
            } else {
              setPoolAddress('');
              setFailure(const aedappfm.PoolNotExists());
              state = state.copyWith(ratio: 0, pool: null);
            }
          },
          failure: (failure) {
            setPoolAddress('');
            setFailure(const aedappfm.PoolNotExists());
            state = state.copyWith(ratio: 0, pool: null);
          },
        );
      }
    }
    state = state.copyWith(
      calculationInProgress: false,
    );
    return;
  }

  Future<
      ({
        double outputAmount,
        double fees,
        double priceImpact,
        double protocolFees,
        bool cancel,
      })> calculateSwapInfos(
    String tokenAddress,
    double amount,
    bool calculateOutputAmount, {
    Duration delay = const Duration(milliseconds: 800),
  }) async {
    if (state.poolGenesisAddress.isEmpty) {
      return (
        outputAmount: 0.0,
        fees: 0.0,
        priceImpact: 0.0,
        protocolFees: 0.0,
        cancel: false,
      );
    }
    final apiService = aedappfm.sl.get<archethic.ApiService>();
    final ({
      double fees,
      double outputAmount,
      double priceImpact,
      double protocolFees,
      bool cancel,
    }) result;
    try {
      result = await Future<
          ({
            double outputAmount,
            double fees,
            double priceImpact,
            double protocolFees,
            bool cancel,
          })>(
        () async {
          if (amount <= 0) {
            return (
              outputAmount: 0.0,
              fees: 0.0,
              priceImpact: 0.0,
              protocolFees: 0.0,
              cancel: false,
            );
          }

          _calculateSwapInfosTask?.cancel();
          _calculateSwapInfosTask = aedappfm.CancelableTask<
              ({
                double outputAmount,
                double fees,
                double priceImpact,
                double protocolFees,
                bool cancel,
              })>(
            task: () async {
              var _outputAmount = 0.0;
              var _fees = 0.0;
              var _priceImpact = 0.0;
              var _protocolFees = 0.0;

              if (calculateOutputAmount) {
                final getSwapInfosResult = await PoolFactoryRepositoryImpl(
                  state.poolGenesisAddress,
                  apiService,
                ).getSwapInfosOutput(tokenAddress, amount);

                getSwapInfosResult.map(
                  success: (success) {
                    if (success != null) {
                      _outputAmount = success['output_amount'] is int
                          ? double.parse(success['output_amount'].toString())
                          : success['output_amount'] ?? 0;
                      _fees = success['fee'] is int
                          ? double.parse(success['fee'].toString())
                          : success['fee'] ?? 0;
                      _priceImpact = success['price_impact'] is int
                          ? double.parse(success['price_impact'].toString())
                          : success['price_impact'] ?? 0;
                      _protocolFees = success['protocol_fee'] is int
                          ? double.parse(success['protocol_fee'].toString())
                          : success['protocol_fee'] ?? 0;
                    }
                  },
                  failure: (failure) {
                    setFailure(
                      aedappfm.Failure.other(
                        cause: 'calculateOutputAmount error $failure',
                      ),
                    );
                  },
                );
              } else {
                final getSwapInfosResult = await PoolFactoryRepositoryImpl(
                  state.poolGenesisAddress,
                  apiService,
                ).getSwapInfosInput(tokenAddress, amount);

                getSwapInfosResult.map(
                  success: (success) {
                    if (success != null) {
                      _outputAmount = success['input_amount'] is int
                          ? double.parse(success['input_amount'].toString())
                          : success['input_amount'] ?? 0;
                      _fees = success['fee'] is int
                          ? double.parse(success['fee'].toString())
                          : success['fee'] ?? 0;
                      _priceImpact = success['price_impact'] is int
                          ? double.parse(success['price_impact'].toString())
                          : success['price_impact'] ?? 0;
                      _protocolFees = success['protocol_fee'] is int
                          ? double.parse(success['protocol_fee'].toString())
                          : success['protocol_fee'] ?? 0;
                    }
                  },
                  failure: (failure) {
                    setFailure(
                      aedappfm.Failure.other(
                        cause: 'calculateOutputAmount error $failure',
                      ),
                    );
                  },
                );
              }

              return (
                outputAmount: _outputAmount,
                fees: _fees,
                priceImpact: _priceImpact,
                protocolFees: _protocolFees,
                cancel: false,
              );
            },
          );

          final __result = await _calculateSwapInfosTask?.schedule(delay);

          return (
            outputAmount: __result == null ? 0.0 : __result.outputAmount,
            fees: __result == null ? 0.0 : __result.fees,
            priceImpact: __result == null ? 0.0 : __result.priceImpact,
            protocolFees: __result == null ? 0.0 : __result.protocolFees,
            cancel: false,
          );
        },
      );
    } on aedappfm.CanceledTask {
      return (
        outputAmount: 0.0,
        fees: 0.0,
        priceImpact: 0.0,
        protocolFees: 0.0,
        cancel: true,
      );
    }
    return (
      outputAmount: result.outputAmount,
      fees: result.fees,
      priceImpact: result.priceImpact,
      protocolFees: result.protocolFees,
      cancel: false,
    );
  }

  Future<void> calculateOutputAmount() async {
    var swapInfos = (
      fees: 0.0,
      outputAmount: 0.0,
      priceImpact: 0.0,
      protocolFees: 0.0,
      cancel: false,
    );

    if (state.tokenToSwap != null &&
        state.tokenSwapped != null &&
        state.tokenToSwap!.address == state.tokenSwapped!.address) {
      setFailure(
        const aedappfm.Failure.other(cause: "You can't swap the same tokens"),
      );
      return;
    }

    if (state.tokenFormSelected == 1) {
      if (state.tokenToSwapAmount == 0) {
        return;
      }
      state = state.copyWith(
        calculateAmountSwapped: true,
        calculationInProgress: true,
      );
      swapInfos = await calculateSwapInfos(
        state.tokenToSwap!.isUCO ? 'UCO' : state.tokenToSwap!.address!,
        state.tokenToSwapAmount,
        true,
      );
      state = state.copyWith(
        tokenSwappedAmount: swapInfos.outputAmount,
      );

      if (swapInfos.cancel == false &&
          state.tokenSwapped != null &&
          state.tokenSwappedAmount == 0) {
        setFailure(
          const aedappfm.Failure.other(
            cause:
                'The entered amount is too low to execute a swap. Please increase the amount.',
          ),
        );
      }
    } else {
      if (state.tokenSwappedAmount == 0) {
        return;
      }
      state = state.copyWith(
        calculateAmountToSwap: true,
        calculationInProgress: true,
      );
      swapInfos = await calculateSwapInfos(
        state.tokenSwapped!.isUCO ? 'UCO' : state.tokenSwapped!.address!,
        state.tokenSwappedAmount,
        false,
      );

      if (swapInfos.cancel == false &&
          state.tokenSwapped != null &&
          state.tokenSwappedAmount == 0) {
        setFailure(
          const aedappfm.Failure.other(
            cause:
                'The entered amount is too low to execute a swap. Please increase the amount.',
          ),
        );
      }

      state = state.copyWith(
        tokenToSwapAmount: swapInfos.outputAmount,
      );
      if (state.tokenToSwap != null) {
        swapInfos = await calculateSwapInfos(
          state.tokenToSwap!.isUCO ? 'UCO' : state.tokenToSwap!.address!,
          state.tokenToSwapAmount,
          true,
        );

        if (swapInfos.cancel == false &&
            state.tokenToSwap == null &&
            state.tokenToSwapAmount == 0) {
          setFailure(
            const aedappfm.Failure.other(
              cause:
                  'The entered amount is too low to execute a swap. Please increase the amount.',
            ),
          );
        }
      }
    }

    final minToReceive = (Decimal.parse(swapInfos.outputAmount.toString()) *
            (((Decimal.parse('100') -
                        Decimal.parse(
                          state.slippageTolerance.toString(),
                        )) /
                    Decimal.parse('100'))
                .toDecimal()))
        .toDouble();

    if (state.tokenToSwapAmount > state.tokenToSwapBalance) {
      setFailure(const aedappfm.Failure.insufficientFunds());
    }

    state = state.copyWith(
      swapFees: swapInfos.fees,
      priceImpact: swapInfos.priceImpact,
      swapProtocolFees: swapInfos.protocolFees,
      minToReceive: minToReceive,
      calculateAmountSwapped: false,
      calculateAmountToSwap: false,
      calculationInProgress: false,
    );
  }

  Future<void> setTokenToSwapAmount(
    double tokenToSwapAmount,
  ) async {
    state = state.copyWith(
      failure: null,
      messageMaxHalfUCO: false,
      tokenToSwapAmount: tokenToSwapAmount,
    );

    if (state.tokenToSwap == null) {
      return;
    }

    await calculateOutputAmount();
  }

  void setTokenToSwapAmountWithoutCalculation(
    double tokenToSwapAmount,
  ) {
    state = state.copyWith(
      tokenToSwapAmount: tokenToSwapAmount,
    );
  }

  Future<void> setTokenSwappedAmount(
    double tokenSwappedAmount,
  ) async {
    state = state.copyWith(
      failure: null,
      tokenSwappedAmount: tokenSwappedAmount,
    );

    if (state.tokenSwapped == null) {
      return;
    }

    await calculateOutputAmount();
  }

  void setSwapOk(bool swapOk) {
    state = state.copyWith(
      swapOk: swapOk,
    );
  }

  Future<void> setTokenSwapped(
    DexToken tokenSwapped,
  ) async {
    state = state.copyWith(
      failure: null,
      tokenSwapped: tokenSwapped,
      calculationInProgress: true,
    );

    final apiService = aedappfm.sl.get<archethic.ApiService>();
    final accountSelected = ref.watch(
      AccountProviders.accounts.select(
        (accounts) => accounts.valueOrNull?.selectedAccount,
      ),
    );
    final balance = await ref.read(
      getBalanceProvider(
        accountSelected!.genesisAddress,
        state.tokenSwapped!.isUCO ? 'UCO' : state.tokenSwapped!.address!,
        apiService,
      ).future,
    );
    state = state.copyWith(tokenSwappedBalance: balance);

    if (state.tokenToSwap != null) {
      if (state.tokenToSwap!.address == state.tokenSwapped!.address) {
        setFailure(
          const aedappfm.Failure.other(cause: "You can't swap the same tokens"),
        );
        state = state.copyWith(
          ratio: 0,
          pool: null,
          calculationInProgress: false,
        );
        return;
      }

      final dexConfig =
          await ref.read(DexConfigProviders.dexConfigRepository).getDexConfig();
      final apiService = aedappfm.sl.get<archethic.ApiService>();
      if (state.tokenSwapped != null) {
        final routerFactory =
            RouterFactory(dexConfig.routerGenesisAddress, apiService);
        final poolInfosResult = await routerFactory.getPoolAddresses(
          state.tokenToSwap!.isUCO ? 'UCO' : state.tokenToSwap!.address!,
          state.tokenSwapped!.isUCO ? 'UCO' : state.tokenSwapped!.address!,
        );
        await poolInfosResult.map(
          success: (success) async {
            if (success != null && success['address'] != null) {
              setPoolAddress(success['address']);
              await setTokenSwappedAmount(state.tokenSwappedAmount);
              await getRatio();
              await getPool();
            } else {
              setPoolAddress('');
              setFailure(const aedappfm.PoolNotExists());
              state = state.copyWith(ratio: 0, pool: null);
            }
          },
          failure: (failure) {
            setPoolAddress('');
            setFailure(const aedappfm.PoolNotExists());
            state = state.copyWith(ratio: 0, pool: null);
          },
        );
      }
    }
    state = state.copyWith(
      calculationInProgress: false,
    );
    return;
  }

  Future<void> swapDirections() async {
    final oldToken1 = state.tokenToSwap;
    final oldToken2 = state.tokenSwapped;
    final oldToken2Amount = state.tokenSwappedAmount;

    setTokenFormSelected(1);
    setTokenToSwapAmountWithoutCalculation(oldToken2Amount);

    if (oldToken2 != null) {
      await setTokenToSwap(oldToken2);
    }

    if (oldToken1 != null) {
      await setTokenSwapped(oldToken1);
    }
    setTokenFormSelected(2);
  }

  Future<void> getRatio() async {
    if (state.tokenToSwap == null || state.tokenSwapped == null) {
      state = state.copyWith(ratio: 0);
      return;
    }

    final ratio = await ref.read(
      DexPoolProviders.getRatio(
        state.poolGenesisAddress,
        state.tokenToSwap!,
      ).future,
    );

    state = state.copyWith(ratio: ratio);
  }

  void setPoolAddress(
    String poolAddress,
  ) {
    state = state.copyWith(
      poolGenesisAddress: poolAddress,
    );
  }

  void setSwapFees(double swapFees) {
    state = state.copyWith(
      swapFees: swapFees,
    );
  }

  Future<void> setSlippageTolerance(
    double slippageTolerance,
  ) async {
    state = state.copyWith(
      slippageTolerance: slippageTolerance,
    );
    if (state.tokenToSwap == null) {
      return;
    }
    final swapInfos = await calculateSwapInfos(
      state.tokenToSwap!.isUCO ? 'UCO' : state.tokenToSwap!.address!,
      state.tokenToSwapAmount,
      true,
    );

    final minToReceive = (Decimal.parse(swapInfos.outputAmount.toString()) *
            (((Decimal.parse('100') -
                        Decimal.parse(
                          state.slippageTolerance.toString(),
                        )) /
                    Decimal.parse('100'))
                .toDecimal()))
        .toDouble();

    state = state.copyWith(
      tokenSwappedAmount: swapInfos.outputAmount,
      swapFees: swapInfos.fees,
      priceImpact: swapInfos.priceImpact,
      swapProtocolFees: swapInfos.protocolFees,
      minToReceive: minToReceive,
    );
  }

  void setTokenToSwapBalance(double tokenToSwapBalance) {
    state = state.copyWith(tokenToSwapBalance: tokenToSwapBalance);
  }

  void setTokenSwappedBalance(double tokenSwappedBalance) {
    state = state.copyWith(tokenSwappedBalance: tokenSwappedBalance);
  }

  void setMinimumReceived(
    double minToReceive,
  ) {
    state = state.copyWith(
      minToReceive: minToReceive,
    );
  }

  void setPriceImpact(
    double priceImpact,
  ) {
    state = state.copyWith(
      priceImpact: priceImpact,
    );
  }

  void setSwapProtocolFees(
    double swapProtocolFees,
  ) {
    state = state.copyWith(
      swapProtocolFees: swapProtocolFees,
    );
  }

  void setRecoveryTransactionSwap(
      archethic.Transaction? recoveryTransactionSwap) {
    state = state.copyWith(recoveryTransactionSwap: recoveryTransactionSwap);
  }

  void setEstimatedReceived(
    double estimatedReceived,
  ) {
    state = state.copyWith(
      estimatedReceived: estimatedReceived,
    );
  }

  void setCurrentStep(int currentStep) {
    state = state.copyWith(currentStep: currentStep);
  }

  void setResumeProcess(bool resumeProcess) {
    state = state.copyWith(resumeProcess: resumeProcess);
  }

  void setTokenFormSelected(int tokenFormSelected) {
    state = state.copyWith(failure: null, tokenFormSelected: tokenFormSelected);
  }

  void setFinalAmount(double? finalAmount) {
    state = state.copyWith(finalAmount: finalAmount);
  }

  void setFailure(aedappfm.Failure? failure) {
    state = state.copyWith(
      failure: failure,
    );
  }

  void setProcessInProgress(bool isProcessInProgress) {
    state = state.copyWith(isProcessInProgress: isProcessInProgress);
  }

  void setMessageMaxHalfUCO(
    bool messageMaxHalfUCO,
  ) {
    state = state.copyWith(
      messageMaxHalfUCO: messageMaxHalfUCO,
    );
  }

  Future<void> validateForm(BuildContext context) async {
    if (await control(context) == false) {
      return;
    }
    final accountSelected = ref.watch(
      AccountProviders.accounts.select(
        (accounts) => accounts.valueOrNull?.selectedAccount,
      ),
    );

    DateTime? consentDateTime;
    consentDateTime = await aedappfm.ConsentRepositoryImpl().getConsentTime(
      accountSelected!.genesisAddress,
    );
    state = state.copyWith(consentDateTime: consentDateTime);
    await context.push(SwapConfirmFormSheet.routerPage);
  }

  Future<bool> control(BuildContext context) async {
    setMessageMaxHalfUCO(false);
    setFailure(null);
    if (kIsWeb &&
        (BrowserUtil().isEdgeBrowser() ||
            BrowserUtil().isInternetExplorerBrowser())) {
      setFailure(
        const aedappfm.Failure.incompatibleBrowser(),
      );
      return false;
    }

    if (state.tokenToSwap == null) {
      setFailure(
        aedappfm.Failure.other(
          cause: AppLocalizations.of(context)!.swapControlTokenToSwapEmpty,
        ),
      );
      return false;
    }

    if (state.tokenSwapped == null) {
      setFailure(
        aedappfm.Failure.other(
          cause: AppLocalizations.of(context)!.swapControlTokenSwappedEmpty,
        ),
      );
      return false;
    }

    if (state.tokenToSwapAmount <= 0) {
      setFailure(
        aedappfm.Failure.other(
          cause: AppLocalizations.of(context)!.swapControlTokenToSwapEmpty,
        ),
      );
      return false;
    }

    if (state.tokenSwappedAmount <= 0) {
      setFailure(
        aedappfm.Failure.other(
          cause: AppLocalizations.of(context)!.swapControlTokenSwappedEmpty,
        ),
      );
      return false;
    }

    if (state.tokenToSwapAmount > state.tokenToSwapBalance) {
      setFailure(
        aedappfm.Failure.other(
          cause: AppLocalizations.of(context)!
              .swapControlTokenToSwapAmountExceedBalance,
        ),
      );
      return false;
    }

    var feesEstimatedUCO = 0.0;
    if (state.tokenToSwap != null && state.tokenToSwap!.isUCO) {
      state = state.copyWith(calculationInProgress: true);
      feesEstimatedUCO = await SwapCase().estimateFees(
        state.poolGenesisAddress,
        state.tokenToSwap!,
        state.tokenToSwapAmount,
        state.slippageTolerance,
      );
      state = state.copyWith(calculationInProgress: false);
    }
    state = state.copyWith(
      feesEstimatedUCO: feesEstimatedUCO,
    );
    if (feesEstimatedUCO > 0) {
      if (state.tokenToSwapAmount + feesEstimatedUCO >
          state.tokenToSwapBalance) {
        final adjustedAmount = state.tokenToSwapBalance - feesEstimatedUCO;
        if (adjustedAmount < 0) {
          state = state.copyWith(messageMaxHalfUCO: true);
          setFailure(const aedappfm.Failure.insufficientFunds());
          return false;
        } else {
          await setTokenToSwapAmount(adjustedAmount);
          state = state.copyWith(messageMaxHalfUCO: true);
        }
      }
    }

    return true;
  }

  Future<void> swap(BuildContext context, WidgetRef ref) async {
    setSwapOk(false);
    setProcessInProgress(true);

    if (await control(context) == false) {
      setProcessInProgress(false);
      return;
    }

    final accountSelected = ref.watch(
      AccountProviders.accounts.select(
        (accounts) => accounts.valueOrNull?.selectedAccount,
      ),
    );

    await aedappfm.ConsentRepositoryImpl().addAddress(
      accountSelected!.genesisAddress,
    );

    final transactionRepository = ref.read(SwapFormProvider._repository);

    if (context.mounted) {
      await SwapCase().run(
        transactionRepository,
        ref,
        context,
        ref.watch(NotificationProviders.notificationService),
        state.poolGenesisAddress,
        state.tokenToSwap!,
        state.tokenSwapped!,
        state.tokenToSwapAmount,
        state.slippageTolerance,
      );
    }
  }
}

abstract class SwapFormProvider {
  static final _repository = Provider<TransactionRemoteRepositoryInterface>(
    (ref) {
      final networkSettings = ref.watch(
        SettingsProviders.settings.select((settings) => settings.network),
      );
      return ArchethicTransactionRepository(
        phoenixHttpEndpoint: networkSettings.getPhoenixHttpLink(),
        websocketEndpoint: networkSettings.getWebsocketUri(),
      );
    },
  );
  static final swapForm = _swapFormProvider;
}
