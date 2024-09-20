import 'package:flutter/widgets.dart';

enum DexActionType {
  swap,
  addLiquidity,
  removeLiquidity,
  claimFarm,
  claimFarmLock,
  depositFarm,
  depositFarmLock,
  levelUpFarmLock,
  withdrawFarm,
  withdrawFarmLock,
  addPool
}

extension DexActionTypeExtension on DexActionType {
  String getLabel(BuildContext context) {
    switch (this) {
      case DexActionType.swap:
        return 'Swap';
      case DexActionType.addLiquidity:
        return 'Add liquidity';
      case DexActionType.removeLiquidity:
        return 'Remove liquidity';
      case DexActionType.claimFarm:
        return 'Claim';
      case DexActionType.claimFarmLock:
        return 'Claim';
      case DexActionType.depositFarm:
        return 'Deposit';
      case DexActionType.depositFarmLock:
        return 'Deposit';
      case DexActionType.levelUpFarmLock:
        return 'Level Up';
      case DexActionType.withdrawFarm:
        return 'Withdraw';
      case DexActionType.withdrawFarmLock:
        return 'Withdraw';
      case DexActionType.addPool:
        return 'Add Pool';
    }
  }
}
