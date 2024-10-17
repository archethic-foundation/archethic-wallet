import 'package:aewallet/modules/aeswap/application/session/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'verified_tokens.g.dart';

@riverpod
aedappfm.VerifiedTokensRepositoryInterface verifiedTokensRepository(
  VerifiedTokensRepositoryRef ref,
) {
  final environment = ref.read(environmentProvider);
  return ref.watch(
    aedappfm.VerifiedTokensProviders.verifiedTokensRepository(environment),
  );
}

@riverpod
Future<bool> isVerifiedToken(IsVerifiedTokenRef ref, String address) async {
  final environment = ref.read(environmentProvider);
  return ref.watch(
    aedappfm.VerifiedTokensProviders.isVerifiedToken(
      environment,
      address,
    ).future,
  );
}

@riverpod
Future<List<String>> verifiedTokens(
  VerifiedTokensRef ref,
) async {
  final environment = ref.read(environmentProvider);

  return ref.watch(
    aedappfm.VerifiedTokensProviders.verifiedTokensByNetwork(
      environment,
    ).future,
  );
}
