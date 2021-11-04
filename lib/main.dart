// @dart=2.9

// Dart imports:
import 'dart:async';
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';
import 'package:safe_device/safe_device.dart';

// Project imports:
import 'package:archethic_mobile_wallet/appstate_container.dart';
import 'package:archethic_mobile_wallet/localization.dart';
import 'package:archethic_mobile_wallet/model/available_currency.dart';
import 'package:archethic_mobile_wallet/model/available_language.dart';
import 'package:archethic_mobile_wallet/model/data/appdb.dart';
import 'package:archethic_mobile_wallet/model/vault.dart';
import 'package:archethic_mobile_wallet/service_locator.dart';
import 'package:archethic_mobile_wallet/styles.dart';
import 'package:archethic_mobile_wallet/ui/home_page.dart';
import 'package:archethic_mobile_wallet/ui/intro/intro_backup_confirm.dart';
import 'package:archethic_mobile_wallet/ui/intro/intro_backup_safety.dart';
import 'package:archethic_mobile_wallet/ui/intro/intro_backup_seed.dart';
import 'package:archethic_mobile_wallet/ui/intro/intro_import_seed.dart';
import 'package:archethic_mobile_wallet/ui/intro/intro_welcome.dart';
import 'package:archethic_mobile_wallet/ui/lock_screen.dart';
import 'package:archethic_mobile_wallet/ui/util/routes.dart';
import 'package:archethic_mobile_wallet/ui/widgets/dialog.dart';
import 'package:archethic_mobile_wallet/util/app_ffi/apputil.dart';
import 'package:archethic_mobile_wallet/util/caseconverter.dart';
import 'package:archethic_mobile_wallet/util/helpers.dart';
import 'package:archethic_mobile_wallet/util/sharedprefsutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.setupDatabase();
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
      textStyle: AppStyles.textStyleSize14W700Background(context),
      backgroundColor: StateContainer.of(context).curTheme.background,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ArchEthic Wallet',
        theme: ThemeData(
          dialogBackgroundColor:
              StateContainer.of(context).curTheme.backgroundDark,
          primaryColor: StateContainer.of(context).curTheme.primary,
          backgroundColor: StateContainer.of(context).curTheme.background,
          fontFamily: 'Montserrat',
          brightness: Brightness.dark,
        ),
        // ignore: always_specify_types
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
        supportedLocales: const <Locale>[
          Locale('en', 'US'), // English
          // Currency-default requires country included
          Locale('es', 'AR'),
          Locale('en', 'AU'),
          Locale('pt', 'BR'),
          Locale('en', 'CA'),
          Locale('de', 'CH'),
          Locale('es', 'CL'),
          Locale('zh', 'CN'),
          Locale('cs', 'CZ'),
          Locale('da', 'DK'),
          Locale('fr', 'FR'),
          Locale('en', 'GB'),
          Locale('zh', 'HK'),
          Locale('hu', 'HU'),
          Locale('id', 'ID'),
          Locale('he', 'IL'),
          Locale('hi', 'IN'),
          Locale('ja', 'JP'),
          Locale('ko', 'KR'),
          Locale('es', 'MX'),
          Locale('ta', 'MY'),
          Locale('en', 'NZ'),
          Locale('tl', 'PH'),
          Locale('ur', 'PK'),
          Locale('pl', 'PL'),
          Locale('ru', 'RU'),
          Locale('sv', 'SE'),
          Locale('zh', 'SG'),
          Locale('th', 'TH'),
          Locale('tr', 'TR'),
          Locale('en', 'TW'),
          Locale('es', 'VE'),
          Locale('en', 'ZA'),
          Locale('en', 'US'),
          Locale('es', 'AR'),
          Locale('de', 'AT'),
          Locale('fr', 'BE'),
          Locale('de', 'BE'),
          Locale('nl', 'BE'),
          Locale('tr', 'CY'),
          Locale('et', 'EE'),
          Locale('fi', 'FI'),
          Locale('fr', 'FR'),
          Locale('el', 'GR'),
          Locale('es', 'AR'),
          Locale('en', 'IE'),
          Locale('it', 'IT'),
          Locale('es', 'AR'),
          Locale('lv', 'LV'),
          Locale('lt', 'LT'),
          Locale('fr', 'LU'),
          Locale('en', 'MT'),
          Locale('nl', 'NL'),
          Locale('pt', 'PT'),
          Locale('sk', 'SK'),
          Locale('sl', 'SI'),
          Locale('es', 'ES'),
          Locale('ar', 'AE'),
          Locale('ar', 'SA'),
          Locale('ar', 'KW'),
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
            case '/intro_backup':
              return MaterialPageRoute(
                builder: (_) =>
                    IntroBackupSeedPage(encryptedSeed: settings.arguments),
                settings: settings,
              );
            case '/intro_backup_safety':
              return MaterialPageRoute<IntroBackupSafetyPage>(
                builder: (_) => IntroBackupSafetyPage(),
                settings: settings,
              );
            case '/intro_import':
              return MaterialPageRoute(
                builder: (_) => IntroImportSeedPage(),
                settings: settings,
              );
            case '/intro_backup_confirm':
              return MaterialPageRoute<IntroBackupConfirm>(
                builder: (_) => IntroBackupConfirm(),
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
      final String salted = AppHelpers.bytesToUtf8String(AppHelpers.hexToBytes(
          seed.length >= 16 ? seed.substring(0, 16) : seed));
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

    if (!kIsWeb &&
        !Platform.isMacOS &&
        !Platform.isWindows &&
        !Platform.isLinux) {
      // Check if device is rooted or jailbroken, show user a warning informing them of the risks if so
      if (!(await sl.get<SharedPrefsUtil>().getHasSeenRootWarning()) &&
          (await SafeDevice.isJailBroken)) {
        AppDialogs.showConfirmDialog(
            context,
            CaseChange.toUpperCase(
                AppLocalization.of(context).warning, context),
            AppLocalization.of(context).rootWarning,
            AppLocalization.of(context).iUnderstandTheRisks.toUpperCase(),
            () async {
              await sl.get<SharedPrefsUtil>().setHasSeenRootWarning();
              checkLoggedIn();
            },
            cancelText: AppLocalization.of(context).exit.toUpperCase(),
            cancelAction: () {
              if (!kIsWeb && Platform.isIOS) {
                exit(0);
              } else {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              }
            });
        return;
      }
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
        await sl.get<DBHelper>().dropAll();
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
          Navigator.of(context).pushReplacementNamed('/home');
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
      if (kIsWeb ||
          (!kIsWeb &&
              Platform.isAndroid &&
              e.toString().contains('flutter_secure'))) {
        if (!(await sl.get<SharedPrefsUtil>().useLegacyStorage())) {
          await sl.get<SharedPrefsUtil>().setUseLegacyStorage();
          checkLoggedIn();
        }
      } else {
        await sl.get<DBHelper>().dropAll();
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
