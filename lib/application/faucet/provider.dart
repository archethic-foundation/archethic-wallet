import 'dart:developer';
import 'dart:io';

import 'package:aewallet/application/account/providers.dart';
import 'package:aewallet/application/device_info.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/domain/models/core/failures.dart';
import 'package:aewallet/domain/repositories/faucet.dart';
import 'package:aewallet/infrastructure/repositories/faucet.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:aewallet/util/date_util.dart';
import 'package:aewallet/util/functional_utils.dart';
import 'package:aewallet/util/screen_util.dart';
import 'package:archethic_lib_dart/archethic_lib_dart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
FaucetRepositoryInterface _faucetRepository(Ref ref) {
  return FaucetRepository();
}

@Riverpod(keepAlive: true)
Future<bool> _isDeviceCompatible(Ref ref) async {
  if (!kIsWeb && Platform.isAndroid) {
    final developerMode = await FlutterJailbreakDetection.developerMode;
    log('developerMode: $developerMode');
    if (developerMode) return false;
  }
  if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
    final jailbroken = await FlutterJailbreakDetection.jailbroken;
    log('jailbroken: $jailbroken');
    if (jailbroken) return false;
  }
  if (kDebugMode) return true;
  if (ScreenUtil.isDesktopMode()) return false;
  if (ref.read(SettingsProviders.settings).network.network !=
      AvailableNetworks.archethicMainNet) return false;

  return true;
}

@Riverpod(keepAlive: true)
Future<bool> _isFaucetEnabled(Ref ref) async {
  final repository = ref.watch(_faucetRepositoryProvider);

  final isEnabled = await repository.isFaucetEnabled();

  return isEnabled.map(
    success: (value) {
      Future.delayed(
        const Duration(minutes: 10),
        () {
          ref.invalidate(_isFaucetEnabledProvider);
        },
      );

      return value;
    },
    failure: (_) {
      Future.delayed(
        const Duration(seconds: 30),
        () {
          ref.invalidate(_isFaucetEnabledProvider);
        },
      );

      // If there was an error, act like if faucet was enabled
      return true;
    },
  );
}

class _FaucetCooldownNotifier extends AsyncNotifier<Duration> {
  @override
  FutureOr<Duration> build() async {
    final repository = ref.watch(_faucetRepositoryProvider);
    final cooldownEndDate = await repository.getClaimCooldownEndDate();

    if (cooldownEndDate == null) return Duration.zero;

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

  Future<void> startCooldown({
    required DateTime endDate,
  }) async {
    final repository = ref.watch(_faucetRepositoryProvider);
    await repository.setClaimCooldownEndDate(date: endDate);

    ref.invalidate(FaucetProviders.claimCooldown);
  }
}

class _FaucetClaimNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() => const AsyncValue.data(null);

  Future<void> claim({
    required String captchaToken,
  }) async {
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

      final keychainSecuredInfos = ref
          .watch(SessionProviders.session)
          .loggedIn!
          .wallet
          .keychainSecuredInfos;

      final genesisAddressKeychain = deriveAddress(
        uint8ListToHex(Uint8List.fromList(keychainSecuredInfos.seed)),
        0,
      );

      final claimChallenge = (await repository.requestChallenge(
        deviceId: installationId,
        keychainAddress: genesisAddressKeychain,
        captchaToken: captchaToken,
      ))
          .map(
        success: id,
        failure: (failure) => failure.maybeMap(
          quotaExceeded: (quotaExceeded) {
            if (quotaExceeded.cooldownEndDate != null) {
              ref
                  .read(FaucetProviders.claimCooldown.notifier)
                  .startCooldown(endDate: quotaExceeded.cooldownEndDate!);
            }
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
        recipientAddress: accountLastAddress,
        keychainAddress: genesisAddressKeychain,
      ))
          .map(
        success: (cooldownEndDate) {
          ref
            ..read(FaucetProviders.claimCooldown.notifier)
                .startCooldown(endDate: cooldownEndDate)
            ..read(AccountProviders.selectedAccount.notifier)
                .refreshRecentTransactions();
        },
        failure: (failure) => failure.maybeMap(
          insufficientFunds: (insufficientFunds) {
            throw failure;
          },
          quotaExceeded: (quotaExceeded) {
            if (quotaExceeded.cooldownEndDate != null) {
              ref
                  .read(FaucetProviders.claimCooldown.notifier)
                  .startCooldown(endDate: quotaExceeded.cooldownEndDate!);
            }
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
