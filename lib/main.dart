// Dart imports:
import 'dart:async';
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:bin/ui/views/intro/intro_backup_confirm.dart';
import 'package:bin/ui/views/intro/intro_backup_safety.dart';
import 'package:bin/ui/views/intro/intro_backup_seed.dart';
import 'package:bin/ui/views/intro/intro_import_seed.dart';
import 'package:bin/ui/views/intro/intro_welcome.dart';
import 'package:bin/ui/views/lock_screen.dart';
import 'package:bin/ui/views/home_page_bin.dart';
import 'package:core/appstate_container.dart';
import 'package:core/localization.dart';
import 'package:core/model/available_language.dart';
import 'package:core/model/data/appdb.dart';
import 'package:core/ui/util/routes.dart';
import 'package:core/ui/util/styles.dart';
import 'package:core/ui/widgets/components/dialog.dart';
import 'package:core/util/app_util.dart';
import 'package:core/util/case_converter.dart';
import 'package:core/util/preferences.dart';
import 'package:core/util/vault.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive/hive.dart';
import 'package:oktoast/oktoast.dart';
import 'package:safe_device/safe_device.dart';

// Project imports:

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await DBHelper.setupDatabase();

  // Run app
  SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[DeviceOrientation.portraitUp]).then((_) {
    runApp(const StateContainer(child: App()));
  });
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        StateContainer.of(context).curTheme.statusBar!);
    return OKToast(
      textStyle: AppStyles.textStyleSize14W700Background(context),
      backgroundColor: StateContainer.of(context).curTheme.background,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ARCHEthic Wallet',
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
        locale: StateContainer.of(context).curLanguage.language ==
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
                builder: (_) => const Splash(),
                settings: settings,
              );
            case '/home':
              return NoTransitionRoute<AppHomePageBin>(
                builder: (_) => const AppHomePageBin(),
                settings: settings,
              );
            case '/home_transition':
              return NoPopTransitionRoute<AppHomePageBin>(
                builder: (_) => const AppHomePageBin(),
                settings: settings,
              );
            case '/intro_welcome':
              return NoTransitionRoute<IntroWelcomePage>(
                builder: (_) => const IntroWelcomePage(),
                settings: settings,
              );
            case '/intro_backup':
              return MaterialPageRoute<IntroBackupSeedPage>(
                builder: (_) => const IntroBackupSeedPage(),
                settings: settings,
              );
            case '/intro_backup_safety':
              return MaterialPageRoute<IntroBackupSafetyPage>(
                builder: (_) => const IntroBackupSafetyPage(),
                settings: settings,
              );
            case '/intro_import':
              return MaterialPageRoute<IntroImportSeedPage>(
                builder: (_) => const IntroImportSeedPage(),
                settings: settings,
              );
            case '/intro_backup_confirm':
              return MaterialPageRoute<IntroBackupConfirm>(
                builder: (_) => const IntroBackupConfirm(),
                settings: settings,
              );
            case '/lock_screen':
              return NoTransitionRoute<AppLockScreen>(
                builder: (_) => const AppLockScreen(),
                settings: settings,
              );
            case '/lock_screen_transition':
              return MaterialPageRoute<AppLockScreen>(
                builder: (_) => const AppLockScreen(),
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
  const Splash({Key? key}) : super(key: key);

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> with WidgetsBindingObserver {
  bool? _hasCheckedLoggedIn;

  Future<void> checkLoggedIn() async {
    final Preferences _preferences = await Preferences.getInstance();
    if (!kIsWeb &&
        !Platform.isMacOS &&
        !Platform.isWindows &&
        !Platform.isLinux) {
      // Check if device is rooted or jailbroken, show user a warning informing them of the risks if so
      if (!_preferences.getHasSeenRootWarning() &&
          (await SafeDevice.isJailBroken)) {
        AppDialogs.showConfirmDialog(
            context,
            CaseChange.toUpperCase(
                AppLocalization.of(context)!.warning, context),
            AppLocalization.of(context)!.rootWarning,
            AppLocalization.of(context)!.iUnderstandTheRisks.toUpperCase(),
            () async {
              _preferences.setHasSeenRootWarning();
              checkLoggedIn();
            },
            cancelText: AppLocalization.of(context)!.exit.toUpperCase(),
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

    if (!_hasCheckedLoggedIn!) {
      _hasCheckedLoggedIn = true;
    } else {
      return;
    }
    try {
      // See if logged in already
      bool isLoggedIn = false;

      final Vault _vault = await Vault.getInstance();
      final String? seed = _vault.getSeed();
      final String? pin = _vault.getPin();
      // If we have a seed set, but not a pin - or vice versa
      // Then delete the seed and pin from device and start over.
      // This would mean user did not complete the intro screen completely.
      if (seed != null && pin != null) {
        isLoggedIn = true;
      } else if (seed != null && pin == null) {
        _vault.deleteSeed();
      } else if (pin != null && seed == null) {
        _vault.deletePin();
      }

      if (isLoggedIn) {
        if (_preferences.getLock() || _preferences.shouldLock()) {
          Navigator.of(context).pushReplacementNamed('/lock_screen');
        } else {
          await AppUtil().loginAccount(seed!, context);
          Navigator.of(context).pushReplacementNamed('/home');
        }
      } else {
        Navigator.of(context).pushReplacementNamed('/intro_welcome');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    FlutterNativeSplash.remove();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    _hasCheckedLoggedIn = false;
    if (SchedulerBinding.instance!.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance!.addPostFrameCallback((_) => checkLoggedIn());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
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
    Preferences.getInstance().then((Preferences _preferences) {
      setState(() {
        StateContainer.of(context).curLanguage = _preferences.getLanguage();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    setLanguage();
    Preferences.getInstance().then((Preferences _preferences) {
      setState(() {
        StateContainer.of(context).curCurrency =
            _preferences.getCurrency(StateContainer.of(context).deviceLocale);
      });
    });
    return Scaffold(
      backgroundColor: StateContainer.of(context).curTheme.background,
    );
  }
}
