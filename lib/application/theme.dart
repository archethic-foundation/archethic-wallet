import 'package:aewallet/application/settings.dart';
import 'package:aewallet/model/available_themes.dart';
import 'package:aewallet/ui/themes/themes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'theme.g.dart';

@Riverpod(keepAlive: true)
BaseTheme _selectedTheme(_SelectedThemeRef ref) {
  return ThemeSetting(ref.watch(ThemeProviders.selectedThemeOption)).getTheme();
}

class ThemeStateNotifier extends StateNotifier<ThemeOptions> {
  ThemeStateNotifier(this.ref) : super(ThemeOptions.dark);

  final Ref ref;

  Future<void> selectTheme(ThemeOptions theme) async {
    await ref
        .read(SettingsProviders.localSettingsRepository)
        .setTheme(ThemeSetting(theme));

    state = theme;
  }
}

abstract class ThemeProviders {
  static final selectedThemeOption =
      StateNotifierProvider<ThemeStateNotifier, ThemeOptions>(
    ThemeStateNotifier.new,
  );

  static final selectedTheme = _selectedThemeProvider;
}
