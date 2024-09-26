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
    path: FarmLockClaimSheet.routerPage,
    pageBuilder: (context, state) {
      final farmAddress = state.uri.queryParameters
          .getDecodedParameter('farmAddress', jsonDecode);
      final rewardToken = state.uri.queryParameters.getDecodedParameter(
        'rewardToken',
        (json) => DexToken.fromJson(jsonDecode(json)),
      );
      final lpTokenAddress = state.uri.queryParameters
          .getDecodedParameter('lpTokenAddress', jsonDecode);
      final rewardAmount = state.uri.queryParameters
          .getDecodedParameter('rewardAmount', jsonDecode);
      final depositId = state.uri.queryParameters
          .getDecodedParameter('depositId', jsonDecode);

      return CustomTransitionPage<void>(
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        key: state.pageKey,
        child: FarmLockClaimSheet(
          farmAddress: farmAddress,
          rewardToken: rewardToken!,
          lpTokenAddress: lpTokenAddress,
          rewardAmount: rewardAmount,
          depositId: depositId,
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
    path: FarmLockWithdrawSheet.routerPage,
    pageBuilder: (context, state) {
      final farmAddress = state.uri.queryParameters
          .getDecodedParameter('farmAddress', jsonDecode);
      final poolAddress = state.uri.queryParameters
          .getDecodedParameter('poolAddress', jsonDecode);
      final rewardToken = state.uri.queryParameters.getDecodedParameter(
        'rewardToken',
        (json) => DexToken.fromJson(jsonDecode(json)),
      );
      final lpToken = state.uri.queryParameters.getDecodedParameter(
        'lpToken',
        (json) => DexToken.fromJson(jsonDecode(json)),
      );
      final lpTokenPair = state.uri.queryParameters.getDecodedParameter(
        'lpTokenPair',
        (json) => DexPair.fromJson(jsonDecode(json)),
      );
      final rewardAmount = state.uri.queryParameters
          .getDecodedParameter('rewardAmount', jsonDecode);
      final depositedAmount = state.uri.queryParameters
          .getDecodedParameter('depositedAmount', jsonDecode);
      final depositId = state.uri.queryParameters
          .getDecodedParameter('depositId', jsonDecode);
      final endDate =
          state.uri.queryParameters.getDecodedParameter('endDate', jsonDecode);

      return CustomTransitionPage<void>(
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        key: state.pageKey,
        child: FarmLockWithdrawSheet(
          farmAddress: farmAddress,
          poolAddress: poolAddress,
          rewardToken: rewardToken!,
          lpToken: lpToken!,
          lpTokenPair: lpTokenPair!,
          endDate: DateTime.fromMillisecondsSinceEpoch(
            endDate * 1000,
          ),
          rewardAmount: rewardAmount,
          depositId: depositId,
          depositedAmount: depositedAmount,
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
    path: FarmLockLevelUpSheet.routerPage,
    pageBuilder: (context, state) {
      final pool = state.uri.queryParameters.getDecodedParameter(
        'pool',
        (json) => DexPool.fromJson(jsonDecode(json)),
      );
      final farmLock = state.uri.queryParameters.getDecodedParameter(
        'farmLock',
        (json) => DexFarmLock.fromJson(jsonDecode(json)),
      );
      final depositId = state.uri.queryParameters.getDecodedParameter(
        'depositId',
        jsonDecode,
      );
      final currentLevel = state.uri.queryParameters.getDecodedParameter(
        'currentLevel',
        jsonDecode,
      );
      final lpAmount = state.uri.queryParameters.getDecodedParameter(
        'lpAmount',
        jsonDecode,
      );
      final rewardAmount = state.uri.queryParameters.getDecodedParameter(
        'rewardAmount',
        jsonDecode,
      );

      return CustomTransitionPage<void>(
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        key: state.pageKey,
        child: FarmLockLevelUpSheet(
          pool: pool!,
          farmLock: farmLock!,
          depositId: depositId,
          currentLevel: currentLevel,
          lpAmount: lpAmount,
          rewardAmount: rewardAmount,
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
