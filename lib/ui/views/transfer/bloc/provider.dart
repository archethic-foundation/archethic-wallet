import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/settings/primary_currency.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/bus/transaction_send_event.dart';
import 'package:aewallet/domain/models/transaction.dart';
import 'package:aewallet/domain/models/transfer.dart';
import 'package:aewallet/domain/repositories/transaction_remote.dart';
import 'package:aewallet/domain/usecases/transaction/calculate_fees.dart';
import 'package:aewallet/infrastructure/repositories/archethic_transaction.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/address.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/ui/util/delayed_task.dart';
import 'package:aewallet/ui/views/transfer/bloc/state.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final _initialTransferFormProvider = Provider<TransferFormState>(
  (ref) {
    throw UnimplementedError();
  },
);

final _transferFormProvider =
    NotifierProvider.autoDispose<TransferFormNotifier, TransferFormState>(
  () {
    return TransferFormNotifier();
  },
  dependencies: [
    TransferFormProvider.initialTransferForm,
    AccountProviders.selectedAccount,
    TransferFormProvider._repository,
    PrimaryCurrencyProviders.selectedPrimaryCurrency,
  ],
);

class TransferFormNotifier extends AutoDisposeNotifier<TransferFormState> {
  TransferFormNotifier();

  CancelableTask<double?>? _calculateFeesTask;

  Future<void> _updateFees(
    BuildContext context, {
    Duration delay = const Duration(milliseconds: 800),
  }) async {
    state = state.copyWith(
      feeEstimation: const AsyncValue.loading(),
    );

    late final double fees;
    switch (state.transferType) {
      case TransferType.uco:
        var amountInUCO = state.amount;
        final primaryCurrency =
            ref.read(PrimaryCurrencyProviders.selectedPrimaryCurrency);
        if (primaryCurrency.primaryCurrency ==
            AvailablePrimaryCurrencyEnum.fiat) {
          amountInUCO = state.amountConverted;
        }

        try {
          fees = await Future<double>(
            () async {
              if (amountInUCO <= 0 || !state.recipient.isAddressValid) {
                return 0; // TODO(Chralu): should we use an error class instead ?
              }

              _calculateFeesTask?.cancel();
              _calculateFeesTask = CancelableTask<double?>(
                task: () => _calculateFees(
                  context: context,
                  formState: state.copyWith(
                    amount: amountInUCO,
                  ),
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
          errorAmountText:
              amountInUCO > state.accountBalance.nativeTokenValue! - fees
                  ? AppLocalization.of(context)!.insufficientBalance.replaceAll(
                        '%1',
                        state.symbol(context),
                      )
                  : '',
        );
        break;
      case TransferType.token:
        try {
          fees = await Future<double>(
            () async {
              if (state.amount <= 0 || !state.recipient.isAddressValid) {
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
          errorAmountText: state.amount > state.accountToken!.amount!
              ? AppLocalization.of(context)!.insufficientBalance.replaceAll(
                    '%1',
                    state.symbol(context),
                  )
              : fees > state.accountBalance.nativeTokenValue!
                  ? AppLocalization.of(context)!.insufficientBalance.replaceAll(
                        '%1',
                        state.symbolFees(context),
                      )
                  : '',
        );
        break;

      case TransferType.nft:
        try {
          fees = await Future<double>(
            () async {
              if (!state.recipient.isAddressValid) {
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
          errorAmountText: fees > state.accountBalance.nativeTokenValue!
              ? AppLocalization.of(context)!.insufficientBalance.replaceAll(
                    '%1',
                    state.symbolFees(context),
                  )
              : '',
        );
        break;
    }
  }

  @override
  TransferFormState build() => ref.watch(
        TransferFormProvider.initialTransferForm,
      );

  void _setRecipient({
    required TransferRecipient recipient,
  }) {
    state = state.copyWith(
      recipient: recipient,
      errorAddressText: '',
      errorMessageText: '',
      errorAmountText: '',
    );
  }

  Future<void> setRecipientNameOrAddress({
    required BuildContext context,
    required String text,
  }) async {
    if (!text.startsWith('@')) {
      _setRecipient(
        recipient: TransferRecipient.address(address: Address(text)),
      );
      _updateFees(context);
      return;
    }

    try {
      final contact = await sl.get<DBHelper>().getContactWithName(text);
      _setRecipient(
        recipient: TransferRecipient.contact(
          contact: contact,
        ),
      );
    } catch (e) {
      _setRecipient(
        recipient: TransferRecipient.unknownContact(
          name: text,
        ),
      );
    }
    _updateFees(context);
  }

  Future<void> setRecipient({
    required BuildContext context,
    required TransferRecipient contact,
  }) async {
    _setRecipient(
      recipient: contact,
    );
    _updateFees(
      context,
      delay: Duration.zero,
    );
  }

  Future<void> setContactAddress({
    required BuildContext context,
    required Address address,
  }) async {
    final contact = await sl.get<DBHelper>().getContactWithAddress(
          address.address,
        );

    if (contact != null) {
      _setRecipient(
        recipient: TransferRecipient.contact(contact: contact),
      );
    } else {
      _setRecipient(
        recipient: TransferRecipient.address(
          address: address,
        ),
      );
    }
    _updateFees(
      context,
      delay: Duration.zero,
    );
  }

  // TODO(Chralu): That operation should be delayed to avoid to spam backend.
  Future<double?> _calculateFees({
    required BuildContext context,
    required TransferFormState formState,
  }) async {
    final selectedAccount = await ref.read(
      AccountProviders.selectedAccount.future,
    );
    final recipientAddress = formState.recipient.address;
    if (recipientAddress == null) return null;

    late Transaction transaction;

    switch (state.transferType) {
      case TransferType.token:
        transaction = Transaction.transfer(
          transfer: Transfer.token(
            accountSelectedName: selectedAccount!.name,
            amount: formState.amount,
            message: formState.message,
            recipientAddress: recipientAddress,
            seed: formState.seed,
            tokenAddress: formState.accountToken?.tokenInformations!.address,
            type: 'fungible',
            tokenId: 0,
            properties:
                formState.accountToken?.tokenInformations!.tokenProperties ??
                    {},
          ),
        );
        break;
      case TransferType.uco:
        transaction = Transaction.transfer(
          transfer: Transfer.uco(
            accountSelectedName: selectedAccount!.name,
            amount: formState.amount,
            message: formState.message,
            recipientAddress: recipientAddress,
            seed: formState.seed,
          ),
        );
        break;
      case TransferType.nft:
        transaction = Transaction.transfer(
          transfer: Transfer.token(
            accountSelectedName: selectedAccount!.name,
            amount: formState.amount,
            message: formState.message,
            recipientAddress: recipientAddress,
            seed: formState.seed,
            tokenAddress: formState.accountToken?.tokenInformations!.address,
            type: 'non-fungible',
            tokenId: 1,
            properties:
                formState.accountToken?.tokenInformations!.tokenProperties ??
                    {},
          ),
        );
        break;
    }

    final calculateFeesResult = await CalculateFeesUsecase(
      repository: ref.read(TransferFormProvider._repository),
    ).run(transaction);

    return calculateFeesResult.valueOrNull;
  }

  Future<void> setMaxAmount({
    required BuildContext context,
    double? tokenPrice,
  }) async {
    if (state.transferType == TransferType.token &&
        state.accountToken != null &&
        state.accountToken!.amount != null) {
      final fees = await _calculateFees(
        context: context,
        formState: state.copyWith(
          amount: state.accountToken!.amount!,
        ),
      );
      if (fees == null) {
        return;
      }
      state = state.copyWith(
        feeEstimation: AsyncValue.data(fees),
        amount: state.accountToken!.amount!,
        errorAmountText: '',
      );

      return;
    }

    final balance = state.accountBalance;

    final fees = await _calculateFees(
      context: context,
      formState: state.copyWith(amount: balance.nativeTokenValue ?? 0),
    );

    if (fees == null) {
      return;
    }

    final primaryCurrency =
        ref.read(PrimaryCurrencyProviders.selectedPrimaryCurrency);

    switch (primaryCurrency.primaryCurrency) {
      case AvailablePrimaryCurrencyEnum.fiat:
        var amountMax = 0.0;
        if (tokenPrice != null) {
          amountMax = (balance.nativeTokenValue! - fees) * tokenPrice;
          state = state.copyWith(
            amount: amountMax,
            amountConverted: balance.nativeTokenValue! - fees,
            feeEstimation: AsyncValue.data(fees),
            errorAmountText: '',
          );
        }
        break;
      case AvailablePrimaryCurrencyEnum.native:
        state = state.copyWith(
          amount: balance.nativeTokenValue! - fees,
          feeEstimation: AsyncValue.data(fees),
          errorAmountText: '',
        );
        break;
    }
  }

  Future<void> setAmount({
    required BuildContext context,
    required double amount,
    double? tokenPrice,
  }) async {
    if (state.transferType == TransferType.token) {
      state = state.copyWith(
        amount: amount,
        amountConverted: 0,
        errorAmountText: '',
      );
      _updateFees(context);
      return;
    }

    var amountConverted = 0.0;
    if (amount > 0 && tokenPrice != null) {
      amountConverted = ref.read(
        PrimaryCurrencyProviders.convertedValue(
          amount: amount,
          tokenPrice: tokenPrice,
        ),
      );
    }

    state = state.copyWith(
      amount: amount,
      amountConverted: amountConverted,
      errorAmountText: '',
    );

    _updateFees(context);
  }

  Future<void> setDefineMaxAmountInProgress({
    required bool defineMaxAmountInProgress,
  }) async {
    state = state.copyWith(
      defineMaxAmountInProgress: defineMaxAmountInProgress,
    );
  }

  Future<void> setMessage({
    required BuildContext context,
    required String message,
  }) async {
    state = state.copyWith(
      message: message.trim(),
    );
    _updateFees(context);
  }

  void setTransferProcessStep(TransferProcessStep transferProcessStep) {
    state = state.copyWith(
      transferProcessStep: transferProcessStep,
    );
  }

  bool controlMaxSend(
    BuildContext context,
  ) {
    if (state.transferType == TransferType.uco &&
        (state.recipient.address == null ||
            state.recipient.address!.address.isEmpty)) {
      state = state.copyWith(
        errorAmountText: AppLocalization.of(context)!.maxSendRecipientMissing,
      );
      return false;
    }
    return true;
  }

  bool controlAmount(
    BuildContext context,
    Account accountSelected,
  ) {
    if (state.amount <= 0) {
      state = state.copyWith(
        errorAmountText: AppLocalization.of(context)!.amountZero,
      );
      return false;
    }

    final feeEstimation = state.feeEstimation.valueOrNull ?? 0;

    switch (state.transferType) {
      case TransferType.uco:
        var amountInUCO = state.amount;
        final primaryCurrency =
            ref.read(PrimaryCurrencyProviders.selectedPrimaryCurrency);
        if (primaryCurrency.primaryCurrency ==
            AvailablePrimaryCurrencyEnum.fiat) {
          amountInUCO = state.amountConverted;
        }

        if (amountInUCO + feeEstimation >
            accountSelected.balance!.nativeTokenValue!) {
          state = state.copyWith(
            errorAmountText:
                AppLocalization.of(context)!.insufficientBalance.replaceAll(
                      '%1',
                      state.symbol(context),
                    ),
          );
          return false;
        }
        break;
      case TransferType.token:
        if (feeEstimation > accountSelected.balance!.nativeTokenValue!) {
          state = state.copyWith(
            errorAmountText:
                AppLocalization.of(context)!.insufficientBalance.replaceAll(
                      '%1',
                      state.symbol(context),
                    ),
          );
          return false;
        }

        if (state.amount > state.accountToken!.amount!) {
          state = state.copyWith(
            errorAmountText:
                AppLocalization.of(context)!.insufficientBalance.replaceAll(
                      '%1',
                      state.symbol(context),
                    ),
          );
          return false;
        }
        break;
      case TransferType.nft:
        if (feeEstimation > accountSelected.balance!.nativeTokenValue!) {
          state = state.copyWith(
            errorAmountText:
                AppLocalization.of(context)!.insufficientBalance.replaceAll(
                      '%1',
                      state.symbolFees(context),
                    ),
          );
          return false;
        }

        if (state.amount > state.accountToken!.amount!) {
          state = state.copyWith(
            errorAmountText:
                AppLocalization.of(context)!.insufficientBalance.replaceAll(
                      '%1',
                      'NFT',
                    ),
          );
          return false;
        }
        break;
    }

    state = state.copyWith(
      errorAmountText: '',
    );
    return true;
  }

  Future<bool> controlAddress(
    BuildContext context,
    Account accountSelected,
  ) async {
    final error = state.recipient.when(
      address: (address) {
        if (address.address.isEmpty) {
          return AppLocalization.of(context)!.addressMissing;
        }
        if (!address.isValid) {
          return AppLocalization.of(context)!.invalidAddress;
        }
        if (accountSelected.lastAddress == address.address) {
          return AppLocalization.of(context)!.sendToMeError.replaceAll(
                '%1',
                state.symbol(context),
              );
        }
      },
      contact: (contact) {
        if (contact.address.isEmpty) {
          return AppLocalization.of(context)!.addressMissing;
        }

        if (!Address(contact.address).isValid) {
          return AppLocalization.of(context)!.invalidAddress;
        }

        if (accountSelected.lastAddress == contact.address) {
          return AppLocalization.of(context)!.sendToMeError.replaceAll(
                '%1',
                state.symbol(context),
              );
        }
      },
      unknownContact: (_) {
        return AppLocalization.of(context)!.contactInvalid;
      },
    );

    if (error == null) return true;

    state = state.copyWith(
      errorAddressText: error,
    );
    return false;
  }

  Future<void> send(BuildContext context) async {
    final transferRepository = ref.read(TransferFormProvider._repository);

    final localizations = AppLocalization.of(context)!;

    final selectedAccount = await ref.read(
      AccountProviders.selectedAccount.future,
    );

    var amountInUCO = state.amount;
    final primaryCurrency =
        ref.read(PrimaryCurrencyProviders.selectedPrimaryCurrency);
    if (primaryCurrency.primaryCurrency == AvailablePrimaryCurrencyEnum.fiat) {
      amountInUCO = state.amountConverted;
    }

    late Transaction transaction;

    switch (state.transferType) {
      case TransferType.token:
        transaction = Transaction.transfer(
          transfer: Transfer.token(
            accountSelectedName: selectedAccount!.name,
            amount: amountInUCO,
            message: state.message,
            recipientAddress: state.recipient.address!,
            seed: state.seed,
            tokenAddress: state.accountToken?.tokenInformations!.address,
            type: 'fungible',
            tokenId: 0,
            properties:
                state.accountToken?.tokenInformations!.tokenProperties ?? {},
          ),
        );
        break;
      case TransferType.uco:
        transaction = Transaction.transfer(
          transfer: Transfer.uco(
            accountSelectedName: selectedAccount!.name,
            amount: amountInUCO,
            message: state.message,
            recipientAddress: state.recipient.address!,
            seed: state.seed,
          ),
        );
        break;
      case TransferType.nft:
        transaction = Transaction.transfer(
          transfer: Transfer.token(
            accountSelectedName: selectedAccount!.name,
            amount: amountInUCO,
            message: state.message,
            recipientAddress: state.recipient.address!,
            seed: state.seed,
            tokenAddress: state.accountToken?.tokenInformations!.address,
            type: 'non-fungible',
            tokenId: 1,
            properties:
                state.accountToken?.tokenInformations!.tokenProperties ?? {},
          ),
        );
        break;
    }

    transferRepository.send(
      transaction: transaction,
      onConfirmation: (confirmation) async {
        EventTaxiImpl.singleton().fire(
          TransactionSendEvent(
            transactionType: TransactionSendEventType.transfer,
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
                transactionType: TransactionSendEventType.transfer,
                response: localizations.noConnection,
                nbConfirmations: 0,
              ),
            );
          },
          invalidConfirmation: (_) {
            EventTaxiImpl.singleton().fire(
              TransactionSendEvent(
                transactionType: TransactionSendEventType.transfer,
                nbConfirmations: 0,
                maxConfirmations: 0,
                response: 'ko',
              ),
            );
          },
          insufficientFunds: (error) {
            EventTaxiImpl.singleton().fire(
              TransactionSendEvent(
                transactionType: TransactionSendEventType.transfer,
                response: localizations.insufficientBalance.replaceAll(
                  '%1',
                  state.symbol(context),
                ),
                nbConfirmations: 0,
              ),
            );
          },
          other: (error) {
            EventTaxiImpl.singleton().fire(
              TransactionSendEvent(
                transactionType: TransactionSendEventType.transfer,
                response: localizations.keychainNotExistWarning,
                nbConfirmations: 0,
              ),
            );
          },
          orElse: () {
            EventTaxiImpl.singleton().fire(
              TransactionSendEvent(
                transactionType: TransactionSendEventType.transfer,
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

abstract class TransferFormProvider {
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
  static final initialTransferForm = _initialTransferFormProvider;
  static final transferForm = _transferFormProvider;
}
