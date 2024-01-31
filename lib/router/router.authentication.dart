part of 'router.dart';

List<GoRoute> _authenticationRoutes(
  GlobalKey<NavigatorState> rootNavigatorKey,
) =>
    [
      GoRoute(
        path: PasswordScreen.routerPage,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final args = state.extra! as Map<String, dynamic>;
          return PasswordScreen(
            canNavigateBack: args['canNavigateBack']! as bool,
          );
        },
      ),
      GoRoute(
        path: PinScreen.routerPage,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final args = state.extra! as Map<String, dynamic>;
          return PinScreen(
            PinOverlayType.values.byName(args['type']! as String),
            canNavigateBack: args['canNavigateBack'] == null ||
                args['canNavigateBack']! as bool,
            description: args['description'] == null
                ? ''
                : args['description']! as String,
          );
        },
      ),
      GoRoute(
        path: YubikeyScreen.routerPage,
        builder: (context, state) {
          final args = state.extra! as Map<String, dynamic>;
          return YubikeyScreen(
            canNavigateBack: args['canNavigateBack']! as bool,
          );
        },
      ),
    ];
