/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';

import 'package:aewallet/infrastructure/repositories/farm_apr.repository.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'farm_apr.g.dart';

@Riverpod(keepAlive: true)
class _FarmAPRNotifier extends _$FarmAPRNotifier {
  static final _logger = Logger('FarmAPRNotifier');

  Timer? _timer;

  @override
  String build() {
    ref.onDispose(() {
      if (_timer != null) {
        _timer!.cancel();
      }
    });

    _getValue();

    return '';
  }

  Future<void> starTimer() async {
    if (_timer != null) return;

    _logger.info('Start timer');
    _timer = Timer.periodic(const Duration(minutes: 5), (_) async {
      final infos = await ref.read(_farmAPRRepositoryProvider).fetchAPRFarm();
      state = infos['defaultAPR'] ?? '';
    });
  }

  Future<void> stopTimer() async {
    _logger.info('Stop timer');
    if (_timer == null) return;
    _timer?.cancel();
  }

  Future<void> _getValue() async {
    final infos = await ref.read(_farmAPRRepositoryProvider).fetchAPRFarm();
    state = infos['defaultAPR'] ?? '';
  }
}

@Riverpod(keepAlive: true)
FarmAPRRepositoryImpl _farmAPRRepository(
  _FarmAPRRepositoryRef ref,
) =>
    FarmAPRRepositoryImpl();

abstract class FarmAPRProviders {
  static final farmAPR = _farmAPRNotifierProvider;
}
