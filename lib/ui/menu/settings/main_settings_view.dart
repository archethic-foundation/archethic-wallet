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

    final selectedAccount = ref.watch(
      AccountProviders.accounts.select(
        (accounts) => accounts.valueOrNull?.selectedAccount,
      ),
    );

    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);

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
                        padding: const EdgeInsets.only(bottom: 10),
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
                      _SettingsListItem.title(text: localizations.information),
                      const _SettingsListItem.spacer(),
                      if (connectivityStatusProvider ==
                          ConnectivityStatus.isConnected)
                        _SettingsListItem.singleLineWithInfos(
                          heading: localizations.aeWebsiteLinkHeader,
                          info: localizations.aeWebsiteLinkDesc,
                          icon: Symbols.language,
                          onPressed: () async {
                            await launchUrl(
                              Uri.parse(
                                'https://www.archethic.net',
                              ),
                              mode: LaunchMode.externalApplication,
                            );
                          },
                          background: ArchethicTheme.backgroundWelcome,
                        ),
                      if (connectivityStatusProvider ==
                          ConnectivityStatus.isConnected)
                        const _SettingsListItem.spacer(),
                      _SettingsListItem.singleLineWithInfos(
                        heading: localizations.mediumLinkHeader,
                        info: localizations.mediumLinkDesc,
                        icon: Symbols.news,
                        onPressed: () async {
                          await launchUrl(
                            Uri.parse(
                              'https://medium.com/archethic',
                            ),
                            mode: LaunchMode.externalApplication,
                          );
                        },
                      ),
                      const _SettingsListItem.spacer(),
                      _SettingsListItem.singleLine(
                        heading: localizations.aboutHeader,
                        headingStyle:
                            ArchethicThemeStyles.textStyleSize16W600Primary,
                        icon: Symbols.info,
                        onPressed: showAbout,
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
                      const _SettingsListItem.spacer(),
                      _SettingsListItem.singleLine(
                        heading: localizations.manualLockAction,
                        headingStyle:
                            ArchethicThemeStyles.textStyleSize16W600Primary,
                        icon: Symbols.lock,
                        displayChevron: false,
                        onPressed: () {
                          ref
                              .read(
                                AuthenticationProviders
                                    .authenticationGuard.notifier,
                              )
                              .lock();
                        },
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
