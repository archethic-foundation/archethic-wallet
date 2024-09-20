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
];
