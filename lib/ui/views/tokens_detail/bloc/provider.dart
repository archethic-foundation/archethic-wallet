import 'package:aewallet/ui/views/tokens_detail/bloc/state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final _tokenDetailFormProvider =
    AutoDisposeNotifierProvider<TokenDetailFormNotifier, TokenDetailFormState>(
  TokenDetailFormNotifier.new,
);

class TokenDetailFormNotifier
    extends AutoDisposeNotifier<TokenDetailFormState> {
  TokenDetailFormNotifier();

  @override
  TokenDetailFormState build() {
    return const TokenDetailFormState();
  }
}

class TokenDetailFormProvider {
  static final tokenDetailForm = _tokenDetailFormProvider;
}
