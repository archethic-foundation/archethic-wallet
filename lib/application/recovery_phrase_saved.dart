/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:aewallet/infrastructure/datasources/preferences.hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recovery_phrase_saved.g.dart';

@riverpod
Future<bool> _isRecoveryPhraseSaved(
  _IsRecoveryPhraseSavedRef ref,
) async {
  final preferences = await PreferencesHiveDatasource.getInstance();
  return preferences.getRecoveryPhraseSaved();
}

@riverpod
Future<void> _setRecoveryPhraseSaved(
  _SetRecoveryPhraseSavedRef ref,
  bool value,
) async {
  final preferences = await PreferencesHiveDatasource.getInstance();
  await preferences.setRecoveryPhraseSaved(value);
  ref.invalidate(RecoveryPhraseSavedProvider.isRecoveryPhraseSaved);
}

abstract class RecoveryPhraseSavedProvider {
  static final isRecoveryPhraseSaved = _isRecoveryPhraseSavedProvider;
  static const setRecoveryPhraseSaved = _setRecoveryPhraseSavedProvider;
}
