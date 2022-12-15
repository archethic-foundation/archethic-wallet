import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/models/core/result.dart';

abstract class FaucetRepositoryInterface {
  /// Return null if device is not authorized to request Faucet
  /// Else, returns the challenge.
  Future<Result<String, Failure>> requestChallenge({
    required String keychainAddress,
    required String deviceId,
    required String captchaToken,
  });

  /// Claims reward
  Future<Result<DateTime, Failure>> claim({
    required String challenge,
    required String deviceId,
    required String recipientAddress,
    required String keychainAddress,
  });

  Future<DateTime?> getClaimCooldownEndDate();

  Future<void> setClaimCooldownEndDate({required DateTime date});

  /// Clears all stored data
  Future<void> clear();

  Future<Result<bool, Failure>> isFaucetEnabled();
}
