part of 'onramp.dart';

@riverpod
class OnRampProviderOrders extends _$OnRampProviderOrders {
  @override
  List<OnRampProviderOrder> build() => [];

  void add(OnRampProviderOrder order) {
    if (state.any(
      (element) => _isSameOrder(element, order),
    )) {
      return;
    }

    state = [
      ...state,
      order,
    ];
  }

  void dismiss(OnRampProviderOrder order) {
    state = state.whereNot((element) => _isSameOrder(element, order)).toList();
  }

  bool _isSameOrder(OnRampProviderOrder o1, OnRampProviderOrder o2) =>
      o1.orderId == o2.orderId && o1.onRampProvider == o2.onRampProvider;
}

@riverpod
OnRampProviderRepository onrampProviderRepository(
  Ref ref,
  OnRampProvider onRampProvider,
) {
  return switch (ref.watch(environmentProvider)) {
    Environment.mainnet => OnRampProviderTransakRepository.production(),
    Environment.testnet => OnRampProviderTransakRepository.staging(),
    Environment.devnet =>
      throw Exception('OnRampTransak not available on Devnet'),
  };
}

@riverpod
Future<List<OnRampProviderToken>> onrampProviderTokens(
  Ref ref,
  OnRampProvider onRampProvider,
) async {
  final providerRepository =
      ref.watch(onrampProviderRepositoryProvider(onRampProvider));

  final providerTokens = await providerRepository.tokens();

  final evmSetup = await ref.watch(onrampEvmSetupProvider.future);

  return providerTokens
      .where(
        (providerToken) => evmSetup.chains.any(
          (chain) =>
              chain.chainId == providerToken.chain.chainId &&
              chain.tokens
                  .any((token) => token.address == providerToken.address),
        ),
      )
      .toList();
}

@riverpod
Future<OnRampProviderToken?> onrampProviderFavoriteToken(
  Ref ref,
  OnRampProvider onRampProvider,
) async {
  final tokens = await ref.watch(
    onrampProviderTokensProvider(onRampProvider).future,
  );

  return tokens.firstOrNull;
}
