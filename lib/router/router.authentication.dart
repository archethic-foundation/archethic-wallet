part of 'router.dart';

List<GoRoute> get _authenticationRoutes => [
      GoRoute(
        path: LoggingOutScreen.routerPage,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const LoggingOutScreen(),
        ),
      ),
      GoRoute(
        path: SetBiometricsScreen.routerPage,
        pageBuilder: (context, state) {
          final extra = state.extra! as Map<String, dynamic>;
          return NoTransitionPage<Uint8List>(
            child: SetBiometricsScreen(
              challenge: extra['challenge'] as Uint8List,
            ),
          );
        },
      ),
      GoRoute(
        path: SetPassword.routerPage,
        pageBuilder: (context, state) {
          final extra = state.extra! as Map<String, dynamic>;
          return NoTransitionPage<Uint8List>(
            key: state.pageKey,
            child: SetPassword(
              header: extra['header'] as String?,
              description: extra['description'] as String?,
              challenge: extra['challenge'] as Uint8List,
            ),
          );
        },
      ),
      GoRoute(
        path: SetYubikey.routerPage,
        pageBuilder: (context, state) {
          final extra = state.extra! as Map<String, dynamic>;
          return NoTransitionPage<void>(
            key: state.pageKey,
            child: SetYubikey(
              challenge: extra['challenge'] as Uint8List,
            ),
          );
        },
      ),
    ];
