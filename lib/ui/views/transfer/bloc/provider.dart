import 'package:aewallet/localization.dart';
import 'package:aewallet/model/address.dart';
import 'package:aewallet/model/data/account.dart';
import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/ui/views/transfer/bloc/model.dart';
import 'package:aewallet/ui/views/transfer/bloc/transaction_builder.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart'
    show
        ApiService,
        fromBigInt,
        toBigInt,
        uint8ListToHex,
        UCOTransfer,
        TokenTransfer;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _initialTransferProvider = Provider.autoDispose<TransferFormData>(
  (ref) {
    throw UnimplementedError();
  },
);

final _transferProvider =
    StateNotifierProvider.autoDispose<TransferNotifier, TransferFormData>(
  (ref) {
    final initialTransfer = ref.watch(TransferProvider.initialTransfer);
    return TransferNotifier(initialTransfer);
  },
  dependencies: [TransferProvider.initialTransfer],
);

class TransferNotifier extends StateNotifier<TransferFormData> {
  TransferNotifier(
    super.state,
  );

  void setContact(Contact? contact) {
    state = state.copyWith(
      contactRecipient: contact,
      isContactKnown: true,
      errorAddressText: '',
      errorAmountText: '',
      errorMessageText: '',
    );
  }

  void setContactKnown(bool isContactKnown) {
    state = state.copyWith(
      isContactKnown: isContactKnown,
    );
  }

  void setMaxSend(bool sendMax) {
    state = state.copyWith(
      isMaxSend: sendMax,
    );
  }

  void setAddress(String address) {
    state = state.copyWith(
      addressRecipient: address,
      errorAddressText: '',
      errorAmountText: '',
      errorMessageText: '',
    );
  }

  void setAmount(double amount, double balance) {
    if (amount + state.feeEstimation == balance) {
      state = state.copyWith(
        amount: amount,
        errorAddressText: '',
        errorAmountText: '',
        errorMessageText: '',
        isMaxSend: true,
      );
    } else {
      state = state.copyWith(
        amount: amount,
        errorAddressText: '',
        errorAmountText: '',
        errorMessageText: '',
        isMaxSend: false,
      );
    }
  }

  void setMessage(String message) {
    state = state.copyWith(
      message: message.trim(),
      errorMessageText: '',
    );
  }

  void setTransferProcessStep(TransferProcessStep transferProcessStep) {
    state = state.copyWith(
      transferProcessStep: transferProcessStep,
    );
  }

  void isMaxSend(
    double? nativeTokenValue,
    double? fiatCurrencyValue,
    double balance,
  ) {
    if (state.amount <= 0) {
      state = state.copyWith(isMaxSend: false);
      return;
    }

    if (state.amount + state.feeEstimation == balance) {
      state = state.copyWith(isMaxSend: true);
    } else {
      state = state.copyWith(isMaxSend: false);
    }
  }

  Future<void> calculateFees(String seed, String accountSelectedName) async {
    if (state.amount <= 0) {
      state = state.copyWith(
        feeEstimation: 0,
      );
      return;
    }

    if (state.contactRecipient != null &&
        (state.contactRecipient!.address!.isEmpty ||
            Address(state.contactRecipient!.address!).isValid() == false)) {
      state = state.copyWith(
        feeEstimation: 0,
      );
      return;
    }

    if (state.contactRecipient == null &&
        (state.addressRecipient.isEmpty ||
            Address(state.addressRecipient).isValid() == false)) {
      state = state.copyWith(
        feeEstimation: 0,
      );
      return;
    }

    try {
      await _buildTransaction(seed, accountSelectedName);
    } catch (e) {
      state = state.copyWith(
        feeEstimation: 0,
        errorAmountText: e.toString(),
      );
      return;
    }

    final transactionFee =
        await sl.get<ApiService>().getTransactionFee(state.transaction!);
    if (transactionFee.errors != null) {
      state = state.copyWith(
        feeEstimation: 0,
      );
      return;
    }

    state = state.copyWith(
      feeEstimation: fromBigInt(transactionFee.fee).toDouble(),
    );
  }

  Future<void> _buildTransaction(
    String seed,
    String accountSelectedName,
  ) async {
    final originPrivateKey = sl.get<ApiService>().getOriginKey();
    final keychain = await sl.get<ApiService>().getKeychain(seed);

    final nameEncoded = Uri.encodeFull(
      accountSelectedName,
    );
    final service = 'archethic-wallet-$nameEncoded';
    final index = (await sl.get<ApiService>().getTransactionIndex(
              uint8ListToHex(
                keychain.deriveAddress(
                  service,
                ),
              ),
            ))
        .chainLength!;

    final transaction = await TransferTransactionBuilder.build(
      message: state.message,
      index: index,
      keychain: keychain,
      originPrivateKey: originPrivateKey,
      serviceName: service,
      tokenTransferList: state.transferType == TransferType.token
          ? <TokenTransfer>[
              TokenTransfer(
                amount: toBigInt(state.amount),
                to: state.contactRecipient == null
                    ? state.addressRecipient
                    : state.contactRecipient!.address!,
                tokenAddress: state.accountToken!.tokenInformations!.address,
                tokenId: 0,
              )
            ]
          : state.transferType == TransferType.nft
              ? <TokenTransfer>[
                  TokenTransfer(
                    amount: toBigInt(state.amount),
                    to: state.contactRecipient == null
                        ? state.addressRecipient
                        : state.contactRecipient!.address!,
                    tokenAddress:
                        state.accountToken!.tokenInformations!.address,
                    // TODO(reddwarf03) : to fix nft management
                    tokenId: 0,
                  )
                ]
              : <TokenTransfer>[],
      ucoTransferList: state.transferType == TransferType.uco
          ? <UCOTransfer>[
              UCOTransfer(
                amount: toBigInt(state.amount),
                to: state.contactRecipient == null
                    ? state.addressRecipient
                    : state.contactRecipient!.address!,
              )
            ]
          : <UCOTransfer>[],
    );
    state = state.copyWith(
      transaction: transaction,
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
                    state.symbol,
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
                    state.symbol,
                  ),
        );
        return false;
      }

      if (state.amount > state.accountToken!.amount!) {
        state = state.copyWith(
          errorAmountText:
              AppLocalization.of(context)!.insufficientBalance.replaceAll(
                    '%1',
                    state.symbol,
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
    if (state.contactRecipient == null) {
      if (state.addressRecipient.isEmpty) {
        state = state.copyWith(
          errorAddressText: AppLocalization.of(context)!.addressMissing,
        );
        return false;
      }

      if (Address(state.addressRecipient).isValid() == false) {
        state = state.copyWith(
          errorAddressText: AppLocalization.of(context)!.invalidAddress,
        );
        return false;
      }

      if (accountSelected.lastAddress == state.addressRecipient) {
        state = state.copyWith(
          errorAddressText: AppLocalization.of(context)!
              .sendToMeError
              .replaceAll('%1', state.symbol),
        );
        return false;
      }
    } else {
      if (state.isContactKnown == false) {
        state = state.copyWith(
          errorAddressText: AppLocalization.of(context)!.contactInvalid,
        );
        return false;
      }

      if (state.contactRecipient!.address == null ||
          state.contactRecipient!.address!.isEmpty) {
        state = state.copyWith(
          errorAddressText: AppLocalization.of(context)!.addressMissing,
        );
        return false;
      }

      if (Address(state.contactRecipient!.address!).isValid() == false) {
        state = state.copyWith(
          errorAddressText: AppLocalization.of(context)!.invalidAddress,
        );
        return false;
      }

      if (accountSelected.lastAddress == state.contactRecipient!.address) {
        state = state.copyWith(
          errorAddressText: AppLocalization.of(context)!
              .sendToMeError
              .replaceAll('%1', state.symbol),
        );
        return false;
      }
    }

    state = state.copyWith(
      errorAddressText: '',
    );
    return true;
  }
}

abstract class TransferProvider {
  static final initialTransfer = _initialTransferProvider;
  static final transfer = _transferProvider;
}
