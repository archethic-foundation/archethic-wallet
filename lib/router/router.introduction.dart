part of 'router.dart';

final _introductionRoutes = [
  GoRoute(
    path: IntroConfigureSecurity.routerPage,
    builder: (context, state) {
      final args = state.extra! as Map<String, dynamic>;
      return IntroConfigureSecurity(
        seed: args['seed']! as String,
        name: args['name']! as String,
      );
    },
  ),
  GoRoute(
    path: IntroWelcome.routerPage,
    builder: (context, state) => const IntroWelcome(),
  ),
  GoRoute(
    path: IntroNewWalletGetFirstInfos.routerPage,
    builder: (context, state) => const IntroNewWalletGetFirstInfos(),
  ),
  GoRoute(
    path: IntroBackupSeedPage.routerPage,
    builder: (context, state) {
      final args = state.extra! as String;
      return IntroBackupSeedPage(
        name: args,
      );
    },
  ),
  GoRoute(
    path: IntroNewWalletDisclaimer.routerPage,
    builder: (context, state) {
      final args = state.extra! as String;
      return IntroNewWalletDisclaimer(
        name: args,
      );
    },
  ),
  GoRoute(
    path: IntroImportSeedPage.routerPage,
    builder: (context, state) => const IntroImportSeedPage(),
  ),
  GoRoute(
    path: IntroBackupConfirm.routerPage,
    builder: (context, state) {
      final args = state.extra! as Map<String, dynamic>;
      return IntroBackupConfirm(
        name: args['name'] == null ? null : args['name']! as String,
        seed: args['seed'] == null ? null : args['seed']! as String,
        welcomeProcess:
            args['welcomeProcess'] == null || args['welcomeProcess']! as bool,
      );
    },
  ),
];
