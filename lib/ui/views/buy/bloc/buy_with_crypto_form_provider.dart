import 'package:aewallet/application/onramp/onramp.dart';
import 'package:aewallet/domain/models/onramp.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'buy_with_crypto_form_provider.freezed.dart';
part 'buy_with_crypto_form_provider.g.dart';

extension OnRampTokenDisplayDataExt on OnRampTokenDisplayData {
  String get desc => '$symbol ($name)';
}

@freezed
class BuyWithCryptoFormState with _$BuyWithCryptoFormState {
  const factory BuyWithCryptoFormState({
    OnRampTokenDisplayData? selectedToken,
    OnRampChain? selectedChain,
    required bool depositAddressVisible,
  }) = _BuyWithCryptoFormState;
  const BuyWithCryptoFormState._();

  bool get canShowDepositAddress =>
      selectedToken != null && selectedChain != null;
}

@riverpod
class BuyWithCryptoForm extends _$BuyWithCryptoForm {
  @override
  Future<BuyWithCryptoFormState> build() async {
    final tokens = await ref.read(onrampTokenDisplayDataProvider.future);
    return BuyWithCryptoFormState(
      selectedToken: tokens.firstOrNull,
      depositAddressVisible: false,
    );
  }

  Future<void> selectToken(OnRampTokenDisplayData token) async {
    await update((state) async {
      if (state.selectedToken == token) return state;

      final chains =
          await ref.read(onrampChainsForTokenProvider(token.id).future);
      final selectedChainStillValid = chains.any(
        (chain) => chain == state.selectedChain,
      );
      return state.copyWith(
        depositAddressVisible: false,
        selectedToken: token,
        selectedChain: selectedChainStillValid ? state.selectedChain : null,
      );
    });
  }

  Future<void> selectChain(OnRampChain chain) async {
    await update((state) async {
      if (state.selectedChain == chain) return state;

      return state.copyWith(
        depositAddressVisible: false,
        selectedChain: chain,
        selectedToken: await _selectedTokenForNewChain(state, chain.id),
      );
    });
  }

  Future<OnRampTokenDisplayData?> _selectedTokenForNewChain(
    BuyWithCryptoFormState state,
    String chainId,
  ) async {
    final selectedToken = state.selectedToken;
    if (selectedToken == null) return null;

    final tokenAvailable = await ref.read(
      onrampTokenAvailableForChainProvider(selectedToken.id, chainId).future,
    );
    if (!tokenAvailable) {
      return null;
    }
    return selectedToken;
  }

  void showDepositAddress() {
    update((state) => state.copyWith(depositAddressVisible: true));
  }
}

@riverpod
Future<List<OnRampTokenDisplayData>> onrampTokenDisplayData(
  Ref ref,
) async {
  final setup = await ref.watch(onrampEvmSetupProvider.future);
  return setup.tokensDisplayData;
}

@riverpod
Future<bool> onrampTokenAvailableForChain(
  Ref ref,
  String tokenId,
  String chainId,
) async {
  final setup = await ref.watch(onrampEvmSetupProvider.future);
  return setup.chains
          .firstWhereOrNull((chain) => chain.id == chainId)
          ?.tokens
          .any(
            (token) => token.id == tokenId,
          ) ??
      false;
}
