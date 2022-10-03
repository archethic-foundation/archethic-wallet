/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:async';
import 'dart:developer' as dev;
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:oktoast/oktoast.dart';
import 'package:window_manager/window_manager.dart';

// Project imports:
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/available_language.dart';
import 'package:aewallet/model/available_themes.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/model/primary_currency.dart';
import 'package:aewallet/ui/themes/theme_dark.dart';
import 'package:aewallet/ui/util/routes.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/home_page_universe.dart';
import 'package:aewallet/ui/views/intro/intro_backup_confirm.dart';
import 'package:aewallet/ui/views/intro/intro_backup_seed.dart';
import 'package:aewallet/ui/views/intro/intro_import_seed.dart';
import 'package:aewallet/ui/views/intro/intro_new_wallet_disclaimer.dart';
import 'package:aewallet/ui/views/intro/intro_new_wallet_get_first_infos.dart';
import 'package:aewallet/ui/views/intro/intro_welcome.dart';
import 'package:aewallet/ui/views/lock_screen.dart';
import 'package:aewallet/ui/views/nft/nft_creation_process.dart';
import 'package:aewallet/ui/views/nft/nft_list_per_category.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/preferences.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await DBHelper.setupDatabase();
  if (!kIsWeb && (Platform.isLinux || Platform.isMacOS || Platform.isWindows)) {
    await windowManager.ensureInitialized();

    const windowOptions = WindowOptions(
      size: Size(370, 800),
      center: true,
      backgroundColor: Colors.transparent,
      fullScreen: false,
      title: 'Archethic Wallet',
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      windowManager.setResizable(false);
      await windowManager.show();
      await windowManager.focus();
    });
  }

  // Run app
  SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[DeviceOrientation.portraitUp],
  ).then((_) {
    runApp(
      const RestartWidget(
        child: StateContainer(
          child: App(),
        ),
      ),
    );
  });
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      StateContainer.of(context).curTheme.statusBar!,
    );
    return OKToast(
      textStyle: AppStyles.textStyleSize14W700Background(context),
      backgroundColor: StateContainer.of(context).curTheme.background,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Archethic Wallet',
        theme: ThemeData(
          dialogBackgroundColor:
              StateContainer.of(context).curTheme.backgroundDark,
          primaryColor: StateContainer.of(context).curTheme.text,
          backgroundColor: StateContainer.of(context).curTheme.background,
          fontFamily: StateContainer.of(context).curTheme.secondaryFont,
          brightness: StateContainer.of(context).curTheme.brightness,
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
          Locale('ar', 'AE'),
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
              return NoTransitionRoute<AppHomePageUniverse>(
                builder: (_) => const AppHomePageUniverse(),
                settings: settings,
              );
            case '/home_transition':
              return NoPopTransitionRoute<AppHomePageUniverse>(
                builder: (_) => const AppHomePageUniverse(),
                settings: settings,
              );
            case '/intro_welcome':
              return NoTransitionRoute<IntroWelcome>(
                builder: (_) => const IntroWelcome(),
                settings: settings,
              );
            case '/intro_welcome_get_first_infos':
              return MaterialPageRoute<IntroNewWalletGetFirstInfos>(
                builder: (_) => const IntroNewWalletGetFirstInfos(),
                settings: settings,
              );
            case '/intro_backup':
              return MaterialPageRoute<IntroBackupSeedPage>(
                builder: (_) => IntroBackupSeedPage(
                  name: settings.arguments as String?,
                ),
                settings: settings,
              );
            case '/intro_backup_safety':
              return MaterialPageRoute<IntroNewWalletDisclaimer>(
                builder: (_) => IntroNewWalletDisclaimer(
                  name: settings.arguments as String?,
                ),
                settings: settings,
              );
            case '/intro_import':
              return MaterialPageRoute<IntroImportSeedPage>(
                builder: (_) => const IntroImportSeedPage(),
                settings: settings,
              );
            case '/intro_backup_confirm':
              final args = settings.arguments as Map<String, dynamic>? ?? {};
              return MaterialPageRoute<IntroBackupConfirm>(
                builder: (_) => IntroBackupConfirm(
                  name: args['name'] == null ? null : args['name'] as String,
                  seed: args['seed'] == null ? null : args['seed'] as String,
                ),
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
            case '/nft_list_per_category':
              return MaterialPageRoute<NFTListPerCategory>(
                builder: (_) => NFTListPerCategory(
                  currentNftCategoryIndex: settings.arguments as int?,
                ),
                settings: settings,
              );
            case '/nft_creation':
              final args = settings.arguments as Map<String, dynamic>? ?? {};
              return MaterialPageRoute<NFTCreationProcess>(
                builder: (_) => NFTCreationProcess(
                  currentNftCategoryIndex:
                      args['currentNftCategoryIndex'] == null
                          ? null
                          : args['currentNftCategoryIndex'] as int,
                  process: args['process'] == null
                      ? null
                      : args['process'] as NFTCreationProcessType,
                  primaryCurrency: args['primaryCurrency'] == null
                      ? null
                      : args['primaryCurrency'] as PrimaryCurrencySetting,
                ),
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
/// Default page route that determines if user is logged in
/// and routes them appropriately.
class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => SplashState();
}

class SplashState extends State<Splash> with WidgetsBindingObserver {
  late bool _hasCheckedLoggedIn;

  Future<void> checkLoggedIn() async {
    final preferences = await Preferences.getInstance();
    /*bool jailbroken = false;
    bool developerMode = false;
    if (!kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      jailbroken = await FlutterJailbreakDetection.jailbroken;
      developerMode = await FlutterJailbreakDetection.developerMode;

      if (!preferences.getHasSeenRootWarning() &&
          (jailbroken || developerMode)) {
        AppDialogs.showConfirmDialog(
            context,
            CaseChange.toUpperCase(AppLocalization.of(context)!.warning,
                StateContainer.of(context).curLanguage.getLocaleString()),
            AppLocalization.of(context)!.rootWarning,
            AppLocalization.of(context)!.iUnderstandTheRisks.toUpperCase(),
            () async {
              preferences.setHasSeenRootWarning();
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
    }*/

    if (!_hasCheckedLoggedIn) {
      _hasCheckedLoggedIn = true;
    } else {
      return;
    }
    try {
      // iOS key store is persistent, so if this is first launch
      // then we will clear the keystore
      /*bool firstLaunch = preferences.getFirstLaunch();
      if (firstLaunch) {
        Vault vault = await Vault.getInstance();
        vault.clearAll();
        preferences.clearAll();
      }
      await preferences.setFirstLaunch(false);
      */
      var isLoggedIn = false;

      final seed = await StateContainer.of(context).getSeed();

      if (seed != null) {
        isLoggedIn = true;
      }

      if (isLoggedIn) {
        StateContainer.of(context).appWallet =
            await sl.get<DBHelper>().getAppWallet();
        if (StateContainer.of(context).appWallet == null) {
          await StateContainer.of(context).logOut();
          StateContainer.of(context).curTheme = DarkTheme();
          preferences.setTheme(ThemeSetting(ThemeOptions.dark));
          Navigator.of(context).pushReplacementNamed('/intro_welcome');
        }
        StateContainer.of(context).checkTransactionInputs(
          AppLocalization.of(context)!.transactionInputNotification,
        );
        StateContainer.of(context).curTheme = preferences.getTheme().getTheme();
        if (preferences.getLock() || preferences.shouldLock()) {
          Navigator.of(context).pushReplacementNamed('/lock_screen');
        } else {
          await StateContainer.of(context).requestUpdate();
          Navigator.of(context).pushReplacementNamed('/home');
        }
      } else {
        StateContainer.of(context).curTheme = DarkTheme();
        preferences.setTheme(ThemeSetting(ThemeOptions.dark));
        Navigator.of(context).pushReplacementNamed('/intro_welcome');
      }
    } catch (e) {
      dev.log(e.toString());
      await StateContainer.of(context).logOut();
      StateContainer.of(context).curTheme = DarkTheme();
      preferences.setTheme(ThemeSetting(ThemeOptions.dark));
      Navigator.of(context).pushReplacementNamed('/intro_welcome');
    }
    FlutterNativeSplash.remove();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _hasCheckedLoggedIn = false;
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
      case AppLifecycleState.inactive:
        super.didChangeAppLifecycleState(state);
        break;
      case AppLifecycleState.detached:
        super.didChangeAppLifecycleState(state);
        break;
    }
  }

  void setLanguage() {
    setState(() {
      StateContainer.of(context).deviceLocale = Localizations.localeOf(context);
    });
    Preferences.getInstance().then((Preferences preferences) {
      setState(() {
        StateContainer.of(context).curLanguage = preferences.getLanguage();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    setLanguage();
    Preferences.getInstance().then((Preferences preferences) {
      setState(() {
        StateContainer.of(context).curCurrency =
            preferences.getCurrency(StateContainer.of(context).deviceLocale);
      });
    });
    return Scaffold(
      backgroundColor: StateContainer.of(context).curTheme.background,
    );
  }
}

class RestartWidget extends StatefulWidget {
  const RestartWidget({this.child, super.key});

  final Widget? child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }

  @override
  State<StatefulWidget> createState() {
    return _RestartWidgetState();
  }
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child ?? Container(),
    );
  }
}
