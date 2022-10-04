/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:io';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/authentication_method.dart';
import 'package:aewallet/model/available_networks.dart';
import 'package:aewallet/model/available_themes.dart';
import 'package:aewallet/model/device_lock_timeout.dart';
import 'package:aewallet/model/device_unlock_option.dart';
import 'package:aewallet/model/setting_item.dart';
import 'package:aewallet/ui/themes/theme_dark.dart';
import 'package:aewallet/ui/util/responsive.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/authenticate/auth_factory.dart';
import 'package:aewallet/ui/views/contacts/contact_list.dart';
import 'package:aewallet/ui/views/settings/backupseed_sheet.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
import 'package:aewallet/ui/widgets/components/icon_widget.dart';
import 'package:aewallet/ui/widgets/components/sheet_util.dart';
import 'package:aewallet/ui/widgets/dialogs/authentification_method_dialog.dart';
import 'package:aewallet/ui/widgets/dialogs/currency_dialog.dart';
import 'package:aewallet/ui/widgets/dialogs/language_dialog.dart';
import 'package:aewallet/ui/widgets/dialogs/lock_dialog.dart';
import 'package:aewallet/ui/widgets/dialogs/lock_timeout_dialog.dart';
import 'package:aewallet/ui/widgets/dialogs/network_dialog.dart';
import 'package:aewallet/ui/widgets/dialogs/primary_currency_dialog.dart';
import 'package:aewallet/ui/widgets/dialogs/theme_dialog.dart';
import 'package:aewallet/util/biometrics_util.dart';
import 'package:aewallet/util/case_converter.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/haptic_util.dart';
import 'package:aewallet/util/mnemonics.dart';
import 'package:aewallet/util/preferences.dart';
// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'main_settings_view.dart';
part 'components/settings_list_item.dart';
part 'components/settings_list_item_switch.dart';
part 'components/settings_list_item_singleline.dart';
part 'components/settings_list_item_defaultvalue.dart';

//TODO(reddwarf03): This drawer seems to be used on desktop too. Should we rename it `SettingsSheetWallet` ?
class SettingsSheetWalletMobile extends StatefulWidget {
  const SettingsSheetWalletMobile({super.key});

  @override
  State<SettingsSheetWalletMobile> createState() => _SettingsSheetWalletMobileState();
}

class _SettingsSheetWalletMobileState extends State<SettingsSheetWalletMobile>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _contactsController;
  late Animation<Offset> _contactsOffsetFloat;
  late AnimationController _securityController;
  late Animation<Offset> _securityOffsetFloat;
  late AnimationController _customController;
  late Animation<Offset> _customOffsetFloat;
  late AnimationController _aboutController;
  late Animation<Offset> _aboutOffsetFloat;

  String versionString = '';

  bool _hasBiometrics = false;
  AuthenticationMethod _curAuthMethod = AuthenticationMethod(AuthMethod.pin);
  UnlockSetting _curUnlockSetting = UnlockSetting(UnlockOption.yes);
  LockTimeoutSetting _curTimeoutSetting = LockTimeoutSetting(LockTimeoutOption.one);
  ThemeSetting _curThemeSetting = ThemeSetting(ThemeOptions.dark);
  NetworksSetting _curNetworksSetting = NetworksSetting(AvailableNetworks.archethicMainNet);

  late bool _securityOpen;
  late bool _customOpen;
  late bool _aboutOpen;
  late bool _contactsOpen;

  bool _pinPadShuffleActive = false;
  bool _showBalancesActive = false;
  bool _showBlogActive = false;
  bool _vibrationActive = false;
  bool _notificationsActive = false;
  bool _showPriceChartActive = false;

  bool notNull(Object? o) => o != null;

  @override
  void initState() {
    super.initState();
    _contactsOpen = false;
    _securityOpen = false;
    _customOpen = false;
    _aboutOpen = false;

    // Determine if they have face or fingerprint enrolled,
    // if not hide the setting
    sl.get<BiometricUtil>().hasBiometrics().then((bool hasBiometrics) {
      setState(() {
        _hasBiometrics = hasBiometrics;
      });
    });
    Preferences.getInstance().then((Preferences preferences) {
      setState(() {
        _pinPadShuffleActive = preferences.getPinPadShuffle();
        _showBalancesActive = preferences.getShowBalances();
        _showBlogActive = preferences.getShowBlog();
        _vibrationActive = preferences.getActiveVibrations();
        _notificationsActive = preferences.getActiveNotifications();
        _showPriceChartActive = preferences.getShowPriceChart();
        _curAuthMethod = preferences.getAuthMethod();
        _curUnlockSetting = preferences.getLock() ? UnlockSetting(UnlockOption.yes) : UnlockSetting(UnlockOption.no);
        _curThemeSetting = preferences.getTheme();
        _curNetworksSetting = preferences.getNetwork();
        _curTimeoutSetting = preferences.getLockTimeout();
      });
    });

    _contactsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _securityController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _customController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _aboutController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _contactsOffsetFloat = Tween<Offset>(begin: const Offset(1.1, 0), end: Offset.zero).animate(_contactsController);
    _securityOffsetFloat = Tween<Offset>(begin: const Offset(1.1, 0), end: Offset.zero).animate(_securityController);
    _customOffsetFloat = Tween<Offset>(begin: const Offset(1.1, 0), end: Offset.zero).animate(_customController);
    _aboutOffsetFloat = Tween<Offset>(begin: const Offset(1.1, 0), end: Offset.zero).animate(_aboutController);

    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        final localizations = AppLocalization.of(context)!;
        versionString =
            '${localizations.version} ${packageInfo.version} - ${localizations.build} ${packageInfo.buildNumber}';
      });
    });
  }

  @override
  void dispose() {
    _contactsController.dispose();
    _securityController.dispose();
    _customController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        super.didChangeAppLifecycleState(state);
        break;
      case AppLifecycleState.resumed:
        super.didChangeAppLifecycleState(state);
        break;
      case AppLifecycleState.detached:
        super.didChangeAppLifecycleState(state);
        break;
      case AppLifecycleState.inactive:
        super.didChangeAppLifecycleState(state);
        break;
    }
  }

  Future<void> _authMethodDialog() async {
    await AuthentificationMethodDialog.getDialog(
      context,
      _hasBiometrics,
      _curAuthMethod,
    );
  }

  Future<void> _lockDialog() async {
    _curUnlockSetting = (await LockDialog.getDialog(context, _curUnlockSetting))!;
  }

  Future<void> _currencyDialog() async {
    await CurrencyDialog.getDialog(context);
  }

  Future<void> _languageDialog() async {
    await LanguageDialog.getDialog(context);
  }

  Future<void> _primaryCurrencyDialog() async {
    await PrimaryCurrencyDialog.getDialog(context);
  }

  // TODO(Chralu): is this useful ?
  // ignore: unused_element
  Future<void> _networkDialog() async {
    final ns = await NetworkDialog.getDialog(context, _curNetworksSetting);
    if (ns != null) {
      _curNetworksSetting = ns;
      await StateContainer.of(context).requestUpdate();
    }
  }

  Future<void> _lockTimeoutDialog() async {
    _curTimeoutSetting = (await LockTimeoutDialog.getDialog(context, _curTimeoutSetting))!;
  }

  Future<void> _themeDialog() async {
    _curThemeSetting = (await ThemeDialog.getDialog(context, _curThemeSetting))!;
  }

  Future<bool> _onBackButtonPressed() async {
    if (_contactsOpen) {
      _contactsOpen = false;
      _contactsController.reverse();
      return false;
    } else if (_securityOpen) {
      _securityOpen = false;
      _securityController.reverse();
      return false;
    } else if (_customOpen) {
      _customOpen = false;
      _customController.reverse();
      return false;
    } else if (_aboutOpen) {
      _aboutOpen = false;
      _aboutController.reverse();
      return false;
    }
    return true;
  }

  void showContacts() {
    _contactsOpen = true;
    _contactsController.forward();
  }

  void showSecurity() {
    _securityOpen = true;
    _securityController.forward();
  }

  void showCustom() {
    _customOpen = true;
    _customController.forward();
  }

  void showAbout() {
    _aboutOpen = true;
    _aboutController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final theme = StateContainer.of(context).curTheme;

    return WillPopScope(
      onWillPop: _onBackButtonPressed,
      child: ClipRect(
        child: Stack(
          children: <Widget>[
            Container(
              color: theme.backgroundDark,
              constraints: const BoxConstraints.expand(),
            ),
            MainSettingsView(
              showContacts: showContacts,
              showSecurity: showSecurity,
              showCustom: showCustom,
              showAbout: showAbout,
            ),
            SlideTransition(
              position: _contactsOffsetFloat,
              child: ContactsList(
                _contactsController,
                _contactsOpen,
              ),
            ),
            SlideTransition(
              position: _securityOffsetFloat,
              child: buildSecurityMenu(context),
            ),
            SlideTransition(
              position: _customOffsetFloat,
              child: buildCustomMenu(context),
            ),
            SlideTransition(
              position: _aboutOffsetFloat,
              child: buildAboutMenu(context),
            ),
          ],
        ),
      ),
    );
  }

  // TODO(Chralu): convert to [Widget] subclass
  Widget buildSecurityMenu(BuildContext context) {
    final localizations = AppLocalization.of(context)!;
    final theme = StateContainer.of(context).curTheme;
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
                          onPressed: () {
                            _securityOpen = false;
                            _securityController.reverse();
                          },
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
                      _SettingsListItem.withDefaultValue(
                        heading: localizations.authMethod,
                        defaultMethod: _curAuthMethod,
                        icon: 'assets/icons/authentLaunch.png',
                        iconColor: theme.iconDrawer!,
                        onPressed: _authMethodDialog,
                      ),
                      // Authenticate on Launch

                      Column(
                        children: <Widget>[
                          const _SettingsListItem.spacer(),
                          _SettingsListItem.withDefaultValue(
                            heading: localizations.lockAppSetting,
                            defaultMethod: _curUnlockSetting,
                            icon: 'assets/icons/authentication.png',
                            iconColor: theme.iconDrawer!,
                            onPressed: _lockDialog,
                          ),
                        ],
                      ),
                      const _SettingsListItem.spacer(),
                      // Authentication Timer
                      _SettingsListItem.withDefaultValue(
                        heading: localizations.autoLockHeader,
                        defaultMethod: _curTimeoutSetting,
                        icon: 'assets/icons/autoLock.png',
                        iconColor: theme.iconDrawer!,
                        onPressed: _lockTimeoutDialog,
                        disabled: _curUnlockSetting.setting == UnlockOption.no,
                      ),
                      Column(
                        children: <Widget>[
                          const _SettingsListItem.spacer(),
                          _SettingsListItem.singleLine(
                            heading: localizations.backupSecretPhrase,
                            headingStyle: AppStyles.textStyleSize16W600EquinoxPrimary(
                              context,
                            ),
                            icon: 'assets/icons/key-word.png',
                            iconColor: theme.iconDrawer!,
                            onPressed: () async {
                              final preferences = await Preferences.getInstance();
                              final authMethod = preferences.getAuthMethod();

                              final auth = await AuthFactory.authenticate(
                                context,
                                authMethod,
                                activeVibrations: StateContainer.of(context).activeVibrations,
                              );
                              if (auth) {
                                final seed = await StateContainer.of(context).getSeed();
                                final mnemonic = AppMnemomics.seedToMnemonic(
                                  seed!,
                                  languageCode: preferences.getLanguageSeed(),
                                );

                                Sheets.showAppHeightNineSheet(
                                  context: context,
                                  widget: AppSeedBackupSheet(mnemonic),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      if (_curAuthMethod.method == AuthMethod.pin) const _SettingsListItem.spacer(),
                      if (_curAuthMethod.method == AuthMethod.pin)
                        _SettingsListItem.withSwitch(
                          heading: localizations.pinPadShuffle,
                          icon: 'assets/icons/shuffle.png',
                          iconColor: theme.iconDrawer!,
                          isSwitched: _pinPadShuffleActive,
                          onChanged: (bool isSwitched) async {
                            final preferences = await Preferences.getInstance();
                            setState(() {
                              _pinPadShuffleActive = isSwitched;
                              preferences.setPinPadShuffle(isSwitched);
                            });
                          },
                        ),

                      const _SettingsListItem.spacer(),
                      _SettingsListItem.singleLine(
                        heading: localizations.removeWallet,
                        headingStyle: AppStyles.textStyleSize16W600EquinoxRed(context),
                        icon: 'assets/icons/rubbish.png',
                        iconColor: Colors.red,
                        onPressed: () {
                          AppDialogs.showConfirmDialog(
                              context,
                              CaseChange.toUpperCase(
                                localizations.warning,
                                StateContainer.of(context).curLanguage.getLocaleString(),
                              ),
                              localizations.removeWalletDetail,
                              localizations.removeWalletAction.toUpperCase(), () {
                            // Show another confirm dialog
                            AppDialogs.showConfirmDialog(context, localizations.removeWalletAreYouSure,
                                localizations.removeWalletReassurance, localizations.yes, () async {
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
                    ].where(notNull).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // TODO(Chralu): convert to [Widget] subclass
  Widget buildCustomMenu(BuildContext context) {
    final localizations = AppLocalization.of(context)!;
    final theme = StateContainer.of(context).curTheme;

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
                          onPressed: () {
                            _customOpen = false;
                            _customController.reverse();
                          },
                        ),
                      ),
                      Text(
                        localizations.customHeader,
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
                            style: AppStyles.textStyleSize20W700EquinoxPrimary(
                              context,
                            ),
                          ),
                        ),
                      ),
                      const _SettingsListItem.spacer(),
                      _SettingsListItem.withDefaultValueWithInfos(
                        heading: localizations.changeCurrencyHeader,
                        info: localizations.changeCurrencyDesc.replaceAll(
                          '%1',
                          StateContainer.of(context).curNetwork.getNetworkCryptoCurrencyLabel(),
                        ),
                        defaultMethod: StateContainer.of(context).curCurrency,
                        icon: 'assets/icons/money-currency.png',
                        iconColor: theme.iconDrawer!,
                        onPressed: _currencyDialog,
                      ),
                      const _SettingsListItem.spacer(),
                      _SettingsListItem.withDefaultValue(
                        heading: localizations.primaryCurrency,
                        defaultMethod: StateContainer.of(context).curPrimaryCurrency,
                        icon: 'assets/icons/exchange.png',
                        iconColor: theme.iconDrawer!,
                        onPressed: _primaryCurrencyDialog,
                      ),
                      const _SettingsListItem.spacer(),
                      _SettingsListItem.withDefaultValue(
                        heading: localizations.language,
                        defaultMethod: StateContainer.of(context).curLanguage,
                        icon: 'assets/icons/languages.png',
                        iconColor: theme.iconDrawer!,
                        onPressed: _languageDialog,
                      ),
                      const _SettingsListItem.spacer(),
                      const _SettingsListItem.spacer(),
                      _SettingsListItem.withDefaultValue(
                        heading: localizations.themeHeader,
                        defaultMethod: _curThemeSetting,
                        icon: 'assets/icons/themes.png',
                        iconColor: theme.iconDrawer!,
                        onPressed: _themeDialog,
                      ),
                      const _SettingsListItem.spacer(),
                      _SettingsListItem.withSwitch(
                        heading: localizations.showBalances,
                        icon: 'assets/icons/shy.png',
                        iconColor: theme.iconDrawer!,
                        isSwitched: _showBalancesActive,
                        onChanged: (bool isSwitched) async {
                          final preferences = await Preferences.getInstance();
                          setState(() {
                            _showBalancesActive = isSwitched;
                            StateContainer.of(context).showBalance = _showBalancesActive;
                            preferences.setShowBalances(_showBalancesActive);
                            StateContainer.of(context).setState(() {});
                          });
                        },
                      ),
                      const _SettingsListItem.spacer(),
                      _SettingsListItem.withSwitch(
                        heading: localizations.showBlog,
                        icon: 'assets/icons/blog.png',
                        iconColor: theme.iconDrawer!,
                        isSwitched: _showBlogActive,
                        onChanged: (bool isSwitched) async {
                          final preferences = await Preferences.getInstance();
                          setState(() {
                            _showBlogActive = isSwitched;
                            StateContainer.of(context).showBlog = _showBlogActive;
                            preferences.setShowBlog(_showBlogActive);
                            StateContainer.of(context).setState(() {});
                          });
                        },
                      ),
                      const _SettingsListItem.spacer(),
                      _SettingsListItem.withSwitch(
                        heading: localizations.showPriceChart,
                        icon: 'assets/icons/statistics.png',
                        iconColor: theme.iconDrawer!,
                        isSwitched: _showPriceChartActive,
                        onChanged: (bool isSwitched) async {
                          final preferences = await Preferences.getInstance();
                          setState(() {
                            _showPriceChartActive = isSwitched;
                            StateContainer.of(context).showPriceChart = _showPriceChartActive;
                            preferences.setShowPriceChart(_showPriceChartActive);
                            StateContainer.of(context).setState(() {});
                          });
                        },
                      ),
                      if (!kIsWeb && (Platform.isIOS == true || Platform.isAndroid == true || Platform.isMacOS == true))
                        const _SettingsListItem.spacer(),
                      if (!kIsWeb && (Platform.isIOS == true || Platform.isAndroid == true || Platform.isMacOS == true))
                        _SettingsListItem.withSwitch(
                          heading: localizations.activateNotifications,
                          icon: 'assets/icons/notification-bell.png',
                          iconColor: theme.iconDrawer!,
                          isSwitched: _notificationsActive,
                          onChanged: (bool isSwitched) async {
                            final preferences = await Preferences.getInstance();
                            setState(() {
                              _notificationsActive = isSwitched;
                              StateContainer.of(context).activeNotifications = _notificationsActive;
                              if (StateContainer.of(context).timerCheckTransactionInputs != null) {
                                StateContainer.of(context).timerCheckTransactionInputs!.cancel();
                              }
                              if (_notificationsActive) {
                                StateContainer.of(context).checkTransactionInputs(
                                  localizations.transactionInputNotification,
                                );
                              }
                              preferences.setActiveNotifications(_notificationsActive);
                            });
                          },
                        ),
                      const _SettingsListItem.spacer(),
                      _SettingsListItem.withSwitch(
                        heading: localizations.activateVibrations,
                        icon: 'assets/icons/vibrate.png',
                        iconColor: theme.iconDrawer!,
                        isSwitched: _vibrationActive,
                        onChanged: (bool isSwitched) async {
                          final preferences = await Preferences.getInstance();
                          setState(() {
                            _vibrationActive = isSwitched;
                            StateContainer.of(context).activeVibrations = _vibrationActive;
                            preferences.setActiveVibrations(_vibrationActive);
                          });
                        },
                      ),
                      const _SettingsListItem.spacer(),
                    ].where(notNull).toList(),
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

  // TODO(Chralu): convert to [Widget] subclass
  Widget buildAboutMenu(BuildContext context) {
    final localizations = AppLocalization.of(context)!;
    final theme = StateContainer.of(context).curTheme;

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
                      onPressed: () {
                        _aboutOpen = false;
                        _aboutController.reverse();
                      },
                    ),
                  ),
                  Expanded(
                    child: AutoSizeText(
                      localizations.aboutHeader,
                      style: AppStyles.textStyleSize24W700EquinoxPrimary(context),
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
                            Text(
                              versionString,
                              style: AppStyles.textStyleSize14W100Primary(
                                context,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const _SettingsListItem.spacer(),
                      _SettingsListItem.singleLine(
                        heading: localizations.aboutGeneralTermsAndConditions,
                        headingStyle: AppStyles.textStyleSize16W600Primary(context),
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
                        headingStyle: AppStyles.textStyleSize16W600Primary(context),
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
                        headingStyle: AppStyles.textStyleSize16W600Primary(context),
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
                    ].where(notNull).toList(),
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
