import 'package:aewallet/domain/models/onramp.dart';

abstract class OnRampRepository {
  Future<void> connect();
  Future<void> dispose();
  Stream<OnRampEvent> get events;
  Future<String> get evmAddress;

  Future<num> get maxAmount;
}
