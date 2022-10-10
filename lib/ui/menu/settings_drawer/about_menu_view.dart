part of 'settings_drawer.dart';

final versionStringProvider = FutureProvider.autoDispose.family<String, AppLocalization>(
  (ref, localizations) async {
    final packageInfo = await PackageInfo.fromPlatform();

    return '${localizations.version} ${packageInfo.version} - ${localizations.build} ${packageInfo.buildNumber}';
  },
);

class AboutMenuView extends ConsumerWidget {
  const AboutMenuView({
    required this.onClose,
    super.key,
  });

  final VoidCallback onClose;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.read(ThemeProviders.theme);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.drawerBackground,
        gradient: LinearGradient(
          colors: <Color>[
            theme.drawerBackground!,
            theme.backgroundDark!,
          ],
          begin: Alignment.center,
          end: const Alignment(5, 0),
        ),
      ),
      child: SafeArea(
        minimum: const EdgeInsets.only(
          top: 60,
        ),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 10, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(right: 10, left: 10),
                    child: BackButton(
                      key: const Key('back'),
                      color: theme.text,
                      onPressed: onClose,
                    ),
                  ),
                  Expanded(
                    child: AutoSizeText(
                      localizations.aboutHeader,
                      style: theme.textStyleSize24W700EquinoxPrimary,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
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
                                  versionStringProvider(AppLocalization.of(context)!),
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
                      const _SettingsListItem.spacer(),
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
                      ),
                      const _SettingsListItem.spacer(),
                      _SettingsListItem.singleLine(
                        heading: localizations.aboutPrivacyPolicy,
                        headingStyle: theme.textStyleSize16W600Primary,
                        icon: 'assets/icons/privacyPolicy.png',
                        iconColor: theme.iconDrawer!,
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
                  //List Top Gradient End
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 20,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[theme.drawerBackground!, theme.backgroundDark00!],
                          begin: const AlignmentDirectional(0.5, -1),
                          end: const AlignmentDirectional(0.5, 1),
                        ),
                      ),
                    ),
                  ), //List Top Gradient End
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
