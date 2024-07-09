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
        path: BiometricsScreen.routerPage,
        pageBuilder: (context, state) {
          final extra = state.extra! as Map<String, dynamic>;

          return NoTransitionPage<void>(
            key: state.pageKey,
            child: BiometricsScreen(
              challenge: extra['challenge'] as Uint8List,
            ),
          );
        },
      ),
      GoRoute(
        path: PasswordScreen.routerPage,
        pageBuilder: (context, state) {
          final extra = state.extra! as Map<String, dynamic>;
          return NoTransitionPage<void>(
            key: state.pageKey,
            child: PasswordScreen(
              canNavigateBack: extra['canNavigateBack'] as bool,
              challenge: extra['challenge'] as Uint8List,
            ),
          );
        },
      ),
      GoRoute(
        path: PinScreen.routerPage,
        pageBuilder: (context, state) {
          final extra = state.extra! as Map<String, dynamic>;

          return NoTransitionPage<void>(
            key: state.pageKey,
            child: PinScreen(
              PinOverlayType.values.byName(
                extra['type']! as String,
              ),
              canNavigateBack: extra['canNavigateBack'] == null ||
                  extra['canNavigateBack']! as bool,
              description: extra['description'] as String? ?? '',
              action: CipherDelegateAction.values.byName(extra['action']),
              challenge: extra['challenge'],
            ),
          );
        },
      ),
      GoRoute(
        path: YubikeyScreen.routerPage,
        pageBuilder: (context, state) {
          final extra = state.extra! as Map<String, dynamic>;
          return NoTransitionPage<void>(
            key: state.pageKey,
            child: YubikeyScreen(
              canNavigateBack: extra['canNavigateBack']! as bool,
              challenge: extra['challenge'] as Uint8List,
            ),
          );
        },
      ),
    ];
