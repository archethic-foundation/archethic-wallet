import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/device_info.dart';
import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/repositories/airdrop.dart';
import 'package:aewallet/infrastructure/repositories/airdrop.dart';
import 'package:aewallet/util/date_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
AirDropRepositoryInterface _airDropRepository(Ref ref) {
  return AirDropRepository();
}

@Riverpod(keepAlive: true)
Future<Duration> _airdropCooldown(Ref ref) async {
  final repository = ref.watch(_airDropRepositoryProvider);
  final lastAirDropDate = await repository.getLastAirdropDate();

  if (lastAirDropDate == null) return Duration.zero;

  final cooldownEndDate =
      lastAirDropDate.toUtc().add(const Duration(hours: 24)).startOfDay;
  final cooldownRemainingTime =
      cooldownEndDate.difference(DateTime.now().toUtc()).max(Duration.zero);

  Future.delayed(
    const Duration(minutes: 1),
    () {
      ref.invalidate(_airdropCooldownProvider);
    },
  );
  return cooldownRemainingTime;
}

@Riverpod(keepAlive: true)
Future<bool> _isAirdropEligible(Ref ref) async {
  final repository = ref.watch(_airDropRepositoryProvider);

  final installationId = await ref.watch(
    DeviceInfoProviders.installationId.future,
  );

  final airDropChallenge = await repository.requestChallenge(
    deviceId: installationId,
  );
  return airDropChallenge.valueOrNull != null;
}

class _AirDropRequestNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() => const AsyncValue.data(null);

  Future<void> requestAirDrop() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(_airDropRepositoryProvider);

      final installationId = await ref.read(
        DeviceInfoProviders.installationId.future,
      );

      final selectedAccount = await ref.read(
        AccountProviders.selectedAccount.future,
      );

      final accountLastAddress = selectedAccount?.lastAddress;

      if (accountLastAddress == null) {
        throw const Failure.invalidValue();
      }

      final airDropChallenge = (await repository.requestChallenge(
        deviceId: installationId,
      ))
          .valueOrThrow;

      final result = await repository.requestAirDrop(
        challenge: airDropChallenge,
        deviceId: installationId,
        keychainAddress: accountLastAddress,
      );

      if (result.isValue) {
        ref
          ..invalidate(_isAirdropEligibleProvider)
          ..invalidate(_airdropCooldownProvider)
          ..read(AccountProviders.selectedAccount.notifier)
              .refreshRecentTransactions();
      }

      return result.valueOrThrow;
    });
  }
}

abstract class AirDropProviders {
  static final isEligible = _isAirdropEligibleProvider;
  static final airDropRequest =
      AsyncNotifierProvider<_AirDropRequestNotifier, void>(
    _AirDropRequestNotifier.new,
  );
  static final airdropCooldown = _airdropCooldownProvider;

  static Future<void> reset(Ref ref) async {
    await ref.read(_airDropRepositoryProvider).clear();
    ref
      ..invalidate(isEligible)
      ..invalidate(airdropCooldown);
  }
}
