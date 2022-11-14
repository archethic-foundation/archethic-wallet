import 'dart:ui';

import 'package:aewallet/domain/models/settings.dart';

abstract class SettingsRepositoryInterface {
  Future<Settings> getSettings(Locale currentLocale);
  Future<void> setSettings(Settings settings);
}
