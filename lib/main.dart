/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:developer' as dev;
import 'dart:io';
import 'package:aewallet/application/authentication/authentication.dart';
import 'package:aewallet/application/language.dart';
import 'package:aewallet/application/settings.dart';
import 'package:aewallet/application/theme.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/appstate_container.dart';
import 'package:aewallet/localization.dart';
import 'package:aewallet/model/available_themes.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/ui/util/routes.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/authenticate/auth_factory.dart';
import 'package:aewallet/ui/views/authenticate/lock_screen.dart';
import 'package:aewallet/ui/views/home_page.dart';
import 'package:aewallet/ui/views/intro/intro_backup_confirm.dart';
import 'package:aewallet/ui/views/intro/intro_backup_seed.dart';
import 'package:aewallet/ui/views/intro/intro_import_seed.dart';
import 'package:aewallet/ui/views/intro/intro_new_wallet_disclaimer.dart';
import 'package:aewallet/ui/views/intro/intro_new_wallet_get_first_infos.dart';
import 'package:aewallet/ui/views/intro/intro_welcome.dart';
import 'package:aewallet/ui/views/nft/layouts/nft_list_per_category.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/nft_creation_process_sheet.dart';
import 'package:aewallet/util/preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oktoast/oktoast.dart';
import 'package:window_manager/window_manager.dart';

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
    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      windowManager.setResizable(false);
      await windowManager.show();
      await windowManager.focus();
    });
  }

  final localPreferencesRepository = await Preferences.getInstance();

  // Run app
  await SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[DeviceOrientation.portraitUp],
  ).then((_) {
    runApp(
      RestartWidget(
        child: ProviderScope(
          overrides: [
            // TODO(reddwarf03): Meaning ? => a way to reinitiliaze the wallet
            SettingsProviders.localSettingsRepository
                .overrideWithValue(localPreferencesRepository),
          ],
          child: const StateContainer(
            child: App(),
          ),
        ),
      ),
    );
  });
}

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final language = ref.watch(LanguageProviders.selectedLanguage);

    SystemChrome.setSystemUIOverlayStyle(
      theme.statusBar!,
    );
    return OKToast(
      textStyle: theme.textStyleSize14W700Background,
      backgroundColor: theme.background,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Archethic Wallet',
        theme: ThemeData(
          dialogBackgroundColor: theme.backgroundDark,
          primaryColor: theme.text,
          backgroundColor: theme.background,
          fontFamily: theme.secondaryFont,
          brightness: theme.brightness,
        ),
        // ignore: always_specify_types
        localizationsDelegates: [
          AppLocalizationsDelegate(language),
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        locale: language.getLocale(),
        supportedLocales: ref.read(LanguageProviders.availableLocales),
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/':
              return NoTransitionRoute<Splash>(
                builder: (_) => const Splash(),
                settings: settings,
              );
            case '/home':
              return NoTransitionRoute<HomePage>(
                builder: (_) => const HomePage(),
                settings: settings,
              );
            case '/home_transition':
              return NoPopTransitionRoute<HomePage>(
                builder: (_) => const HomePage(),
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
              return MaterialPageRoute<NftCreationProcessSheet>(
                builder: (_) => NftCreationProcessSheet(
                  seed: args['seed'] as String,
                  currentNftCategoryIndex:
                      args['currentNftCategoryIndex'] as int,
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
class Splash extends ConsumerStatefulWidget {
  const Splash({super.key});

  @override
  ConsumerState<Splash> createState() => SplashState();
}

class SplashState extends ConsumerState<Splash> with WidgetsBindingObserver {
  // late bool _hasCheckedLoggedIn;

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

      await ref.read(SessionProviders.session.notifier).restore();

      final session = ref.read(SessionProviders.session);
      FlutterNativeSplash.remove();

      if (session.isLoggedOut) {
        await _goToIntroScreen();
        return;
      }

      if (preferences.getLock()) {
        await Navigator.of(context).pushReplacementNamed('/home');

        await AuthFactory.forceAuthenticate(
          context,
          ref,
          authMethod: ref.read(
            AuthenticationProviders.preferedAuthMethod,
          ),
          canCancel: false,
        );
      } else {
        await StateContainer.of(context).requestUpdate();
        await Navigator.of(context).pushReplacementNamed('/home');
      }
    } catch (e) {
      dev.log(e.toString());
      FlutterNativeSplash.remove();
      await _goToIntroScreen();
    }
  }

  Future<void> _goToIntroScreen() async {
    // TODO(Chralu): Theme reset should be part of the `logOut` usecase.
    await ref
        .read(ThemeProviders.selectedThemeOption.notifier)
        .selectTheme(ThemeOptions.dark);
    await Navigator.of(context).pushReplacementNamed('/intro_welcome');
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => checkLoggedIn(),
    );
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
        updateDefaultLocale();
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

  void updateDefaultLocale() {
    ref
        .read(LanguageProviders.defaultLocale.notifier)
        .update((state) => Localizations.localeOf(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ref.read(ThemeProviders.selectedTheme).background,
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
