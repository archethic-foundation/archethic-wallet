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
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: theme.text05,
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsetsDirectional.only(
                            top: 20,
                            bottom: 10,
                          ),
                          child: Text(
                            localizations.preferences,
                            style: theme.textStyleSize24W700EquinoxPrimary,
                          ),
                        ),
                      ),
                      const _SettingsListItem.spacer(),
                      const _CurrencySettingsListItem(),
                      const _SettingsListItem.spacer(),
                      _SettingsListItem.withDefaultValue(
                        heading: localizations.primaryCurrency,
                        defaultMethod: primaryCurrency,
                        icon: 'assets/icons/menu/primary-currency.svg',
                        iconColor: theme.iconDrawer!,
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
                      const _ShowBlogSettingsListItem(),
                      const _SettingsListItem.spacer(),
                      const _ShowPriceChartSettingsListItem(),
                      if (hasNotifications) const _SettingsListItem.spacer(),
                      if (hasNotifications)
                        const _ActiveNotificationsSettingsListItem(),
                      const _SettingsListItem.spacer(),
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
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final currency = ref.watch(CurrencyProviders.selectedCurrency);
    return _SettingsListItem.withDefaultValueWithInfos(
      heading: localizations.changeCurrencyHeader,
      info: localizations.changeCurrencyDesc.replaceAll(
        '%1',
        StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel(),
      ),
      defaultMethod: currency,
      icon: 'assets/icons/menu/currency.svg',
      iconColor: theme.iconDrawer!,
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
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final language = ref.watch(LanguageProviders.selectedLanguage);

    return _SettingsListItem.withDefaultValue(
      heading: localizations.language,
      defaultMethod: language,
      icon: 'assets/icons/menu/language.svg',
      iconColor: theme.iconDrawer!,
      onPressed: () => LanguageDialog.getDialog(context, ref),
    );
  }
}

class _ThemeSettingsListItem extends ConsumerWidget {
  const _ThemeSettingsListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);

    final themeOption = ref.watch(ThemeProviders.selectedThemeOption);
    return _SettingsListItem.withDefaultValue(
      heading: localizations.themeHeader,
      defaultMethod: ThemeSetting(themeOption),
      icon: 'assets/icons/menu/theme.svg',
      iconColor: theme.iconDrawer!,
      onPressed: () async {
        final pickedTheme = await ThemeDialog.getDialog(
          context,
          ref,
          ThemeSetting(themeOption),
        );
        if (pickedTheme == null) return;

        await ref.read(
          ThemeProviders.selectTheme(theme: pickedTheme.theme).future,
        );
      },
    );
  }
}

class _ShowBalancesSettingsListItem extends ConsumerWidget {
  const _ShowBalancesSettingsListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final showBalancesSetting = ref
        .watch(preferenceProvider.select((settings) => settings.showBalances));
    final preferencesNotifier = ref.read(preferenceProvider.notifier);
    return _SettingsListItem.withSwitch(
      heading: localizations.showBalances,
      icon: 'assets/icons/menu/show-balance.svg',
      iconColor: theme.iconDrawer!,
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
    final theme = ref.watch(ThemeProviders.selectedTheme);

    final showBlogSetting =
        ref.watch(preferenceProvider.select((settings) => settings.showBlog));
    final preferencesNotifier = ref.read(preferenceProvider.notifier);

    return _SettingsListItem.withSwitch(
      heading: localizations.showBlog,
      icon: 'assets/icons/menu/show-blog.svg',
      iconColor: theme.iconDrawer!,
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
    final theme = ref.watch(ThemeProviders.selectedTheme);

    final showPriceChart = ref.watch(
      preferenceProvider.select((settings) => settings.showPriceChart),
    );
    final preferencesNotifier = ref.read(preferenceProvider.notifier);

    return _SettingsListItem.withSwitch(
      heading: localizations.showPriceChart,
      icon: 'assets/icons/menu/show-chart.svg',
      iconColor: theme.iconDrawer!,
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
    final theme = ref.watch(ThemeProviders.selectedTheme);

    final activeNotifications = ref.watch(
      preferenceProvider.select((settings) => settings.activeNotifications),
    );
    final preferencesNotifier = ref.read(preferenceProvider.notifier);

    return _SettingsListItem.withSwitch(
      heading: localizations.activateNotifications,
      icon: 'assets/icons/menu/notification.svg',
      iconColor: theme.iconDrawer!,
      isSwitched: activeNotifications,
      onChanged: (bool isSwitched) async {
        await preferencesNotifier.setActiveNotifications(isSwitched);
        if (StateContainer.of(context).timerCheckTransactionInputs != null) {
          StateContainer.of(context).timerCheckTransactionInputs!.cancel();
        }
        if (isSwitched) {
          StateContainer.of(context).checkTransactionInputs(
            localizations.transactionInputNotification,
          );
        }
      },
    );
  }
}

class _ActiveVibrationsSettingsListItem extends ConsumerWidget {
  const _ActiveVibrationsSettingsListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);

    final activeVibrations = ref.watch(
      preferenceProvider.select((settings) => settings.activeVibrations),
    );
    final preferencesNotifier = ref.read(preferenceProvider.notifier);

    return _SettingsListItem.withSwitch(
      heading: localizations.activateVibrations,
      icon: 'assets/icons/menu/vibration.svg',
      iconColor: theme.iconDrawer!,
      isSwitched: activeVibrations,
      onChanged: (bool isSwitched) async {
        await preferencesNotifier.setActiveVibrations(isSwitched);
      },
    );
  }
}
