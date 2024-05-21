part of 'settings_sheet.dart';

class CustomizationMenuView extends ConsumerWidget
    implements SheetSkeletonInterface {
  const CustomizationMenuView({
    super.key,
  });

  static const routerPage = '/customization_menu_view';

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
      title: localizations.customHeader,
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
    final primaryCurrency =
        ref.watch(PrimaryCurrencyProviders.selectedPrimaryCurrency);
    final hasNotifications =
        ref.watch(DeviceAbilities.hasNotificationsProvider);
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
                    children: <Widget>[
                      const _CurrencySettingsListItem(),
                      const _SettingsListItem.spacer(),
                      _SettingsListItem.withDefaultValue(
                        heading: localizations.primaryCurrency,
                        defaultMethod: primaryCurrency,
                        icon: Symbols.currency_exchange,
                        onPressed: () =>
                            PrimaryCurrencyDialog.getDialog(context, ref),
                      ),
                      const _SettingsListItem.spacer(),
                      const _LanguageSettingsListItem(),
                      const _SettingsListItem.spacer(),
                      const _ShowBalancesSettingsListItem(),
                      const _SettingsListItem.spacer(),
                      if (connectivityStatusProvider ==
                          ConnectivityStatus.isConnected)
                        const _ShowBlogSettingsListItem(),
                      if (connectivityStatusProvider ==
                          ConnectivityStatus.isConnected)
                        const _SettingsListItem.spacer(),
                      const _ShowPriceChartSettingsListItem(),
                      if (hasNotifications &&
                          connectivityStatusProvider ==
                              ConnectivityStatus.isConnected)
                        const _SettingsListItem.spacer(),
                      if (hasNotifications &&
                          connectivityStatusProvider ==
                              ConnectivityStatus.isConnected)
                        const _ActiveNotificationsSettingsListItem(),
                      if (UniversalPlatform.isMobile)
                        const _SettingsListItem.spacer(),
                      if (UniversalPlatform.isMobile)
                        const _ActiveVibrationsSettingsListItem(),
                      const _SettingsListItem.spacer(),
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

class _CurrencySettingsListItem extends ConsumerWidget {
  const _CurrencySettingsListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final currency = ref.watch(
      SettingsProviders.settings.select((settings) => settings.currency),
    );
    return _SettingsListItem.withDefaultValueWithInfos(
      heading: localizations.changeCurrencyHeader,
      info: localizations.changeCurrencyDesc
          .replaceAll('%1', AccountBalance.cryptoCurrencyLabel),
      defaultMethod: AvailableCurrency(currency),
      icon: Symbols.euro,
      onPressed: () => CurrencyDialog.getDialog(context, ref),
      disabled: false,
    );
  }
}

class _LanguageSettingsListItem extends ConsumerWidget {
  const _LanguageSettingsListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final language = ref.watch(LanguageProviders.selectedLanguage);

    return _SettingsListItem.withDefaultValue(
      heading: localizations.language,
      defaultMethod: LanguageSetting(language),
      icon: Symbols.translate,
      onPressed: () => LanguageDialog.getDialog(context, ref),
    );
  }
}

class _ShowBalancesSettingsListItem extends ConsumerWidget {
  const _ShowBalancesSettingsListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final showBalancesSetting = ref.watch(
      SettingsProviders.settings.select((settings) => settings.showBalances),
    );
    final preferencesNotifier = ref.read(SettingsProviders.settings.notifier);
    return _SettingsListItem.withSwitch(
      heading: localizations.showBalances,
      icon: Symbols.account_balance_wallet,
      isSwitched: showBalancesSetting,
      onChanged: (showBalances) async {
        await preferencesNotifier.setShowBalances(showBalances);
      },
    );
  }
}

class _ShowBlogSettingsListItem extends ConsumerWidget {
  const _ShowBlogSettingsListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final showBlogSetting = ref.watch(
      SettingsProviders.settings.select((settings) => settings.showBlog),
    );
    final preferencesNotifier = ref.read(SettingsProviders.settings.notifier);

    return _SettingsListItem.withSwitch(
      heading: localizations.showBlog,
      icon: Symbols.article,
      isSwitched: showBlogSetting,
      onChanged: (showBlog) async {
        await preferencesNotifier.setShowBlog(showBlog);
      },
    );
  }
}

class _ShowPriceChartSettingsListItem extends ConsumerWidget {
  const _ShowPriceChartSettingsListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final showPriceChart = ref.watch(
      SettingsProviders.settings.select((settings) => settings.showPriceChart),
    );
    final preferencesNotifier = ref.read(SettingsProviders.settings.notifier);

    return _SettingsListItem.withSwitch(
      heading: localizations.showPriceChart,
      icon: Symbols.show_chart,
      isSwitched: showPriceChart,
      onChanged: (showPriceChart) async {
        await preferencesNotifier.setShowPriceChart(showPriceChart);
      },
    );
  }
}

class _ActiveNotificationsSettingsListItem extends ConsumerWidget {
  const _ActiveNotificationsSettingsListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final activeNotifications = ref.watch(
      SettingsProviders.settings
          .select((settings) => settings.activeNotifications),
    );
    final preferencesNotifier = ref.read(SettingsProviders.settings.notifier);

    return _SettingsListItem.withSwitch(
      heading: localizations.activateNotifications,
      icon: Symbols.notifications,
      isSwitched: activeNotifications,
      onChanged: (bool isSwitched) async {
        await preferencesNotifier.setActiveNotifications(isSwitched);
      },
    );
  }
}

class _ActiveVibrationsSettingsListItem extends ConsumerWidget {
  const _ActiveVibrationsSettingsListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final activeVibrations = ref.watch(
      SettingsProviders.settings
          .select((settings) => settings.activeVibrations),
    );
    final preferencesNotifier = ref.read(SettingsProviders.settings.notifier);

    return _SettingsListItem.withSwitch(
      heading: localizations.activateVibrations,
      icon: Symbols.vibration,
      isSwitched: activeVibrations,
      onChanged: (bool isSwitched) async {
        await preferencesNotifier.setActiveVibrations(isSwitched);
      },
    );
  }
}
