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
    context.go(SecurityMenuView.routerPage);
  }

  void showCustom() {
    context.go(CustomizationMenuView.routerPage);
  }

  void showAbout() {
    context.go(AboutMenuView.routerPage);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          localizations.settings,
          style: ArchethicThemeStyles.textStyleSize24W700Primary,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
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
