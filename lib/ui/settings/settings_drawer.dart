// Dart imports:
// ignore_for_file: always_specify_types

import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

// Project imports:
import 'package:archethic_wallet/appstate_container.dart';
import 'package:archethic_wallet/localization.dart';
import 'package:archethic_wallet/model/authentication_method.dart';
import 'package:archethic_wallet/model/available_currency.dart';
import 'package:archethic_wallet/model/available_language.dart';
import 'package:archethic_wallet/model/available_themes.dart';
import 'package:archethic_wallet/model/data/appdb.dart';
import 'package:archethic_wallet/model/device_lock_timeout.dart';
import 'package:archethic_wallet/model/device_unlock_option.dart';
import 'package:archethic_wallet/model/vault.dart';
import 'package:archethic_wallet/service_locator.dart';
import 'package:archethic_wallet/styles.dart';
import 'package:archethic_wallet/ui/nft/add_nft.dart';
import 'package:archethic_wallet/ui/settings/backupseed_sheet.dart';
import 'package:archethic_wallet/ui/settings/contacts_widget.dart';
import 'package:archethic_wallet/ui/settings/custom_url_widget.dart';
import 'package:archethic_wallet/ui/settings/nodes_widget.dart';
import 'package:archethic_wallet/ui/settings/settings_list_item.dart';
import 'package:archethic_wallet/ui/settings/wallet_faq_widget.dart';
import 'package:archethic_wallet/ui/settings/yubikey_params_widget.dart';
import 'package:archethic_wallet/ui/util/ui_util.dart';
import 'package:archethic_wallet/ui/widgets/app_simpledialog.dart';
import 'package:archethic_wallet/ui/widgets/dialog.dart';
import 'package:archethic_wallet/ui/widgets/pin_screen.dart';
import 'package:archethic_wallet/ui/widgets/sheet_util.dart';
import 'package:archethic_wallet/ui/widgets/yubikey_screen.dart';
import 'package:archethic_wallet/util/biometrics.dart';
import 'package:archethic_wallet/util/caseconverter.dart';
import 'package:archethic_wallet/util/hapticutil.dart';
import 'package:archethic_wallet/util/sharedprefsutil.dart';
import '../../appstate_container.dart';
import '../../util/sharedprefsutil.dart';

class SettingsSheet extends StatefulWidget {
  @override
  _SettingsSheetState createState() => _SettingsSheetState();
}

class _SettingsSheetState extends State<SettingsSheet>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  AnimationController? _contactsController;
  Animation<Offset>? _contactsOffsetFloat;
  AnimationController? _securityController;
  Animation<Offset>? _securityOffsetFloat;
  AnimationController? _nodesController;
  Animation<Offset>? _nodesOffsetFloat;
  AnimationController? _nftController;
  Animation<Offset>? _nftOffsetFloat;
  AnimationController? _customUrlController;
  Animation<Offset>? _customUrlOffsetFloat;
  AnimationController? _walletFAQController;
  Animation<Offset>? _walletFAQOffsetFloat;
  AnimationController? _aboutController;
  Animation<Offset>? _aboutOffsetFloat;
  AnimationController? _yubikeyParamsController;
  Animation<Offset>? _yubikeyParamsOffsetFloat;

  String versionString = '';

  bool _hasBiometrics = false;
  AuthenticationMethod _curAuthMethod =
      AuthenticationMethod(AuthMethod.BIOMETRICS);
  UnlockSetting _curUnlockSetting = UnlockSetting(UnlockOption.NO);
  LockTimeoutSetting _curTimeoutSetting =
      LockTimeoutSetting(LockTimeoutOption.ONE);
  ThemeSetting _curThemeSetting = ThemeSetting(ThemeOptions.LIGHT);

  bool? _securityOpen;
  bool? _aboutOpen;
  bool? _contactsOpen;
  bool? _nodesOpen;
  bool? _customUrlOpen;
  bool? _walletFAQOpen;
  bool? _nftOpen;
  bool? _yubikeyParamsOpen;

  bool _pinPadShuffleActive = false;

  bool notNull(Object o) => o != null;

  @override
  void initState() {
    super.initState();
    _contactsOpen = false;
    _nodesOpen = false;
    _securityOpen = false;
    _aboutOpen = false;
    _customUrlOpen = false;
    _walletFAQOpen = false;
    _nftOpen = false;
    _yubikeyParamsOpen = false;

    // Determine if they have face or fingerprint enrolled, if not hide the setting
    sl.get<BiometricUtil>().hasBiometrics().then((bool hasBiometrics) {
      setState(() {
        _hasBiometrics = hasBiometrics;
      });
    });
    sl.get<SharedPrefsUtil>().getPinPadShuffle().then((bool pinPadShuffle) {
      setState(() {
        _pinPadShuffleActive = pinPadShuffle;
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
    // Get default theme settings
    sl.get<SharedPrefsUtil>().getTheme().then((ThemeSetting theme) {
      setState(() {
        _curThemeSetting = theme;
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
    _contactsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _securityController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _aboutController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _nodesController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _customUrlController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _walletFAQController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _nftController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _yubikeyParamsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _contactsOffsetFloat =
        Tween<Offset>(begin: const Offset(1.1, 0), end: const Offset(0, 0))
            .animate(_contactsController!);
    _securityOffsetFloat =
        Tween<Offset>(begin: const Offset(1.1, 0), end: const Offset(0, 0))
            .animate(_securityController!);
    _aboutOffsetFloat =
        Tween<Offset>(begin: const Offset(1.1, 0), end: const Offset(0, 0))
            .animate(_aboutController!);
    _nodesOffsetFloat =
        Tween<Offset>(begin: const Offset(1.1, 0), end: const Offset(0, 0))
            .animate(_nodesController!);
    _customUrlOffsetFloat =
        Tween<Offset>(begin: const Offset(1.1, 0), end: const Offset(0, 0))
            .animate(_customUrlController!);
    _walletFAQOffsetFloat =
        Tween<Offset>(begin: const Offset(1.1, 0), end: const Offset(0, 0))
            .animate(_walletFAQController!);
    _nftOffsetFloat =
        Tween<Offset>(begin: const Offset(1.1, 0), end: const Offset(0, 0))
            .animate(_nftController!);
    _yubikeyParamsOffsetFloat =
        Tween<Offset>(begin: const Offset(1.1, 0), end: const Offset(0, 0))
            .animate(_yubikeyParamsController!);
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        versionString =
            AppLocalization.of(context)!.version + ' ${packageInfo.version}';
      });
    });
  }

  @override
  void dispose() {
    _contactsController!.dispose();
    _securityController!.dispose();
    _aboutController!.dispose();
    _customUrlController!.dispose();
    _nodesController!.dispose();
    _walletFAQController!.dispose();
    _nftController!.dispose();
    _yubikeyParamsController!.dispose();
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
              AppLocalization.of(context)!.authMethod,
              style: AppStyles.textStyleSize20W700Primary(context),
            ),
            children: <Widget>[
              if (_hasBiometrics)
                AppSimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, AuthMethod.BIOMETRICS);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      AppLocalization.of(context)!.biometricsMethod,
                      style: AppStyles.textStyleSize16W600Primary(context),
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
                    AppLocalization.of(context)!.pinMethod,
                    style: AppStyles.textStyleSize16W600Primary(context),
                  ),
                ),
              ),
              AppSimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, AuthMethod.YUBIKEY_WITH_YUBICLOUD);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    AppLocalization.of(context)!.yubikeyWithYubiCloudMethod,
                    style: AppStyles.textStyleSize16W600Primary(context),
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
      case AuthMethod.YUBIKEY_WITH_YUBICLOUD:
        sl
            .get<SharedPrefsUtil>()
            .setAuthMethod(
                AuthenticationMethod(AuthMethod.YUBIKEY_WITH_YUBICLOUD))
            .then((_) {
          setState(() {
            _curAuthMethod =
                AuthenticationMethod(AuthMethod.YUBIKEY_WITH_YUBICLOUD);
          });
        });
        break;
      default:
        sl
            .get<SharedPrefsUtil>()
            .setAuthMethod(AuthenticationMethod(AuthMethod.PIN))
            .then((_) {
          setState(() {
            _curAuthMethod = AuthenticationMethod(AuthMethod.PIN);
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
              AppLocalization.of(context)!.lockAppSetting,
              style: AppStyles.textStyleSize20W700Primary(context),
            ),
            children: <Widget>[
              AppSimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, UnlockOption.NO);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    AppLocalization.of(context)!.no,
                    style: AppStyles.textStyleSize16W600Primary(context),
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
                    AppLocalization.of(context)!.yes,
                    style: AppStyles.textStyleSize16W600Primary(context),
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
      default:
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
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(
                  'assets/icons/currency/${AvailableCurrency(value).getIso4217Code().toLowerCase()}.png',
                  width: 30,
                  height: 20,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(AvailableCurrency(value).getDisplayName(context),
                  style: StateContainer.of(context)
                              .curCurrency
                              .getDisplayName(context) ==
                          AvailableCurrency(value).getDisplayName(context)
                      ? AppStyles.textStyleSize16W600ChoiceOption(context)
                      : AppStyles.textStyleSize16W600Primary(context)),
              const SizedBox(width: 20),
              if (StateContainer.of(context)
                      .curCurrency
                      .getDisplayName(context) ==
                  AvailableCurrency(value).getDisplayName(context))
                FaIcon(
                  FontAwesomeIcons.check,
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
    final AvailableCurrencyEnum? selection =
        await showAppDialog<AvailableCurrencyEnum>(
            context: context,
            builder: (BuildContext context) {
              return AppSimpleDialog(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    AppLocalization.of(context)!.currency,
                    style: AppStyles.textStyleSize20W700Primary(context),
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
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: LanguageSetting(value).getLocaleString().toLowerCase() ==
                        'default'
                    ? const SizedBox(
                        width: 30,
                        height: 20,
                      )
                    : Image.asset(
                        'assets/icons/country/${LanguageSetting(value).getLocaleString().toLowerCase()}.png',
                        width: 30,
                        height: 20,
                      ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(LanguageSetting(value).getDisplayName(context),
                  style: StateContainer.of(context)
                              .curLanguage
                              .getDisplayName(context) ==
                          LanguageSetting(value).getDisplayName(context)
                      ? AppStyles.textStyleSize16W600ChoiceOption(context)
                      : AppStyles.textStyleSize16W600Primary(context)),
              const SizedBox(width: 20),
              if (StateContainer.of(context)
                      .curLanguage
                      .getDisplayName(context) ==
                  LanguageSetting(value).getDisplayName(context))
                FaIcon(
                  FontAwesomeIcons.check,
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
    final AvailableLanguage? selection = await showAppDialog<AvailableLanguage>(
        context: context,
        builder: (BuildContext context) {
          return AppSimpleDialog(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                AppLocalization.of(context)!.language,
                style: AppStyles.textStyleSize20W700Primary(context),
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
                      ? AppStyles.textStyleSize16W600ChoiceOption(context)
                      : AppStyles.textStyleSize16W600Primary(context)),
              const SizedBox(width: 20),
              if (_curUnlockSetting.getDisplayName(context) ==
                  LockTimeoutSetting(value).getDisplayName(context))
                FaIcon(
                  FontAwesomeIcons.check,
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
                AppLocalization.of(context)!.autoLockHeader,
                style: AppStyles.textStyleSize20W700Primary(context),
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

  List<Widget> _buildThemeOptions() {
    List<Widget> ret = List<Widget>.empty(growable: true);
    ThemeOptions.values.forEach((ThemeOptions value) {
      ret.add(SimpleDialogOption(
        onPressed: () {
          Navigator.pop(context, value);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: <Widget>[
              Text(ThemeSetting(value).getDisplayName(context),
                  style: StateContainer.of(context).curTheme.displayName ==
                          ThemeSetting(value).getDisplayName(context)
                      ? AppStyles.textStyleSize16W600ChoiceOption(context)
                      : AppStyles.textStyleSize16W600Primary(context)),
              const SizedBox(width: 20),
              if (StateContainer.of(context).curTheme.displayName ==
                  ThemeSetting(value).getDisplayName(context))
                FaIcon(
                  FontAwesomeIcons.check,
                  color: StateContainer.of(context).curTheme.choiceOption,
                  size: 16,
                )
              else
                const SizedBox(),
            ],
          ),
        ),
      ));
    });
    return ret;
  }

  Future<void> _themeDialog() async {
    ThemeOptions selection = await showAppDialog<ThemeOptions>(
        context: context,
        builder: (BuildContext context) {
          return AppSimpleDialog(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                AppLocalization.of(context)!.themeHeader,
                style: AppStyles.textStyleSize20W700Primary(context),
              ),
            ),
            children: _buildThemeOptions(),
          );
        });
    if (_curThemeSetting != ThemeSetting(selection)) {
      sl.get<SharedPrefsUtil>().setTheme(ThemeSetting(selection)).then((_) {
        setState(() {
          StateContainer.of(context).updateTheme(ThemeSetting(selection));
          _curThemeSetting = ThemeSetting(selection);
        });
      });
    }
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
    } else if (_aboutOpen!) {
      setState(() {
        _aboutOpen = false;
      });
      _aboutController!.reverse();
      return false;
    } else if (_customUrlOpen!) {
      setState(() {
        _customUrlOpen = false;
      });
      _customUrlController!.reverse();
      return false;
    } else if (_nodesOpen!) {
      setState(() {
        _nodesOpen = false;
      });
      _nodesController!.reverse();
      return false;
    } else if (_walletFAQOpen!) {
      setState(() {
        _walletFAQOpen = false;
      });
      _walletFAQController!.reverse();
      return false;
    } else if (_nftOpen!) {
      setState(() {
        _nftOpen = false;
      });
      _nftController!.reverse();
      return false;
    } else if (_yubikeyParamsOpen!) {
      setState(() {
        _yubikeyParamsOpen = false;
      });
      _yubikeyParamsController!.reverse();
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
                child: ContactsList(_contactsController!, _contactsOpen!)),
            SlideTransition(
                position: _securityOffsetFloat!,
                child: buildSecurityMenu(context)),
            SlideTransition(
                position: _aboutOffsetFloat!, child: buildAboutMenu(context)),
            SlideTransition(
                position: _nodesOffsetFloat!,
                child: NodesList(_nodesController!, _nodesOpen!)),
            SlideTransition(
                position: _customUrlOffsetFloat!,
                child: CustomUrl(_customUrlController!, _customUrlOpen!)),
            SlideTransition(
                position: _walletFAQOffsetFloat!,
                child: WalletFAQ(_walletFAQController!, _walletFAQOpen!)),
            SlideTransition(
                position: _nftOffsetFloat!, child: buildNFTMenu(context)),
            SlideTransition(
                position: _yubikeyParamsOffsetFloat!,
                child: YubikeyParams(
                    _yubikeyParamsController!, _yubikeyParamsOpen!)),
          ],
        ),
      ),
    );
  }

  Widget buildMainSettings(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: StateContainer.of(context).curTheme.backgroundDark,
          border: Border(
            right: BorderSide(
                color: StateContainer.of(context).curTheme.primary30!,
                width: 1),
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
                      margin: const EdgeInsetsDirectional.only(
                          start: 30.0, top: 10.0, bottom: 10.0),
                      child: Text(AppLocalization.of(context)!.manage,
                          style: AppStyles.textStyleSize20W700Primary(context)),
                    ),
                    if (StateContainer.of(context).wallet != null &&
                        StateContainer.of(context).wallet!.accountBalance.uco !=
                            null &&
                        StateContainer.of(context).wallet!.accountBalance.uco! >
                            0)
                      Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.primary15,
                      )
                    else
                      const SizedBox(),
                    if (StateContainer.of(context).wallet != null &&
                        StateContainer.of(context).wallet!.accountBalance.uco !=
                            null &&
                        StateContainer.of(context).wallet!.accountBalance.uco! >
                            0)
                      AppSettings.buildSettingsListItemSingleLineWithInfos(
                          context,
                          AppLocalization.of(context)!.nftHeader,
                          AppLocalization.of(context)!.nftHeaderDesc,
                          icon: 'assets/icons/nft.png', onPressed: () {
                        setState(() {
                          _nftOpen = true;
                        });
                        _nftController!.forward();
                      })
                    else
                      const SizedBox(),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.primary15,
                    ),
                    AppSettings.buildSettingsListItemSingleLineWithInfos(
                        context,
                        AppLocalization.of(context)!.addressBookHeader,
                        AppLocalization.of(context)!.addressBookDesc,
                        icon: 'assets/icons/address-book.png', onPressed: () {
                      setState(() {
                        _contactsOpen = true;
                      });
                      _contactsController!.forward();
                    }),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.primary15,
                    ),
                    Container(
                      margin: const EdgeInsetsDirectional.only(
                          start: 30.0, top: 20.0, bottom: 10.0),
                      child: Text(AppLocalization.of(context)!.informations,
                          style: AppStyles.textStyleSize20W700Primary(context)),
                    ),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.primary15,
                    ),
                    AppSettings.buildSettingsListItemSingleLineWithInfos(
                        context,
                        AppLocalization.of(context)!.nodesHeader,
                        AppLocalization.of(context)!.nodesHeaderDesc,
                        icon: 'assets/icons/nodes.png', onPressed: () {
                      setState(() {
                        _nodesOpen = true;
                      });
                      _nodesController!.forward();
                    }),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.primary15,
                    ),
                    AppSettings.buildSettingsListItemSingleLineWithInfos(
                        context,
                        AppLocalization.of(context)!.walletFAQHeader,
                        AppLocalization.of(context)!.walletFAQDesc,
                        icon: 'assets/icons/faq.png', onPressed: () {
                      setState(() {
                        _walletFAQOpen = true;
                      });
                      _walletFAQController!.forward();
                    }),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.primary15,
                    ),
                    AppSettings.buildSettingsListItemSingleLineWithInfos(
                        context,
                        AppLocalization.of(context)!.labLinkHeader,
                        AppLocalization.of(context)!.labLinkDesc,
                        icon: 'assets/icons/microscope.png',
                        onPressed: () async {
                      UIUtil.showWebview(
                          context,
                          'https://www.archethic.net/lab.html',
                          AppLocalization.of(context)!.labLinkHeader);
                    }),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.primary15,
                    ),
                    AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context)!.aboutHeader,
                        'assets/icons/help.png', onPressed: () {
                      setState(() {
                        _aboutOpen = true;
                      });
                      _aboutController!.forward();
                    }),
                    Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.primary15),
                    Container(
                      margin: const EdgeInsetsDirectional.only(
                          start: 30.0, top: 20.0, bottom: 10.0),
                      child: Text(AppLocalization.of(context)!.preferences,
                          style: AppStyles.textStyleSize20W700Primary(context)),
                    ),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.primary15,
                    ),
                    AppSettings.buildSettingsListItemWithDefaultValueWithInfos(
                        context,
                        AppLocalization.of(context)!.changeCurrencyHeader,
                        AppLocalization.of(context)!.changeCurrencyDesc,
                        StateContainer.of(context).curCurrency,
                        'assets/icons/money-currency.png',
                        _currencyDialog),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.primary15,
                    ),
                    AppSettings.buildSettingsListItemWithDefaultValue(
                        context,
                        AppLocalization.of(context)!.language,
                        StateContainer.of(context).curLanguage,
                        'assets/icons/languages.png',
                        _languageDialog),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.primary15,
                    ),
                    AppSettings.buildSettingsListItemWithDefaultValue(
                        context,
                        AppLocalization.of(context)!.themeHeader,
                        _curThemeSetting,
                        'assets/icons/themes.png',
                        _themeDialog),
                    /*Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.primary15,
                    ),
                    AppSettings.buildSettingsListItemSingleLineWithInfos(
                        context,
                        AppLocalization.of(context)!.customUrlHeader,
                        AppLocalization.of(context)!.customUrlDesc,
                        icon: 'assets/icons/url.png', onPressed: () {
                      setState(() {
                        _customUrlOpen = true;
                      });
                      _customUrlController!.forward();
                    }),*/
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.primary15,
                    ),
                    AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context)!.securityHeader,
                        'assets/icons/encrypted.png', onPressed: () {
                      setState(() {
                        _securityOpen = true;
                      });
                      _securityController!.forward();
                    }),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.primary15,
                    ),
                    AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context)!.logout,
                        'assets/icons/logout.png', onPressed: () {
                      AppDialogs.showConfirmDialog(
                          context,
                          CaseChange.toUpperCase(
                              AppLocalization.of(context)!.warning, context),
                          AppLocalization.of(context)!.logoutDetail,
                          AppLocalization.of(context)!
                              .logoutAction
                              .toUpperCase(), () {
                        // Show another confirm dialog
                        AppDialogs.showConfirmDialog(
                            context,
                            AppLocalization.of(context)!.logoutAreYouSure,
                            AppLocalization.of(context)!.logoutReassurance,
                            CaseChange.toUpperCase(
                                AppLocalization.of(context)!.yes, context), () {
                          // Delete all data
                          sl.get<DBHelper>().dropAll();
                          sl.get<Vault>().deleteAll().then((_) {
                            sl.get<SharedPrefsUtil>().deleteAll().then((_) {
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
                      color: StateContainer.of(context).curTheme.primary15,
                    ),
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
                          StateContainer.of(context).curTheme.backgroundDark!,
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
                          StateContainer.of(context).curTheme.backgroundDark!
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
        border: Border(
          right: BorderSide(
              color: StateContainer.of(context).curTheme.primary30!, width: 1),
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
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                _securityOpen = false;
                              });
                              _securityController!.reverse();
                            },
                            child: FaIcon(FontAwesomeIcons.chevronLeft,
                                color:
                                    StateContainer.of(context).curTheme.primary,
                                size: 24)),
                      ),
                      //Security Header Text
                      Text(
                        AppLocalization.of(context)!.securityHeader,
                        style: AppStyles.textStyleSize28W700Primary(context),
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
                      child: Text(AppLocalization.of(context)!.preferences,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w100,
                              color: StateContainer.of(context)
                                  .curTheme
                                  .primary60)),
                    ),
                    // Authentication Method
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.primary15,
                    ),
                    AppSettings.buildSettingsListItemWithDefaultValue(
                        context,
                        AppLocalization.of(context)!.authMethod,
                        _curAuthMethod,
                        'assets/icons/authentLaunch.png',
                        _authMethodDialog),
                    // Authenticate on Launch
                    if (StateContainer.of(context).encryptedSecret == null)
                      Column(children: <Widget>[
                        Divider(
                            height: 2,
                            color:
                                StateContainer.of(context).curTheme.primary15),
                        AppSettings.buildSettingsListItemWithDefaultValue(
                            context,
                            AppLocalization.of(context)!.lockAppSetting,
                            _curUnlockSetting,
                            'assets/icons/authentLaunch.png',
                            _lockDialog),
                      ])
                    else
                      const SizedBox(),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.primary15,
                    ),
                    // Authentication Timer
                    AppSettings.buildSettingsListItemWithDefaultValue(
                      context,
                      AppLocalization.of(context)!.autoLockHeader,
                      _curTimeoutSetting,
                      'assets/icons/autoLock.png',
                      _lockTimeoutDialog,
                      disabled: _curUnlockSetting.setting == UnlockOption.NO &&
                          StateContainer.of(context).encryptedSecret == null,
                    ),
                    Column(children: <Widget>[
                      Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.primary15,
                      ),
                      AppSettings.buildSettingsListItemSingleLine(
                          context,
                          AppLocalization.of(context)!.backupSecretPhrase,
                          'assets/icons/key-word.png', onPressed: () async {
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
                                    AppLocalization.of(context)!
                                        .fingerprintSeedBackup);
                            if (authenticated) {
                              sl
                                  .get<HapticUtil>()
                                  .feedback(FeedbackType.success);
                              StateContainer.of(context)
                                  .getSeed()
                                  .then((String seed) {
                                Sheets.showAppHeightNineSheet(
                                    context: context,
                                    widget: AppSeedBackupSheet(seed));
                              });
                            }
                          } catch (e) {
                            await authenticateWithPin();
                          }
                        } else {
                          if (authMethod.method ==
                              AuthMethod.YUBIKEY_WITH_YUBICLOUD) {
                            return authenticateWithYubikey();
                          } else {
                            await authenticateWithPin();
                          }
                        }
                      }),
                    ]),
                    Divider(
                      height: 2,
                      color: StateContainer.of(context).curTheme.primary15,
                    ),
                    AppSettings.buildSettingsListItemSwitch(
                        context,
                        AppLocalization.of(context)!.pinPadShuffle,
                        'assets/icons/shuffle.png',
                        _pinPadShuffleActive, onChanged: (bool _isSwitched) {
                      setState(() {
                        _pinPadShuffleActive = _isSwitched;
                        _isSwitched
                            ? sl.get<SharedPrefsUtil>().setPinPadShuffle(true)
                            : sl.get<SharedPrefsUtil>().setPinPadShuffle(false);
                      });
                    }),
                    Column(children: <Widget>[
                      Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.primary15,
                      ),
                      AppSettings.buildSettingsListItemSingleLineWithInfos(
                          context,
                          AppLocalization.of(context)!.yubikeyParamsHeader,
                          AppLocalization.of(context)!.yubikeyParamsDesc,
                          icon: 'assets/icons/digital-key.png', onPressed: () {
                        setState(() {
                          _yubikeyParamsOpen = true;
                        });
                        _yubikeyParamsController!.forward();
                      }),
                    ]),
                    Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.primary15),
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
                          StateContainer.of(context).curTheme.backgroundDark!,
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
              color: StateContainer.of(context).curTheme.primary30!, width: 1),
        ),
        color: StateContainer.of(context).curTheme.backgroundDark,
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
                      Container(
                        height: 40,
                        width: 40,
                        margin: const EdgeInsets.only(right: 10, left: 10),
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                _aboutOpen = false;
                              });
                              _aboutController!.reverse();
                            },
                            child: FaIcon(FontAwesomeIcons.chevronLeft,
                                color:
                                    StateContainer.of(context).curTheme.primary,
                                size: 24)),
                      ),
                      Text(
                        AppLocalization.of(context)!.aboutHeader,
                        style: AppStyles.textStyleSize28W700Primary(context),
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
                        color: StateContainer.of(context).curTheme.primary15),
                    AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context)!
                            .aboutGeneralTermsAndConditions,
                        'assets/icons/terms-and-conditions.png',
                        onPressed: () async {
                      UIUtil.showWebview(
                          context,
                          'https://archethic.net',
                          AppLocalization.of(context)!
                              .aboutGeneralTermsAndConditions);
                    }),
                    Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.primary15),
                    AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context)!.aboutWalletServiceTerms,
                        'assets/icons/walletServiceTerms.png',
                        onPressed: () async {
                      UIUtil.showWebview(context, 'https://archethic.net',
                          AppLocalization.of(context)!.aboutWalletServiceTerms);
                    }),
                    Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.primary15),
                    AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context)!.aboutPrivacyPolicy,
                        'assets/icons/privacyPolicy.png', onPressed: () async {
                      UIUtil.showWebview(context, 'https://archethic.net',
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
                          StateContainer.of(context).curTheme.backgroundDark!,
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

  Widget buildNFTMenu(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
              color: StateContainer.of(context).curTheme.primary30!, width: 1),
        ),
        color: StateContainer.of(context).curTheme.backgroundDark,
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
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                _nftOpen = false;
                              });
                              _nftController!.reverse();
                            },
                            child: FaIcon(FontAwesomeIcons.chevronLeft,
                                color:
                                    StateContainer.of(context).curTheme.primary,
                                size: 24)),
                      ),
                      Text(
                        AppLocalization.of(context)!.nftHeader,
                        style: AppStyles.textStyleSize28W700Primary(context),
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
                    Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.primary15),
                    AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context)!.addNFTHeader,
                        'assets/icons/addNft.png', onPressed: () {
                      Sheets.showAppHeightNineSheet(
                          context: context, widget: const AddNFTSheet());
                    }),
                    Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.primary15),
                    AppSettings.buildSettingsListItemSingleLine(
                        context,
                        AppLocalization.of(context)!.transferNFT,
                        'assets/icons/transferNft.png', onPressed: () {
                      /*Sheets.showAppHeightNineSheet(
                          context: context,
                          widget: TransferNftSheet(
                            contactsRef: StateContainer.of(context).contactsRef,
                            title: AppLocalization.of(context).transferNFT,
                          ));*/
                    }),
                    Divider(
                        height: 2,
                        color: StateContainer.of(context).curTheme.primary15),
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
                          StateContainer.of(context).curTheme.backgroundDark!,
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

  Future<void> authenticateWithYubikey() async {
    // Yubikey Authentication
    final bool auth = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return const YubikeyScreen();
    })) as bool;
    if (auth) {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      StateContainer.of(context).getSeed().then((String seed) {
        Sheets.showAppHeightNineSheet(
            context: context, widget: AppSeedBackupSheet(seed));
      });
    }
  }

  Future<void> authenticateWithPin() async {
    // PIN Authentication
    final String? expectedPin = await sl.get<Vault>().getPin();
    final bool auth = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return PinScreen(
        PinOverlayType.ENTER_PIN,
        expectedPin: expectedPin!,
        description: AppLocalization.of(context)!.pinSecretPhraseBackup,
      );
    })) as bool;
    if (auth) {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      StateContainer.of(context).getSeed().then((String seed) {
        Sheets.showAppHeightNineSheet(
            context: context, widget: AppSeedBackupSheet(seed));
      });
    }
  }
}
