import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';

abstract class FaucetRepositoryInterface {
  /// Return [null] if device is not authorized to request Faucet
  /// Else, returns the challenge.
  Future<Result<String, Failure>> requestChallenge({
    required String deviceId,
  });

  /// Claims reward
  Future<Result<void, Failure>> claim({
    required String challenge,
    required String deviceId,
    required String keychainAddress,
  });

  Future<DateTime?> getLastClaimDate();

  Future<void> setLastClaimDate();

  /// Clears all stored data
  Future<void> clear();

  Future<bool> isFaucetEnabled();
}
