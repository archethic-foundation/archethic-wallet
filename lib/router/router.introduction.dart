part of 'router.dart';

final _introductionRoutes = [
  GoRoute(
    path: IntroConfigureSecurity.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: IntroConfigureSecurity(
        isImportProfile:
            (state.extra! as Map<String, dynamic>)['isImportProfile']! as bool,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    ),
  ),
  GoRoute(
    path: IntroWelcome.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: const IntroWelcome(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    ),
  ),
  GoRoute(
    path: IntroNewWalletGetFirstInfos.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: const IntroNewWalletGetFirstInfos(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    ),
  ),
  GoRoute(
    path: IntroBackupSeedPage.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: IntroBackupSeedPage(
        name: state.extra! as String,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    ),
  ),
  GoRoute(
    path: IntroNewWalletDisclaimer.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: IntroNewWalletDisclaimer(
        name: state.extra! as String,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    ),
  ),
  GoRoute(
    path: IntroImportSeedPage.routerPage,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      key: state.pageKey,
      child: const IntroImportSeedPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    ),
  ),
  GoRoute(
    path: IntroBackupConfirm.routerPage,
    pageBuilder: (context, state) => NoTransitionPage<void>(
      key: state.pageKey,
      child: IntroBackupConfirm(
        name: (state.extra! as Map<String, dynamic>)['name'] == null
            ? null
            : (state.extra! as Map<String, dynamic>)['name']! as String,
        seed: (state.extra! as Map<String, dynamic>)['seed'] == null
            ? null
            : (state.extra! as Map<String, dynamic>)['seed']! as String,
        welcomeProcess:
            (state.extra! as Map<String, dynamic>)['welcomeProcess'] == null ||
                (state.extra! as Map<String, dynamic>)['welcomeProcess']!
                    as bool,
      ),
    ),
  ),
  GoRoute(
    path: NetworkDialog.routerPage,
    pageBuilder: (context, state) => DialogPage<NetworksSetting>(
      barrierDismissible: false,
      builder: (BuildContext context) => const NetworkDialog(),
    ),
  ),
];
