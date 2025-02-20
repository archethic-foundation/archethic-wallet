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
          context.pop();
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
    final settings = ref.watch(SettingsProviders.settings);

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            aedappfm.ArchethicThemeBase.blue700.withOpacity(0.4),
            aedappfm.ArchethicThemeBase.blue700.withOpacity(1),
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
                      // Authentication Timer
                      if (FeatureFlags.privacyMask) ...[
                        const _SettingsListItem.spacer(),
                        const _PrivacyMaskSettingsListItem(),
                      ],
                      const _SettingsListItem.spacer(),
                      const _AutoLockSettingsListItem(),
                      const _SettingsListItem.spacer(),
                      const _BackupSecretPhraseListItem(),
                      const _SettingsListItem.spacer(),
                      _SettingsListItem.singleLineWithInfos(
                        heading: localizations.switchEnvHeader,
                        info: localizations.switchEnvHeaderInfo(
                          settings.environment.displayName,
                        ),
                        headingStyle:
                            ArchethicThemeStyles.textStyleSize16W600Primary,
                        icon: Symbols.deployed_code_account,
                        onPressed: () async {
                          await _switchEnv(context, ref);
                        },
                      ),
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
                          RemoveWalletDialog.show(context, ref);
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

  Future<void> _switchEnv(BuildContext context, WidgetRef ref) async {
    final settings = ref.watch(SettingsProviders.settings);
    final localizations = AppLocalizations.of(context)!;

    final _saveEnvironment = settings.environment;
    final _selectedEnvironment = await context
        .push(EnvironmentDialog.routerPage) as aedappfm.Environment?;
    if (_selectedEnvironment == null) return;
    if (_selectedEnvironment != _saveEnvironment) {
      final seed = ref.read(sessionNotifierProvider).loggedIn?.wallet.seed;

      var keychainNetworkExists = false;

      try {
        await archethic.ApiService(
          _selectedEnvironment.endpoint,
        ).getKeychain(seed!);
        keychainNetworkExists = true;
        // ignore: empty_catches
      } catch (e) {}

      if (keychainNetworkExists == false) {
        final session = ref.read(sessionNotifierProvider);

        final accounts = await AccountsDialog.selectMultipleAccounts(
          context: context,
          accounts: session.loggedIn!.wallet.appKeychain.accounts,
          confirmBtnLabel: localizations.networkChangeCreateKeychainBtn,
          dialogTitle: localizations.networkChangeHeader,
          isModal: true,
          header: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Text(
                  localizations.networkChangeKeychainNotExists(
                    _selectedEnvironment.displayName,
                  ),
                  style: AppTextStyles.bodySmall(context),
                ),
              ],
            ),
          ),
        );

        final nameList = <String>[];
        if (accounts == null || accounts.isEmpty) {
          return;
        }
        for (final account in accounts) {
          nameList.add(Uri.decodeFull(account.name));
        }

        try {
          context.loadingOverlay.show(
            title: AppLocalizations.of(context)!.pleaseWaitChangeNetwork,
          );
          final originKeychain = await archethic.ApiService(
            _saveEnvironment.endpoint,
          ).getKeychain(seed!);
          await ref.read(createNewAppWalletCaseProvider).run(
                seed,
                archethic.ApiService(_selectedEnvironment.endpoint),
                nameList,
                keychainSeed: originKeychain.seed == null
                    ? null
                    : archethic.uint8ListToHex(originKeychain.seed!),
              );

          UIUtil.showSnackbar(
            localizations.walletCreatedTargetEnv(
              _selectedEnvironment.displayName,
            ),
            context,
            ref,
            ArchethicTheme.text,
            ArchethicTheme.snackBarShadow,
            duration: const Duration(milliseconds: 5000),
            icon: Symbols.info,
          );
        } catch (e) {
          UIUtil.showSnackbar(
            '${localizations.walletNotCreatedTargetEnv(_selectedEnvironment.displayName)} (${_getErrorMessage(e)})',
            context,
            ref,
            ArchethicTheme.text,
            ArchethicTheme.snackBarShadow,
            duration: const Duration(milliseconds: 5000),
          );

          context.loadingOverlay.hide();
          context.pop();
          return;
        }
      } else {
        context.loadingOverlay.show(
          title: AppLocalizations.of(context)!.pleaseWaitChangeNetwork,
        );
      }

      try {
        final languageSeed = ref.read(
          SettingsProviders.settings.select(
            (settings) => settings.languageSeed,
          ),
        );
        await ref
            .read(SettingsProviders.settings.notifier)
            .setEnvironment(_selectedEnvironment);

        await ref.read(sessionNotifierProvider.notifier).restoreFromSeed(
              seed: seed!,
              languageCode: languageSeed,
            );

        final accounts = await ref.read(accountsNotifierProvider.future);

        await ref
            .read(accountsNotifierProvider.notifier)
            .selectAccount(accounts.first);

        unawaited(
          (await ref
                  .read(accountsNotifierProvider.notifier)
                  .selectedAccountNotifier)
              ?.refreshAll(),
        );
        context.loadingOverlay.hide();
      } catch (e) {
        UIUtil.showSnackbar(
          '${localizations.walletChangeLoadingError} (${_getErrorMessage(e)})',
          context,
          ref,
          ArchethicTheme.text,
          ArchethicTheme.snackBarShadow,
          duration: const Duration(milliseconds: 5000),
        );

        await ref
            .read(SettingsProviders.settings.notifier)
            .setEnvironment(_saveEnvironment);

        context.loadingOverlay.hide();
        context.pop();
      }
    }
  }

  String _getErrorMessage(Object e) {
    if (e is archethic.ArchethicConnectionException) {
      return e.cause;
    } else if (e is archethic.ArchethicInvalidResponseException) {
      return e.cause;
    } else if (e is ArchethicNewKeychainErrorException) {
      return e.cause;
    } else if (e is ArchethicNewKeychainAccessErrorException) {
      return e.cause;
    }
    return e.toString();
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

    return _SettingsListItem.withDefaultValue(
      heading: localizations.authMethod,
      defaultValue: AuthenticationMethod(authenticationMethod),
      icon: Symbols.fingerprint,
      onPressed: () async {
        final auth = await AuthFactory.of(context).authenticate();
        if (!auth) return;

        await AuthentificationMethodDialog.getDialog(
          context,
          ref,
          AuthenticationMethod(authenticationMethod),
        );
      },
    );
  }
}

class _PrivacyMaskSettingsListItem extends ConsumerWidget {
  const _PrivacyMaskSettingsListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final maskEnabled = ref.watch(
      AuthenticationProviders.settings.select(
        (settings) => settings.privacyMask == PrivacyMaskOption.enabled,
      ),
    );

    return _SettingsListItem.withSwitch(
      heading: localizations.privacyMaskSetting,
      icon: Symbols.eye_tracking,
      isSwitched: maskEnabled,
      onChanged: (bool isSwitched) {
        ref
            .read(
              AuthenticationProviders.settings.notifier,
            )
            .setPrivacyMask(
              isSwitched
                  ? PrivacyMaskOption.enabled
                  : PrivacyMaskOption.disabled,
            );
      },
    );
  }
}

class _AutoLockSettingsListItem extends ConsumerWidget {
  const _AutoLockSettingsListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    final lockTimeout = ref.watch(
      AuthenticationProviders.settings.select(
        (settings) => settings.lockTimeout,
      ),
    );
    final authenticationSettingsNotifier =
        ref.read(AuthenticationProviders.settings.notifier);

    return _SettingsListItem.withDefaultValue(
      heading: localizations.autoLockHeader,
      defaultValue: LockTimeoutSetting(lockTimeout),
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

        final auth = await AuthFactory.of(context).authenticate();
        if (!auth) return;

        final seed = ref.read(sessionNotifierProvider).loggedIn?.wallet.seed;
        final mnemonic = AppMnemomics.seedToMnemonic(
          seed!,
          languageCode: preferences.languageSeed,
        );

        await context.push(
          AppSeedBackupSheet.routerPage,
          extra: {'mnemonic': mnemonic, 'seed': seed},
        );
        context.go(HomePage.routerPage);
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
      onPressed: () {
        AppDialogs.showConfirmDialog(
          context,
          ref,
          localizations.resyncWallet,
          localizations.resyncWalletAreYouSure,
          localizations.yes,
          () async {
            final cache = await Hive.openBox<CacheItemHive>(
              CacheManagerHive.cacheManagerHiveTable,
            );
            await cache.clear();
            await TokensListHiveDatasource.clear();
            await (await ref
                    .read(accountsNotifierProvider.notifier)
                    .selectedAccountNotifier)
                ?.refreshAll();
          },
        );
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
