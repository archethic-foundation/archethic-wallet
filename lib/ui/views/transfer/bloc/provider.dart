import 'package:aewallet/application/account.dart';
import 'package:aewallet/bus/transaction_send_event.dart';
import 'package:aewallet/domain/models/transfer.dart';
import 'package:aewallet/domain/repositories/transfer.dart';
import 'package:aewallet/domain/usecases/transaction/calculate_fees.dart';
import 'package:aewallet/infrastructure/repositories/transfer.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/address.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/ui/views/transfer/bloc/state.dart';
import 'package:aewallet/util/confirmations/transaction_sender.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/preferences.dart';
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
    AccountProviders.getSelectedAccount,
    TransferFormProvider._repository,
  ],
);

class TransferFormNotifier extends AutoDisposeNotifier<TransferFormState> {
  TransferFormNotifier();

  @override
  TransferFormState build() => ref.watch(
        TransferFormProvider.initialTransferForm,
      );

  Future<void> setRecipient({
    required BuildContext context,
    required TransferRecipient recipient,
  }) async {
    final fees = await _calculateFees(
      context: context,
      formState: state.copyWith(
        recipient: recipient,
      ),
    );

    state = state.copyWith(
      feeEstimation: fees ?? 0,
      recipient: recipient,
      errorAddressText: '',
      errorMessageText: '',
    );
  }

  Future<void> setRecipientNameOrAddress({
    required BuildContext context,
    required String text,
  }) async {
    if (!text.startsWith('@')) {
      setRecipient(
        context: context,
        recipient: TransferRecipient.address(address: Address(text)),
      );
      return;
    }

    try {
      final contact = await sl.get<DBHelper>().getContactWithName(text);
      setRecipient(
        context: context,
        recipient: TransferRecipient.contact(
          contact: contact,
        ),
      );
    } catch (e) {
      setRecipient(
        context: context,
        recipient: TransferRecipient.unknownContact(
          name: text,
        ),
      );
    }
  }

  Future<void> setContactAddress({
    required BuildContext context,
    required Address address,
  }) async {
    final contact =
        await sl.get<DBHelper>().getContactWithAddress(address.address);

    if (contact != null) {
      setRecipient(
        context: context,
        recipient: TransferRecipient.contact(contact: contact),
      );
    } else {
      setRecipient(
        context: context,
        recipient: TransferRecipient.address(
          address: address,
        ),
      );
    }
  }

  // TODO(Chralu): That operation should be delayed to avoid to spam backend.
  Future<double?> _calculateFees({
    required BuildContext context,
    required TransferFormState formState,
  }) async {
    final selectedAccount = ref.read(
      AccountProviders.getSelectedAccount(context: context),
    );

    final recipientAddress = formState.recipient.address;
    if (recipientAddress == null) return null;

    final calculateFeesResult = await CalculateFeesUsecase(
      repository: ref.read(TransferFormProvider._repository),
    ).run(
      Transfer.uco(
        accountSelectedName: selectedAccount!.name!,
        amount: formState.amount,
        message: formState.message,
        recipientAddress: recipientAddress,
        seed: formState.seed,
        tokenAddress: formState.accountToken?.tokenInformations!.address,
      ),
    );

    return calculateFeesResult.valueOrNull;
  }

  Future<void> setMaxAmount({
    required BuildContext context,
  }) async {
    final balance = state.accountBalance;

    final fees = await _calculateFees(
      context: context,
      formState: state.copyWith(amount: balance),
    );

    if (fees == null) {
      return;
    }

    state = state.copyWith(
      amount: balance - fees,
      feeEstimation: fees,
      errorAmountText: '',
    );
  }

  Future<void> setAmount({
    required BuildContext context,
    required double amount,
  }) async {
    final balance = state.accountBalance;

    final fees = await _calculateFees(
      context: context,
      formState: state.copyWith(
        amount: amount,
      ),
    );

    if (fees == null) {
      state = state.copyWith(
        amount: amount,
        feeEstimation: 0,
        errorAmountText: '',
      );
      return;
    }

    if (amount > balance - fees) {
      state = state.copyWith(
        errorAmountText:
            AppLocalization.of(context)!.insufficientBalance.replaceAll(
                  '%1',
                  state.symbol(context),
                ),
      );
      return;
    }

    state = state.copyWith(
      amount: amount,
      feeEstimation: fees,
      accountBalance: balance,
      errorAmountText: '',
    );
  }

  Future<void> setMessage({
    required BuildContext context,
    required String message,
  }) async {
    final fees = await _calculateFees(
      context: context,
      formState: state.copyWith(
        message: message,
      ),
    );

    state = state.copyWith(
      message: message.trim(),
      feeEstimation: fees ?? 0,
    );
  }

  void setTransferProcessStep(TransferProcessStep transferProcessStep) {
    state = state.copyWith(
      transferProcessStep: transferProcessStep,
    );
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

    if (state.transferType == TransferType.uco) {
      if (state.amount + state.feeEstimation >
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
    } else {
      if (state.feeEstimation > accountSelected.balance!.nativeTokenValue!) {
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
    final localizations = AppLocalization.of(context)!;

    final preferences = await Preferences.getInstance();

    final TransactionSenderInterface transactionSender =
        ArchethicTransactionSender(
      phoenixHttpEndpoint: await preferences.getNetwork().getPhoenixHttpLink(),
      websocketEndpoint: await preferences.getNetwork().getWebsocketUri(),
    );

    transactionSender.send(
      transaction: state.transaction!,
      onConfirmation: (confirmation) async {
        EventTaxiImpl.singleton().fire(
          TransactionSendEvent(
            transactionType: TransactionSendEventType.transfer,
            response: 'ok',
            nbConfirmations: confirmation.nbConfirmations,
            transactionAddress: state.transaction!.address,
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
  static final _repository = Provider<TransferRepositoryInterface>(
    (ref) => ArchethicTransferRepository(),
  );
  static final initialTransferForm = _initialTransferFormProvider;
  static final transferForm = _transferFormProvider;
}
