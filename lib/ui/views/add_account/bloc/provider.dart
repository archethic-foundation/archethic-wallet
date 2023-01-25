/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/bus/transaction_send_event.dart';
import 'package:aewallet/domain/models/transaction.dart';
import 'package:aewallet/domain/repositories/transaction_remote.dart';
import 'package:aewallet/infrastructure/repositories/archethic_transaction.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/ui/views/add_account/bloc/state.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final _initialAddAccountFormProvider = Provider<AddAccountFormState>(
  (ref) {
    throw UnimplementedError();
  },
);

final _addAccountFormProvider =
    NotifierProvider.autoDispose<AddAccountFormNotifier, AddAccountFormState>(
  () {
    return AddAccountFormNotifier();
  },
  dependencies: [
    AddAccountFormProvider.initialAddAccountForm,
    AccountProviders.selectedAccount,
    AddAccountFormProvider._repository,
    AccountProviders.sortedAccounts,
    SessionProviders.session,
  ],
);

class AddAccountFormNotifier extends AutoDisposeNotifier<AddAccountFormState> {
  AddAccountFormNotifier();

  @override
  AddAccountFormState build() => ref.watch(
        AddAccountFormProvider.initialAddAccountForm,
      );

  Future<void> setName(
    String name,
  ) async {
    state = state.copyWith(
      name: name,
    );
    return;
  }

  void setError(
    String errorText,
  ) {
    state = state.copyWith(
      errorText: errorText,
    );
  }

  void setAddAccountProcessStep(AddAccountProcessStep addAccountProcessStep) {
    state = state.copyWith(
      addAccountProcessStep: addAccountProcessStep,
    );
  }

  bool controlName(
    BuildContext context,
  ) {
    if (state.name.trim().isEmpty) {
      state = state.copyWith(
        errorText:
            AppLocalization.of(context)!.introNewWalletGetFirstInfosNameBlank,
      );
      return false;
    }

    final accounts =
        ref.read(AccountProviders.sortedAccounts).valueOrNull ?? [];
    if (accounts
        .where((Account element) => element.name == state.name)
        .isNotEmpty) {
      state = state.copyWith(
        errorText: AppLocalization.of(context)!.addAccountExists,
      );
      return false;
    }

    return true;
  }

  Future<void> send(BuildContext context) async {
    final transactionRepository = ref.read(AddAccountFormProvider._repository);

    final localizations = AppLocalization.of(context)!;

    late Transaction transaction;

    transaction = Transaction.keychain(
      name: state.name,
      seed: state.seed,
    );

    transactionRepository.send(
      transaction: transaction,
      onConfirmation: (confirmation) async {
        EventTaxiImpl.singleton().fire(
          TransactionSendEvent(
            transactionType: TransactionSendEventType.keychain,
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
                transactionType: TransactionSendEventType.keychain,
                response: localizations.noConnection,
                nbConfirmations: 0,
              ),
            );
          },
          consensusNotReached: (_) {
            EventTaxiImpl.singleton().fire(
              TransactionSendEvent(
                transactionType: TransactionSendEventType.keychain,
                response: localizations.consensusNotReached,
                nbConfirmations: 0,
              ),
            );
          },
          timeout: (_) {
            EventTaxiImpl.singleton().fire(
              TransactionSendEvent(
                transactionType: TransactionSendEventType.keychain,
                response: localizations.transactionTimeOut,
                nbConfirmations: 0,
              ),
            );
          },
          invalidConfirmation: (_) {
            EventTaxiImpl.singleton().fire(
              TransactionSendEvent(
                transactionType: TransactionSendEventType.keychain,
                nbConfirmations: 0,
                maxConfirmations: 0,
                response: 'ko',
              ),
            );
          },
          other: (error) {
            EventTaxiImpl.singleton().fire(
              TransactionSendEvent(
                transactionType: TransactionSendEventType.keychain,
                response: localizations.genericError,
                nbConfirmations: 0,
              ),
            );
          },
          orElse: () {
            EventTaxiImpl.singleton().fire(
              TransactionSendEvent(
                transactionType: TransactionSendEventType.keychain,
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

abstract class AddAccountFormProvider {
  static final _repository = Provider<TransactionRemoteRepositoryInterface>(
    // TODO(Chralu): factorize that repository declaration
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
  static final initialAddAccountForm = _initialAddAccountFormProvider;
  static final addAccountForm = _addAccountFormProvider;
}
