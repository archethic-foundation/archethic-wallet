import 'package:aewallet/domain/repositories/tokens/tokens.repository.dart';
import 'package:aewallet/infrastructure/repositories/tokens/tokens.repository.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tokens.g.dart';

@riverpod
TokensRepository _tokensRepository(_TokensRepositoryRef ref) =>
    TokensRepositoryImpl();

@riverpod
Future<List<AEToken>> _tokens(
  _TokensRef ref,
  String userGenesisAddress, {
  bool withVerified = true,
  bool withLPToken = false,
  bool withNotVerified = false,
}) async {
  final apiService = sl.get<ApiService>();

  return ref.watch(_tokensRepositoryProvider).getTokensList(
        userGenesisAddress,
        apiService,
        withVerified: withVerified,
        withLPToken: withLPToken,
        withNotVerified: withNotVerified,
      );
}

abstract class TokensProviders {
  static const tokens = _tokensProvider;
}
