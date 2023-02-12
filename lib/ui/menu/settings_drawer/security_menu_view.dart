/// SPDX-License-Identifier: AGPL-3.0-or-later
part of 'settings_drawer.dart';

class SecurityMenuView extends ConsumerWidget {
  const SecurityMenuView({
    required this.close,
    super.key,
  });

  final VoidCallback close;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final localizations = AppLocalization.of(context)!;
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
            // Back button and Security Text
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
                          onPressed: close,
                        ),
                      ),
                      //Security Header Text
                      Text(
                        localizations.securityHeader,
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
                      const _SettingsListItem.spacer(),
                      _SettingsListItem.title(text: localizations.preferences),

                      // Authentication Method
                      const _SettingsListItem.spacer(),
                      const _AuthMethodSettingsListItem(),
                      // Authenticate on Launch
                      const _SettingsListItem.spacer(),
                      const _LockSettingsListItem(),
                      // Authentication Timer
                      const _SettingsListItem.spacer(),
                      const _AutoLockSettingsListItem(),
                      const _SettingsListItem.spacer(),
                      const _BackupSecretPhraseListItem(),
                      const _PinPadShuffleSettingsListItem(),
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
                        headingStyle: theme.textStyleSize16W600EquinoxRed,
                        icon: UiIcons.trash,
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
                                // Authenticate
                                final authMethod = AuthenticationMethod(
                                  ref.read(
                                    AuthenticationProviders.settings.select(
                                      (settings) =>
                                          settings.authenticationMethod,
                                    ),
                                  ),
                                );
                                final auth = await AuthFactory.authenticate(
                                  context,
                                  ref,
                                  authMethod: authMethod,
                                  activeVibrations: ref
                                      .read(SettingsProviders.settings)
                                      .activeVibrations,
                                );
                                if (auth) {
                                  await ref
                                      .read(SessionProviders.session.notifier)
                                      .logout();
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/',
                                    (Route<dynamic> route) => false,
                                  );
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
    final localizations = AppLocalization.of(context)!;

    final authenticationMethod = ref.watch(
      AuthenticationProviders.settings.select(
        (settings) => settings.authenticationMethod,
      ),
    );
    final asyncHasBiometrics = ref.watch(DeviceAbilities.hasBiometricsProvider);

    return _SettingsListItem.withDefaultValue(
      heading: localizations.authMethod,
      defaultMethod: AuthenticationMethod(authenticationMethod),
      icon: UiIcons.authent,
      onPressed: asyncHasBiometrics.maybeWhen(
        data: (hasBiometrics) => () => AuthentificationMethodDialog.getDialog(
              context,
              ref,
              hasBiometrics,
              AuthenticationMethod(authenticationMethod),
            ),
        orElse: () => () {},
      ),
    );
  }
}

class _LockSettingsListItem extends ConsumerWidget {
  const _LockSettingsListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;

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
      icon: UiIcons.authent_at_launch,
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
    final localizations = AppLocalization.of(context)!;

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
      icon: UiIcons.auto_lock,
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
    final localizations = AppLocalization.of(context)!;

    final pinPadShuffle = ref.watch(
      AuthenticationProviders.settings.select(
        (settings) => settings.pinPadShuffle,
      ),
    );
    final authenticationMethod = ref.watch(
      AuthenticationProviders.settings.select(
        (settings) => settings.authenticationMethod,
      ),
    );

    if (authenticationMethod != AuthMethod.pin) return const SizedBox();
    return Column(
      children: [
        const _SettingsListItem.spacer(),
        _SettingsListItem.withSwitch(
          heading: localizations.pinPadShuffle,
          icon: UiIcons.swap,
          isSwitched: pinPadShuffle,
          onChanged: (bool isSwitched) {
            ref
                .read(
                  AuthenticationProviders.settings.notifier,
                )
                .setPinPadShuffle(isSwitched);
          },
        ),
      ],
    );
  }
}

class _BackupSecretPhraseListItem extends ConsumerWidget {
  const _BackupSecretPhraseListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = ref.watch(ThemeProviders.selectedTheme);

    return _SettingsListItem.singleLine(
      heading: localizations.backupSecretPhrase,
      headingStyle: theme.textStyleSize16W600EquinoxPrimary,
      icon: UiIcons.vault,
      onPressed: () async {
        final preferences = ref.read(SettingsProviders.settings);
        final authenticationSettings = ref.read(
          AuthenticationProviders.settings,
        );

        final auth = await AuthFactory.authenticate(
          context,
          ref,
          authMethod: AuthenticationMethod(
            authenticationSettings.authenticationMethod,
          ),
          activeVibrations: preferences.activeVibrations,
        );
        if (auth) {
          await ref.ensuresAutolockMaskHidden();

          final seed = ref.read(SessionProviders.session).loggedIn?.wallet.seed;
          final mnemonic = AppMnemomics.seedToMnemonic(
            seed!,
            languageCode: preferences.languageSeed,
          );

          Sheets.showAppHeightNineSheet(
            context: context,
            ref: ref,
            widget: AppSeedBackupSheet(mnemonic),
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
    final localizations = AppLocalization.of(context)!;

    return _SettingsListItem.singleLineWithInfos(
      heading: localizations.resyncWallet,
      info: localizations.resyncWalletDescription,
      icon: Icons.sync,
      onPressed: () async {
        AppDialogs.showConfirmDialog(context, ref, localizations.resyncWallet,
            localizations.resyncWalletAreYouSure, localizations.yes, () async {
          final session = ref.read(SessionProviders.session).loggedIn!;
          for (final element in session.wallet.appKeychain.accounts) {
            await element.clearRecentTransactionsFromCache();
          }
          ref
              .read(AccountProviders.selectedAccount.notifier)
              .refreshRecentTransactions();
        });
      },
      displayChevron: false,
    );
  }
}
