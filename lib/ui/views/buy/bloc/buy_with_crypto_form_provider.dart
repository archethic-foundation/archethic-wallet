import 'package:aewallet/application/onramp/onramp.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'buy_with_crypto_form_provider.freezed.dart';
part 'buy_with_crypto_form_provider.g.dart';

extension OnRampTokenToDisplayData on OnRampToken {
  OnRampTokenDisplayData get displayData =>
      (iconUrl: iconUrl, symbol: symbol, name: name);
}

typedef OnRampTokenDisplayData = ({
  String iconUrl,
  String symbol,
  String name,
});

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
    final tokens = await ref.read(onrampTokensProvider.future);
    return BuyWithCryptoFormState(
      selectedToken: tokens.firstOrNull?.displayData,
      depositAddressVisible: false,
    );
  }

  Future<void> selectToken(OnRampTokenDisplayData token) async {
    await update((state) async {
      if (state.selectedToken == token) return state;

      final chains =
          await ref.read(onrampChainsForTokenProvider(token.symbol).future);
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

      final selectedTokenForNewChain = switch (state.selectedToken) {
        null => null,
        final selectedToken => await ref
            .read(
              onrampTokenFromDisplayDataProvider(selectedToken, chain.id)
                  .future,
            )
            .then((token) => token?.displayData),
      };

      return state.copyWith(
        depositAddressVisible: false,
        selectedChain: chain,
        selectedToken: selectedTokenForNewChain,
      );
    });
  }

  void showDepositAddress() {
    update((state) => state.copyWith(depositAddressVisible: true));
  }
}

@riverpod
Future<List<OnRampTokenDisplayData>> onrampTokenDisplayData(
  Ref ref,
) async {
  final tokens = await ref.watch(onrampTokensProvider.future);
  return tokens.map((token) => token.displayData).toSet().toList();
}

@riverpod
Future<OnRampToken?> onrampTokenFromDisplayData(
  Ref ref,
  OnRampTokenDisplayData tokenDisplayData,
  String chainId,
) async {
  final setup = await ref.watch(onrampSetupProvider.future);
  return setup.chains
      .firstWhereOrNull((chain) => chain.id == chainId)
      ?.tokens
      .firstWhereOrNull(
        (token) =>
            token.symbol == tokenDisplayData.symbol &&
            token.iconUrl == tokenDisplayData.iconUrl,
      );
}
