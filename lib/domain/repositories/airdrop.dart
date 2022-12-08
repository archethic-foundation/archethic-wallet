import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';

abstract class AirDropRepositoryInterface {
  /// Return [null] if device is not authorized to request AirDrop
  /// Else, return the challenge.
  Future<Result<String, Failure>> requestChallenge({
    required String deviceId,
  });

  /// Request AirDrop
  Future<Result<void, Failure>> requestAirDrop({
    required String challenge,
    required String deviceId,
    required String keychainAddress,
  });

  Future<DateTime?> getLastAirdropDate();

  Future<void> setLastAirdropDate();

  /// Clears all stored data
  Future<void> clear();
}
