/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/bus/transaction_send_event.dart';
import 'package:aewallet/domain/models/token.dart';
import 'package:aewallet/domain/models/transaction.dart';
import 'package:aewallet/domain/repositories/transaction_remote.dart';
import 'package:aewallet/domain/repositories/transaction_validation_ratios.dart';
import 'package:aewallet/domain/usecases/transaction/calculate_fees.dart';
import 'package:aewallet/infrastructure/repositories/transaction/archethic_transaction.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/ui/util/delayed_task.dart';
import 'package:aewallet/ui/views/tokens_fungibles/bloc/state.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart' as archethic;
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

const addTokenBCValidationRatio = 0.5;

final _initialAddTokenFormProvider = Provider<AddTokenFormState>(
  (ref) {
    throw UnimplementedError();
  },
);

final _addTokenFormProvider =
    NotifierProvider.autoDispose<AddTokenFormNotifier, AddTokenFormState>(
  () {
    return AddTokenFormNotifier();
  },
  dependencies: [
    AddTokenFormProvider.initialAddTokenForm,
    AccountProviders.selectedAccount,
    AddTokenFormProvider._repository,
    SessionProviders.session,
  ],
);

class AddTokenFormNotifier extends AutoDisposeNotifier<AddTokenFormState> {
  AddTokenFormNotifier();

  CancelableTask<double?>? _calculateFeesTask;

  Future<void> _updateFees(
    BuildContext context, {
    Duration delay = const Duration(milliseconds: 800),
  }) async {
    state = state.copyWith(
      feeEstimation: const AsyncValue.loading(),
    );

    late final double fees;

    try {
      fees = await Future<double>(
        () async {
          if (state.initialSupply <= 0 ||
              state.name.isEmpty ||
              state.symbol.isEmpty) {
            return 0;
          }

          _calculateFeesTask?.cancel();
          _calculateFeesTask = CancelableTask<double?>(
            task: () => _calculateFees(
              context: context,
              formState: state,
            ),
          );
          final fees = await _calculateFeesTask?.schedule(delay);

          return fees ?? 0;
        },
      );
    } on CanceledTask {
      return;
    }

    state = state.copyWith(
      feeEstimation: AsyncValue.data(fees),
      errorNameText: '',
    );
    if (state.feeEstimationOrZero >
        state.accountBalance.nativeTokenValue - fees) {
      state = state.copyWith(
        errorNameText:
            AppLocalizations.of(context)!.insufficientBalance.replaceAll(
                  '%1',
                  state.symbolFees(context),
                ),
      );
    }
  }

  @override
  AddTokenFormState build() => ref.watch(
        AddTokenFormProvider.initialAddTokenForm,
      );

  Future<double?> _calculateFees({
    required BuildContext context,
    required AddTokenFormState formState,
  }) async {
    final selectedAccount = await ref.read(
      AccountProviders.selectedAccount.future,
    );

    late Transaction transaction;

    final keychainSecuredInfos = ref
        .read(SessionProviders.session)
        .loggedIn!
        .wallet
        .keychainSecuredInfos;

    transaction = Transaction.token(
      token: Token(
        accountSelectedName: selectedAccount!.name,
        name: formState.name,
        symbol: formState.symbol,
        initialSupply: formState.initialSupply,
        keychainSecuredInfos: keychainSecuredInfos,
        transactionLastAddress: selectedAccount.lastAddress!,
        type: 'fungible',
        aeip: [2, 9],
        properties: [],
      ),
    );

    final calculateFeesResult = await CalculateFeesUsecase(
      repository: ref.read(AddTokenFormProvider._repository),
    ).run(transaction);

    return calculateFeesResult.valueOrNull;
  }

  Future<void> setName({
    required BuildContext context,
    required String name,
  }) async {
    state = state.copyWith(
      name: name,
    );
    _updateFees(
      context,
    );
    return;
  }

  void setErrors({
    String? errorAmountText,
    String? errorInitialSupplyText,
    String? errorNameText,
    String? errorSymbolText,
  }) {
    state = state.copyWith(
      errorAmountText: errorAmountText ?? '',
      errorInitialSupplyText: errorInitialSupplyText ?? '',
      errorNameText: errorNameText ?? '',
      errorSymbolText: errorSymbolText ?? '',
    );
  }

  Future<void> setSymbol({
    required BuildContext context,
    required String symbol,
  }) async {
    state = state.copyWith(
      symbol: symbol,
    );
    _updateFees(
      context,
    );
    return;
  }

  Future<void> setInitialSupply({
    required BuildContext context,
    required double initialSupply,
  }) async {
    state = state.copyWith(
      initialSupply: initialSupply,
    );
    _updateFees(
      context,
    );
    return;
  }

  void setAddTokenProcessStep(AddTokenProcessStep addTokenProcessStep) {
    state = state.copyWith(
      addTokenProcessStep: addTokenProcessStep,
    );
  }

  bool controlName(
    BuildContext context,
  ) {
    if (state.name.isEmpty) {
      state = state.copyWith(
        errorNameText: AppLocalizations.of(context)!.tokenNameMissing,
      );
      return false;
    }

    if (kTokenFordiddenName.contains(state.name.toUpperCase())) {
      state = state.copyWith(
        errorNameText: AppLocalizations.of(context)!.tokenNameUCO,
      );
      return false;
    }

    return true;
  }

  bool controlSymbol(
    BuildContext context,
  ) {
    if (state.symbol.isEmpty) {
      state = state.copyWith(
        errorSymbolText: AppLocalizations.of(context)!.tokenSymbolMissing,
      );
      return false;
    }

    if (kTokenFordiddenName.contains(state.symbol.toUpperCase())) {
      state = state.copyWith(
        errorSymbolText: AppLocalizations.of(context)!.tokenSymbolUCO,
      );
      return false;
    }
    return true;
  }

  bool controlInitialSupply(
    BuildContext context,
  ) {
    if (state.initialSupply <= 0) {
      state = state.copyWith(
        errorInitialSupplyText:
            AppLocalizations.of(context)!.tokenInitialSupplyPositive,
      );
      return false;
    }

    // TODO(reddwarf03): Pb avec la gestion des bigint à régler (1)
    if (state.initialSupply > 9999999999) {
      state = state.copyWith(
        errorInitialSupplyText:
            AppLocalizations.of(context)!.tokenInitialSupplyTooHigh,
      );
      return false;
    }

    return true;
  }

  bool controlAmount(
    BuildContext context,
    Account accountSelected,
  ) {
    final feeEstimation = state.feeEstimation.valueOrNull ?? 0;

    if (feeEstimation > accountSelected.balance!.nativeTokenValue) {
      state = state.copyWith(
        errorAmountText:
            AppLocalizations.of(context)!.insufficientBalance.replaceAll(
                  '%1',
                  state.symbolFees(context),
                ),
      );
      return false;
    }

    state = state.copyWith(
      errorAmountText: '',
    );
    return true;
  }

  Future<void> send(BuildContext context) async {
    final transactionRepository = ref.read(AddTokenFormProvider._repository);

    final localizations = AppLocalizations.of(context)!;

    final selectedAccount = await ref.read(
      AccountProviders.selectedAccount.future,
    );

    late Transaction transaction;

    final keychainSecuredInfos = ref
        .read(SessionProviders.session)
        .loggedIn!
        .wallet
        .keychainSecuredInfos;

    transaction = Transaction.token(
      token: Token(
        name: state.name,
        symbol: state.symbol,
        initialSupply: state.initialSupply,
        accountSelectedName: selectedAccount!.name,
        keychainSecuredInfos: keychainSecuredInfos,
        transactionLastAddress: selectedAccount.lastAddress!,
        type: 'fungible',
        aeip: [2, 9],
        properties: [],
      ),
    );

    transactionRepository.send(
      transaction: transaction,
      onConfirmation: (confirmation) async {
        if (archethic.TransactionConfirmation.isEnoughConfirmations(
          confirmation.nbConfirmations,
          confirmation.maxConfirmations,
          TransactionValidationRatios.addFungibleToken,
        )) {
          transactionRepository.close();
          EventTaxiImpl.singleton().fire(
            TransactionSendEvent(
              transactionType: TransactionSendEventType.token,
              response: 'ok',
              nbConfirmations: confirmation.nbConfirmations,
              transactionAddress: confirmation.transactionAddress,
              maxConfirmations: confirmation.maxConfirmations,
            ),
          );
        }
      },
      onError: (error) async {
        error.maybeMap(
          connectivity: (_) {
            EventTaxiImpl.singleton().fire(
              TransactionSendEvent(
                transactionType: TransactionSendEventType.token,
                response: localizations.noConnection,
                nbConfirmations: 0,
              ),
            );
          },
          consensusNotReached: (_) {
            EventTaxiImpl.singleton().fire(
              TransactionSendEvent(
                transactionType: TransactionSendEventType.token,
                response: localizations.consensusNotReached,
                nbConfirmations: 0,
              ),
            );
          },
          timeout: (_) {
            EventTaxiImpl.singleton().fire(
              TransactionSendEvent(
                transactionType: TransactionSendEventType.token,
                response: localizations.transactionTimeOut,
                nbConfirmations: 0,
              ),
            );
          },
          invalidConfirmation: (_) {
            EventTaxiImpl.singleton().fire(
              TransactionSendEvent(
                transactionType: TransactionSendEventType.token,
                nbConfirmations: 0,
                maxConfirmations: 0,
                response: 'ko',
              ),
            );
          },
          insufficientFunds: (error) {
            EventTaxiImpl.singleton().fire(
              TransactionSendEvent(
                transactionType: TransactionSendEventType.token,
                response: localizations.insufficientBalance.replaceAll(
                  '%1',
                  state.symbolFees(context),
                ),
                nbConfirmations: 0,
              ),
            );
          },
          other: (error) {
            EventTaxiImpl.singleton().fire(
              TransactionSendEvent(
                transactionType: TransactionSendEventType.token,
                response: localizations.genericError,
                nbConfirmations: 0,
              ),
            );
          },
          orElse: () {
            EventTaxiImpl.singleton().fire(
              TransactionSendEvent(
                transactionType: TransactionSendEventType.token,
                response: '',
                nbConfirmations: 0,
              ),
            );
          },
        );
      },
    );
  }
}

abstract class AddTokenFormProvider {
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
  static final initialAddTokenForm = _initialAddTokenFormProvider;
  static final addTokenForm = _addTokenFormProvider;
}
