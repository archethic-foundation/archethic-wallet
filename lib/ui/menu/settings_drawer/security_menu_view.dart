/// SPDX-License-Identifier: AGPL-3.0-or-later
part of 'settings_drawer.dart';

class SecurityMenuView extends StatelessWidget {
  const SecurityMenuView({
    required this.close,
    super.key,
  });

  final VoidCallback close;

  @override
  Widget build(BuildContext context) {
    final theme = StateContainer.of(context).curTheme;
    final localizations = AppLocalization.of(context)!;

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
                        style: AppStyles.textStyleSize24W700EquinoxPrimary(
                          context,
                        ),
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
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: theme.text05,
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsetsDirectional.only(
                            top: 15,
                            bottom: 15,
                          ),
                          child: Text(
                            localizations.preferences,
                            style: AppStyles.textStyleSize20W700EquinoxPrimary(
                              context,
                            ),
                          ),
                        ),
                      ),
                      /* const _SettingsListItem.spacer(),
                    AppSettings.buildSettingsListItemWithDefaultValue(
                        context,
                        localizations.networksHeader,
                        _curNetworksSetting,
                        'assets/icons/url.png',
                        theme.iconDrawer!,
                        _networkDialog),*/
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
                      _SettingsListItem.singleLine(
                        heading: localizations.removeWallet,
                        headingStyle:
                            AppStyles.textStyleSize16W600EquinoxRed(context),
                        icon: 'assets/icons/menu/remove-wallet.svg',
                        iconColor: Colors.red,
                        onPressed: () {
                          AppDialogs.showConfirmDialog(
                              context,
                              CaseChange.toUpperCase(
                                localizations.warning,
                                StateContainer.of(context)
                                    .curLanguage
                                    .getLocaleString(),
                              ),
                              localizations.removeWalletDetail,
                              localizations.removeWalletAction.toUpperCase(),
                              () {
                            // Show another confirm dialog
                            AppDialogs.showConfirmDialog(
                                context,
                                localizations.removeWalletAreYouSure,
                                localizations.removeWalletReassurance,
                                localizations.yes, () async {
                              await StateContainer.of(context).logOut();
                              StateContainer.of(context).curTheme = DarkTheme();
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                '/',
                                (Route<dynamic> route) => false,
                              );
                            });
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
    final theme = StateContainer.of(context).curTheme;

    final authenticationMethod = ref.watch(
      preferenceProvider.select((settings) => settings.authenticationMethod),
    );
    final asyncHasBiometrics = ref.watch(DeviceAbilities.hasBiometricsProvider);

    return _SettingsListItem.withDefaultValue(
      heading: localizations.authMethod,
      defaultMethod: AuthenticationMethod(authenticationMethod),
      icon: 'assets/icons/menu/authent.svg',
      iconColor: theme.iconDrawer!,
      onPressed: asyncHasBiometrics.maybeWhen(
        data: (hasBiometrics) => () => AuthentificationMethodDialog.getDialog(
              context,
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
    final theme = StateContainer.of(context).curTheme;

    final lock =
        ref.watch(preferenceProvider.select((settings) => settings.lock));
    final settingsNotifier = ref.read(preferenceProvider.notifier);

    return _SettingsListItem.withDefaultValue(
      heading: localizations.lockAppSetting,
      defaultMethod: UnlockSetting(lock),
      icon: 'assets/icons/menu/authent-at-launch.svg',
      iconColor: theme.iconDrawer!,
      onPressed: () async {
        final unlockSetting = await LockDialog.getDialog(
          context,
          UnlockSetting(lock),
        );
        if (unlockSetting == null) return;
        await settingsNotifier.setLockApp(unlockSetting.setting);
      },
    );
  }
}

class _AutoLockSettingsListItem extends ConsumerWidget {
  const _AutoLockSettingsListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalization.of(context)!;
    final theme = StateContainer.of(context).curTheme;

    final lock =
        ref.watch(preferenceProvider.select((settings) => settings.lock));
    final lockTimeout = ref
        .watch(preferenceProvider.select((settings) => settings.lockTimeout));
    final settingsNotifier = ref.read(preferenceProvider.notifier);

    return _SettingsListItem.withDefaultValue(
      heading: localizations.autoLockHeader,
      defaultMethod: LockTimeoutSetting(lockTimeout),
      icon: 'assets/icons/menu/auto-lock.svg',
      iconColor: theme.iconDrawer!,
      onPressed: () async {
        final lockTimeoutSetting = await LockTimeoutDialog.getDialog(
          context,
          LockTimeoutSetting(lockTimeout),
        );
        if (lockTimeoutSetting == null) return;
        await settingsNotifier.setLockTimeout(lockTimeoutSetting.setting);
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
    final theme = StateContainer.of(context).curTheme;

    final pinPadShuffle = ref
        .watch(preferenceProvider.select((settings) => settings.pinPadShuffle));
    final authenticationMethod = ref.watch(
      preferenceProvider.select((settings) => settings.authenticationMethod),
    );
    final settingsNotifier = ref.read(preferenceProvider.notifier);

    if (authenticationMethod != AuthMethod.pin) return const SizedBox();
    return Column(
      children: [
        const _SettingsListItem.spacer(),
        _SettingsListItem.withSwitch(
          heading: localizations.pinPadShuffle,
          icon: 'assets/icons/menu/pin-swap.svg',
          iconColor: theme.iconDrawer!,
          isSwitched: pinPadShuffle,
          onChanged: (bool isSwitched) {
            settingsNotifier.setPinPadShuffle(isSwitched);
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
    final theme = StateContainer.of(context).curTheme;

    return _SettingsListItem.singleLine(
      heading: localizations.backupSecretPhrase,
      headingStyle: AppStyles.textStyleSize16W600EquinoxPrimary(
        context,
      ),
      icon: 'assets/icons/menu/vault.svg',
      iconColor: theme.iconDrawer!,
      onPressed: () async {
        final preferences = ref.watch(preferenceProvider);

        final auth = await AuthFactory.authenticate(
          context,
          AuthenticationMethod(preferences.authenticationMethod),
          activeVibrations: StateContainer.of(context).activeVibrations,
        );
        if (auth) {
          final seed = await StateContainer.of(context).getSeed();
          final mnemonic = AppMnemomics.seedToMnemonic(
            seed!,
            languageCode: preferences.languageSeed,
          );

          Sheets.showAppHeightNineSheet(
            context: context,
            widget: AppSeedBackupSheet(mnemonic),
          );
        }
      },
    );
  }
}
