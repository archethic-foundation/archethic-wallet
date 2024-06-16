import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/price_history/providers.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/tokens/tokens.dart';
import 'package:aewallet/domain/models/market_price_history.dart';
import 'package:aewallet/ui/views/tokens_list/bloc/state.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final _tokensListFormProvider =
    AutoDisposeNotifierProvider<TokensListFormNotifier, TokensListFormState>(
  TokensListFormNotifier.new,
);

class TokensListFormNotifier extends AutoDisposeNotifier<TokensListFormState> {
  TokensListFormNotifier();

  @override
  TokensListFormState build() {
    return const TokensListFormState(
      tokensToDisplay: AsyncValue.loading(),
    );
  }

  void reset() {
    state = state.copyWith(
      tokensToDisplay: const AsyncValue.data(<AEToken>[]),
    );
  }

  Future<void> setSearchCriteria(String searchCriteria) async {
    state = state.copyWith(searchCriteria: searchCriteria);
    await getTokensList(
      cancelToken: UniqueKey().toString(),
    );
  }

  Future<void> getTokensList({
    required String cancelToken,
  }) async {
    state = state.copyWith(
      tokensToDisplay: const AsyncValue.loading(),
      cancelToken: cancelToken,
    );

    final selectedAccount = await ref.read(
      AccountProviders.selectedAccount.future,
    );

    final tokensList = await ref.read(
      TokensProviders.getTokensList(selectedAccount!.genesisAddress).future,
    );

    final sortedTokens = tokensList.toList()
      ..sort((a, b) {
        if (a.address == null && b.address != null) return -1;
        if (a.address != null && b.address == null) return 1;

        if (a.isVerified && !b.isVerified) return -1;
        if (!a.isVerified && b.isVerified) return 1;

        if (!a.isLpToken && b.isLpToken) return -1;
        if (a.isLpToken && !b.isLpToken) return 1;

        final symbolComparison = a.symbol.compareTo(b.symbol);
        if (symbolComparison != 0) return symbolComparison;

        return 0;
      });

    if (state.searchCriteria.isNotEmpty) {
      sortedTokens.removeWhere(
        (element) =>
            element.symbol.toUpperCase().contains(state.searchCriteria) ==
                false &&
            element.address?.toUpperCase().contains(state.searchCriteria) ==
                false,
      );
    }

    if (state.cancelToken == cancelToken) {
      state = state.copyWith(
        tokensToDisplay: AsyncValue.data(sortedTokens),
      );
    }
  }

  Future<List<PriceHistoryValue>?> getPriceHistoryValues(
    String? coingeckoCoinId,
  ) async {
    List<PriceHistoryValue>? chartInfos;

    if (coingeckoCoinId != null && coingeckoCoinId.isNotEmpty) {
      final settings = ref.watch(SettingsProviders.settings);

      chartInfos = await ref.read(
        PriceHistoryProviders.priceHistory(
          scaleOption: settings.priceChartIntervalOption,
          coinId: coingeckoCoinId,
        ).future,
      );
    }
    return chartInfos;
  }
}

class TokensListFormProvider {
  static final tokensListForm = _tokensListFormProvider;
}
