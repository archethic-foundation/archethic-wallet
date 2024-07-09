/// SPDX-License-Identifier: AGPL-3.0-or-later

import 'dart:async';
import 'dart:io';

import 'package:aewallet/application/authentication/authentication.dart';
import 'package:aewallet/application/migrations/migration_manager.dart';
import 'package:aewallet/application/notification/providers.dart';
import 'package:aewallet/application/oracle/provider.dart';
import 'package:aewallet/application/session/session.dart';
import 'package:aewallet/application/settings/language.dart';
import 'package:aewallet/application/settings/settings.dart';
import 'package:aewallet/application/verified_tokens.dart';
import 'package:aewallet/domain/repositories/features_flags.dart';
import 'package:aewallet/infrastructure/datasources/appdb.hive.dart';
import 'package:aewallet/model/available_language.dart';
import 'package:aewallet/providers_observer.dart';
import 'package:aewallet/router/router.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/themes/styles.dart';
import 'package:aewallet/ui/views/authenticate/auth_factory.dart';
import 'package:aewallet/ui/views/authenticate/auto_lock_guard.dart';
import 'package:aewallet/ui/views/intro/layouts/intro_welcome.dart';
import 'package:aewallet/ui/views/main/home_page.dart';
import 'package:aewallet/ui/widgets/components/limited_width_layout.dart';
import 'package:aewallet/ui/widgets/components/sheet_skeleton.dart';
import 'package:aewallet/ui/widgets/components/window_size.dart';
import 'package:aewallet/util/security_manager.dart';
import 'package:aewallet/util/service_locator.dart';
import 'package:aewallet/util/universal_platform.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:oktoast/oktoast.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await DBHelper.setupDatabase();
  await setupServiceLocator();

  if (UniversalPlatform.isDesktop) {
    await windowManager.ensureInitialized();

    final idealSize = WindowSize().idealSize;

    final windowOptions = WindowOptions(
      size: idealSize,
      center: false,
      maximumSize: idealSize,
      backgroundColor: Colors.transparent,
      fullScreen: false,
      title: 'Archethic Wallet',
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
    );

    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      // https://github.com/leanflutter/window_manager/issues/238
      if (UniversalPlatform.isLinux) {
        await windowManager.setResizable(true);
      } else {
        await windowManager.setResizable(false);
      }

      // ignore: cascade_invocations
      if (UniversalPlatform.isWindows) {
        await windowManager.setMaximizable(false);
      }
      await windowManager.show();
      await windowManager.focus();
    });
  }

  if (UniversalPlatform.isAndroid) {
    // Fix LetsEncrypt root certificate for Android<7.1
    final x1cert = await rootBundle.load('assets/ssl/isrg-root-x1.pem');
    SecurityContext.defaultContext.setTrustedCertificatesBytes(
      x1cert.buffer.asUint8List(),
    );
    final r3cert = await rootBundle.load('assets/ssl/r3.pem');
    SecurityContext.defaultContext.setTrustedCertificatesBytes(
      r3cert.buffer.asUint8List(),
    );
  }

  // Run app
  if (!kIsWeb) {
    await SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[DeviceOrientation.portraitUp],
    );
  }
  FlutterNativeSplash.remove();

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
  final router = RoutesPath(rootNavigatorKey).createRouter();
  final _logger = Logger('AppWidget');

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

  Future<void> didChangeAppLifecycleStateAsync(AppLifecycleState state) async {
    _logger.info('Lifecycle State : $state');
    var isDeviceSecured = false;
    ref.invalidate(ArchethicOracleUCOProviders.archethicOracleUCO);
    await ref
        .read(ArchethicOracleUCOProviders.archethicOracleUCO.notifier)
        .init();
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
          await SecurityManager().checkDeviceSecurity(
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
      case AppLifecycleState.hidden:
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
    final language = ref.watch(LanguageProviders.selectedLanguage);
    if (FeatureFlags.messagingActive) {
      NotificationProviders.keepPushSettingsUpToDateWorker(ref);
    }

    SystemChrome.setSystemUIOverlayStyle(
      ArchethicTheme.statusBar,
    );

    return LimitedWidthLayout(
      child: GestureDetector(
        onTap: () {
          // Hide soft input keyboard after tapping outside anywhere on screen
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: OKToast(
          textStyle: ArchethicThemeStyles.textStyleSize14W700Background,
          backgroundColor: ArchethicTheme.background,
          child: MaterialApp.router(
            routerConfig: router,
            debugShowCheckedModeBanner: false,
            title: 'Archethic Wallet',
            theme: ThemeData(
              brightness: Brightness.dark,
              fontFamily: 'PPTelegraf',
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              fontFamily: 'PPTelegraf',
              useMaterial3: true,
            ),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            locale: language.getLocale(),
            supportedLocales: ref.read(LanguageProviders.availableLocales),
          ),
        ),
      ),
    );
  }
}

/// Splash
/// Default page route that determines if user is logged in
/// and routes them appropriately.
class Splash extends ConsumerStatefulWidget {
  const Splash({super.key});

  static const routerPage = '/';

  @override
  ConsumerState<Splash> createState() => SplashState();
}

class SplashState extends ConsumerState<Splash> with WidgetsBindingObserver {
  final _logger = Logger('SplashState');

  Future<void> initializeProviders() async {
    await ref
        .read(LocalDataMigrationProviders.localDataMigration.notifier)
        .migrateLocalData();

    final locale = ref.read(LanguageProviders.selectedLocale);
    await ref.read(SettingsProviders.settings.notifier).initialize(locale);
    await ref.read(AuthenticationProviders.settings.notifier).initialize();
    if (FeatureFlags.messagingActive) {
      await ref.read(NotificationProviders.repository).initialize();
    }
    await ref
        .read(
          VerifiedTokensProviders.verifiedTokens.notifier,
        )
        .init();
    await SecurityManager().checkDeviceSecurity(ref, context);

    AuthFactory.of(context).init();
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

      if (FeatureFlags.forceLogout) {
        await ref.read(SessionProviders.session.notifier).logout();

        context.go(IntroWelcome.routerPage);
        return;
      }

      await ref.read(SessionProviders.session.notifier).restore();

      final session = ref.read(SessionProviders.session);

      if (session.isLoggedOut) {
        context.go(IntroWelcome.routerPage);
        return;
      }
      await ref
          .read(ArchethicOracleUCOProviders.archethicOracleUCO.notifier)
          .init();

      context.go(HomePage.routerPage);
    } catch (e, stack) {
      _logger.severe(e.toString(), e, stack);
      context.go(IntroWelcome.routerPage);
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await initializeProviders();
      await checkLoggedIn();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AutoLockGuard(
      child: SheetSkeleton(
        appBar: AppBar(),
        menu: true,
        sheetContent: const SizedBox.shrink(),
      ),
    );
  }
}
