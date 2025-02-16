import 'dart:async';

import 'package:aewallet/application/airdrop/airdrop.dart';
import 'package:aewallet/infrastructure/datasources/airdrop_datasource.hive.dart';
import 'package:aewallet/infrastructure/datasources/airdrop_dto.hive.dart';
import 'package:aewallet/model/airdrop.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'airdrop_notifier.g.dart';

@riverpod
class AirdropNotifier extends _$AirdropNotifier {
  Timer? _timer;
  static final _logger = Logger('AirdropNotifier');

  @override
  FutureOr<Airdrop?> build() async {
    ref.onDispose(stopTimer);
    startTimer();
    final airdropHiveDatasource = await AirdropHiveDatasource.getInstance();
    final _airdropDto = airdropHiveDatasource.getAirdrop();
    if (_airdropDto != null) {
      return _airdropDto.toModel();
    }

    return null;
  }

  void startTimer() {
    if (_timer != null) return;

    _logger.info('Start timer');
    ref.read(airdropUserInfoProvider);
    // Backend refreshs datas all hours
    _timer = Timer.periodic(const Duration(hours: 1), (_) {
      ref.read(airdropUserInfoProvider);
    });
  }

  Future<void> stopTimer() async {
    _logger.info('Stop timer');
    if (_timer == null) return;
    _timer?.cancel();
    _timer = null;
  }

  Future<void> deleteAirdrop(
    Ref ref,
  ) async {
    final airdropHiveDatasource = await AirdropHiveDatasource.getInstance();
    await airdropHiveDatasource.removeAirdrop();
    state = const AsyncValue.data(null);
  }

  Future<void> setAirdrop(Airdrop airdrop) async {
    try {
      final _airdropDto = airdrop.toHive();
      final airdropHiveDatasource = await AirdropHiveDatasource.getInstance();
      await airdropHiveDatasource.setAirdrop(_airdropDto);

      state = AsyncValue.data(airdrop);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      rethrow;
    }
  }

  Future<void> updateUserInfo({
    int? personalMultiplier,
    double? personalLPAmount,
    double? personalLPFlexibleAmount,
    bool? isMailConfirmed,
    String? email,
    String? referralCode,
  }) async {
    final currentAirdrop = state.valueOrNull;
    if (currentAirdrop != null) {
      await setAirdrop(
        currentAirdrop.copyWith(
          personalMultiplier:
              personalMultiplier ?? currentAirdrop.personalMultiplier,
          personalLPAmount: personalLPAmount ?? currentAirdrop.personalLPAmount,
          personalLPFlexibleAmount: personalLPFlexibleAmount ??
              currentAirdrop.personalLPFlexibleAmount,
          isMailConfirmed: isMailConfirmed ?? currentAirdrop.isMailConfirmed,
          email: email ?? currentAirdrop.email,
          referralCode: referralCode ?? currentAirdrop.referralCode,
        ),
      );
    } else {
      await setAirdrop(
        Airdrop(
          personalMultiplier: personalMultiplier,
          personalLPAmount: personalLPAmount,
          personalLPFlexibleAmount: personalLPFlexibleAmount,
          isMailConfirmed: isMailConfirmed,
          email: email,
          referralCode: referralCode,
        ),
      );
    }
  }
}
