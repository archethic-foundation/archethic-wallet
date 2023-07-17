/// SPDX-License-Identifier: AGPL-3.0-or-later
import 'dart:async';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:aewallet/application/authentication/authentication.dart';
import 'package:aewallet/application/notification/providers.dart';
import 'package:aewallet/application/settings/language.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/settings/theme.dart';
import 'package:aewallet/application/version_manager.dart';
import 'package:aewallet/application/wallet/wallet.dart';
import 'package:aewallet/domain/repositories/features_flags.dart';
import 'package:aewallet/domain/repositories/settings.dart';
import 'package:aewallet/infrastructure/rpc/deeplink_server.dart';
import 'package:aewallet/infrastructure/rpc/websocket_server.dart';
import 'package:aewallet/model/available_language.dart';
import 'package:aewallet/model/data/appdb.dart';
import 'package:aewallet/providers_observer.dart';
import 'package:aewallet/ui/util/routes.dart';
import 'package:aewallet/ui/util/styles.dart';
import 'package:aewallet/ui/views/authenticate/auto_lock_guard.dart';
import 'package:aewallet/ui/views/authenticate/lock_screen.dart';
import 'package:aewallet/ui/views/intro/intro_backup_confirm.dart';
import 'package:aewallet/ui/views/intro/intro_backup_seed.dart';
import 'package:aewallet/ui/views/intro/intro_import_seed.dart';
import 'package:aewallet/ui/views/intro/intro_new_wallet_disclaimer.dart';
import 'package:aewallet/ui/views/intro/intro_new_wallet_get_first_infos.dart';
import 'package:aewallet/ui/views/intro/intro_welcome.dart';
import 'package:aewallet/ui/views/main/home_page.dart';
import 'package:aewallet/ui/views/messenger/layouts/messenger_talk_page.dart';
import 'package:aewallet/ui/views/nft/layouts/nft_list_per_category.dart';
import 'package:aewallet/ui/views/nft_creation/layouts/nft_creation_process_sheet.dart';
import 'package:aewallet/ui/views/rpc_command_receiver/rpc_command_receiver.dart';
import 'package:aewallet/util/get_it_instance.dart';
import 'package:aewallet/util/navigation.dart';
import 'package:aewallet/util/security_manager.dart';
import 'package:aewallet/util/service_locator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oktoast/oktoast.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await DBHelper.setupDatabase();
  await setupServiceLocator();

  final isRpcEnabled = (await sl
          .get<SettingsRepositoryInterface>()
          .getSettings(const Locale('fr')))
      .activeRPCServer;
  final rpcWebsocketServer = sl.get<ArchethicWebsocketRPCServer>();
  if (isRpcEnabled && ArchethicWebsocketRPCServer.isPlatformCompatible) {
    rpcWebsocketServer.run();
  }

  if (!kIsWeb && (Platform.isLinux || Platform.isMacOS || Platform.isWindows)) {
    await windowManager.ensureInitialized();

    var sizeWindows = const Size(370, 800);
    if (Platform.isLinux) {
      sizeWindows = const Size(430, 850);
    }

    final windowOptions = WindowOptions(
      size: sizeWindows,
      maximumSize: sizeWindows,
      center: true,
      backgroundColor: Colors.transparent,
      fullScreen: false,
      title: 'Archethic Wallet',
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
    );

    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      // https://github.com/leanflutter/window_manager/issues/238
      if (Platform.isLinux) {
        await windowManager.setResizable(true);
      } else {
        await windowManager.setResizable(false);
      }

      // ignore: cascade_invocations
      if (Platform.isWindows) {
        windowManager.setMaximizable(false);
      }
      await windowManager.show();
      await windowManager.focus();
    });
  }

  if (!kIsWeb && Platform.isAndroid) {
    // Fix LetsEncrypt root certificate for Android<7.1
    final x1cert = await rootBundle.load('assets/ssl/isrg-root-x1.pem');
    SecurityContext.defaultContext.setTrustedCertificatesBytes(
      x1cert.buffer.asUint8List(),
    );
  }

  // Run app
  await SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[DeviceOrientation.portraitUp],
  );

  runApp(
    ProviderScope(
      observers: [
        ProvidersLogger(),
      ],
      child: const App(),
    ),
  );
}

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => AppState();
}

class AppState extends ConsumerState<App> with WidgetsBindingObserver {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    didChangeAppLifecycleStateAsync(state);
  }

  Future didChangeAppLifecycleStateAsync(AppLifecycleState state) async {
    debugPrint('Lifecycle State : $state');
    var isDeviceSecured = false;

    // Account for user changing locale when leaving the app
    switch (state) {
      case AppLifecycleState.paused:
        isDeviceSecured = await SecurityManager().isDeviceSecured();
        super.didChangeAppLifecycleState(state);
        break;
      case AppLifecycleState.resumed:
        updateDefaultLocale();
        // Value changed since last time we came in pause state
        if (isDeviceSecured != await SecurityManager().isDeviceSecured()) {
          SecurityManager().checkDeviceSecurity(
            ref,
            rootNavigatorKey.currentState!.overlay!.context,
          );
        }
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
    ref.read(LanguageProviders.defaultLocale.notifier).update(
          (state) => Localizations.localeOf(
            rootNavigatorKey.currentState!.overlay!.context,
          ),
        );
  }

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    final deeplinkRpcReceiver = sl.get<ArchethicDeeplinkRPCServer>();
    final theme = ref.watch(ThemeProviders.selectedTheme);
    final language = ref.watch(LanguageProviders.selectedLanguage);
    if (FeatureFlags.messagingActive) {
      NotificationProviders.keepPushSettingsUpToDateWorker(ref);
    }

    SystemChrome.setSystemUIOverlayStyle(
      theme.statusBar!,
    );
    return OKToast(
      textStyle: theme.textStyleSize14W700Background,
      backgroundColor: theme.background,
      child: MaterialApp(
        navigatorKey: rootNavigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Archethic Wallet',
        theme: ThemeData(
          dialogBackgroundColor: theme.backgroundDark,
          primaryColor: theme.text,
          fontFamily: theme.secondaryFont,
          brightness: theme.brightness,
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        locale: language.getLocale(),
        supportedLocales: ref.read(LanguageProviders.availableLocales),
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          if (deeplinkRpcReceiver.canHandle(settings.name)) {
            deeplinkRpcReceiver.handle(settings.name);
            return null;
          }

          final routes = <String, MaterialPageRoute>{
            '/': NoTransitionRoute<Splash>(
              builder: (_) => const Splash(),
              settings: settings,
            ),
            '/home': NoTransitionRoute<HomePage>(
              builder: (_) => const AutoLockGuard(child: HomePage()),
              settings: settings,
            ),
            '/intro_welcome': NoTransitionRoute<IntroWelcome>(
              builder: (_) => const IntroWelcome(),
              settings: settings,
            ),
            '/intro_welcome_get_first_infos':
                MaterialPageRoute<IntroNewWalletGetFirstInfos>(
              builder: (_) => const IntroNewWalletGetFirstInfos(),
              settings: settings,
            ),
            '/intro_backup': MaterialPageRoute<IntroBackupSeedPage>(
              builder: (_) => IntroBackupSeedPage(
                name: settings.arguments as String?,
              ),
              settings: settings,
            ),
            '/intro_backup_safety': MaterialPageRoute<IntroNewWalletDisclaimer>(
              builder: (_) => IntroNewWalletDisclaimer(
                name: settings.arguments as String?,
              ),
              settings: settings,
            ),
            '/intro_import': MaterialPageRoute<IntroImportSeedPage>(
              builder: (_) => const IntroImportSeedPage(),
              settings: settings,
            ),
            '/intro_backup_confirm': MaterialPageRoute<IntroBackupConfirm>(
              builder: (_) {
                final args = settings.arguments as Map<String, dynamic>? ?? {};
                return IntroBackupConfirm(
                  name: args['name'] == null ? null : args['name'] as String,
                  seed: args['seed'] == null ? null : args['seed'] as String,
                );
              },
              settings: settings,
            ),
            '/lock_screen_transition': MaterialPageRoute<AppLockScreen>(
              builder: (_) => const AppLockScreen(),
              settings: settings,
            ),
            '/nft_list_per_category': MaterialPageRoute<NFTListPerCategory>(
              builder: (_) => NFTListPerCategory(
                currentNftCategoryIndex: settings.arguments as int?,
              ),
              settings: settings,
            ),
            '/nft_creation': MaterialPageRoute(
              builder: (_) {
                final args = settings.arguments as Map<String, dynamic>? ?? {};
                return NftCreationProcessSheet(
                  currentNftCategoryIndex:
                      args['currentNftCategoryIndex'] as int,
                );
              },
              settings: settings,
            ),
            '/messenger_talk': MaterialPageRoute(
              builder: (_) =>
                  MessengerTalkPage(talkAddress: settings.arguments! as String),
            ),
          };

          /// Wraps all routes with [RPCCommandReceiver]
          /// That way, RPCCommandReceiver should never been disposed.
          final route = routes[settings.name];
          return route?.copyWith(
            builder: (context) => RPCCommandReceiver(
              child: route.builder(context),
            ),
          );
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

  Future<void> initializeProviders() async {
    await ref.read(SettingsProviders.settings.notifier).initialize();
    await ref.read(AuthenticationProviders.settings.notifier).initialize();
    if (FeatureFlags.messagingActive) {
      await ref.read(NotificationProviders.repository).initialize();
    }
  }

  Future<void> checkLoggedIn() async {
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
        _goToIntroScreen();
        return;
      }

      Navigator.of(context).pushReplacementNamed('/home');
    } catch (e, stack) {
      dev.log(e.toString(), error: e, stackTrace: stack);
      FlutterNativeSplash.remove();
      _goToIntroScreen();
    }
  }

  void _goToIntroScreen() {
    Navigator.of(context).pushReplacementNamed('/intro_welcome');
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await initializeProviders();
      await checkLoggedIn();
      await SecurityManager().checkDeviceSecurity(ref, context);
      ref.read(VersionProviders.checkCurrentVersion);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ref.read(ThemeProviders.selectedTheme).background,
    );
  }
}
