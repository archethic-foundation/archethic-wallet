/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account.dart';
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/bus/transaction_send_event.dart';
import 'package:aewallet/domain/models/token.dart';
import 'package:aewallet/domain/models/transaction.dart';
import 'package:aewallet/domain/repositories/transaction.dart';
import 'package:aewallet/domain/usecases/transaction/calculate_fees.dart';
import 'package:aewallet/infrastructure/repositories/archethic_transaction.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/ui/util/delayed_task.dart';
import 'package:aewallet/ui/views/tokens_fungibles/bloc/state.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
    AccountProviders.getSelectedAccount,
    AddTokenFormProvider._repository,
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
            return 0; // TODO(Chralu): should we use an error class instead ?
          }

          _calculateFeesTask?.cancel();
          _calculateFeesTask = CancelableTask<double?>(
            task: () => _calculateFees(
              context: context,
              formState: state,
            ),
          );
          final fees = await _calculateFeesTask?.schedule(delay);

          return fees ??
              0; // TODO(Chralu): should we use an error class instead ?
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
        state.accountBalance.nativeTokenValue! - fees) {
      state = state.copyWith(
        errorNameText:
            AppLocalization.of(context)!.insufficientBalance.replaceAll(
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

  // TODO(Chralu): That operation should be delayed to avoid to spam backend.
  Future<double?> _calculateFees({
    required BuildContext context,
    required AddTokenFormState formState,
  }) async {
    final selectedAccount = ref.read(
      AccountProviders.getSelectedAccount(context: context),
    );

    late Transaction transaction;

    transaction = Transaction.token(
      token: Token(
        accountSelectedName: selectedAccount!.name!,
        name: formState.name,
        symbol: formState.symbol,
        initialSupply: formState.initialSupply,
        seed: formState.seed,
        type: 'fungible',
        properties: {},
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
        errorNameText: AppLocalization.of(context)!.tokenNameMissing,
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
        errorSymbolText: AppLocalization.of(context)!.tokenSymbolMissing,
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
            AppLocalization.of(context)!.tokenInitialSupplyPositive,
      );
      return false;
    }

    // TODO(@reddwarf03): Pb avec la gestion des bigint à régler
    if (state.initialSupply > 9999999999) {
      state = state.copyWith(
        errorInitialSupplyText:
            AppLocalization.of(context)!.tokenInitialSupplyTooHigh,
      );
      return false;
    }

    return true;
  }

  Future<void> send(BuildContext context) async {
    final transactionRepository = ref.read(AddTokenFormProvider._repository);

    final localizations = AppLocalization.of(context)!;

    final selectedAccount = ref.read(
      AccountProviders.getSelectedAccount(context: context),
    );

    late Transaction transaction;

    transaction = Transaction.token(
      token: Token(
        name: state.name,
        symbol: state.symbol,
        initialSupply: state.initialSupply,
        accountSelectedName: selectedAccount!.name!,
        seed: state.seed,
        type: 'fungible',
        properties: {},
      ),
    );

    transactionRepository.send(
      transaction: transaction,
      onConfirmation: (confirmation) async {
        EventTaxiImpl.singleton().fire(
          TransactionSendEvent(
            transactionType: TransactionSendEventType.token,
            response: 'ok',
            nbConfirmations: confirmation.nbConfirmations,
            transactionAddress: confirmation.transactionAddress,
            maxConfirmations: confirmation.maxConfirmations,
          ),
        );
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
                response: localizations.keychainNotExistWarning,
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
  static final _repository = Provider<TransactionRepositoryInterface>(
    (ref) {
      final networkSettings = ref
          .watch(
            SettingsProviders.localSettingsRepository,
          )
          .getNetwork();
      return ArchethicTransactionRepository(
        phoenixHttpEndpoint: networkSettings.getPhoenixHttpLink(),
        websocketEndpoint: networkSettings.getWebsocketUri(),
      );
    },
  );
  static final initialAddTokenForm = _initialAddTokenFormProvider;
  static final addTokenForm = _addTokenFormProvider;
}
