// @dart=2.9

import 'dart:async';

import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:uniris_mobile_wallet/ui/settings/custom_url_widget.dart';
import 'package:uniris_mobile_wallet/ui/settings/disable_password_sheet.dart';
import 'package:uniris_mobile_wallet/ui/settings/set_password_sheet.dart';
import 'package:uniris_mobile_wallet/ui/widgets/app_simpledialog.dart';
import 'package:uniris_mobile_wallet/ui/widgets/dialog.dart';
import 'package:uniris_mobile_wallet/ui/widgets/sheet_util.dart';
import 'package:package_info/package_info.dart';
import 'package:flutter/material.dart';
import 'package:uniris_mobile_wallet/appstate_container.dart';
import 'package:uniris_mobile_wallet/localization.dart';
import 'package:uniris_mobile_wallet/styles.dart';
import 'package:uniris_mobile_wallet/app_icons.dart';
import 'package:uniris_mobile_wallet/service_locator.dart';
import 'package:uniris_mobile_wallet/model/authentication_method.dart';
import 'package:uniris_mobile_wallet/model/available_currency.dart';
import 'package:uniris_mobile_wallet/model/device_unlock_option.dart';
import 'package:uniris_mobile_wallet/model/device_lock_timeout.dart';
import 'package:uniris_mobile_wallet/model/available_language.dart';
import 'package:uniris_mobile_wallet/model/vault.dart';
import 'package:uniris_mobile_wallet/ui/settings/settings_list_item.dart';
import 'package:uniris_mobile_wallet/ui/settings/contacts_widget.dart';
import 'package:uniris_mobile_wallet/ui/widgets/security.dart';
import 'package:uniris_mobile_wallet/util/caseconverter.dart';
import 'package:uniris_mobile_wallet/util/hapticutil.dart';
import 'package:uniris_mobile_wallet/util/sharedprefsutil.dart';
import 'package:uniris_mobile_wallet/util/biometrics.dart';

import '../../appstate_container.dart';
import '../../util/sharedprefsutil.dart';

class SettingsSheet extends StatefulWidget {
  @override
  _SettingsSheetState createState() => _SettingsSheetState();
}

class _SettingsSheetState extends State<SettingsSheet>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  AnimationController _controller;
  Animation<Offset> _offsetFloat;
  AnimationController _securityController;
  Animation<Offset> _securityOffsetFloat;
  AnimationController _customUrlController;
  Animation<Offset> _customUrlOffsetFloat;

  String versionString = '';

  bool _hasBiometrics = false;
  AuthenticationMethod _curAuthMethod =
      AuthenticationMethod(AuthMethod.BIOMETRICS);
  UnlockSetting _curUnlockSetting = UnlockSetting(UnlockOption.NO);
  LockTimeoutSetting _curTimeoutSetting =
      LockTimeoutSetting(LockTimeoutOption.ONE);

  bool _securityOpen;

  bool _contactsOpen;

  bool _customUrlOpen;

  bool notNull(Object o) => o != null;

  @override
  void initState() {
    super.initState();
    _contactsOpen = false;
    _securityOpen = false;
    _customUrlOpen = false;
    // Determine if they have face or fingerprint enrolled, if not hide the setting
    sl.get<BiometricUtil>().hasBiometrics().then((bool hasBiometrics) {
      setState(() {
        _hasBiometrics = hasBiometrics;
      });
    });
    // Get default auth method setting
    sl
        .get<SharedPrefsUtil>()
        .getAuthMethod()
        .then((AuthenticationMethod authMethod) {
      setState(() {
        _curAuthMethod = authMethod;
      });
    });
    // Get default unlock settings
    sl.get<SharedPrefsUtil>().getLock().then((bool lock) {
      setState(() {
        _curUnlockSetting = lock
            ? UnlockSetting(UnlockOption.YES)
            : UnlockSetting(UnlockOption.NO);
      });
    });
    sl
        .get<SharedPrefsUtil>()
        .getLockTimeout()
        .then((LockTimeoutSetting lockTimeout) {
      setState(() {
        _curTimeoutSetting = lockTimeout;
      });
    });
    // Setup animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    // For security menu
    _securityController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    // For customUrl menu
    _customUrlController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );

    _offsetFloat =
        Tween<Offset>(begin: const Offset(1.1, 0), end: const Offset(0, 0))
            .animate(_controller);
    _securityOffsetFloat =
        Tween<Offset>(begin: const Offset(1.1, 0), end: const Offset(0, 0))
            .animate(_securityController);
    _customUrlOffsetFloat =
        Tween<Offset>(begin: const Offset(1.1, 0), end: const Offset(0, 0))
            .animate(_customUrlController);
    // Version string
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        versionString = 'v${packageInfo.version}';
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _securityController.dispose();
    _customUrlController.dispose();
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
    switch (await showDialog<AuthMethod>(
        context: context,
        builder: (BuildContext context) {
          return AppSimpleDialog(
            title: Text(
              AppLocalization.of(context).authMethod,
              style: AppStyles.textStyleDialogHeader(context),
            ),
            children: <Widget>[
              AppSimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, AuthMethod.BIOMETRICS);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    AppLocalization.of(context).biometricsMethod,
                    style: AppStyles.textStyleDialogOptions(context),
                  ),
                ),
              ),
              AppSimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, AuthMethod.PIN);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    AppLocalization.of(context).pinMethod,
                    style: AppStyles.textStyleDialogOptions(context),
                  ),
                ),
              ),
            ],
          );
        })) {
      case AuthMethod.PIN:
        sl
            .get<SharedPrefsUtil>()
            .setAuthMethod(AuthenticationMethod(AuthMethod.PIN))
            .then((_) {
          setState(() {
            _curAuthMethod = AuthenticationMethod(AuthMethod.PIN);
          });
        });
        break;
      case AuthMethod.BIOMETRICS:
        sl
            .get<SharedPrefsUtil>()
            .setAuthMethod(AuthenticationMethod(AuthMethod.BIOMETRICS))
            .then((_) {
          setState(() {
            _curAuthMethod = AuthenticationMethod(AuthMethod.BIOMETRICS);
          });
        });
        break;
    }
  }

  Future<void> _lockDialog() async {
    switch (await showDialog<UnlockOption>(
        context: context,
        builder: (BuildContext context) {
          return AppSimpleDialog(
            title: Text(
              AppLocalization.of(context).lockAppSetting,
              style: AppStyles.textStyleDialogHeader(context),
            ),
            children: <Widget>[
              AppSimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, UnlockOption.NO);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    AppLocalization.of(context).no,
                    style: AppStyles.textStyleDialogOptions(context),
                  ),
                ),
              ),
              AppSimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, UnlockOption.YES);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    AppLocalization.of(context).yes,
                    style: AppStyles.textStyleDialogOptions(context),
                  ),
                ),
              ),
            ],
          );
        })) {
      case UnlockOption.YES:
        sl.get<SharedPrefsUtil>().setLock(true).then((_) {
          setState(() {
            _curUnlockSetting = UnlockSetting(UnlockOption.YES);
          });
        });
        break;
      case UnlockOption.NO:
        sl.get<SharedPrefsUtil>().setLock(false).then((_) {
          setState(() {
            _curUnlockSetting = UnlockSetting(UnlockOption.NO);
          });
        });
        break;
    }
  }

  List<Widget> _buildCurrencyOptions() {
    final List<Widget> ret = List<Widget>.empty(growable: true);
    for (AvailableCurrencyEnum value in AvailableCurrencyEnum.values) {
      ret.add(SimpleDialogOption(
        onPressed: () {
          Navigator.pop(context, value);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: <Widget>[
              Text(AvailableCurrency(value).getDisplayName(context),
                  style: StateContainer.of(context)
                              .curCurrency
                              .getDisplayName(context) ==
                          AvailableCurrency(value).getDisplayName(context)
                      ? AppStyles.textStyleDialogOptionsChoice(context)
                      : AppStyles.textStyleDialogOptions(context)),
              const SizedBox(width: 20),
              if (StateContainer.of(context)
                      .curCurrency
                      .getDisplayName(context) ==
                  AvailableCurrency(value).getDisplayName(context))
                Icon(
                  FontAwesome.ok,
                  color: StateContainer.of(context).curTheme.choiceOption,
                  size: 16,
                )
              else
                const SizedBox(),
            ],
          ),
        ),
      ));
    }
    return ret;
  }

  Future<void> _currencyDialog() async {
    final AvailableCurrencyEnum selection =
        await showAppDialog<AvailableCurrencyEnum>(
            context: context,
            builder: (BuildContext context) {
              return AppSimpleDialog(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    AppLocalization.of(context).currency,
                    style: AppStyles.textStyleDialogHeader(context),
                  ),
                ),
                children: _buildCurrencyOptions(),
              );
            });
    if (selection != null) {
      sl
          .get<SharedPrefsUtil>()
          .setCurrency(AvailableCurrency(selection))
          .then((_) {
        if (StateContainer.of(context).curCurrency.currency != selection) {
          setState(() {
            StateContainer.of(context).curCurrency =
                AvailableCurrency(selection);
            StateContainer.of(context)
                .updateCurrency(AvailableCurrency(selection));
          });
        }
      });
    }
  }

  List<Widget> _buildLanguageOptions() {
    final List<Widget> ret = List<Widget>.empty(growable: true);
    for (AvailableLanguage value in AvailableLanguage.values) {
      ret.add(SimpleDialogOption(
        onPressed: () {
          Navigator.pop(context, value);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: <Widget>[
              Text(LanguageSetting(value).getDisplayName(context),
                  style: StateContainer.of(context)
                              .curLanguage
                              .getDisplayName(context) ==
                          LanguageSetting(value).getDisplayName(context)
                      ? AppStyles.textStyleDialogOptionsChoice(context)
                      : AppStyles.textStyleDialogOptions(context)),
              const SizedBox(width: 20),
              if (StateContainer.of(context)
                      .curLanguage
                      .getDisplayName(context) ==
                  LanguageSetting(value).getDisplayName(context))
                Icon(
                  FontAwesome.ok,
                  color: StateContainer.of(context).curTheme.choiceOption,
                  size: 16,
                )
              else
                const SizedBox(),
            ],
          ),
        ),
      ));
    }

    return ret;
  }

  Future<void> _languageDialog() async {
    final AvailableLanguage selection = await showAppDialog<AvailableLanguage>(
        context: context,
        builder: (BuildContext context) {
          return AppSimpleDialog(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                AppLocalization.of(context).language,
                style: AppStyles.textStyleDialogHeader(context),
              ),
            ),
            children: _buildLanguageOptions(),
          );
        });
    if (selection != null) {
      sl
          .get<SharedPrefsUtil>()
          .setLanguage(LanguageSetting(selection))
          .then((_) {
        if (StateContainer.of(context).curLanguage.language != selection) {
          setState(() {
            StateContainer.of(context)
                .updateLanguage(LanguageSetting(selection));
          });
        }
      });
    }
  }

  List<Widget> _buildLockTimeoutOptions() {
    final List<Widget> ret = List<Widget>.empty(growable: true);
    for (LockTimeoutOption value in LockTimeoutOption.values) {
      ret.add(SimpleDialogOption(
        onPressed: () {
          Navigator.pop(context, value);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: <Widget>[
              Text(LockTimeoutSetting(value).getDisplayName(context),
                  style: _curUnlockSetting.getDisplayName(context) ==
                          LockTimeoutSetting(value).getDisplayName(context)
                      ? AppStyles.textStyleDialogOptionsChoice(context)
                      : AppStyles.textStyleDialogOptions(context)),
              const SizedBox(width: 20),
              if (_curUnlockSetting.getDisplayName(context) ==
                  LockTimeoutSetting(value).getDisplayName(context))
                Icon(
                  FontAwesome.ok,
                  color: StateContainer.of(context).curTheme.choiceOption,
                  size: 16,
                )
              else
                const SizedBox(),
            ],
          ),
        ),
      ));
    }

    return ret;
  }

  Future<void> _lockTimeoutDialog() async {
    final LockTimeoutOption selection = await showAppDialog<LockTimeoutOption>(
        context: context,
        builder: (BuildContext context) {
          return AppSimpleDialog(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                AppLocalization.of(context).autoLockHeader,
                style: AppStyles.textStyleDialogHeader(context),
              ),
            ),
            children: _buildLockTimeoutOptions(),
          );
        });
    sl
        .get<SharedPrefsUtil>()
        .setLockTimeout(LockTimeoutSetting(selection))
        .then((_) {
      if (_curTimeoutSetting.setting != selection) {
        sl
            .get<SharedPrefsUtil>()
            .setLockTimeout(LockTimeoutSetting(selection))
            .then((_) {
          setState(() {
            _curTimeoutSetting = LockTimeoutSetting(selection);
          });
        });
      }
    });
  }

  Future<bool> _onBackButtonPressed() async {
    if (_contactsOpen) {
      setState(() {
        _contactsOpen = false;
      });
      _controller.reverse();
      return false;
    } else if (_securityOpen) {
      setState(() {
        _securityOpen = false;
      });
      _securityController.reverse();
      return false;
    } else if (_customUrlOpen) {
      setState(() {
        _customUrlOpen = false;
      });
      _customUrlController.reverse();
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
                position: _offsetFloat,
                child: ContactsList(_controller, _contactsOpen)),
            SlideTransition(
                position: _securityOffsetFloat,
                child: buildSecurityMenu(context)),
            SlideTransition(
                position: _customUrlOffsetFloat,
                child: CustomUrl(_customUrlController, _customUrlOpen)),
          ],
        ),
      ),
    );
  }

  Widget buildMainSettings(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: StateContainer.of(context).curTheme.backgroundDark,
      ),
      child: SafeArea(
        minimum: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 30,
        ),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsetsDirectional.only(
                  start: 26.0, end: 20, bottom: 15),
              child: Text(
                'Settings',
                style: AppStyles.textStyleSettingItemHeader(context),
              ),
            ),
            // Settings items
            Expanded(
                child: Stack(
              children: <Widget>[
                ListView(
                  padding: const EdgeInsets.only(top: 15.0),
                  children: <Widget>[
                    /*Container(
                      margin:
                          EdgeInsetsDirectional.only(start: 30.0, bottom: 10.0),
                      child: Text(AppLocalization.of(context).informations,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w100,
                              color:
                                  StateContainer.of(context).curTheme.text60)),
                    ),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),*/
                    Container(
                      margin: const EdgeInsetsDirectional.only(
                          start: 30.0, top: 20.0, bottom: 10.0),
                      child: Text(AppLocalization.of(context).manage,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w100,
                              color:
                                  StateContainer.of(context).curTheme.text60)),
                    ),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemSingleLineWithInfos(
                        context,
                        AppLocalization.of(context).addressBookHeader,
                        AppLocalization.of(context).addressBookDesc,
                        Typicons.contacts, onPressed: () {
                      setState(() {
                        _contactsOpen = true;
                      });
                      _controller.forward();
                    }),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context).backupSecretPhrase,
                        AppIcons.backupseed, onPressed: () async {
                      // Authenticate
                      final AuthenticationMethod authMethod =
                          await sl.get<SharedPrefsUtil>().getAuthMethod();
                      final bool hasBiometrics =
                          await sl.get<BiometricUtil>().hasBiometrics();
                      if (authMethod.method == AuthMethod.BIOMETRICS &&
                          hasBiometrics) {
                        try {
                          final bool authenticated = await sl
                              .get<BiometricUtil>()
                              .authenticateWithBiometrics(
                                  context,
                                  AppLocalization.of(context)
                                      .fingerprintSeedBackup);
                          if (authenticated) {
                            sl.get<HapticUtil>().fingerprintSucess();
                            StateContainer.of(context)
                                .getSeed()
                                .then((String seed) {});
                          }
                        } catch (e) {
                          await authenticateWithPin();
                        }
                      } else {
                        await authenticateWithPin();
                      }
                    }),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemSingleLineWithInfos(
                        context,
                        AppLocalization.of(context).customUrlHeader,
                        AppLocalization.of(context).customUrlDesc,
                        FontAwesome.code, onPressed: () {
                      setState(() {
                        _customUrlOpen = true;
                      });
                      _customUrlController.forward();
                    }),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    Container(
                      margin: const EdgeInsetsDirectional.only(
                          start: 30.0, top: 20.0, bottom: 10.0),
                      child: Text(AppLocalization.of(context).preferences,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w100,
                              color:
                                  StateContainer.of(context).curTheme.text60)),
                    ),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemWithDefaultValueWithInfos(
                        context,
                        AppLocalization.of(context).changeCurrency,
                        'Select the fiat currency you would like to display alongside UCO',
                        StateContainer.of(context).curCurrency,
                        FontAwesome.money,
                        _currencyDialog),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemWithDefaultValue(
                        context,
                        AppLocalization.of(context).language,
                        StateContainer.of(context).curLanguage,
                        FontAwesome.language,
                        _languageDialog),
                    /*Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context).securityHeader,
                        AppIcons.security, onPressed: () {
                      setState(() {
                        _securityOpen = true;
                      });
                      _securityController.forward();
                    }),*/
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context).logout,
                        FontAwesome.logout, onPressed: () {
                      AppDialogs.showConfirmDialog(
                          context,
                          CaseChange.toUpperCase(
                              AppLocalization.of(context).warning, context),
                          AppLocalization.of(context).logoutDetail,
                          AppLocalization.of(context)
                              .logoutAction
                              .toUpperCase(), () {
                        // Show another confirm dialog
                        AppDialogs.showConfirmDialog(
                            context,
                            AppLocalization.of(context).logoutAreYouSure,
                            AppLocalization.of(context).logoutReassurance,
                            CaseChange.toUpperCase(
                                AppLocalization.of(context).yes, context), () {
                          // Delete all data
                          sl.get<Vault>().deleteAll().then((_) {
                            sl
                                .get<SharedPrefsUtil>()
                                .deleteAll()
                                .then((_) {
                              StateContainer.of(context).logOut();
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/', (Route<dynamic> route) => false);
                            });
                          });
                        });
                      });
                    }),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(versionString,
                              style: AppStyles.textStyleVersion(context)),
                        ],
                      ),
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
                          StateContainer.of(context).curTheme.backgroundDark,
                          StateContainer.of(context).curTheme.backgroundDark00
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
                          StateContainer.of(context).curTheme.backgroundDark00,
                          StateContainer.of(context).curTheme.backgroundDark
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
        color: StateContainer.of(context).curTheme.backgroundDark,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: StateContainer.of(context).curTheme.overlay30,
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
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                _securityOpen = false;
                              });
                              _securityController.reverse();
                            },
                            child: Icon(AppIcons.back,
                                color: StateContainer.of(context).curTheme.text,
                                size: 24)),
                      ),
                      //Security Header Text
                      Text(
                        AppLocalization.of(context).securityHeader,
                        style: AppStyles.textStyleSettingsHeader(context),
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
                      margin: const EdgeInsetsDirectional.only(
                          start: 30.0, bottom: 10),
                      child: Text(AppLocalization.of(context).preferences,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w100,
                              color:
                                  StateContainer.of(context).curTheme.text60)),
                    ),
                    // Authentication Method
                    if (_hasBiometrics)
                      Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.text15,
                      )
                    else
                      null,
                    if (_hasBiometrics)
                      AppSettings.buildSettingsListItemWithDefaultValue(
                          context,
                          AppLocalization.of(context).authMethod,
                          _curAuthMethod,
                          AppIcons.fingerprint,
                          _authMethodDialog)
                    else
                      null,
                    // Authenticate on Launch
                    if (StateContainer.of(context).encryptedSecret == null)
                      Column(children: <Widget>[
                        Divider(
                            height: 2,
                            color: StateContainer.of(context).curTheme.text15),
                        AppSettings.buildSettingsListItemWithDefaultValue(
                            context,
                            AppLocalization.of(context).lockAppSetting,
                            _curUnlockSetting,
                            AppIcons.lock,
                            _lockDialog),
                      ])
                    else
                      const SizedBox(),
                    // Authentication Timer
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.text15,
                    ),
                    AppSettings.buildSettingsListItemWithDefaultValue(
                      context,
                      AppLocalization.of(context).autoLockHeader,
                      _curTimeoutSetting,
                      AppIcons.timer,
                      _lockTimeoutDialog,
                      disabled: _curUnlockSetting.setting == UnlockOption.NO &&
                          StateContainer.of(context).encryptedSecret == null,
                    ),
                    // Encrypt option
                    if (StateContainer.of(context).encryptedSecret == null)
                      Column(children: <Widget>[
                        Divider(
                            height: 2,
                            color: StateContainer.of(context).curTheme.text15),
                        AppSettings.buildSettingsListItemSingleLine(
                            context,
                            AppLocalization.of(context).setWalletPassword,
                            AppIcons.walletpassword, onPressed: () {
                          Sheets.showAppHeightNineSheet(
                              context: context, widget: SetPasswordSheet());
                        })
                      ])
                    else
                      Column(children: <Widget>[
                        Divider(
                            height: 2,
                            color: StateContainer.of(context).curTheme.text15),
                        AppSettings.buildSettingsListItemSingleLine(
                            context,
                            AppLocalization.of(context).disableWalletPassword,
                            AppIcons.walletpassworddisabled, onPressed: () {
                          Sheets.showAppHeightNineSheet(
                              context: context, widget: DisablePasswordSheet());
                        }),
                      ]),
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
                          StateContainer.of(context).curTheme.backgroundDark,
                          StateContainer.of(context).curTheme.backgroundDark00
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

  Future<void> authenticateWithPin() async {
    // PIN Authentication
    final String expectedPin = await sl.get<Vault>().getPin();
    final bool auth = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return PinScreen(
        PinOverlayType.ENTER_PIN,
        expectedPin: expectedPin,
        description: AppLocalization.of(context).pinSeedBackup,
      );
    }));
    if (auth != null && auth) {
      await Future.delayed(const Duration(milliseconds: 200));
      Navigator.of(context).pop();
    }
  }
}
