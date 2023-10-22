part of 'settings_sheet.dart';

class AboutMenuView extends ConsumerWidget {
  const AboutMenuView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);
    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        backgroundColor: theme.background,
        title: AutoSizeText(
          localizations.aboutHeader,
          style: theme.textStyleSize24W700TelegrafPrimary,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  ListView(
                    padding: const EdgeInsets.only(top: 15),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 10),
                        child: Row(
                          children: <Widget>[
                            Consumer(
                              builder: (context, ref, child) {
                                final asyncVersionString = ref.watch(
                                  versionStringProvider(
                                    AppLocalizations.of(context)!,
                                  ),
                                );

                                return Text(
                                  asyncVersionString.asData?.value ?? '',
                                  style: theme.textStyleSize14W100Primary,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      /*const _SettingsListItem.spacer(),
                      _SettingsListItem.singleLine(
                        heading: localizations.aboutGeneralTermsAndConditions,
                        headingStyle: theme.textStyleSize16W600Primary,
                        icon: 'assets/icons/terms-and-conditions.png',
                        iconColor: theme.iconDrawer!,
                        onPressed: () async {
                          UIUtil.showWebview(
                            context,
                            'https://archethic.net',
                            localizations.aboutGeneralTermsAndConditions,
                          );
                        },
                      ),
                      const _SettingsListItem.spacer(),
                      _SettingsListItem.singleLine(
                        heading: localizations.aboutWalletServiceTerms,
                        headingStyle: theme.textStyleSize16W600Primary,
                        icon: 'assets/icons/walletServiceTerms.png',
                        iconColor: theme.iconDrawer!,
                        onPressed: () async {
                          UIUtil.showWebview(
                            context,
                            'https://archethic.net',
                            localizations.aboutWalletServiceTerms,
                          );
                        },
                      ),*/
                      const _SettingsListItem.spacer(),
                      if (connectivityStatusProvider ==
                          ConnectivityStatus.isConnected)
                        _SettingsListItem.singleLine(
                          heading: localizations.aboutPrivacyPolicy,
                          headingStyle: theme.textStyleSize16W600Primary,
                          icon: Symbols.policy_rounded,
                          onPressed: () async {
                            UIUtil.showWebview(
                              context,
                              'https://archethic.net/aewallet-privacy.html',
                              localizations.aboutPrivacyPolicy,
                            );
                          },
                        ),
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
