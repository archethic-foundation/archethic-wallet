import 'dart:async';
import 'dart:core';

import 'package:aewallet/application/account/accounts_notifier.dart';
import 'package:aewallet/application/feature_flags.dart';
import 'package:aewallet/application/recent_transactions.dart';
import 'package:aewallet/application/session/session.dart';
import 'package:aewallet/domain/models/onramp.dart';
import 'package:aewallet/domain/repositories/on_ramp.dart';
import 'package:aewallet/infrastructure/repositories/on_ramp.repository.dart';
import 'package:aewallet/main.dart';
import 'package:aewallet/modules/aeswap/application/session/provider.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onramp.g.dart';

@riverpod
({bool fromCrypto, bool fromFiat}) onrampFeatureFlag(Ref ref) => (
      fromCrypto: ref
              .watch(getFeatureFlagProvider(kApplicationCode, 'on-ramp-crypto'))
              .valueOrNull ??
          false,
      fromFiat: ref
              .watch(getFeatureFlagProvider(kApplicationCode, 'on-ramp-fiat'))
              .valueOrNull ??
          false
    );

@riverpod
Future<OnRampRepository> _onRampRepository(Ref ref) async {
  final environment = ref.watch(environmentProvider);
  final urls = switch (environment) {
    Environment.devnet => (
        http: 'http://localhost:4100/api/v1',
        ws: 'ws://localhost:4100/ws/websocket'
      ),
    Environment.testnet => (
        http: 'https://api.onramp.testnet.archethic.net/api/v1',
        ws: 'wss://api.onramp.testnet.archethic.net/ws/websocket'
      ),
    Environment.mainnet => (
        http: 'https://api.onramp.archethic.net/api/v1',
        ws: 'wss://api.onramp.archethic.net/ws/websocket'
      ),
  };

  late OnRampRepository? repository;

  ref.onDispose(() {
    repository?.dispose();
  });

  final session = ref.watch(sessionNotifierProvider).loggedIn!;
  final accountSelected = ref.watch(
    accountsNotifierProvider.select(
      (accounts) => accounts.valueOrNull?.selectedAccount,
    ),
  )!;

  repository = OnRampRepositoryImpl(
    httpBaseUrl: urls.http,
    wsBaseUrl: urls.ws,
    wallet: session.wallet,
    account: accountSelected,
  );
  await repository.connect();
  return repository;
}

@riverpod
Future<OnRampSetup> onrampEvmSetup(
  Ref ref,
) async {
  final repository = await ref.watch(_onRampRepositoryProvider.future);
  return repository.evmSetup;
}

@riverpod
Future<OnRampProvider> onrampProviderSetup(Ref ref, String providerId) async {
  final setup = await ref.watch(onrampEvmSetupProvider.future);

  final entries = setup.chains
      .where((chainSetup) => chainSetup.providers[providerId] != null)
      .map(
        (chainSetup) =>
            MapEntry(chainSetup.id, chainSetup.providers[providerId]!),
      );

  return Map.fromEntries(entries);
}

@riverpod
Future<({String chainId, String tokenId})?> onrampProviderFavoriteSetup(
  Ref ref,
  String providerId,
) async {
  final setup = await ref.watch(onrampProviderSetupProvider(providerId).future);
  final chainSetup = setup.entries.firstOrNull;
  final chainId = chainSetup?.value.id;
  final tokenSetup = chainSetup?.value.tokens.entries.firstOrNull;
  final tokenId = tokenSetup?.value.id;

  if (chainId == null || tokenId == null) return null;

  return (chainId: chainId, tokenId: tokenId);
}

@riverpod
Future<List<OnRampChain>> onrampChainsForToken(
  Ref ref,
  String tokenId,
) async {
  final setup = await ref.watch(onrampEvmSetupProvider.future);
  return setup.chains
      .where(
        (chain) => chain.tokens.any((token) => token.id == tokenId),
      )
      .toList();
}

@riverpod
Future<List<OnRampTokenDisplayData>> onrampTokensDisplayData(Ref ref) async {
  final setup = await ref.watch(onrampEvmSetupProvider.future);
  return setup.tokensDisplayData;
}

@riverpod
Future<OnRampTokenDisplayData?> onrampTokenDisplayData(
  Ref ref,
  String id,
) async {
  final setup = await ref.watch(onrampEvmSetupProvider.future);
  return setup.tokensDisplayData
      .firstWhereOrNull((displayData) => displayData.id == id);
}

@riverpod
Future<double?> onrampTokenFees(
  Ref ref,
  String id,
) async {
  final setup = await ref.watch(onrampEvmSetupProvider.future);
  return setup.chains.firstWhereOrNull((info) => info.id == id)?.feeRate;
}

@riverpod
Future<OnRampToken?> onrampToken(
  Ref ref,
  String chainId,
  String tokenId,
) async {
  final setup = await ref.watch(onrampEvmSetupProvider.future);
  return setup.chains
      .firstWhereOrNull((chain) => chain.id == chainId)
      ?.tokens
      .firstWhereOrNull((token) => token.id == tokenId);
}

@riverpod
Future<num> onrampMaxAmount(Ref ref) async {
  final repository = await ref.watch(_onRampRepositoryProvider.future);
  return repository.maxAmount;
}

@riverpod
Future<String> onrampDepositAddress(Ref ref) async {
  final repository = await ref.watch(_onRampRepositoryProvider.future);
  return repository.evmAddress;
}

@riverpod
Stream<List<OnRampDeposit>> onrampTransfers(Ref ref) async* {
  void maybeInvalidateRecentTransactions(OnRampDeposit deposit) {
    if (deposit.completedRatio < 1) return;
    ref.invalidate(recentTransactionsProvider);
  }

  final repository = await ref.watch(_onRampRepositoryProvider.future);
  final history = await repository.depositsHistory;
  yield history;
  var deposits = [];
  await for (final event in repository.events) {
    switch (event) {
      case OnRampDepositsSnapshotEvent(deposits: final newDeposits):
        deposits = newDeposits;
        break;
      case OnRampDepositUpdateEvent(deposit: final updatedDeposit):
        maybeInvalidateRecentTransactions(updatedDeposit);
        var found = false;
        deposits = deposits.map((deposit) {
          if (deposit.id == updatedDeposit.id) {
            found = true;
            return updatedDeposit;
          }
          return deposit;
        }).toList();
        if (!found) deposits = [updatedDeposit, ...deposits];
        break;
    }
    yield [
      ...deposits,
      ...history,
    ];
  }
}
