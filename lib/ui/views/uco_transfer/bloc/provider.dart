import 'package:aewallet/model/data/contact.dart';
import 'package:aewallet/ui/views/uco_transfer/bloc/model.dart';
import 'package:aewallet/ui/views/uco_transfer/bloc/transaction_builder.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart'
    show
        ApiService,
        fromBigInt,
        toBigInt,
        uint8ListToHex,
        UCOTransfer,
        TokenTransfer;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _transferProvider =
    StateNotifierProvider<TransferNotifier, Transfer>((ref) {
  return TransferNotifier(const Transfer());
});

class TransferNotifier extends StateNotifier<Transfer> {
  TransferNotifier(
    super.state,
  );

  void setContact(Contact contact) {
    state = state.copyWith(
      isContact: true,
      contactRecipient: contact,
    );
  }

  void setAddress(String address) {
    final isContact = address.startsWith('@');
    if (isContact) {
      state = state.copyWith(
        isContact: isContact,
      );
    } else {
      // TODO(reddwarf03): Ajouter controle adresse + détermination contact address
      state = state.copyWith(
        addressRecipient: address,
        isContact: isContact,
      );
    }
  }

  void setAmount(double amount) {
    state = state.copyWith(amount: amount);
  }

  void setMessage(String message) {
    state = state.copyWith(message: message.trim());
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
    if (state.amount <= 0 || state.addressRecipient.isEmpty) {
      state = state.copyWith(
        feeEstimation: 0,
      );
      return;
    }

    await _buildTransaction(seed, accountSelectedName);
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
      String seed, String accountSelectedName,) async {
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
      tokenTransferList: <TokenTransfer>[
        // TODO(reddwarf03): Add token address and id
        TokenTransfer(
          amount: toBigInt(state.amount),
          to: state.addressRecipient,
        )
      ],
      ucoTransferList: <UCOTransfer>[
        UCOTransfer(amount: toBigInt(state.amount), to: state.addressRecipient)
      ],
    );
    state = state.copyWith(
      transaction: transaction,
    );
  }
}

abstract class TransferProvider {
  static final transfer = _transferProvider;
}
