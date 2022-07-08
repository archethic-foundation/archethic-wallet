/// SPDX-License-Identifier: AGPL-3.0-or-later

// Dart imports:
import 'dart:async';
import 'dart:developer' as dev;
import 'dart:io';

// Flutter imports:
import 'package:aeuniverse/ui/themes/theme_dark.dart';
import 'package:core/util/get_it_instance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:aeuniverse/appstate_container.dart';
import 'package:aeuniverse/ui/util/styles.dart';
import 'package:aeuniverse/ui/views/home_page_universe.dart';
import 'package:aeuniverse/ui/views/intro/intro_backup_confirm.dart';
import 'package:aeuniverse/ui/views/intro/intro_backup_seed.dart';
import 'package:aeuniverse/ui/views/intro/intro_configure_security.dart';
import 'package:aeuniverse/ui/views/intro/intro_import_seed.dart';
import 'package:aeuniverse/ui/views/intro/intro_new_wallet_disclaimer.dart';
import 'package:aeuniverse/ui/views/intro/intro_new_wallet_get_first_infos.dart';
import 'package:aeuniverse/ui/views/intro/intro_password.dart';
import 'package:aeuniverse/ui/views/intro/intro_welcome.dart';
import 'package:aeuniverse/ui/views/intro/intro_yubikey.dart';
import 'package:aeuniverse/ui/views/lock_screen.dart';
import 'package:aeuniverse/ui/views/settings/update_password.dart';
import 'package:aeuniverse/ui/views/settings/update_yubikey.dart';
import 'package:aeuniverse/ui/widgets/components/dialog.dart';
import 'package:aeuniverse/ui/widgets/components/picker_item.dart';
import 'package:aeuniverse/util/preferences.dart';
import 'package:core/localization.dart';
import 'package:core/model/available_language.dart';
import 'package:core/model/data/appdb.dart';
import 'package:core_ui/ui/util/routes.dart';
import 'package:core_ui/util/case_converter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:oktoast/oktoast.dart';
import 'package:safe_device/safe_device.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await DBHelper.setupDatabase();

  // Run app
  SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[DeviceOrientation.portraitUp]).then((_) {
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
        StateContainer.of(context).curTheme.statusBar!);
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
          Locale("ar", "AE"),
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
                  name: settings.arguments == null
                      ? null
                      : settings.arguments as String,
                ),
                settings: settings,
              );
            case '/intro_backup_safety':
              return MaterialPageRoute<IntroNewWalletDisclaimer>(
                builder: (_) => IntroNewWalletDisclaimer(
                  name: settings.arguments == null
                      ? null
                      : settings.arguments as String,
                ),
                settings: settings,
              );
            case '/intro_configure_security':
              Map<String, dynamic> args =
                  settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute<IntroConfigureSecurity>(
                builder: (_) => IntroConfigureSecurity(
                    accessModes: args['accessModes'] == null
                        ? null
                        : args['accessModes'] as List<PickerItem>,
                    name: args['name'] == null ? null : args['name'] as String,
                    seed: args['seed'] == null ? null : args['seed'] as String),
                settings: settings,
              );
            case '/intro_password':
              Map<String, String?> args =
                  settings.arguments as Map<String, String?>;
              return MaterialPageRoute(
                builder: (_) => IntroPassword(
                    name: args['name'] == null ? '' : args['name'] as String,
                    seed: args['seed'] == null ? '' : args['seed'] as String),
                settings: settings,
              );
            case '/intro_yubikey':
              Map<String, String?> args =
                  settings.arguments as Map<String, String?>;
              return MaterialPageRoute(
                builder: (_) => IntroYubikey(
                    name: args['name'] == null ? '' : args['name'] as String,
                    seed: args['seed'] == null ? '' : args['seed'] as String),
                settings: settings,
              );
            case '/update_password':
              return MaterialPageRoute(
                builder: (_) => const UpdatePassword(),
                settings: settings,
              );
            case '/update_yubikey':
              return MaterialPageRoute(
                builder: (_) => const UpdateYubikey(),
                settings: settings,
              );
            case '/intro_import':
              return MaterialPageRoute<IntroImportSeedPage>(
                builder: (_) => const IntroImportSeedPage(),
                settings: settings,
              );
            case '/intro_backup_confirm':
              Map<String, dynamic> args =
                  settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute<IntroBackupConfirm>(
                builder: (_) => IntroBackupConfirm(
                    wordList: args['mnemonic'] == null
                        ? List<String>.empty(growable: true)
                        : args['mnemonic'] as List<String>,
                    name: args['name'] == null ? null : args['name'] as String,
                    seed: args['seed'] == null ? null : args['seed'] as String),
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
  const Splash({super.key});

  @override
  State<Splash> createState() => SplashState();
}

class SplashState extends State<Splash> with WidgetsBindingObserver {
  bool? _hasCheckedLoggedIn;

  Future<void> checkLoggedIn() async {
    final Preferences preferences = await Preferences.getInstance();
    if (!kIsWeb &&
        !Platform.isMacOS &&
        !Platform.isWindows &&
        !Platform.isLinux) {
      // Check if device is rooted or jailbroken, show user a warning informing them of the risks if so
      if (!preferences.getHasSeenRootWarning() &&
          (await SafeDevice.isJailBroken)) {
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
    }

    if (!_hasCheckedLoggedIn!) {
      _hasCheckedLoggedIn = true;
    } else {
      return;
    }
    try {
      // See if logged in already
      bool isLoggedIn = false;

      final String? seed = await StateContainer.of(context).getSeed();

      if (seed != null) {
        isLoggedIn = true;
      }

      if (isLoggedIn) {
        StateContainer.of(context).appWallet =
            await sl.get<DBHelper>().getAppWallet();
        if (StateContainer.of(context).appWallet == null) {
          await StateContainer.of(context).logOut();
          StateContainer.of(context).curTheme = DarkTheme();
          Navigator.of(context).pushReplacementNamed('/intro_welcome');
        }
        StateContainer.of(context).checkTransactionInputs(
            AppLocalization.of(context)!.transactionInputNotification);
        if (preferences.getLock() || preferences.shouldLock()) {
          Navigator.of(context).pushReplacementNamed('/lock_screen');
        } else {
          StateContainer.of(context).requestUpdate();
          Navigator.of(context).pushReplacementNamed('/home');
        }
      } else {
        StateContainer.of(context).curTheme = DarkTheme();
        Navigator.of(context).pushReplacementNamed('/intro_welcome');
      }
    } catch (e) {
      dev.log(e.toString());
      await StateContainer.of(context).logOut();
      StateContainer.of(context).curTheme = DarkTheme();
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
      default:
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
