import 'package:aewallet/domain/models/onramp.dart';

abstract class OnRampRepository {
  Future<void> connect();
  Future<void> dispose();
  Stream<OnRampEvent> get events;
  Future<List<OnRampDeposit>> get depositsHistory;
  Future<String> get evmAddress;

  Future<num> get maxAmount;

  Future<OnRampSetup> get evmSetup;

  Future<void> sendEventOnrampWithFiat({required String provider});
}

abstract class OnRampProviderRepository {
  Future<List<OnRampProviderToken>> tokens();

  Uri checkoutUri({
    required String depositAddress,
    required String tokenId,
    required String chainId,
  });
  Uri orderTrackUrl({required String orderId});
}
