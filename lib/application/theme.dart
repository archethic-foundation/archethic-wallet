import 'package:aewallet/application/settings.dart';
import 'package:aewallet/model/available_themes.dart';
import 'package:aewallet/ui/themes/themes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'theme.g.dart';

@riverpod
BaseTheme _selectedTheme(_SelectedThemeRef ref) {
  return ThemeSetting(ref.watch(_selectedThemeOptionProvider)).getTheme();
}

@riverpod
ThemeOptions _selectedThemeOption(_SelectedThemeOptionRef ref) {
  return ref.read(SettingsProviders.localSettingsRepository).getTheme().theme;
}

@riverpod
Future<void> _selectTheme(
  _SelectThemeRef ref, {
  required ThemeOptions theme,
}) async {
  await ref.read(SettingsProviders.localSettingsRepository).setTheme(ThemeSetting(theme));
  ref.invalidate(ThemeProviders.themeOption);
}

abstract class ThemeProviders {
  static final themeOption = _selectedThemeOptionProvider;
  static final theme = _selectedThemeProvider;

  static final selectTheme = _selectThemeProvider;
}
