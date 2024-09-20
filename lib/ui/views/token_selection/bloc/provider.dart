import 'package:aewallet/modules/aeswap/application/dex_token.dart';
import 'package:aewallet/ui/views/token_selection/bloc/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _tokenSelectionFormProvider = NotifierProvider.autoDispose<
    TokenSelectionFormNotifier, TokenSelectionFormState>(
  () {
    return TokenSelectionFormNotifier();
  },
);

class TokenSelectionFormNotifier
    extends AutoDisposeNotifier<TokenSelectionFormState> {
  TokenSelectionFormNotifier();

  @override
  TokenSelectionFormState build() => const TokenSelectionFormState();

  Future<void> setSearchText(
    String searchText,
  ) async {
    state = state.copyWith(
      searchText: searchText,
      result: [],
    );

    if (state.isAddress) {
      final token = await ref.read(
        DexTokensProviders.getTokenFromAddress(
          searchText,
        ).future,
      );
      if (token != null) {
        state = state.copyWith(
          result: [token],
        );
      }
    }
  }
}

abstract class TokenSelectionFormProvider {
  static final tokenSelectionForm = _tokenSelectionFormProvider;
}
