// @dart=2.9

// Dart imports:
import 'dart:async';
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';
import 'package:root_checker/root_checker.dart';

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/localization.dart';
import 'package:archethic_mobile_wallet/model/available_currency.dart';
import 'package:archethic_mobile_wallet/model/available_language.dart';
import 'package:archethic_mobile_wallet/model/vault.dart';
import 'package:archethic_mobile_wallet/service_locator.dart';
import 'package:archethic_mobile_wallet/styles.dart';
import 'package:archethic_mobile_wallet/ui/before_scan_screen.dart';
import 'package:archethic_mobile_wallet/ui/home_page.dart';
import 'package:archethic_mobile_wallet/ui/intro/intro_backup_confirm.dart';
import 'package:archethic_mobile_wallet/ui/intro/intro_backup_safety.dart';
import 'package:archethic_mobile_wallet/ui/intro/intro_enter_tx_chain_seed.dart';
import 'package:archethic_mobile_wallet/ui/intro/intro_password.dart';
import 'package:archethic_mobile_wallet/ui/intro/intro_password_on_launch.dart';
import 'package:archethic_mobile_wallet/ui/intro/intro_welcome.dart';
import 'package:archethic_mobile_wallet/ui/lock_screen.dart';
import 'package:archethic_mobile_wallet/ui/password_lock_screen.dart';
import 'package:archethic_mobile_wallet/ui/util/routes.dart';
import 'package:archethic_mobile_wallet/ui/widgets/dialog.dart';
import 'package:archethic_mobile_wallet/util/app_ffi/apputil.dart';
import 'package:archethic_mobile_wallet/util/caseconverter.dart';
import 'package:archethic_mobile_wallet/util/helpers.dart';
import 'package:archethic_mobile_wallet/util/sharedprefsutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Run app
  SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[DeviceOrientation.portraitUp]).then((_) {
    runApp(StateContainer(child: App()));
  });
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        StateContainer.of(context).curTheme.statusBar);
    return OKToast(
      textStyle: AppStyles.textStyleSmallW700Background(context),
      backgroundColor: StateContainer.of(context).curTheme.background,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ArchEthic Wallet',
        theme: ThemeData(
          dialogBackgroundColor:
              StateContainer.of(context).curTheme.backgroundDark,
          primaryColor: StateContainer.of(context).curTheme.primary,
          accentColor: StateContainer.of(context).curTheme.primary10,
          backgroundColor: StateContainer.of(context).curTheme.background,
          fontFamily: 'Montserrat',
          brightness: Brightness.dark,
        ),
        localizationsDelegates: [
          AppLocalizationsDelegate(StateContainer.of(context).curLanguage),
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        locale: StateContainer.of(context).curLanguage == null ||
                StateContainer.of(context).curLanguage.language ==
                    AvailableLanguage.DEFAULT
            ? null
            : StateContainer.of(context).curLanguage.getLocale(),
        supportedLocales: [
          const Locale('en', 'US'), // English
          // Currency-default requires country included
          const Locale('es', 'AR'),
          const Locale('en', 'AU'),
          const Locale('pt', 'BR'),
          const Locale('en', 'CA'),
          const Locale('de', 'CH'),
          const Locale('es', 'CL'),
          const Locale('zh', 'CN'),
          const Locale('cs', 'CZ'),
          const Locale('da', 'DK'),
          const Locale('fr', 'FR'),
          const Locale('en', 'GB'),
          const Locale('zh', 'HK'),
          const Locale('hu', 'HU'),
          const Locale('id', 'ID'),
          const Locale('he', 'IL'),
          const Locale('hi', 'IN'),
          const Locale('ja', 'JP'),
          const Locale('ko', 'KR'),
          const Locale('es', 'MX'),
          const Locale('ta', 'MY'),
          const Locale('en', 'NZ'),
          const Locale('tl', 'PH'),
          const Locale('ur', 'PK'),
          const Locale('pl', 'PL'),
          const Locale('ru', 'RU'),
          const Locale('sv', 'SE'),
          const Locale('zh', 'SG'),
          const Locale('th', 'TH'),
          const Locale('tr', 'TR'),
          const Locale('en', 'TW'),
          const Locale('es', 'VE'),
          const Locale('en', 'ZA'),
          const Locale('en', 'US'),
          const Locale('es', 'AR'),
          const Locale('de', 'AT'),
          const Locale('fr', 'BE'),
          const Locale('de', 'BE'),
          const Locale('nl', 'BE'),
          const Locale('tr', 'CY'),
          const Locale('et', 'EE'),
          const Locale('fi', 'FI'),
          const Locale('fr', 'FR'),
          const Locale('el', 'GR'),
          const Locale('es', 'AR'),
          const Locale('en', 'IE'),
          const Locale('it', 'IT'),
          const Locale('es', 'AR'),
          const Locale('lv', 'LV'),
          const Locale('lt', 'LT'),
          const Locale('fr', 'LU'),
          const Locale('en', 'MT'),
          const Locale('nl', 'NL'),
          const Locale('pt', 'PT'),
          const Locale('sk', 'SK'),
          const Locale('sl', 'SI'),
          const Locale('es', 'ES'),
          const Locale('ar', 'AE'), // UAE
          const Locale('ar', 'SA'), // Saudi Arabia
          const Locale('ar', 'KW'), // Kuwait
        ],
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/':
              return NoTransitionRoute<Splash>(
                builder: (_) => Splash(),
                settings: settings,
              );
            case '/home':
              return NoTransitionRoute<AppHomePage>(
                builder: (_) => const AppHomePage(),
                settings: settings,
              );
            case '/home_transition':
              return NoPopTransitionRoute<AppHomePage>(
                builder: (_) => const AppHomePage(),
                settings: settings,
              );
            case '/intro_welcome':
              return NoTransitionRoute<IntroWelcomePage>(
                builder: (_) => IntroWelcomePage(),
                settings: settings,
              );
            case '/intro_password_on_launch':
              return MaterialPageRoute<IntroPasswordOnLaunch>(
                builder: (_) => IntroPasswordOnLaunch(seed: settings.arguments),
                settings: settings,
              );
            case '/intro_password':
              return MaterialPageRoute<IntroPassword>(
                builder: (_) => IntroPassword(seed: settings.arguments),
                settings: settings,
              );
            case '/intro_backup_safety':
              return MaterialPageRoute<IntroBackupSafetyPage>(
                builder: (_) => IntroBackupSafetyPage(),
                settings: settings,
              );
            case '/intro_backup_confirm':
              return MaterialPageRoute<IntroBackupConfirm>(
                builder: (_) => IntroBackupConfirm(),
                settings: settings,
              );
            case '/intro_enter_transaction_chain_seed':
              return MaterialPageRoute<IntroEnterTxChainSeed>(
                builder: (_) => IntroEnterTxChainSeed(),
                settings: settings,
              );
            case '/lock_screen':
              return NoTransitionRoute<AppLockScreen>(
                builder: (_) => AppLockScreen(),
                settings: settings,
              );
            case '/lock_screen_transition':
              return MaterialPageRoute<AppLockScreen>(
                builder: (_) => AppLockScreen(),
                settings: settings,
              );
            case '/password_lock_screen':
              return NoTransitionRoute<AppPasswordLockScreen>(
                builder: (_) => AppPasswordLockScreen(),
                settings: settings,
              );
            case '/before_scan_screen':
              return NoTransitionRoute<BeforeScanScreen>(
                builder: (_) => BeforeScanScreen(),
                settings: settings,
              );
            default:
              return null;
          }
        },
      ),
    );
  }
}

/// Splash
/// Default page route that determines if user is logged in and routes them appropriately.
class Splash extends StatefulWidget {
  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> with WidgetsBindingObserver {
  bool _hasCheckedLoggedIn;
  bool _retried;

  bool seedIsEncrypted(String seed) {
    if (seed == null) {
      return false;
    }
    try {
      final String salted = AppHelpers.bytesToUtf8String(
          AppHelpers.hexToBytes(seed.substring(0, 16)));
      if (salted == 'Salted__') {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> checkLoggedIn() async {
    // Update session key
    await sl.get<Vault>().updateSessionKey();
    // Check if device is rooted or jailbroken, show user a warning informing them of the risks if so
    if (!(await sl.get<SharedPrefsUtil>().getHasSeenRootWarning()) &&
        (await RootChecker.isDeviceRooted)) {
      AppDialogs.showConfirmDialog(
          context,
          CaseChange.toUpperCase(AppLocalization.of(context).warning, context),
          AppLocalization.of(context).rootWarning,
          AppLocalization.of(context).iUnderstandTheRisks.toUpperCase(),
          () async {
            await sl.get<SharedPrefsUtil>().setHasSeenRootWarning();
            checkLoggedIn();
          },
          cancelText: AppLocalization.of(context).exit.toUpperCase(),
          cancelAction: () {
            if (Platform.isIOS) {
              exit(0);
            } else {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            }
          });
      return;
    }
    if (!_hasCheckedLoggedIn) {
      _hasCheckedLoggedIn = true;
    } else {
      return;
    }
    try {
      // iOS key store is persistent, so if this is first launch then we will clear the keystore
      final bool firstLaunch = await sl.get<SharedPrefsUtil>().getFirstLaunch();
      if (firstLaunch) {
        await sl.get<Vault>().deleteAll();
      }
      await sl.get<SharedPrefsUtil>().setFirstLaunch();
      // See if logged in already
      bool isLoggedIn = false;
      bool isEncrypted = false;
      final String seed = await sl.get<Vault>().getSeed();
      final String pin = await sl.get<Vault>().getPin();
      // If we have a seed set, but not a pin - or vice versa
      // Then delete the seed and pin from device and start over.
      // This would mean user did not complete the intro screen completely.
      if (seed != null && pin != null) {
        isLoggedIn = true;
        isEncrypted = seedIsEncrypted(seed);
      } else if (seed != null && pin == null) {
        await sl.get<Vault>().deleteSeed();
      } else if (pin != null && seed == null) {
        await sl.get<Vault>().deletePin();
      }

      if (isLoggedIn) {
        if (isEncrypted) {
          Navigator.of(context).pushReplacementNamed('/password_lock_screen');
        } else if (await sl.get<SharedPrefsUtil>().getLock() ||
            await sl.get<SharedPrefsUtil>().shouldLock()) {
          Navigator.of(context).pushReplacementNamed('/lock_screen');
        } else {
          await AppUtil().loginAccount(seed, context);
          final PriceConversion conversion =
              await sl.get<SharedPrefsUtil>().getPriceConversion();
          Navigator.of(context)
              .pushReplacementNamed('/home', arguments: conversion);
        }
      } else {
        Navigator.of(context).pushReplacementNamed('/intro_welcome');
      }
    } catch (e) {
      /// Fallback secure storage
      /// A very small percentage of users are encountering issues writing to the
      /// Android keyStore using the flutter_secure_storage plugin.
      ///
      /// Instead of telling them they are out of luck, this is an automatic "fallback"
      /// It will generate a 64-byte secret using the native android "bottlerocketstudios" Vault
      /// This secret is used to encrypt sensitive data and save it in SharedPreferences
      if (Platform.isAndroid && e.toString().contains('flutter_secure')) {
        if (!(await sl.get<SharedPrefsUtil>().useLegacyStorage())) {
          await sl.get<SharedPrefsUtil>().setUseLegacyStorage();
          checkLoggedIn();
        }
      } else {
        await sl.get<Vault>().deleteAll();
        await sl.get<SharedPrefsUtil>().deleteAll();
        if (!_retried) {
          _retried = true;
          _hasCheckedLoggedIn = false;
          checkLoggedIn();
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _hasCheckedLoggedIn = false;
    _retried = false;
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((_) => checkLoggedIn());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Account for user changing locale when leaving the app
    switch (state) {
      case AppLifecycleState.paused:
        super.didChangeAppLifecycleState(state);
        break;
      case AppLifecycleState.resumed:
        setLanguage();
        super.didChangeAppLifecycleState(state);
        break;
      default:
        super.didChangeAppLifecycleState(state);
        break;
    }
  }

  void setLanguage() {
    setState(() {
      StateContainer.of(context).deviceLocale = Localizations.localeOf(context);
    });
    sl.get<SharedPrefsUtil>().getLanguage().then((LanguageSetting setting) {
      setState(() {
        StateContainer.of(context).updateLanguage(setting);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    setLanguage();
    sl
        .get<SharedPrefsUtil>()
        .getCurrency(StateContainer.of(context).deviceLocale)
        .then((AvailableCurrency currency) {
      StateContainer.of(context).curCurrency = currency;
    });
    return Scaffold(
      backgroundColor: StateContainer.of(context).curTheme.background,
    );
  }
}
