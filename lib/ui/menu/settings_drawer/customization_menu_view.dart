part of 'settings_drawer.dart';

class CustomizationMenuView extends ConsumerWidget {
  const CustomizationMenuView({
    required this.onClose,
    super.key,
  });

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final primaryCurrency =
        ref.watch(PrimaryCurrencyProviders.selectedPrimaryCurrency);
    final hasNotifications =
        ref.watch(DeviceAbilities.hasNotificationsProvider);
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);
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
                  Row(
                    children: <Widget>[
                      //Back button
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
                      Text(
                        localizations.customHeader,
                        style: theme.textStyleSize24W700EquinoxPrimary,
                      ),
                    ],
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
                      _SettingsListItem.title(text: localizations.preferences),
                      const _SettingsListItem.spacer(),
                      const _CurrencySettingsListItem(),
                      const _SettingsListItem.spacer(),
                      _SettingsListItem.withDefaultValue(
                        heading: localizations.primaryCurrency,
                        defaultMethod: primaryCurrency,
                        icon: primaryCurrency.primaryCurrency ==
                                AvailablePrimaryCurrencyEnum.fiat
                            ? UiIcons.primary_currency
                            : UiIcons.primary_currency_uco,
                        onPressed: () =>
                            PrimaryCurrencyDialog.getDialog(context, ref),
                      ),
                      const _SettingsListItem.spacer(),
                      const _LanguageSettingsListItem(),
                      const _SettingsListItem.spacer(),
                      const _ThemeSettingsListItem(),
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
                      if (!kIsWeb && (Platform.isAndroid || Platform.isIOS))
                        const _SettingsListItem.spacer(),
                      if (!kIsWeb && (Platform.isAndroid || Platform.isIOS))
                        const _ActiveVibrationsSettingsListItem(),
                      const _SettingsListItem.spacer(),
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
                          colors: <Color>[
                            theme.drawerBackground!,
                            theme.backgroundDark00!
                          ],
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

class _CurrencySettingsListItem extends ConsumerWidget {
  const _CurrencySettingsListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final currency = ref.watch(
      SettingsProviders.settings.select((settings) => settings.currency),
    );
    return _SettingsListItem.withDefaultValueWithInfos(
      heading: localizations.changeCurrencyHeader,
      info: localizations.changeCurrencyDesc
          .replaceAll('%1', AccountBalance.cryptoCurrencyLabel),
      defaultMethod: AvailableCurrency(currency),
      icon: UiIcons.currency,
      onPressed: () => CurrencyDialog.getDialog(context, ref),
      disabled: false,
    );
  }
}

class _LanguageSettingsListItem extends ConsumerWidget {
  const _LanguageSettingsListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final language = ref.watch(LanguageProviders.selectedLanguage);

    return _SettingsListItem.withDefaultValue(
      heading: localizations.language,
      defaultMethod: LanguageSetting(language),
      icon: UiIcons.language,
      onPressed: () => LanguageDialog.getDialog(context, ref),
    );
  }
}

class _ThemeSettingsListItem extends ConsumerWidget {
  const _ThemeSettingsListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;

    final themeOption = ref.watch(
      SettingsProviders.settings.select((settings) => settings.theme),
    );
    return _SettingsListItem.withDefaultValue(
      heading: localizations.themeHeader,
      defaultMethod: ThemeSetting(themeOption),
      icon: UiIcons.theme,
      onPressed: () async {
        final pickedTheme = await ThemeDialog.getDialog(
          context,
          ref,
          ThemeSetting(themeOption),
        );
        if (pickedTheme == null) return;

        await ref
            .read(SettingsProviders.settings.notifier)
            .selectTheme(pickedTheme.theme);
      },
    );
  }
}

class _ShowBalancesSettingsListItem extends ConsumerWidget {
  const _ShowBalancesSettingsListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final showBalancesSetting = ref.watch(
      SettingsProviders.settings.select((settings) => settings.showBalances),
    );
    final preferencesNotifier = ref.read(SettingsProviders.settings.notifier);
    return _SettingsListItem.withSwitch(
      heading: localizations.showBalances,
      icon: UiIcons.show_balance,
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
    final localizations = AppLocalization.of(context)!;

    final showBlogSetting = ref.watch(
      SettingsProviders.settings.select((settings) => settings.showBlog),
    );
    final preferencesNotifier = ref.read(SettingsProviders.settings.notifier);

    return _SettingsListItem.withSwitch(
      heading: localizations.showBlog,
      icon: UiIcons.show_blog,
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
    final localizations = AppLocalization.of(context)!;

    final showPriceChart = ref.watch(
      SettingsProviders.settings.select((settings) => settings.showPriceChart),
    );
    final preferencesNotifier = ref.read(SettingsProviders.settings.notifier);

    return _SettingsListItem.withSwitch(
      heading: localizations.showPriceChart,
      icon: UiIcons.show_chart,
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
    final localizations = AppLocalization.of(context)!;

    final activeNotifications = ref.watch(
      SettingsProviders.settings
          .select((settings) => settings.activeNotifications),
    );
    final preferencesNotifier = ref.read(SettingsProviders.settings.notifier);

    return _SettingsListItem.withSwitch(
      heading: localizations.activateNotifications,
      icon: UiIcons.notification,
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
    final localizations = AppLocalization.of(context)!;

    final activeVibrations = ref.watch(
      SettingsProviders.settings
          .select((settings) => settings.activeVibrations),
    );
    final preferencesNotifier = ref.read(SettingsProviders.settings.notifier);

    return _SettingsListItem.withSwitch(
      heading: localizations.activateVibrations,
      icon: UiIcons.vibration,
      isSwitched: activeVibrations,
      onChanged: (bool isSwitched) async {
        await preferencesNotifier.setActiveVibrations(isSwitched);
      },
    );
  }
}
