part of 'router.dart';

final _aeSwapRoutes = [
  GoRoute(
    path: LiquidityAddSheet.routerPage,
    pageBuilder: (context, state) {
      final pool = state.uri.queryParameters.getDecodedParameter(
        'pool',
        (json) => DexPool.fromJson(jsonDecode(json)),
      );
      return CustomTransitionPage<void>(
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        key: state.pageKey,
        child: LiquidityAddSheet(
          pool: pool!,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
    },
  ),
  GoRoute(
    path: LiquidityAddResultSheet.routerPage,
    pageBuilder: (context, state) {
      return CustomTransitionPage<void>(
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        key: state.pageKey,
        child: const LiquidityAddResultSheet(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
    },
  ),
  GoRoute(
    path: SwapConfirmFormSheet.routerPage,
    pageBuilder: (context, state) {
      return CustomTransitionPage<void>(
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        key: state.pageKey,
        child: const SwapConfirmFormSheet(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
    },
  ),
  GoRoute(
    path: SwapResultSheet.routerPage,
    pageBuilder: (context, state) {
      return CustomTransitionPage<void>(
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        key: state.pageKey,
        child: const SwapResultSheet(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
    },
  ),
  GoRoute(
    path: FarmLockDepositSheet.routerPage,
    pageBuilder: (context, state) {
      final pool = state.uri.queryParameters.getDecodedParameter(
        'pool',
        (json) => DexPool.fromJson(jsonDecode(json)),
      );
      final farmLock = state.uri.queryParameters.getDecodedParameter(
        'farmLock',
        (json) => DexFarmLock.fromJson(jsonDecode(json)),
      );
      return CustomTransitionPage<void>(
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        key: state.pageKey,
        child: FarmLockDepositSheet(
          pool: pool!,
          farmLock: farmLock!,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
    },
  ),
  GoRoute(
    path: FarmLockDepositResultSheet.routerPage,
    pageBuilder: (context, state) {
      return CustomTransitionPage<void>(
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        key: state.pageKey,
        child: const FarmLockDepositResultSheet(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
    },
  ),
  GoRoute(
    path: LiquidityRemoveSheet.routerPage,
    pageBuilder: (context, state) {
      final pool = state.uri.queryParameters.getDecodedParameter(
        'pool',
        (json) => DexPool.fromJson(jsonDecode(json)),
      );
      final pair = state.uri.queryParameters.getDecodedParameter(
        'pair',
        (json) => DexPair.fromJson(jsonDecode(json)),
      );
      final lpToken = state.uri.queryParameters.getDecodedParameter(
        'lpToken',
        (json) => DexToken.fromJson(jsonDecode(json)),
      );

      return NoTransitionPage(
        child: LiquidityRemoveSheet(
          pool: pool!,
          pair: pair!,
          lpToken: lpToken!,
        ),
      );
    },
  ),
  GoRoute(
    path: LiquidityRemoveResultSheet.routerPage,
    pageBuilder: (context, state) {
      return CustomTransitionPage<void>(
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        key: state.pageKey,
        child: const LiquidityRemoveResultSheet(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
    },
  ),
];
