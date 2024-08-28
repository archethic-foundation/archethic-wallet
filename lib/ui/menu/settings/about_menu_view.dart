part of 'settings_sheet.dart';

class AboutMenuView extends ConsumerWidget implements SheetSkeletonInterface {
  const AboutMenuView({
    super.key,
  });

  static const routerPage = '/about_menu_view';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SheetSkeleton(
      appBar: getAppBar(context, ref),
      floatingActionButton: getFloatingActionButton(context, ref),
      sheetContent: getSheetContent(context, ref),
      menu: true,
    );
  }

  @override
  Widget getFloatingActionButton(BuildContext context, WidgetRef ref) {
    return const SizedBox.shrink();
  }

  @override
  PreferredSizeWidget getAppBar(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    return SheetAppBar(
      title: localizations.aboutHeader,
      widgetLeft: BackButton(
        key: const Key('back'),
        color: ArchethicTheme.text,
        onPressed: () {
          context.go(SettingsSheetWallet.routerPage);
        },
      ),
    );
  }

  @override
  Widget getSheetContent(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);

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
                                  style: ArchethicThemeStyles
                                      .textStyleSize14W200Primary,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const _SettingsListItem.spacer(),
                      if (connectivityStatusProvider ==
                          ConnectivityStatus.isConnected)
                        _SettingsListItem.singleLine(
                          heading: localizations.aboutPrivacyPolicy,
                          headingStyle:
                              ArchethicThemeStyles.textStyleSize16W600Primary,
                          icon: Symbols.policy_rounded,
                          onPressed: () async {
                            await launchUrl(
                              Uri.parse(
                                'https://www.archethic.net/privacy-policy-wallet.html',
                              ),
                              mode: LaunchMode.externalApplication,
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
