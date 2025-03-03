import 'dart:async';
import 'dart:core';

import 'package:aewallet/application/session/session.dart';
import 'package:aewallet/domain/models/onramp.dart';
import 'package:aewallet/domain/repositories/on_ramp.dart';
import 'package:aewallet/infrastructure/repositories/on_ramp.repository.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onramp.g.dart';

@riverpod
Future<OnRampRepository> _onRampRepository(Ref ref) async {
  late OnRampRepository? repository;

  ref.onDispose(() {
    repository?.dispose();
  });

  final session = ref.watch(sessionNotifierProvider).loggedIn!;

  repository = OnRampRepositoryImpl(
    httpBaseUrl: 'http://localhost:4100/api/v1',
    wsBaseUrl: 'ws://localhost:4100/ws/websocket',
    wallet: session.wallet,
  );
  await repository.connect();
  return repository;
}

@riverpod
Future<({List<OnRampChain> chains})> onrampSetup(
  Ref ref,
) async =>
    (
      chains: [
        (
          id: 'polygon',
          name: 'polygon',
          iconUrl:
              'https://www.cryptologos.cc/logos/polygon-matic-logo.png?v=040',
          tokens: [
            (
              id: 'poly_eth',
              symbol: 'ETH',
              name: 'Ethereum',
              feeRate: 0.1,
              address: 'poly_eth',
              iconUrl:
                  'https://icons.iconarchive.com/icons/cjdowner/cryptocurrency-flat/1024/Ethereum-ETH-icon.png'
            ),
            (
              id: 'poly_btc',
              symbol: 'BTC',
              name: 'Bitcoin',
              feeRate: 0.1,
              address: 'poly_btc',
              iconUrl:
                  'https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Ficons.iconarchive.com%2Ficons%2Fcjdowner%2Fcryptocurrency-flat%2F1024%2FBitcoin-BTC-icon.png&f=1&nofb=1&ipt=e13399a403e865bea373356838869d463d2a0eaca417f8eb42cb2dc4c1ba534b&ipo=images'
            ),
            (
              id: 'poly_matic',
              symbol: 'MATIC',
              name: 'Matic',
              feeRate: 0.1,
              address: 'poly_matic',
              iconUrl:
                  'https://cdn.iconscout.com/icon/premium/png-256-thumb/polygon-matic-7151798-5795452.png'
            ),
          ]
        ),
        (
          id: 'ethereum',
          name: 'ethereum',
          iconUrl:
              'https://icons.iconarchive.com/icons/cjdowner/cryptocurrency-flat/1024/Ethereum-ETH-icon.png',
          tokens: [
            (
              id: 'eth_eth',
              symbol: 'ETH',
              name: 'Ethereum',
              feeRate: 0.1,
              address: 'eth_eth',
              iconUrl:
                  'https://icons.iconarchive.com/icons/cjdowner/cryptocurrency-flat/1024/Ethereum-ETH-icon.png'
            ),
            (
              id: 'eth_btc',
              symbol: 'BTC',
              name: 'Bitcoin',
              feeRate: 0.1,
              address: 'eth_btc',
              iconUrl:
                  'https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Ficons.iconarchive.com%2Ficons%2Fcjdowner%2Fcryptocurrency-flat%2F1024%2FBitcoin-BTC-icon.png&f=1&nofb=1&ipt=e13399a403e865bea373356838869d463d2a0eaca417f8eb42cb2dc4c1ba534b&ipo=images'
            ),
          ]
        ),
        (
          id: 'bitcoin',
          name: 'bitcoin',
          iconUrl:
              'https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Ficons.iconarchive.com%2Ficons%2Fcjdowner%2Fcryptocurrency-flat%2F1024%2FBitcoin-BTC-icon.png&f=1&nofb=1&ipt=e13399a403e865bea373356838869d463d2a0eaca417f8eb42cb2dc4c1ba534b&ipo=images',
          tokens: [
            (
              id: 'btc_btc',
              symbol: 'BTC',
              name: 'Bitcoin',
              feeRate: 0.1,
              address: 'btc_btc',
              iconUrl:
                  'https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Ficons.iconarchive.com%2Ficons%2Fcjdowner%2Fcryptocurrency-flat%2F1024%2FBitcoin-BTC-icon.png&f=1&nofb=1&ipt=e13399a403e865bea373356838869d463d2a0eaca417f8eb42cb2dc4c1ba534b&ipo=images'
            ),
          ]
        ),
      ],
    );

@riverpod
Future<List<OnRampChain>> onrampChainsForToken(
  Ref ref,
  String tokenSymbol,
) async {
  final setup = await ref.watch(onrampSetupProvider.future);
  return setup.chains
      .where(
        (chain) => chain.tokens.any((token) => token.symbol == tokenSymbol),
      )
      .toList();
}

@riverpod
Future<List<OnRampChain>> onrampChains(Ref ref) async {
  final setup = await ref.watch(onrampSetupProvider.future);
  return setup.chains;
}

@riverpod
Future<List<OnRampToken>> onrampTokens(
  Ref ref,
) async {
  final setup = await ref.watch(onrampSetupProvider.future);
  return setup.chains.expand((chain) => chain.tokens).toList();
}

@riverpod
Future<OnRampToken?> onrampToken(Ref ref, String id) async {
  final setup = await ref.watch(onrampSetupProvider.future);
  return setup.chains
      .expand((chain) => chain.tokens)
      .firstWhereOrNull((token) => token.id == id);
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
  final repository = await ref.watch(_onRampRepositoryProvider.future);

  var deposits = <OnRampDeposit>[];
  await for (final event in repository.events) {
    switch (event) {
      case OnRampDepositsSnapshotEvent(deposits: final newDeposits):
        deposits = newDeposits;
        break;
      case OnRampDepositUpdateEvent(deposit: final updatedDeposit):
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
    yield deposits;
  }
  // unawaited(
  //   channel.messages.forEach((message) {
  //     message.
  //   }),
  // );
  // await Future.delayed(const Duration(seconds: 3));
  // return [
  //   (
  //     id: 'cc',
  //     depositDate: DateTime.now().subtract(const Duration(minutes: 2)),
  //     depositChainId: 'polygon',
  //     depositTokenId: 'poly_eth',
  //     depositAmount: 1234567890.1,
  //     feeAmount: 1.02,
  //     remainingAmount: 1234567889.08,
  //     transferedUcoAmount: 0,
  //     state: OnRampTransferState.rebalancing,
  //   ),
  //   (
  //     id: 'bb',
  //     depositDate: DateTime.now().subtract(const Duration(hours: 1)),
  //     depositChainId: 'polygon',
  //     depositTokenId: 'poly_eth',
  //     depositAmount: 102.05,
  //     feeAmount: 1.02,
  //     remainingAmount: 25.53, //effectué 75.5
  //     transferedUcoAmount: 123213445434343.45343,
  //     state: OnRampTransferState.rebalancing,
  //   ),
  //   (
  //     id: 'aa',
  //     depositDate: DateTime.now().subtract(const Duration(hours: 2)),
  //     depositChainId: 'polygon',
  //     depositTokenId: 'poly_eth',
  //     depositAmount: 100.05,
  //     feeAmount: 1.02,
  //     remainingAmount: 0,
  //     transferedUcoAmount: 123213.45343,
  //     state: OnRampTransferState.completed,
  //   ),
  // ];
}
