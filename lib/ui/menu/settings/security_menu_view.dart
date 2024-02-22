/// SPDX-License-Identifier: AGPL-3.0-or-later
part of 'settings_sheet.dart';

class SecurityMenuView extends ConsumerWidget
    implements SheetSkeletonInterface {
  const SecurityMenuView({
    super.key,
  });

  static const routerPage = '/security_menu_view';

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
      title: localizations.securityHeader,
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
    final authenticationMethod = ref.watch(
      AuthenticationProviders.settings.select(
        (settings) => settings.authenticationMethod,
      ),
    );

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
                      // Authentication Method
                      const _AuthMethodSettingsListItem(),
                      // Authenticate on Launch
                      const _SettingsListItem.spacer(),
                      const _LockSettingsListItem(),
                      // Authentication Timer
                      const _SettingsListItem.spacer(),
                      const _AutoLockSettingsListItem(),
                      const _SettingsListItem.spacer(),
                      const _BackupSecretPhraseListItem(),
                      const _SettingsListItem.spacer(),
                      if (ArchethicWebsocketRPCServer.isPlatformCompatible)
                        const _ActiveServerRPCSettingsListItem(),
                      if (ArchethicWebsocketRPCServer.isPlatformCompatible)
                        const _SettingsListItem.spacer(),
                      if (authenticationMethod == AuthMethod.pin)
                        const _PinPadShuffleSettingsListItem(),
                      if (authenticationMethod == AuthMethod.pin)
                        const _SettingsListItem.spacer(),
                      if (connectivityStatusProvider ==
                          ConnectivityStatus.isConnected)
                        const _SyncBlockchainSettingsListItem(),
                      if (connectivityStatusProvider ==
                          ConnectivityStatus.isConnected)
                        const _SettingsListItem.spacer(),
                      _SettingsListItem.singleLineWithInfos(
                        heading: localizations.removeWallet,
                        info: localizations.removeWalletDescription,
                        headingStyle:
                            ArchethicThemeStyles.textStyleSize16W600Red,
                        icon: Symbols.delete,
                        onPressed: () {
                          final language = ref.read(
                            LanguageProviders.selectedLanguage,
                          );

                          AppDialogs.showConfirmDialog(
                              context,
                              ref,
                              CaseChange.toUpperCase(
                                localizations.warning,
                                language.getLocaleString(),
                              ),
                              localizations.removeWalletDetail,
                              localizations.removeWalletAction, () {
                            // Show another confirm dialog
                            AppDialogs.showConfirmDialog(
                              context,
                              ref,
                              localizations.areYouSure,
                              localizations.removeWalletReassurance,
                              localizations.yes,
                              () async {
                                final auth = await AuthFactory.authenticate(
                                  context,
                                  ref,
                                  activeVibrations: ref
                                      .read(SettingsProviders.settings)
                                      .activeVibrations,
                                );
                                if (auth) {
                                  await ref
                                      .read(SessionProviders.session.notifier)
                                      .logout();
                                  context.go(Splash.routerPage);
                                }
                              },
                            );
                          });
                        },
                      ),
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

class _AuthMethodSettingsListItem extends ConsumerWidget {
  const _AuthMethodSettingsListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final authenticationMethod = ref.watch(
      AuthenticationProviders.settings.select(
        (settings) => settings.authenticationMethod,
      ),
    );
    final asyncHasBiometrics = ref.watch(DeviceAbilities.hasBiometricsProvider);

    return _SettingsListItem.withDefaultValue(
      heading: localizations.authMethod,
      defaultMethod: AuthenticationMethod(authenticationMethod),
      icon: Symbols.fingerprint,
      onPressed: asyncHasBiometrics.maybeWhen(
        data: (hasBiometrics) => () async {
          final auth = await AuthFactory.authenticate(
            context,
            ref,
            activeVibrations:
                ref.read(SettingsProviders.settings).activeVibrations,
          );
          if (auth) {
            return AuthentificationMethodDialog.getDialog(
              context,
              ref,
              hasBiometrics,
              AuthenticationMethod(authenticationMethod),
            );
          }
        },
        orElse: () => () {},
      ),
    );
  }
}

class _LockSettingsListItem extends ConsumerWidget {
  const _LockSettingsListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final lock = ref.watch(
      AuthenticationProviders.settings.select(
        (settings) => settings.lock,
      ),
    );
    final authenticationSettingsNotifier =
        ref.read(AuthenticationProviders.settings.notifier);

    return _SettingsListItem.withDefaultValue(
      heading: localizations.lockAppSetting,
      defaultMethod: UnlockSetting(lock),
      icon: Symbols.login,
      onPressed: () async {
        final unlockSetting = await LockDialog.getDialog(
          context,
          ref,
          UnlockSetting(lock),
        );
        if (unlockSetting == null) return;
        await authenticationSettingsNotifier.setLockApp(unlockSetting.setting);
      },
    );
  }
}

class _AutoLockSettingsListItem extends ConsumerWidget {
  const _AutoLockSettingsListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final lock = ref.watch(
      AuthenticationProviders.settings.select(
        (settings) => settings.lock,
      ),
    );
    final lockTimeout = ref.watch(
      AuthenticationProviders.settings.select(
        (settings) => settings.lockTimeout,
      ),
    );
    final authenticationSettingsNotifier =
        ref.read(AuthenticationProviders.settings.notifier);

    return _SettingsListItem.withDefaultValue(
      heading: localizations.autoLockHeader,
      defaultMethod: LockTimeoutSetting(lockTimeout),
      icon: Symbols.lock,
      onPressed: () async {
        final lockTimeoutSetting = await LockTimeoutDialog.getDialog(
          context,
          ref,
          LockTimeoutSetting(lockTimeout),
        );
        if (lockTimeoutSetting == null) return;
        await authenticationSettingsNotifier
            .setLockTimeout(lockTimeoutSetting.setting);
      },
      disabled: lock == UnlockOption.no,
    );
  }
}

class _PinPadShuffleSettingsListItem extends ConsumerWidget {
  const _PinPadShuffleSettingsListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final pinPadShuffle = ref.watch(
      AuthenticationProviders.settings.select(
        (settings) => settings.pinPadShuffle,
      ),
    );

    return _SettingsListItem.withSwitch(
      heading: localizations.pinPadShuffle,
      icon: Symbols.shuffle,
      isSwitched: pinPadShuffle,
      onChanged: (bool isSwitched) {
        ref
            .read(
              AuthenticationProviders.settings.notifier,
            )
            .setPinPadShuffle(isSwitched);
      },
    );
  }
}

class _BackupSecretPhraseListItem extends ConsumerWidget {
  const _BackupSecretPhraseListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    return _SettingsListItem.singleLine(
      heading: localizations.backupSecretPhrase,
      headingStyle: ArchethicThemeStyles.textStyleSize16W600Primary,
      icon: Symbols.key,
      onPressed: () async {
        final preferences = ref.read(SettingsProviders.settings);

        final auth = await AuthFactory.authenticate(
          context,
          ref,
          activeVibrations: preferences.activeVibrations,
        );
        if (auth) {
          await ref.ensuresAutolockMaskHidden();

          final seed = ref.read(SessionProviders.session).loggedIn?.wallet.seed;
          final mnemonic = AppMnemomics.seedToMnemonic(
            seed!,
            languageCode: preferences.languageSeed,
          );

          context.go(
            AppSeedBackupSheet.routerPage,
            extra: {'mnemonic': mnemonic, 'seed': seed},
          );
        }
      },
    );
  }
}

class _SyncBlockchainSettingsListItem extends ConsumerWidget {
  const _SyncBlockchainSettingsListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    return _SettingsListItem.singleLineWithInfos(
      heading: localizations.resyncWallet,
      info: localizations.resyncWalletDescription,
      icon: Symbols.sync,
      onPressed: () async {
        AppDialogs.showConfirmDialog(context, ref, localizations.resyncWallet,
            localizations.resyncWalletAreYouSure, localizations.yes, () async {
          final session = ref.read(SessionProviders.session).loggedIn!;
          for (final element in session.wallet.appKeychain.accounts) {
            await element.clearRecentTransactionsFromCache();
          }
          final cache = await Hive.openBox<CacheItemHive>(
            CacheManagerHive.cacheManagerHiveTable,
          );
          await cache.clear();
          final tokensListDatasource =
              await HiveTokensListDatasource.getInstance();
          await tokensListDatasource.clearAll();
          await ref
              .read(AccountProviders.selectedAccount.notifier)
              .refreshRecentTransactions();
        });
      },
      displayChevron: false,
    );
  }
}

class _ActiveServerRPCSettingsListItem extends ConsumerWidget {
  const _ActiveServerRPCSettingsListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final activeRPCServer = ref.watch(
      SettingsProviders.settings.select((settings) => settings.activeRPCServer),
    );
    final preferencesNotifier = ref.read(SettingsProviders.settings.notifier);

    return _SettingsListItem.withSwitch(
      heading: localizations.activeRPCServer,
      icon: Symbols.share,
      isSwitched: activeRPCServer,
      onChanged: (bool isSwitched) async {
        await preferencesNotifier.setActiveRPCServer(isSwitched);
        if (isSwitched) {
          await sl.get<ArchethicWebsocketRPCServer>().run();
        } else {
          await sl.get<ArchethicWebsocketRPCServer>().stop();
        }
      },
    );
  }
}
