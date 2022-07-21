/// SPDX-License-Identifier: AGPL-3.0-or-later
// ignore_for_file: always_specify_types

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/model/available_networks.dart';
import 'package:aeuniverse/model/available_themes.dart';
import 'package:aeuniverse/ui/themes/theme_dark.dart';
import 'package:aeuniverse/ui/util/settings_list_item.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/util/ui_util.dart';
import 'package:aeuniverse/ui/views/authenticate/auth_factory.dart';
import 'package:aeuniverse/ui/views/settings/backupseed_sheet.dart';
import 'package:aeuniverse/ui/widgets/components/dialog.dart';
import 'package:aeuniverse/ui/widgets/components/sheet_util.dart';
import 'package:aeuniverse/ui/widgets/dialogs/authentification_method_dialog.dart';
import 'package:aeuniverse/ui/widgets/dialogs/currency_dialog.dart';
import 'package:aeuniverse/ui/widgets/dialogs/language_dialog.dart';
import 'package:aeuniverse/ui/widgets/dialogs/lock_dialog.dart';
import 'package:aeuniverse/ui/widgets/dialogs/lock_timeout_dialog.dart';
import 'package:aeuniverse/ui/widgets/dialogs/network_dialog.dart';
import 'package:aeuniverse/ui/widgets/dialogs/primary_currency_dialog.dart';
import 'package:aeuniverse/ui/widgets/dialogs/theme_dialog.dart';
import 'package:aeuniverse/util/preferences.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:core/localization.dart';
import 'package:core/model/authentication_method.dart';
import 'package:core/model/device_lock_timeout.dart';
import 'package:core/model/device_unlock_option.dart';
import 'package:core/util/biometrics_util.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:core_ui/util/case_converter.dart';
import 'package:package_info_plus/package_info_plus.dart';

// Project imports:
import 'package:aewallet/ui/views/contacts/contact_list.dart';
import 'package:aewallet/ui/views/settings/wallet_faq_widget.dart';

class SettingsSheetWalletMobile extends StatefulWidget {
  const SettingsSheetWalletMobile({super.key});

  @override
  State<SettingsSheetWalletMobile> createState() =>
      _SettingsSheetWalletMobileState();
}

class _SettingsSheetWalletMobileState extends State<SettingsSheetWalletMobile>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  AnimationController? _contactsController;
  Animation<Offset>? _contactsOffsetFloat;
  AnimationController? _securityController;
  Animation<Offset>? _securityOffsetFloat;
  AnimationController? _customController;
  Animation<Offset>? _customOffsetFloat;
  AnimationController? _tokenController;
  Animation<Offset>? _tokenOffsetFloat;
  AnimationController? _walletFAQController;
  Animation<Offset>? _walletFAQOffsetFloat;
  AnimationController? _aboutController;
  Animation<Offset>? _aboutOffsetFloat;

  String versionString = '';

  bool _hasBiometrics = false;
  AuthenticationMethod _curAuthMethod = AuthenticationMethod(AuthMethod.pin);
  UnlockSetting _curUnlockSetting = UnlockSetting(UnlockOption.yes);
  LockTimeoutSetting _curTimeoutSetting =
      LockTimeoutSetting(LockTimeoutOption.one);
  ThemeSetting _curThemeSetting = ThemeSetting(ThemeOptions.dark);
  NetworksSetting _curNetworksSetting =
      NetworksSetting(AvailableNetworks.ArchethicMainNet);

  bool? _securityOpen;
  bool? _customOpen;
  bool? _aboutOpen;
  bool? _contactsOpen;
  bool? _walletFAQOpen;
  bool? _tokenOpen;

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
    _walletFAQOpen = false;
    _tokenOpen = false;

    // Determine if they have face or fingerprint enrolled, if not hide the setting
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
    _walletFAQController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _tokenController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _contactsOffsetFloat =
        Tween<Offset>(begin: const Offset(1.1, 0), end: const Offset(0, 0))
            .animate(_contactsController!);
    _securityOffsetFloat =
        Tween<Offset>(begin: const Offset(1.1, 0), end: const Offset(0, 0))
            .animate(_securityController!);
    _customOffsetFloat =
        Tween<Offset>(begin: const Offset(1.1, 0), end: const Offset(0, 0))
            .animate(_customController!);
    _aboutOffsetFloat =
        Tween<Offset>(begin: const Offset(1.1, 0), end: const Offset(0, 0))
            .animate(_aboutController!);
    _walletFAQOffsetFloat =
        Tween<Offset>(begin: const Offset(1.1, 0), end: const Offset(0, 0))
            .animate(_walletFAQController!);
    _tokenOffsetFloat =
        Tween<Offset>(begin: const Offset(1.1, 0), end: const Offset(0, 0))
            .animate(_tokenController!);
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        versionString =
            '${AppLocalization.of(context)!.version} ${packageInfo.version}';
      });
    });
  }

  @override
  void dispose() {
    _contactsController!.dispose();
    _securityController!.dispose();
    _customController!.dispose();
    _aboutController!.dispose();
    _walletFAQController!.dispose();
    _tokenController!.dispose();
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
      default:
        super.didChangeAppLifecycleState(state);
        break;
    }
  }

  Future<void> _authMethodDialog() async {
    await AuthentificationMethodDialog.getDialog(
        context, _hasBiometrics, _curAuthMethod);
  }

  Future<void> _lockDialog() async {
    _curUnlockSetting =
        (await LockDialog.getDialog(context, _curUnlockSetting))!;
    setState(() {});
  }

  Future<void> _currencyDialog() async {
    await CurrencyDialog.getDialog(context);
    setState(() {});
  }

  Future<void> _languageDialog() async {
    await LanguageDialog.getDialog(context);
    setState(() {});
  }

  Future<void> _primaryCurrencyDialog() async {
    await PrimaryCurrencyDialog.getDialog(context);
    setState(() {});
  }

  Future<void> _networkDialog() async {
    NetworksSetting? ns =
        await NetworkDialog.getDialog(context, _curNetworksSetting);
    if (ns != null) {
      _curNetworksSetting = ns;
      await StateContainer.of(context).requestUpdate();
      setState(() {});
    }
  }

  Future<void> _lockTimeoutDialog() async {
    _curTimeoutSetting =
        (await LockTimeoutDialog.getDialog(context, _curTimeoutSetting))!;
    setState(() {});
  }

  Future<void> _themeDialog() async {
    _curThemeSetting =
        (await ThemeDialog.getDialog(context, _curThemeSetting))!;
    setState(() {});
  }

  Future<bool> _onBackButtonPressed() async {
    if (_contactsOpen!) {
      setState(() {
        _contactsOpen = false;
      });
      _contactsController!.reverse();
      return false;
    } else if (_securityOpen!) {
      setState(() {
        _securityOpen = false;
      });
      _securityController!.reverse();
      return false;
    } else if (_customOpen!) {
      setState(() {
        _customOpen = false;
      });
      _customController!.reverse();
      return false;
    } else if (_aboutOpen!) {
      setState(() {
        _aboutOpen = false;
      });
      _aboutController!.reverse();
      return false;
    } else if (_walletFAQOpen!) {
      setState(() {
        _walletFAQOpen = false;
      });
      _walletFAQController!.reverse();
      return false;
    } else if (_tokenOpen!) {
      setState(() {
        _tokenOpen = false;
      });
      _tokenController!.reverse();
      return false;
    }
    return true;
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
            buildMainSettings(context),
            SlideTransition(
              position: _contactsOffsetFloat!,
              child: ContactsList(
                _contactsController!,
                _contactsOpen!,
              ),
            ),
            SlideTransition(
                position: _securityOffsetFloat!,
                child: buildSecurityMenu(context)),
            SlideTransition(
                position: _customOffsetFloat!, child: buildCustomMenu(context)),
            SlideTransition(
                position: _aboutOffsetFloat!, child: buildAboutMenu(context)),
            SlideTransition(
                position: _walletFAQOffsetFloat!,
                child: WalletFAQ(_walletFAQController!, _walletFAQOpen!)),
            SlideTransition(
                position: _tokenOffsetFloat!, child: buildTokenMenu(context)),
          ],
        ),
      ),
    );
  }

  Widget buildMainSettings(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: StateContainer.of(context).curTheme.drawerBackground!,
          border: Border(
            right: BorderSide(
                color: StateContainer.of(context).curTheme.text30!, width: 1),
          )),
      child: SafeArea(
        minimum: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 30,
        ),
        child: Column(
          children: <Widget>[
            // Settings items
            Expanded(
                child: Stack(
              children: <Widget>[
                ListView(
                  padding: const EdgeInsets.only(top: 15.0),
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsetsDirectional.only(
                          top: 10.0, bottom: 10.0),
                      child: Text(AppLocalization.of(context)!.manage,
                          style: AppStyles.textStyleSize20W700EquinoxPrimary(
                              context)),
                    ),
                    if (StateContainer.of(context)
                        .appWallet!
                        .appKeychain!
                        .getAccountSelected()!
                        .balance!
                        .isNativeTokenValuePositive())
                      Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15,
                      )
                    else
                      const SizedBox(),
                    /* if (StateContainer.of(context).wallet != null &&
                        StateContainer.of(context)
                                .wallet!
                                .accountBalance
                                .networkCurrencyValue !=
                            null &&
                        StateContainer.of(context)
                                .wallet!
                                .accountBalance
                                .networkCurrencyValue! >
                            0)
                      AppSettings.buildSettingsListItemSingleLineWithInfos(
                          context,
                          AppLocalization.of(context)!.tokenHeader,
                          AppLocalization.of(context)!.tokenHeaderDesc,
                          icon: 'packages/aewallet/assets/icons/token.png',
                          iconColor: StateContainer.of(context)
                              .curTheme
                              .iconDrawer!, onPressed: () {
                        setState(() {
                          _tokenOpen = true;
                        });
                        _tokenController!.forward();
                      })
                    else
                      const SizedBox(),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),*/
                    AppSettings.buildSettingsListItemSingleLineWithInfos(
                        context,
                        AppLocalization.of(context)!.addressBookHeader,
                        AppLocalization.of(context)!.addressBookDesc,
                        icon: 'packages/aewallet/assets/icons/address-book.png',
                        iconColor: StateContainer.of(context)
                            .curTheme
                            .iconDrawer!, onPressed: () {
                      setState(() {
                        _contactsOpen = true;
                      });
                      _contactsController!.forward();
                    }),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsetsDirectional.only(
                          top: 20.0, bottom: 10.0),
                      child: Text(AppLocalization.of(context)!.preferences,
                          style: AppStyles.textStyleSize20W700EquinoxPrimary(
                              context)),
                    ),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context)!.securityHeader,
                        AppStyles.textStyleSize16W600EquinoxPrimary(context),
                        'packages/aewallet/assets/icons/encrypted.png',
                        StateContainer.of(context).curTheme.iconDrawer!,
                        onPressed: () {
                      setState(() {
                        _securityOpen = true;
                      });
                      _securityController!.forward();
                    }),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context)!.customHeader,
                        AppStyles.textStyleSize16W600EquinoxPrimary(context),
                        'packages/aewallet/assets/icons/brush.png',
                        StateContainer.of(context).curTheme.iconDrawer!,
                        onPressed: () {
                      setState(() {
                        _customOpen = true;
                      });
                      _customController!.forward();
                    }),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsetsDirectional.only(
                          top: 20.0, bottom: 10.0),
                      child: Text(AppLocalization.of(context)!.informations,
                          style: AppStyles.textStyleSize20W700EquinoxPrimary(
                              context)),
                    ),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemSingleLineWithInfos(
                        context,
                        AppLocalization.of(context)!.walletFAQHeader,
                        AppLocalization.of(context)!.walletFAQDesc,
                        icon: 'packages/aewallet/assets/icons/faq.png',
                        iconColor: StateContainer.of(context)
                            .curTheme
                            .iconDrawer!, onPressed: () {
                      setState(() {
                        _walletFAQOpen = true;
                      });
                      _walletFAQController!.forward();
                    }),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemSingleLineWithInfos(
                        context,
                        AppLocalization.of(context)!.aeWebsiteLinkHeader,
                        AppLocalization.of(context)!.aeWebsiteLinkDesc,
                        icon: 'packages/aewallet/assets/icons/home.png',
                        iconColor: StateContainer.of(context)
                            .curTheme
                            .iconDrawer!, onPressed: () async {
                      UIUtil.showWebview(context, 'https://www.archethic.net',
                          AppLocalization.of(context)!.aeWebsiteLinkHeader);
                    }),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemSingleLineWithInfos(
                        context,
                        AppLocalization.of(context)!.labLinkHeader,
                        AppLocalization.of(context)!.labLinkDesc,
                        icon: 'packages/aewallet/assets/icons/microscope.png',
                        iconColor: StateContainer.of(context)
                            .curTheme
                            .iconDrawer!, onPressed: () async {
                      UIUtil.showWebview(
                          context,
                          'https://www.archethic.net/lab.html',
                          AppLocalization.of(context)!.labLinkHeader);
                    }),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context)!.aboutHeader,
                        AppStyles.textStyleSize16W600EquinoxPrimary(context),
                        'packages/aewallet/assets/icons/help.png',
                        StateContainer.of(context).curTheme.iconDrawer!,
                        onPressed: () {
                      setState(() {
                        _aboutOpen = true;
                      });
                      _aboutController!.forward();
                    }),
                    Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15),
                    const SizedBox(height: 30),
                  ].where(notNull).toList(),
                ),
                //List Top Gradient End
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 20.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          StateContainer.of(context).curTheme.drawerBackground!,
                          StateContainer.of(context).curTheme.backgroundDark00!
                        ],
                        begin: const AlignmentDirectional(0.5, -1.0),
                        end: const AlignmentDirectional(0.5, 1.0),
                      ),
                    ),
                  ),
                ), //List Top Gradient End
                //List Bottom Gradient
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 30.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          StateContainer.of(context).curTheme.backgroundDark00!,
                          StateContainer.of(context).curTheme.drawerBackground!
                        ],
                        begin: const AlignmentDirectional(0.5, -1),
                        end: const AlignmentDirectional(0.5, 0.5),
                      ),
                    ),
                  ),
                ), //List Bottom Gradient End
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget buildSecurityMenu(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: StateContainer.of(context).curTheme.drawerBackground,
        border: Border(
          right: BorderSide(
              color: StateContainer.of(context).curTheme.text30!, width: 1),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: StateContainer.of(context).curTheme.overlay30!,
              offset: const Offset(-5, 0),
              blurRadius: 20),
        ],
      ),
      child: SafeArea(
        minimum: const EdgeInsets.only(
          top: 60,
        ),
        child: Column(
          children: <Widget>[
            // Back button and Security Text
            Container(
              margin: const EdgeInsets.only(bottom: 10.0, top: 5),
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
                            setState(() {
                              _securityOpen = false;
                            });
                            _securityController!.reverse();
                          },
                        ),
                      ),
                      //Security Header Text
                      Text(
                        AppLocalization.of(context)!.securityHeader,
                        style: AppStyles.textStyleSize24W700EquinoxPrimary(
                            context),
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
                  padding: const EdgeInsets.only(top: 15.0),
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsetsDirectional.only(bottom: 10),
                      child: Text(AppLocalization.of(context)!.preferences,
                          style: AppStyles.textStyleSize20W700EquinoxPrimary(
                              context)),
                    ),
                    /*Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemWithDefaultValue(
                        context,
                        AppLocalization.of(context)!.networksHeader,
                        _curNetworksSetting,
                        'packages/aewallet/assets/icons/url.png',
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
                        'packages/aewallet/assets/icons/authentLaunch.png',
                        StateContainer.of(context).curTheme.iconDrawer!,
                        _authMethodDialog),
                    // Authenticate on Launch

                    Column(children: <Widget>[
                      Divider(
                          height: 2,
                          color: StateContainer.of(context).curTheme.text15),
                      AppSettings.buildSettingsListItemWithDefaultValue(
                          context,
                          AppLocalization.of(context)!.lockAppSetting,
                          _curUnlockSetting,
                          'packages/aewallet/assets/icons/authentication.png',
                          StateContainer.of(context).curTheme.iconDrawer!,
                          _lockDialog),
                    ]),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    // Authentication Timer
                    AppSettings.buildSettingsListItemWithDefaultValue(
                      context,
                      AppLocalization.of(context)!.autoLockHeader,
                      _curTimeoutSetting,
                      'packages/aewallet/assets/icons/autoLock.png',
                      StateContainer.of(context).curTheme.iconDrawer!,
                      _lockTimeoutDialog,
                      disabled: _curUnlockSetting.setting == UnlockOption.no,
                    ),
                    Column(children: <Widget>[
                      Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15,
                      ),
                      AppSettings.buildSettingsListItemSingleLine(
                          context,
                          AppLocalization.of(context)!.backupSecretPhrase,
                          AppStyles.textStyleSize16W600EquinoxPrimary(context),
                          'packages/aewallet/assets/icons/key-word.png',
                          StateContainer.of(context).curTheme.iconDrawer!,
                          onPressed: () async {
                        final Preferences preferences =
                            await Preferences.getInstance();
                        final AuthenticationMethod authMethod =
                            preferences.getAuthMethod();

                        bool auth = await AuthFactory.authenticate(
                            context, authMethod,
                            activeVibrations:
                                StateContainer.of(context).activeVibrations);
                        if (auth) {
                          StateContainer.of(context)
                              .getSeed()
                              .then((String? seed) {
                            Sheets.showAppHeightNineSheet(
                                context: context,
                                widget: AppSeedBackupSheet(seed!));
                          });
                        }
                      }),
                    ]),
                    if (_curAuthMethod.method == AuthMethod.pin)
                      Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15,
                      ),
                    if (_curAuthMethod.method == AuthMethod.pin)
                      AppSettings.buildSettingsListItemSwitch(
                          context,
                          AppLocalization.of(context)!.pinPadShuffle,
                          'packages/aewallet/assets/icons/shuffle.png',
                          StateContainer.of(context).curTheme.iconDrawer!,
                          _pinPadShuffleActive,
                          onChanged: (bool isSwitched) async {
                        final Preferences preferences =
                            await Preferences.getInstance();
                        setState(() {
                          _pinPadShuffleActive = isSwitched;
                          preferences.setPinPadShuffle(isSwitched);
                        });
                      }),

                    Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15),
                    AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context)!.removeWallet,
                        AppStyles.textStyleSize16W600EquinoxRed(context),
                        'packages/aewallet/assets/icons/rubbish.png',
                        Colors.red, onPressed: () {
                      AppDialogs.showConfirmDialog(
                          context,
                          CaseChange.toUpperCase(
                              AppLocalization.of(context)!.warning,
                              StateContainer.of(context)
                                  .curLanguage
                                  .getLocaleString()),
                          AppLocalization.of(context)!.removeWalletDetail,
                          AppLocalization.of(context)!
                              .removeWalletAction
                              .toUpperCase(), () {
                        // Show another confirm dialog
                        AppDialogs.showConfirmDialog(
                            context,
                            AppLocalization.of(context)!.removeWalletAreYouSure,
                            AppLocalization.of(context)!
                                .removeWalletReassurance,
                            AppLocalization.of(context)!.yes, () async {
                          await StateContainer.of(context).logOut();
                          StateContainer.of(context).curTheme = DarkTheme();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/', (Route<dynamic> route) => false);
                        });
                      });
                    }),
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
                    height: 20.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          StateContainer.of(context).curTheme.drawerBackground!,
                          StateContainer.of(context).curTheme.backgroundDark00!
                        ],
                        begin: const AlignmentDirectional(0.5, -1.0),
                        end: const AlignmentDirectional(0.5, 1.0),
                      ),
                    ),
                  ),
                ), //List Top Gradient End
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget buildCustomMenu(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: StateContainer.of(context).curTheme.drawerBackground,
        border: Border(
          right: BorderSide(
              color: StateContainer.of(context).curTheme.text30!, width: 1),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: StateContainer.of(context).curTheme.overlay30!,
              offset: const Offset(-5, 0),
              blurRadius: 20),
        ],
      ),
      child: SafeArea(
        minimum: const EdgeInsets.only(
          top: 60,
        ),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 10.0, top: 5),
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
                            setState(() {
                              _customOpen = false;
                            });
                            _customController!.reverse();
                          },
                        ),
                      ),
                      Text(
                        AppLocalization.of(context)!.customHeader,
                        style: AppStyles.textStyleSize24W700EquinoxPrimary(
                            context),
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
                  padding: const EdgeInsets.only(top: 15.0),
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsetsDirectional.only(bottom: 10),
                      child: Text(AppLocalization.of(context)!.preferences,
                          style: AppStyles.textStyleSize20W700EquinoxPrimary(
                              context)),
                    ),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemWithDefaultValueWithInfos(
                        context,
                        AppLocalization.of(context)!.changeCurrencyHeader,
                        AppLocalization.of(context)!
                            .changeCurrencyDesc
                            .replaceAll(
                                '%1',
                                StateContainer.of(context)
                                    .curNetwork
                                    .getNetworkCryptoCurrencyLabel()),
                        StateContainer.of(context).curCurrency,
                        'packages/aewallet/assets/icons/money-currency.png',
                        StateContainer.of(context).curTheme.iconDrawer!,
                        _currencyDialog),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemWithDefaultValue(
                        context,
                        AppLocalization.of(context)!.primaryCurrency,
                        StateContainer.of(context).curPrimaryCurrency,
                        'packages/aewallet/assets/icons/exchange.png',
                        StateContainer.of(context).curTheme.iconDrawer!,
                        _primaryCurrencyDialog),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemWithDefaultValue(
                        context,
                        AppLocalization.of(context)!.language,
                        StateContainer.of(context).curLanguage,
                        'packages/aewallet/assets/icons/languages.png',
                        StateContainer.of(context).curTheme.iconDrawer!,
                        _languageDialog),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemWithDefaultValue(
                        context,
                        AppLocalization.of(context)!.themeHeader,
                        _curThemeSetting,
                        'packages/aewallet/assets/icons/themes.png',
                        StateContainer.of(context).curTheme.iconDrawer!,
                        _themeDialog),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemSwitch(
                        context,
                        AppLocalization.of(context)!.showBalances,
                        'packages/aewallet/assets/icons/shy.png',
                        StateContainer.of(context).curTheme.iconDrawer!,
                        _showBalancesActive,
                        onChanged: (bool isSwitched) async {
                      final Preferences preferences =
                          await Preferences.getInstance();
                      setState(() {
                        _showBalancesActive = isSwitched;
                        StateContainer.of(context).showBalance =
                            _showBalancesActive;
                        preferences.setShowBalances(_showBalancesActive);
                      });
                    }),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemSwitch(
                        context,
                        AppLocalization.of(context)!.showBlog,
                        'packages/aewallet/assets/icons/blog.png',
                        StateContainer.of(context).curTheme.iconDrawer!,
                        _showBlogActive, onChanged: (bool isSwitched) async {
                      final Preferences preferences =
                          await Preferences.getInstance();
                      setState(() {
                        _showBlogActive = isSwitched;
                        StateContainer.of(context).showBlog = _showBlogActive;
                        preferences.setShowBlog(_showBlogActive);
                      });
                    }),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemSwitch(
                        context,
                        AppLocalization.of(context)!.showPriceChart,
                        'packages/aewallet/assets/icons/statistics.png',
                        StateContainer.of(context).curTheme.iconDrawer!,
                        _showPriceChartActive,
                        onChanged: (bool isSwitched) async {
                      final Preferences preferences =
                          await Preferences.getInstance();
                      setState(() {
                        _showPriceChartActive = isSwitched;
                        StateContainer.of(context).showPriceChart =
                            _showPriceChartActive;
                        preferences.setShowPriceChart(_showPriceChartActive);
                      });
                    }),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemSwitch(
                        context,
                        AppLocalization.of(context)!.activateNotifications,
                        'packages/aewallet/assets/icons/notification-bell.png',
                        StateContainer.of(context).curTheme.iconDrawer!,
                        _notificationsActive,
                        onChanged: (bool isSwitched) async {
                      final Preferences preferences =
                          await Preferences.getInstance();
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
                          StateContainer.of(context).checkTransactionInputs(
                              AppLocalization.of(context)!
                                  .transactionInputNotification);
                        }
                        preferences
                            .setActiveNotifications(_notificationsActive);
                      });
                    }),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemSwitch(
                        context,
                        AppLocalization.of(context)!.activateVibrations,
                        'packages/aewallet/assets/icons/vibrate.png',
                        StateContainer.of(context).curTheme.iconDrawer!,
                        _vibrationActive, onChanged: (bool isSwitched) async {
                      final Preferences preferences =
                          await Preferences.getInstance();
                      setState(() {
                        _vibrationActive = isSwitched;
                        StateContainer.of(context).activeVibrations =
                            _vibrationActive;
                        preferences.setActiveVibrations(_vibrationActive);
                      });
                    }),
                    Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15),
                  ].where(notNull).toList(),
                ),
                //List Top Gradient End
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 20.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          StateContainer.of(context).curTheme.drawerBackground!,
                          StateContainer.of(context).curTheme.backgroundDark00!
                        ],
                        begin: const AlignmentDirectional(0.5, -1.0),
                        end: const AlignmentDirectional(0.5, 1.0),
                      ),
                    ),
                  ),
                ), //List Top Gradient End
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget buildAboutMenu(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
              color: StateContainer.of(context).curTheme.text30!, width: 1),
        ),
        color: StateContainer.of(context).curTheme.drawerBackground,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: StateContainer.of(context).curTheme.overlay30!,
              offset: const Offset(-5, 0),
              blurRadius: 20),
        ],
      ),
      child: SafeArea(
        minimum: const EdgeInsets.only(
          top: 60,
        ),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 10.0, top: 5),
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
                        setState(() {
                          _aboutOpen = false;
                        });
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
                  padding: const EdgeInsets.only(top: 15.0),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(versionString,
                              style: AppStyles.textStyleSize14W100Primary(
                                  context)),
                        ],
                      ),
                    ),
                    Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15),
                    AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context)!
                            .aboutGeneralTermsAndConditions,
                        AppStyles.textStyleSize16W600Primary(context),
                        'packages/aewallet/assets/icons/terms-and-conditions.png',
                        StateContainer.of(context).curTheme.iconDrawer!,
                        onPressed: () async {
                      UIUtil.showWebview(
                          context,
                          'https://archethic.net',
                          AppLocalization.of(context)!
                              .aboutGeneralTermsAndConditions);
                    }),
                    Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15),
                    AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context)!.aboutWalletServiceTerms,
                        AppStyles.textStyleSize16W600Primary(context),
                        'packages/aewallet/assets/icons/walletServiceTerms.png',
                        StateContainer.of(context).curTheme.iconDrawer!,
                        onPressed: () async {
                      UIUtil.showWebview(context, 'https://archethic.net',
                          AppLocalization.of(context)!.aboutWalletServiceTerms);
                    }),
                    Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15),
                    AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context)!.aboutPrivacyPolicy,
                        AppStyles.textStyleSize16W600Primary(context),
                        'packages/aewallet/assets/icons/privacyPolicy.png',
                        StateContainer.of(context).curTheme.iconDrawer!,
                        onPressed: () async {
                      UIUtil.showWebview(
                          context,
                          'https://archethic.net/aewallet-privacy.html',
                          AppLocalization.of(context)!.aboutPrivacyPolicy);
                    }),
                  ].where(notNull).toList(),
                ),
                //List Top Gradient End
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 20.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          StateContainer.of(context).curTheme.drawerBackground!,
                          StateContainer.of(context).curTheme.backgroundDark00!
                        ],
                        begin: const AlignmentDirectional(0.5, -1.0),
                        end: const AlignmentDirectional(0.5, 1.0),
                      ),
                    ),
                  ),
                ), //List Top Gradient End
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget buildTokenMenu(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
              color: StateContainer.of(context).curTheme.text30!, width: 1),
        ),
        color: StateContainer.of(context).curTheme.drawerBackground,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: StateContainer.of(context).curTheme.overlay30!,
              offset: const Offset(-5, 0),
              blurRadius: 20),
        ],
      ),
      child: SafeArea(
        minimum: const EdgeInsets.only(
          top: 60,
        ),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 10.0, top: 5),
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
                        setState(() {
                          _tokenOpen = false;
                        });
                        _tokenController!.reverse();
                      },
                    ),
                  ),
                  Expanded(
                    child: AutoSizeText(
                      AppLocalization.of(context)!.tokenHeader,
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
                  padding: const EdgeInsets.only(top: 15.0),
                  children: <Widget>[
                    /*Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15),
                    AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context)!.addTokenHeader,
                        AppStyles.textStyleSize16W600Primary(context),
                        'packages/aewallet/assets/icons/addToken.png',
                        StateContainer.of(context).curTheme.iconDrawer!,
                        onPressed: () {
                      Sheets.showAppHeightNineSheet(
                          context: context, widget: const AddTokenSheet());
                    }),
                    Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15),
                    AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context)!.transferToken,
                        AppStyles.textStyleSize16W600Primary(context),
                        'packages/aewallet/assets/icons/transferToken.png',
                        StateContainer.of(context).curTheme.iconDrawer!,
                        onPressed: () {
                      /*Sheets.showAppHeightNineSheet(
                          context: context,
                          widget: TransferTokenSheet(
                            contactsRef: StateContainer.of(context).contactsRef,
                            title: AppLocalization.of(context).transferToken,
                          ));*/
                    }),*/
                    Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15),
                  ].where(notNull).toList(),
                ),
                //List Top Gradient End
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 20.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          StateContainer.of(context).curTheme.drawerBackground!,
                          StateContainer.of(context).curTheme.backgroundDark00!
                        ],
                        begin: const AlignmentDirectional(0.5, -1.0),
                        end: const AlignmentDirectional(0.5, 1.0),
                      ),
                    ),
                  ),
                ), //List Top Gradient End
              ],
            )),
          ],
        ),
      ),
    );
  }
}
