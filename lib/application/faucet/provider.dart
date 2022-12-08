import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/device_info.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/repositories/faucet.dart';
import 'package:aewallet/infrastructure/repositories/faucet.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:aewallet/util/date_util.dart';
import 'package:aewallet/util/functional_utils.dart';
import 'package:aewallet/util/screen_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
FaucetRepositoryInterface _faucetRepository(Ref ref) {
  return FaucetRepository();
}

@Riverpod(keepAlive: true)
Future<bool> _isDeviceCompatible(Ref ref) async {
  if (ScreenUtil.isDesktopMode()) return false;
  if (ref.read(SettingsProviders.settings).network.network !=
      AvailableNetworks.archethicMainNet) return false;

  return true;
}

@Riverpod(keepAlive: true)
Future<bool> _isFaucetEnabled(Ref ref) async {
  final repository = ref.watch(_faucetRepositoryProvider);

  return repository.isFaucetEnabled();
}

class _FaucetCooldownNotifier extends AsyncNotifier<Duration> {
  @override
  FutureOr<Duration> build() async {
    final repository = ref.watch(_faucetRepositoryProvider);
    final lastFaucetClaimDate = await repository.getLastClaimDate();

    if (lastFaucetClaimDate == null) return Duration.zero;

    final cooldownEndDate =
        lastFaucetClaimDate.toUtc().add(const Duration(hours: 24)).startOfDay;
    final cooldownRemainingTime =
        cooldownEndDate.difference(DateTime.now().toUtc()).max(Duration.zero);

    Future.delayed(
      const Duration(minutes: 1),
      () {
        ref.invalidate(FaucetProviders.claimCooldown);
      },
    );
    return cooldownRemainingTime;
  }

  Future<void> startCooldown() async {
    if (state.isLoading || state.valueOrNull != Duration.zero) return;

    final repository = ref.watch(_faucetRepositoryProvider);
    await repository.setLastClaimDate();

    ref.invalidate(FaucetProviders.claimCooldown);
  }
}

class _FaucetClaimNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() => const AsyncValue.data(null);

  Future<void> claim() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(_faucetRepositoryProvider);

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

      final claimChallenge = (await repository.requestChallenge(
        deviceId: installationId,
      ))
          .map(
        success: id,
        failure: (failure) => failure.maybeMap(
          quotaExceeded: (quotaExceeded) {
            ref.read(FaucetProviders.claimCooldown.notifier).startCooldown();
            throw failure;
          },
          orElse: () {
            throw failure;
          },
        ),
      );

      return (await repository.claim(
        challenge: claimChallenge,
        deviceId: installationId,
        keychainAddress: accountLastAddress,
      ))
          .map(
        success: (success) {
          ref
            ..read(FaucetProviders.claimCooldown.notifier).startCooldown()
            ..read(AccountProviders.selectedAccount.notifier)
                .refreshRecentTransactions();

          return success;
        },
        failure: (failure) => failure.maybeMap(
          insufficientFunds: (insufficientFunds) {
            throw failure;
          },
          quotaExceeded: (quotaExceeded) {
            ref.read(FaucetProviders.claimCooldown.notifier).startCooldown();
            throw failure;
          },
          orElse: () {
            throw failure;
          },
        ),
      );
    });
  }
}

abstract class FaucetProviders {
  /// Is the device compatible with Faucet ?
  static final isDeviceCompatible = _isDeviceCompatibleProvider;

  /// Is the Faucet active ?
  static final isFaucetEnabled = _isFaucetEnabledProvider;

  /// Notifier that requests Faucet claim
  static final claimRequest = AsyncNotifierProvider<_FaucetClaimNotifier, void>(
    _FaucetClaimNotifier.new,
  );

  /// Faucet claim cooldown counter
  static final claimCooldown =
      AsyncNotifierProvider<_FaucetCooldownNotifier, Duration>(
    _FaucetCooldownNotifier.new,
  );
}
