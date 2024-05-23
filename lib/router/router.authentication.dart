part of 'router.dart';

List<GoRoute> _authenticationRoutes(
  GlobalKey<NavigatorState> rootNavigatorKey,
) =>
    [
      GoRoute(
        path: LoggingOutScreen.routerPage,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
          key: state.pageKey,
          child: const LoggingOutScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        ),
      ),
      GoRoute(
        path: PasswordScreen.routerPage,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
          key: state.pageKey,
          child: PasswordScreen(
            canNavigateBack: (state.extra!
                as Map<String, dynamic>)['canNavigateBack']! as bool,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        ),
      ),
      GoRoute(
        path: PinScreen.routerPage,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
          key: state.pageKey,
          child: PinScreen(
            PinOverlayType.values.byName(
              (state.extra! as Map<String, dynamic>)['type']! as String,
            ),
            canNavigateBack:
                (state.extra! as Map<String, dynamic>)['canNavigateBack'] ==
                        null ||
                    (state.extra! as Map<String, dynamic>)['canNavigateBack']!
                        as bool,
            description:
                (state.extra! as Map<String, dynamic>)['description'] == null
                    ? ''
                    : (state.extra! as Map<String, dynamic>)['description']!
                        as String,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        ),
      ),
      GoRoute(
        path: YubikeyScreen.routerPage,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
          key: state.pageKey,
          child: YubikeyScreen(
            canNavigateBack: (state.extra!
                as Map<String, dynamic>)['canNavigateBack']! as bool,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        ),
      ),
    ];
