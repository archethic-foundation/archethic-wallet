/// SPDX-License-Identifier: AGPL-3.0-or-later
part of 'settings_sheet.dart';

class SettingsSheetWallet extends ConsumerStatefulWidget {
  const SettingsSheetWallet({super.key});

  @override
  ConsumerState<SettingsSheetWallet> createState() =>
      _SettingsSheetWalletMobileState();
}

class _SettingsSheetWalletMobileState extends ConsumerState<SettingsSheetWallet>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  bool notNull(Object? o) => o != null;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        super.didChangeAppLifecycleState(state);
        break;
      case AppLifecycleState.resumed:
        super.didChangeAppLifecycleState(state);
        break;
      case AppLifecycleState.detached:
        super.didChangeAppLifecycleState(state);
        break;
      case AppLifecycleState.inactive:
        super.didChangeAppLifecycleState(state);
        break;
      case AppLifecycleState.hidden:
        super.didChangeAppLifecycleState(state);
        break;
    }
  }

  void showSecurity() {
    Navigator.of(context).pushNamed('/security_menu_view');
  }

  void showCustom() {
    Navigator.of(context).pushNamed('/customization_menu_view');
  }

  void showAbout() {
    Navigator.of(context).pushNamed('/about_menu_view');
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ArchethicTheme.background,
        title: AutoSizeText(
          localizations.settings,
          style: ArchethicThemeStyles.textStyleSize24W700Primary,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ClipRect(
        child: Stack(
          children: <Widget>[
            Container(
              color: ArchethicTheme.backgroundDark,
              constraints: const BoxConstraints.expand(),
            ),
            MainMenuView(
              showSecurity: showSecurity,
              showCustom: showCustom,
              showAbout: showAbout,
            ),
          ],
        ),
      ),
    );
  }
}
