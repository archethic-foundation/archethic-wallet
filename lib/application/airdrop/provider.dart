import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/device_info.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/repositories/airdrop.dart';
import 'package:aewallet/infrastructure/repositories/airdrop.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:aewallet/util/date_util.dart';
import 'package:aewallet/util/functional_utils.dart';
import 'package:aewallet/util/screen_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:safe_device/safe_device.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
AirDropRepositoryInterface _airDropRepository(Ref ref) {
  return AirDropRepository();
}

@Riverpod(keepAlive: true)
Future<bool> _isDeviceCompatible(Ref ref) async {
  if (ScreenUtil.isDesktopMode()) return false;
  if (ref.read(SettingsProviders.settings).network.network !=
      AvailableNetworks.archethicMainNet) return false;

  final isSafeDevice = await SafeDevice.isSafeDevice;
  if (isSafeDevice == false) return false;

  return true;
}

@Riverpod(keepAlive: true)
Future<bool> _isAirdropEnabled(Ref ref) async {
  /// If the airdrop API replyes as expected, it means airdrop is enabled.
  final repository = ref.watch(_airDropRepositoryProvider);

  final installationId = await ref.watch(
    DeviceInfoProviders.installationId.future,
  );

  final airDropChallenge = await repository.requestChallenge(
    deviceId: installationId,
  );

  return airDropChallenge.map(
    success: (_) => true,
    failure: (failure) => failure.maybeMap(
      quotaExceeded: (_) async {
        ref.read(AirDropProviders.airdropCooldown.notifier).startCooldown();
        return true;
      },
      orElse: () {
        // retry request later
        Future.delayed(
          const Duration(minutes: 1),
          () => ref.invalidate(_isAirdropEnabledProvider),
        );

        return false;
      },
    ),
  );
}

class _AirDropCooldownNotifier extends AsyncNotifier<Duration> {
  @override
  FutureOr<Duration> build() async {
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
        ref.invalidate(AirDropProviders.airdropCooldown);
      },
    );
    return cooldownRemainingTime;
  }

  Future<void> startCooldown() async {
    if (state.isLoading || state.valueOrNull != Duration.zero) return;

    final repository = ref.watch(_airDropRepositoryProvider);
    await repository.setLastAirdropDate();

    ref.invalidate(AirDropProviders.airdropCooldown);
  }
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
          .map(
        success: id,
        failure: (failure) => failure.maybeMap(
          quotaExceeded: (quotaExceeded) {
            ref.read(AirDropProviders.airdropCooldown.notifier).startCooldown();
            throw failure;
          },
          orElse: () {
            throw failure;
          },
        ),
      );

      final result = (await repository.requestAirDrop(
        challenge: airDropChallenge,
        deviceId: installationId,
        keychainAddress: accountLastAddress,
      ))
          .map(
        success: id,
        failure: (failure) => failure.maybeMap(
          insufficientFunds: (insufficientFunds) {
            throw failure;
          },
          quotaExceeded: (quotaExceeded) {
            ref.read(AirDropProviders.airdropCooldown.notifier).startCooldown();
            throw failure;
          },
          orElse: () {
            throw failure;
          },
        ),
      );

      ref
        ..read(AirDropProviders.airdropCooldown.notifier).startCooldown()
        ..invalidate(_isAirdropEnabledProvider)
        ..read(AccountProviders.selectedAccount.notifier)
            .refreshRecentTransactions();

      return result;
    });
  }
}

abstract class AirDropProviders {
  /// Is the device compatible with Faucet ?
  static final isDeviceCompatible = _isDeviceCompatibleProvider;

  /// Is the Faucet active ?
  static final isFaucetEnabled = _isAirdropEnabledProvider;

  /// Notifier that requests Faucet claim
  static final airDropRequest =
      AsyncNotifierProvider<_AirDropRequestNotifier, void>(
    _AirDropRequestNotifier.new,
  );

  /// Faucet claim cooldown counter
  static final airdropCooldown =
      AsyncNotifierProvider<_AirDropCooldownNotifier, Duration>(
    _AirDropCooldownNotifier.new,
  );

  static Future<void> reset(Ref ref) async {
    await ref.read(_airDropRepositoryProvider).clear();
    ref.invalidate(airdropCooldown);
  }
}
