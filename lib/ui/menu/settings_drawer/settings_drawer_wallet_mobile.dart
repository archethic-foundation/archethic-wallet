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
import 'package:aewallet/ui/menu/settings_drawer/components/settings_list_item.dart';
import 'package:aewallet/ui/themes/theme_dark.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/authenticate/auth_factory.dart';
import 'package:aewallet/ui/views/contacts/contact_list.dart';
import 'package:aewallet/ui/views/settings/backupseed_sheet.dart';
import 'package:aewallet/ui/widgets/components/dialog.dart';
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
import 'package:aewallet/util/mnemonics.dart';
import 'package:aewallet/util/preferences.dart';
// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'components/main_settings.dart';

class SettingsSheetWalletMobile extends StatefulWidget {
  const SettingsSheetWalletMobile({super.key});

  @override
  State<SettingsSheetWalletMobile> createState() =>
      _SettingsSheetWalletMobileState();
}

class _SettingsSheetWalletMobileState extends State<SettingsSheetWalletMobile>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _contactsController;
  late Animation<Offset>? _contactsOffsetFloat;
  late AnimationController? _securityController;
  late Animation<Offset>? _securityOffsetFloat;
  late AnimationController? _customController;
  late Animation<Offset>? _customOffsetFloat;
  late AnimationController? _aboutController;
  late Animation<Offset>? _aboutOffsetFloat;

  String versionString = '';

  bool _hasBiometrics = false;
  AuthenticationMethod _curAuthMethod = AuthenticationMethod(AuthMethod.pin);
  UnlockSetting _curUnlockSetting = UnlockSetting(UnlockOption.yes);
  LockTimeoutSetting _curTimeoutSetting =
      LockTimeoutSetting(LockTimeoutOption.one);
  ThemeSetting _curThemeSetting = ThemeSetting(ThemeOptions.dark);
  NetworksSetting _curNetworksSetting =
      NetworksSetting(AvailableNetworks.archethicMainNet);

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
        _curUnlockSetting = preferences.getLock()
            ? UnlockSetting(UnlockOption.yes)
            : UnlockSetting(UnlockOption.no);
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
    _contactsOffsetFloat =
        Tween<Offset>(begin: const Offset(1.1, 0), end: Offset.zero)
            .animate(_contactsController);
    _securityOffsetFloat =
        Tween<Offset>(begin: const Offset(1.1, 0), end: Offset.zero)
            .animate(_securityController!);
    _customOffsetFloat =
        Tween<Offset>(begin: const Offset(1.1, 0), end: Offset.zero)
            .animate(_customController!);
    _aboutOffsetFloat =
        Tween<Offset>(begin: const Offset(1.1, 0), end: Offset.zero)
            .animate(_aboutController!);
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        versionString =
            '${AppLocalization.of(context)!.version} ${packageInfo.version} - ${AppLocalization.of(context)!.build} ${packageInfo.buildNumber}';
      });
    });
  }

  @override
  void dispose() {
    _contactsController.dispose();
    _securityController!.dispose();
    _customController!.dispose();
    _aboutController!.dispose();
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
    _curUnlockSetting =
        (await LockDialog.getDialog(context, _curUnlockSetting))!;
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
    _curTimeoutSetting =
        (await LockTimeoutDialog.getDialog(context, _curTimeoutSetting))!;
  }

  Future<void> _themeDialog() async {
    _curThemeSetting =
        (await ThemeDialog.getDialog(context, _curThemeSetting))!;
  }

  Future<bool> _onBackButtonPressed() async {
    if (_contactsOpen) {
      _contactsOpen = false;
      _contactsController.reverse();
      return false;
    } else if (_securityOpen) {
      _securityOpen = false;
      _securityController!.reverse();
      return false;
    } else if (_customOpen) {
      _customOpen = false;
      _customController!.reverse();
      return false;
    } else if (_aboutOpen) {
      _aboutOpen = false;
      _aboutController!.reverse();
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
    _securityController!.forward();
  }

  void showCustom() {
    _customOpen = true;
    _customController!.forward();
  }

  void showAbout() {
    _aboutOpen = true;
    _aboutController!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackButtonPressed,
      child: ClipRect(
        child: Stack(
          children: <Widget>[
            Container(
              color: StateContainer.of(context).curTheme.backgroundDark,
              constraints: const BoxConstraints.expand(),
            ),
            MainSettings(
              showContacts: showContacts,
              showSecurity: showSecurity,
              showCustom: showCustom,
              showAbout: showAbout,
            ),
            SlideTransition(
              position: _contactsOffsetFloat!,
              child: ContactsList(
                _contactsController,
                _contactsOpen,
              ),
            ),
            SlideTransition(
              position: _securityOffsetFloat!,
              child: buildSecurityMenu(context),
            ),
            SlideTransition(
              position: _customOffsetFloat!,
              child: buildCustomMenu(context),
            ),
            SlideTransition(
              position: _aboutOffsetFloat!,
              child: buildAboutMenu(context),
            ),
          ],
        ),
      ),
    );
  }

  // TODO(Chralu): convert to [Widget] subclass
  Widget buildSecurityMenu(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: StateContainer.of(context).curTheme.drawerBackground,
        gradient: LinearGradient(
          colors: <Color>[
            StateContainer.of(context).curTheme.drawerBackground!,
            StateContainer.of(context).curTheme.backgroundDark!,
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
                          color: StateContainer.of(context).curTheme.text,
                          onPressed: () {
                            _securityOpen = false;
                            _securityController!.reverse();
                          },
                        ),
                      ),
                      //Security Header Text
                      Text(
                        AppLocalization.of(context)!.securityHeader,
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
                      Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15,
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: StateContainer.of(context).curTheme.text05,
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsetsDirectional.only(
                            top: 15,
                            bottom: 15,
                          ),
                          child: Text(
                            AppLocalization.of(context)!.preferences,
                            style: AppStyles.textStyleSize20W700EquinoxPrimary(
                              context,
                            ),
                          ),
                        ),
                      ),
                      /*Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemWithDefaultValue(
                        context,
                        AppLocalization.of(context)!.networksHeader,
                        _curNetworksSetting,
                        'assets/icons/url.png',
                        StateContainer.of(context).curTheme.iconDrawer!,
                        _networkDialog),*/
                      // Authentication Method
                      Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15,
                      ),
                      AppSettings.buildSettingsListItemWithDefaultValue(
                        context,
                        AppLocalization.of(context)!.authMethod,
                        _curAuthMethod,
                        'assets/icons/authentLaunch.png',
                        StateContainer.of(context).curTheme.iconDrawer!,
                        _authMethodDialog,
                      ),
                      // Authenticate on Launch

                      Column(
                        children: <Widget>[
                          Divider(
                            height: 2,
                            color: StateContainer.of(context).curTheme.text15,
                          ),
                          AppSettings.buildSettingsListItemWithDefaultValue(
                            context,
                            AppLocalization.of(context)!.lockAppSetting,
                            _curUnlockSetting,
                            'assets/icons/authentication.png',
                            StateContainer.of(context).curTheme.iconDrawer!,
                            _lockDialog,
                          ),
                        ],
                      ),
                      Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15,
                      ),
                      // Authentication Timer
                      AppSettings.buildSettingsListItemWithDefaultValue(
                        context,
                        AppLocalization.of(context)!.autoLockHeader,
                        _curTimeoutSetting,
                        'assets/icons/autoLock.png',
                        StateContainer.of(context).curTheme.iconDrawer!,
                        _lockTimeoutDialog,
                        disabled: _curUnlockSetting.setting == UnlockOption.no,
                      ),
                      Column(
                        children: <Widget>[
                          Divider(
                            height: 2,
                            color: StateContainer.of(context).curTheme.text15,
                          ),
                          AppSettings.buildSettingsListItemSingleLine(
                            context,
                            AppLocalization.of(context)!.backupSecretPhrase,
                            AppStyles.textStyleSize16W600EquinoxPrimary(
                              context,
                            ),
                            'assets/icons/key-word.png',
                            StateContainer.of(context).curTheme.iconDrawer!,
                            onPressed: () async {
                              final preferences =
                                  await Preferences.getInstance();
                              final authMethod = preferences.getAuthMethod();

                              final auth = await AuthFactory.authenticate(
                                context,
                                authMethod,
                                activeVibrations:
                                    StateContainer.of(context).activeVibrations,
                              );
                              if (auth) {
                                final seed =
                                    await StateContainer.of(context).getSeed();
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
                      if (_curAuthMethod.method == AuthMethod.pin)
                        Divider(
                          height: 2,
                          color: StateContainer.of(context).curTheme.text15,
                        ),
                      if (_curAuthMethod.method == AuthMethod.pin)
                        AppSettings.buildSettingsListItemSwitch(
                          context,
                          AppLocalization.of(context)!.pinPadShuffle,
                          'assets/icons/shuffle.png',
                          StateContainer.of(context).curTheme.iconDrawer!,
                          _pinPadShuffleActive,
                          onChanged: (bool isSwitched) async {
                            final preferences = await Preferences.getInstance();
                            setState(() {
                              _pinPadShuffleActive = isSwitched;
                              preferences.setPinPadShuffle(isSwitched);
                            });
                          },
                        ),

                      Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15,
                      ),
                      AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context)!.removeWallet,
                        AppStyles.textStyleSize16W600EquinoxRed(context),
                        'assets/icons/rubbish.png',
                        Colors.red,
                        onPressed: () {
                          AppDialogs.showConfirmDialog(
                              context,
                              CaseChange.toUpperCase(
                                AppLocalization.of(context)!.warning,
                                StateContainer.of(context)
                                    .curLanguage
                                    .getLocaleString(),
                              ),
                              AppLocalization.of(context)!.removeWalletDetail,
                              AppLocalization.of(context)!
                                  .removeWalletAction
                                  .toUpperCase(), () {
                            // Show another confirm dialog
                            AppDialogs.showConfirmDialog(
                                context,
                                AppLocalization.of(context)!
                                    .removeWalletAreYouSure,
                                AppLocalization.of(context)!
                                    .removeWalletReassurance,
                                AppLocalization.of(context)!.yes, () async {
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
                      Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15,
                      ),
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
    return DecoratedBox(
      decoration: BoxDecoration(
        color: StateContainer.of(context).curTheme.drawerBackground,
        gradient: LinearGradient(
          colors: <Color>[
            StateContainer.of(context).curTheme.drawerBackground!,
            StateContainer.of(context).curTheme.backgroundDark!,
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
                          color: StateContainer.of(context).curTheme.text,
                          onPressed: () {
                            _customOpen = false;
                            _customController!.reverse();
                          },
                        ),
                      ),
                      Text(
                        AppLocalization.of(context)!.customHeader,
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
                          color: StateContainer.of(context).curTheme.text05,
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsetsDirectional.only(
                            top: 20,
                            bottom: 10,
                          ),
                          child: Text(
                            AppLocalization.of(context)!.preferences,
                            style: AppStyles.textStyleSize20W700EquinoxPrimary(
                              context,
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15,
                      ),
                      AppSettings
                          .buildSettingsListItemWithDefaultValueWithInfos(
                        context,
                        AppLocalization.of(context)!.changeCurrencyHeader,
                        AppLocalization.of(context)!
                            .changeCurrencyDesc
                            .replaceAll(
                              '%1',
                              StateContainer.of(context)
                                  .curNetwork
                                  .getNetworkCryptoCurrencyLabel(),
                            ),
                        StateContainer.of(context).curCurrency,
                        'assets/icons/money-currency.png',
                        StateContainer.of(context).curTheme.iconDrawer!,
                        _currencyDialog,
                      ),
                      Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15,
                      ),
                      AppSettings.buildSettingsListItemWithDefaultValue(
                        context,
                        AppLocalization.of(context)!.primaryCurrency,
                        StateContainer.of(context).curPrimaryCurrency,
                        'assets/icons/exchange.png',
                        StateContainer.of(context).curTheme.iconDrawer!,
                        _primaryCurrencyDialog,
                      ),
                      Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15,
                      ),
                      AppSettings.buildSettingsListItemWithDefaultValue(
                        context,
                        AppLocalization.of(context)!.language,
                        StateContainer.of(context).curLanguage,
                        'assets/icons/languages.png',
                        StateContainer.of(context).curTheme.iconDrawer!,
                        _languageDialog,
                      ),
                      Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15,
                      ),
                      AppSettings.buildSettingsListItemWithDefaultValue(
                        context,
                        AppLocalization.of(context)!.themeHeader,
                        _curThemeSetting,
                        'assets/icons/themes.png',
                        StateContainer.of(context).curTheme.iconDrawer!,
                        _themeDialog,
                      ),
                      Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15,
                      ),
                      AppSettings.buildSettingsListItemSwitch(
                        context,
                        AppLocalization.of(context)!.showBalances,
                        'assets/icons/shy.png',
                        StateContainer.of(context).curTheme.iconDrawer!,
                        _showBalancesActive,
                        onChanged: (bool isSwitched) async {
                          final preferences = await Preferences.getInstance();
                          setState(() {
                            _showBalancesActive = isSwitched;
                            StateContainer.of(context).showBalance =
                                _showBalancesActive;
                            preferences.setShowBalances(_showBalancesActive);
                            StateContainer.of(context).setState(() {});
                          });
                        },
                      ),
                      Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15,
                      ),
                      AppSettings.buildSettingsListItemSwitch(
                        context,
                        AppLocalization.of(context)!.showBlog,
                        'assets/icons/blog.png',
                        StateContainer.of(context).curTheme.iconDrawer!,
                        _showBlogActive,
                        onChanged: (bool isSwitched) async {
                          final preferences = await Preferences.getInstance();
                          setState(() {
                            _showBlogActive = isSwitched;
                            StateContainer.of(context).showBlog =
                                _showBlogActive;
                            preferences.setShowBlog(_showBlogActive);
                            StateContainer.of(context).setState(() {});
                          });
                        },
                      ),
                      Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15,
                      ),
                      AppSettings.buildSettingsListItemSwitch(
                        context,
                        AppLocalization.of(context)!.showPriceChart,
                        'assets/icons/statistics.png',
                        StateContainer.of(context).curTheme.iconDrawer!,
                        _showPriceChartActive,
                        onChanged: (bool isSwitched) async {
                          final preferences = await Preferences.getInstance();
                          setState(() {
                            _showPriceChartActive = isSwitched;
                            StateContainer.of(context).showPriceChart =
                                _showPriceChartActive;
                            preferences
                                .setShowPriceChart(_showPriceChartActive);
                            StateContainer.of(context).setState(() {});
                          });
                        },
                      ),
                      if (!kIsWeb &&
                          (Platform.isIOS == true ||
                              Platform.isAndroid == true ||
                              Platform.isMacOS == true))
                        Divider(
                          height: 2,
                          color: StateContainer.of(context).curTheme.text15,
                        ),
                      if (!kIsWeb &&
                          (Platform.isIOS == true ||
                              Platform.isAndroid == true ||
                              Platform.isMacOS == true))
                        AppSettings.buildSettingsListItemSwitch(
                          context,
                          AppLocalization.of(context)!.activateNotifications,
                          'assets/icons/notification-bell.png',
                          StateContainer.of(context).curTheme.iconDrawer!,
                          _notificationsActive,
                          onChanged: (bool isSwitched) async {
                            final preferences = await Preferences.getInstance();
                            setState(() {
                              _notificationsActive = isSwitched;
                              StateContainer.of(context).activeNotifications =
                                  _notificationsActive;
                              if (StateContainer.of(context)
                                      .timerCheckTransactionInputs !=
                                  null) {
                                StateContainer.of(context)
                                    .timerCheckTransactionInputs!
                                    .cancel();
                              }
                              if (_notificationsActive) {
                                StateContainer.of(context)
                                    .checkTransactionInputs(
                                  AppLocalization.of(context)!
                                      .transactionInputNotification,
                                );
                              }
                              preferences
                                  .setActiveNotifications(_notificationsActive);
                            });
                          },
                        ),
                      Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15,
                      ),
                      AppSettings.buildSettingsListItemSwitch(
                        context,
                        AppLocalization.of(context)!.activateVibrations,
                        'assets/icons/vibrate.png',
                        StateContainer.of(context).curTheme.iconDrawer!,
                        _vibrationActive,
                        onChanged: (bool isSwitched) async {
                          final preferences = await Preferences.getInstance();
                          setState(() {
                            _vibrationActive = isSwitched;
                            StateContainer.of(context).activeVibrations =
                                _vibrationActive;
                            preferences.setActiveVibrations(_vibrationActive);
                          });
                        },
                      ),
                      Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15,
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
                          colors: <Color>[
                            StateContainer.of(context)
                                .curTheme
                                .drawerBackground!,
                            StateContainer.of(context)
                                .curTheme
                                .backgroundDark00!
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

  // TODO(Chralu): convert to [Widget] subclass
  Widget buildAboutMenu(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: StateContainer.of(context).curTheme.drawerBackground,
        gradient: LinearGradient(
          colors: <Color>[
            StateContainer.of(context).curTheme.drawerBackground!,
            StateContainer.of(context).curTheme.backgroundDark!,
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
                      color: StateContainer.of(context).curTheme.text,
                      onPressed: () {
                        _aboutOpen = false;
                        _aboutController!.reverse();
                      },
                    ),
                  ),
                  Expanded(
                    child: AutoSizeText(
                      AppLocalization.of(context)!.aboutHeader,
                      style:
                          AppStyles.textStyleSize24W700EquinoxPrimary(context),
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
                      Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15,
                      ),
                      AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context)!
                            .aboutGeneralTermsAndConditions,
                        AppStyles.textStyleSize16W600Primary(context),
                        'assets/icons/terms-and-conditions.png',
                        StateContainer.of(context).curTheme.iconDrawer!,
                        onPressed: () async {
                          UIUtil.showWebview(
                            context,
                            'https://archethic.net',
                            AppLocalization.of(context)!
                                .aboutGeneralTermsAndConditions,
                          );
                        },
                      ),
                      Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15,
                      ),
                      AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context)!.aboutWalletServiceTerms,
                        AppStyles.textStyleSize16W600Primary(context),
                        'assets/icons/walletServiceTerms.png',
                        StateContainer.of(context).curTheme.iconDrawer!,
                        onPressed: () async {
                          UIUtil.showWebview(
                            context,
                            'https://archethic.net',
                            AppLocalization.of(context)!
                                .aboutWalletServiceTerms,
                          );
                        },
                      ),
                      Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15,
                      ),
                      AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context)!.aboutPrivacyPolicy,
                        AppStyles.textStyleSize16W600Primary(context),
                        'assets/icons/privacyPolicy.png',
                        StateContainer.of(context).curTheme.iconDrawer!,
                        onPressed: () async {
                          UIUtil.showWebview(
                            context,
                            'https://archethic.net/aewallet-privacy.html',
                            AppLocalization.of(context)!.aboutPrivacyPolicy,
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
                          colors: <Color>[
                            StateContainer.of(context)
                                .curTheme
                                .drawerBackground!,
                            StateContainer.of(context)
                                .curTheme
                                .backgroundDark00!
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
