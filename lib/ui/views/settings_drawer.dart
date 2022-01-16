// Dart imports:
// ignore_for_file: always_specify_types

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:archethic_wallet/ui/widgets/components/icon_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
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
import 'package:archethic_wallet/util/service_locator.dart';
import 'package:archethic_wallet/ui/util/styles.dart';
import 'package:archethic_wallet/ui/util/settings_list_item.dart';
import 'package:archethic_wallet/ui/util/ui_util.dart';
import 'package:archethic_wallet/ui/views/nft/add_nft.dart';
import 'package:archethic_wallet/ui/views/pin_screen.dart';
import 'package:archethic_wallet/ui/views/settings/backupseed_sheet.dart';
import 'package:archethic_wallet/ui/views/settings/contacts_widget.dart';
import 'package:archethic_wallet/ui/views/settings/custom_url_widget.dart';
import 'package:archethic_wallet/ui/views/settings/nodes_widget.dart';
import 'package:archethic_wallet/ui/views/settings/wallet_faq_widget.dart';
import 'package:archethic_wallet/ui/views/settings/yubikey_params_widget.dart';
import 'package:archethic_wallet/ui/views/yubikey_screen.dart';
import 'package:archethic_wallet/ui/widgets/components/dialog.dart';
import 'package:archethic_wallet/ui/widgets/components/sheet_util.dart';
import 'package:archethic_wallet/util/biometrics_util.dart';
import 'package:archethic_wallet/util/case_converter.dart';
import 'package:archethic_wallet/util/haptic_util.dart';
import 'package:archethic_wallet/util/preferences.dart';
import 'package:archethic_wallet/util/vault.dart';

class SettingsSheet extends StatefulWidget {
  const SettingsSheet({Key? key}) : super(key: key);

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
  AuthenticationMethod _curAuthMethod = AuthenticationMethod(AuthMethod.pin);
  UnlockSetting _curUnlockSetting = UnlockSetting(UnlockOption.no);
  LockTimeoutSetting _curTimeoutSetting =
      LockTimeoutSetting(LockTimeoutOption.one);
  ThemeSetting _curThemeSetting = ThemeSetting(ThemeOptions.dark);

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
    Preferences.getInstance().then((Preferences _preferences) {
      setState(() {
        _pinPadShuffleActive = _preferences.getPinPadShuffle();
        _curAuthMethod = _preferences.getAuthMethod();
        _curUnlockSetting = _preferences.getLock()
            ? UnlockSetting(UnlockOption.yes)
            : UnlockSetting(UnlockOption.no);
        _curThemeSetting = _preferences.getTheme();
        _curTimeoutSetting = _preferences.getLockTimeout();
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
    final Preferences _preferences = await Preferences.getInstance();
    switch (await showDialog<AuthMethod>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(
              AppLocalization.of(context)!.authMethod,
              style: AppStyles.textStyleSize20W700Primary(context),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                side: BorderSide(
                    color: StateContainer.of(context).curTheme.primary45!)),
            children: <Widget>[
              if (_hasBiometrics)
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, AuthMethod.biometrics);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Text(
                          AppLocalization.of(context)!.biometricsMethod,
                          style: _curAuthMethod.getIndex() ==
                                  AuthenticationMethod(AuthMethod.biometrics)
                                      .method
                                      .index
                              ? AppStyles.textStyleSize16W600ChoiceOption(
                                  context)
                              : AppStyles.textStyleSize16W600Primary(context),
                        ),
                        const SizedBox(width: 20),
                        if (_curAuthMethod.getIndex() ==
                            AuthenticationMethod(AuthMethod.biometrics)
                                .method
                                .index)
                          FaIcon(
                            FontAwesomeIcons.check,
                            color: StateContainer.of(context)
                                .curTheme
                                .choiceOption,
                            size: 16,
                          )
                      ],
                    ),
                  ),
                ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, AuthMethod.pin);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Text(
                        AppLocalization.of(context)!.pinMethod,
                        style: _curAuthMethod.getIndex() ==
                                AuthenticationMethod(AuthMethod.pin)
                                    .method
                                    .index
                            ? AppStyles.textStyleSize16W600ChoiceOption(context)
                            : AppStyles.textStyleSize16W600Primary(context),
                      ),
                      const SizedBox(width: 20),
                      if (_curAuthMethod.getIndex() ==
                          AuthenticationMethod(AuthMethod.pin).method.index)
                        FaIcon(
                          FontAwesomeIcons.check,
                          color:
                              StateContainer.of(context).curTheme.choiceOption,
                          size: 16,
                        )
                    ],
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, AuthMethod.yubikeyWithYubicloud);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Text(
                        AppLocalization.of(context)!.yubikeyWithYubiCloudMethod,
                        style: _curAuthMethod.getIndex() ==
                                AuthenticationMethod(
                                        AuthMethod.yubikeyWithYubicloud)
                                    .method
                                    .index
                            ? AppStyles.textStyleSize16W600ChoiceOption(context)
                            : AppStyles.textStyleSize16W600Primary(context),
                      ),
                      const SizedBox(width: 20),
                      if (_curAuthMethod.getIndex() ==
                          AuthenticationMethod(AuthMethod.yubikeyWithYubicloud)
                              .method
                              .index)
                        FaIcon(
                          FontAwesomeIcons.check,
                          color:
                              StateContainer.of(context).curTheme.choiceOption,
                          size: 16,
                        )
                    ],
                  ),
                ),
              ),
            ],
          );
        })) {
      case AuthMethod.pin:
        _preferences.setAuthMethod(AuthenticationMethod(AuthMethod.pin));
        setState(() {
          _curAuthMethod = AuthenticationMethod(AuthMethod.pin);
        });
        break;
      case AuthMethod.biometrics:
        _preferences.setAuthMethod(AuthenticationMethod(AuthMethod.biometrics));
        setState(() {
          _curAuthMethod = AuthenticationMethod(AuthMethod.biometrics);
        });

        break;
      case AuthMethod.yubikeyWithYubicloud:
        _preferences.setAuthMethod(
            AuthenticationMethod(AuthMethod.yubikeyWithYubicloud));
        setState(() {
          _curAuthMethod =
              AuthenticationMethod(AuthMethod.yubikeyWithYubicloud);
        });

        break;
      default:
        _preferences.setAuthMethod(AuthenticationMethod(AuthMethod.pin));
        setState(() {
          _curAuthMethod = AuthenticationMethod(AuthMethod.pin);
        });
        break;
    }
  }

  Future<void> _lockDialog() async {
    final Preferences _preferences = await Preferences.getInstance();
    switch (await showDialog<UnlockOption>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(
              AppLocalization.of(context)!.lockAppSetting,
              style: AppStyles.textStyleSize20W700Primary(context),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                side: BorderSide(
                    color: StateContainer.of(context).curTheme.primary45!)),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, UnlockOption.no);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Text(
                        AppLocalization.of(context)!.no,
                        style: _curUnlockSetting.setting.index ==
                                UnlockSetting(UnlockOption.no).getIndex()
                            ? AppStyles.textStyleSize16W600ChoiceOption(context)
                            : AppStyles.textStyleSize16W600Primary(context),
                      ),
                      const SizedBox(width: 20),
                      if (_curUnlockSetting.setting.index ==
                          UnlockSetting(UnlockOption.no).getIndex())
                        FaIcon(
                          FontAwesomeIcons.check,
                          color:
                              StateContainer.of(context).curTheme.choiceOption,
                          size: 16,
                        )
                    ],
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, UnlockOption.yes);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Text(
                        AppLocalization.of(context)!.yes,
                        style: _curUnlockSetting.setting.index ==
                                UnlockSetting(UnlockOption.yes).getIndex()
                            ? AppStyles.textStyleSize16W600ChoiceOption(context)
                            : AppStyles.textStyleSize16W600Primary(context),
                      ),
                      const SizedBox(width: 20),
                      if (_curUnlockSetting.setting.index ==
                          UnlockSetting(UnlockOption.yes).getIndex())
                        FaIcon(
                          FontAwesomeIcons.check,
                          color:
                              StateContainer.of(context).curTheme.choiceOption,
                          size: 16,
                        )
                    ],
                  ),
                ),
              ),
            ],
          );
        })) {
      case UnlockOption.yes:
        _preferences.setLock(true);
        setState(() {
          _curUnlockSetting = UnlockSetting(UnlockOption.yes);
        });
        break;
      case UnlockOption.no:
        _preferences.setLock(false);
        setState(() {
          _curUnlockSetting = UnlockSetting(UnlockOption.no);
        });
        break;
      default:
        _preferences.setLock(false);
        setState(() {
          _curUnlockSetting = UnlockSetting(UnlockOption.no);
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
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
              if (AvailableCurrency(value).getIso4217Code() == 'EUR' ||
                  AvailableCurrency(value).getIso4217Code() == 'USD')
                const SizedBox(
                  width: 10,
                ),
              if (AvailableCurrency(value).getIso4217Code() == 'EUR' ||
                  AvailableCurrency(value).getIso4217Code() == 'USD')
                buildIconWidget(
                  context,
                  'assets/icons/oracle.png',
                  25,
                  25,
                  color: StateContainer.of(context)
                              .curCurrency
                              .getDisplayName(context) ==
                          AvailableCurrency(value).getDisplayName(context)
                      ? StateContainer.of(context).curTheme.choiceOption
                      : StateContainer.of(context).curTheme.primary,
                ),
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
            ],
          ),
        ),
      ));
    }
    return ret;
  }

  Future<void> _currencyDialog() async {
    final Preferences _preferences = await Preferences.getInstance();
    final AvailableCurrencyEnum? selection =
        await showDialog<AvailableCurrencyEnum>(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    AppLocalization.of(context)!.currency,
                    style: AppStyles.textStyleSize20W700Primary(context),
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    side: BorderSide(
                        color: StateContainer.of(context).curTheme.primary45!)),
                children: _buildCurrencyOptions(),
              );
            });
    if (selection != null) {
      _preferences.setCurrency(AvailableCurrency(selection));
      if (StateContainer.of(context).curCurrency.currency != selection) {
        setState(() {
          StateContainer.of(context).curCurrency = AvailableCurrency(selection);
          StateContainer.of(context)
              .updateCurrency(AvailableCurrency(selection));
        });
      }
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
    final Preferences _preferences = await Preferences.getInstance();
    final AvailableLanguage? selection = await showDialog<AvailableLanguage>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                AppLocalization.of(context)!.language,
                style: AppStyles.textStyleSize20W700Primary(context),
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                side: BorderSide(
                    color: StateContainer.of(context).curTheme.primary45!)),
            children: _buildLanguageOptions(),
          );
        });
    if (selection != null) {
      _preferences.setLanguage(LanguageSetting(selection));
      if (StateContainer.of(context).curLanguage.language != selection) {
        setState(() {
          StateContainer.of(context).updateLanguage(LanguageSetting(selection));
        });
      }
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
    final Preferences _preferences = await Preferences.getInstance();
    final LockTimeoutOption? selection = await showDialog<LockTimeoutOption>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                AppLocalization.of(context)!.autoLockHeader,
                style: AppStyles.textStyleSize20W700Primary(context),
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                side: BorderSide(
                    color: StateContainer.of(context).curTheme.primary45!)),
            children: _buildLockTimeoutOptions(),
          );
        });

    if (_curTimeoutSetting.setting != selection) {
      _preferences.setLockTimeout(LockTimeoutSetting(selection!));
      setState(() {
        _curTimeoutSetting = LockTimeoutSetting(selection);
      });
    }
  }

  List<Widget> _buildThemeOptions() {
    final List<Widget> ret = List<Widget>.empty(growable: true);
    for (var value in ThemeOptions.values) {
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
    }
    return ret;
  }

  Future<void> _themeDialog() async {
    final Preferences _preferences = await Preferences.getInstance();
    final ThemeOptions? selection = await showDialog<ThemeOptions>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                AppLocalization.of(context)!.themeHeader,
                style: AppStyles.textStyleSize20W700Primary(context),
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                side: BorderSide(
                    color: StateContainer.of(context).curTheme.primary45!)),
            children: _buildThemeOptions(),
          );
        });
    if (_curThemeSetting != ThemeSetting(selection!)) {
      _preferences.setTheme(ThemeSetting(selection));
      setState(() {
        StateContainer.of(context).updateTheme(ThemeSetting(selection));
        _curThemeSetting = ThemeSetting(selection);
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
                          Vault.getInstance().then((Vault _vault) {
                            _vault.deleteAll();
                          });
                          Preferences.getInstance()
                              .then((Preferences _preferences) {
                            _preferences.deleteAll();
                            StateContainer.of(context).logOut();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/', (Route<dynamic> route) => false);
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

                    Column(children: <Widget>[
                      Divider(
                          height: 2,
                          color: StateContainer.of(context).curTheme.primary15),
                      AppSettings.buildSettingsListItemWithDefaultValue(
                          context,
                          AppLocalization.of(context)!.lockAppSetting,
                          _curUnlockSetting,
                          'assets/icons/authentication.png',
                          _lockDialog),
                    ]),
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
                      disabled: _curUnlockSetting.setting == UnlockOption.no,
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
                        final Preferences _preferences =
                            await Preferences.getInstance();
                        final AuthenticationMethod authMethod =
                            _preferences.getAuthMethod();
                        final bool hasBiometrics =
                            await sl.get<BiometricUtil>().hasBiometrics();

                        if (authMethod.method == AuthMethod.biometrics &&
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
                              AuthMethod.yubikeyWithYubicloud) {
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
                        _pinPadShuffleActive,
                        onChanged: (bool _isSwitched) async {
                      final Preferences _preferences =
                          await Preferences.getInstance();
                      setState(() {
                        _pinPadShuffleActive = _isSwitched;
                        _isSwitched
                            ? _preferences.setPinPadShuffle(true)
                            : _preferences.setPinPadShuffle(false);
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
                            color: StateContainer.of(context).curTheme.primary,
                            size: 24)),
                  ),
                  Expanded(
                    child: AutoSizeText(
                      AppLocalization.of(context)!.aboutHeader,
                      style: AppStyles.textStyleSize28W700Primary(context),
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
                            color: StateContainer.of(context).curTheme.primary,
                            size: 24)),
                  ),
                  Expanded(
                    child: AutoSizeText(
                      AppLocalization.of(context)!.nftHeader,
                      style: AppStyles.textStyleSize28W700Primary(context),
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
    final Vault _vault = await Vault.getInstance();
    final String? expectedPin = _vault.getPin();
    final bool auth = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return PinScreen(
        PinOverlayType.enterPin,
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
