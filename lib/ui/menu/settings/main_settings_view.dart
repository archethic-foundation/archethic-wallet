/// SPDX-License-Identifier: AGPL-3.0-or-later
part of 'settings_sheet.dart';

class MainMenuView extends ConsumerWidget {
  const MainMenuView({
    required this.showSecurity,
    required this.showCustom,
    required this.showAbout,
    super.key,
  });

  final VoidCallback showSecurity;
  final VoidCallback showCustom;
  final VoidCallback showAbout;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final selectedAccount =
        ref.watch(AccountProviders.selectedAccount).valueOrNull;
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);

    final networkSettings = ref.watch(
      SettingsProviders.settings.select((settings) => settings.network),
    );

    DApp? aeSwapUrl;
    if (connectivityStatusProvider == ConnectivityStatus.isConnected &&
        FeatureFlags.dexActive &&
        DEXSheet.isAvailable) {
      ref.watch(DAppsProviders.getDApp(networkSettings.network, 'aeSwap')).map(
            data: (data) {
              aeSwapUrl = data.value;
            },
            error: (error) {},
            loading: (loading) {},
          );
    }

    if (selectedAccount == null) return const SizedBox();

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            ArchethicThemeBase.blue700.withOpacity(0.4),
            ArchethicThemeBase.blue700.withOpacity(1),
          ],
          begin: Alignment.topLeft,
          end: const Alignment(5, 0),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            // Settings items
            Expanded(
              child: Stack(
                children: <Widget>[
                  ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Align(
                          child: Text(
                            ref
                                .read(SettingsProviders.settings)
                                .network
                                .getDisplayName(context),
                            style:
                                ArchethicThemeStyles.textStyleSize12W100Primary,
                          ),
                        ),
                      ),
                      const _SettingsListItem.spacer(),
                      _SettingsListItem.title(text: localizations.preferences),
                      const _SettingsListItem.spacer(),
                      _SettingsListItem.singleLine(
                        heading: localizations.securityHeader,
                        headingStyle:
                            ArchethicThemeStyles.textStyleSize16W600Primary,
                        icon: Symbols.security,
                        onPressed: showSecurity,
                      ),
                      const _SettingsListItem.spacer(),
                      _SettingsListItem.singleLine(
                        heading: localizations.customHeader,
                        headingStyle:
                            ArchethicThemeStyles.textStyleSize16W600Primary,
                        icon: Symbols.tune,
                        onPressed: showCustom,
                      ),
                      if (aeSwapUrl != null)
                        Column(
                          children: [
                            if (connectivityStatusProvider ==
                                    ConnectivityStatus.isConnected &&
                                FeatureFlags.dexActive &&
                                DEXSheet.isAvailable)
                              const _SettingsListItem.spacer(),
                            if (connectivityStatusProvider ==
                                    ConnectivityStatus.isConnected &&
                                FeatureFlags.dexActive &&
                                DEXSheet.isAvailable)
                              _SettingsListItem.title(
                                text: localizations.dapp,
                              ),
                            if (connectivityStatusProvider ==
                                    ConnectivityStatus.isConnected &&
                                FeatureFlags.dexActive &&
                                DEXSheet.isAvailable)
                              const _SettingsListItem.spacer(),
                            if (connectivityStatusProvider ==
                                    ConnectivityStatus.isConnected &&
                                FeatureFlags.dexActive &&
                                DEXSheet.isAvailable)
                              _SettingsListItem.singleLineWithInfos(
                                heading: localizations.aeSwapLinkHeader,
                                info: localizations.aeSwapLinkDesc,
                                icon: Symbols.swap_horiz_rounded,
                                onPressed: () async {
                                  await context.push(
                                    DEXSheet.routerPage,
                                    extra: aeSwapUrl!.url,
                                  );
                                },
                                background: ArchethicTheme.backgroundAESwap,
                              ),
                          ],
                        ),
                      const _SettingsListItem.spacer(),
                      _SettingsListItem.title(text: localizations.information),
                      const _SettingsListItem.spacer(),
                      if (connectivityStatusProvider ==
                          ConnectivityStatus.isConnected)
                        _SettingsListItem.singleLineWithInfos(
                          heading: localizations.aeWebsiteLinkHeader,
                          info: localizations.aeWebsiteLinkDesc,
                          icon: Symbols.language,
                          onPressed: () async {
                            UIUtil.showWebview(
                              context,
                              'https://www.archethic.net',
                              localizations.aeWebsiteLinkHeader,
                            );
                          },
                          background: ArchethicTheme.backgroundWelcome,
                        ),
                      if (connectivityStatusProvider ==
                          ConnectivityStatus.isConnected)
                        const _SettingsListItem.spacer(),
                      _SettingsListItem.singleLine(
                        heading: localizations.aboutHeader,
                        headingStyle:
                            ArchethicThemeStyles.textStyleSize16W600Primary,
                        icon: Symbols.info,
                        onPressed: showAbout,
                      ),
                      const _SettingsListItem.spacer(),
                      const SizedBox(height: 30),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
