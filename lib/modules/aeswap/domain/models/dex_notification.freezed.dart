// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dex_notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DexNotification {
  DexActionType get actionType => throw _privateConstructorUsedError;
  String? get txAddress => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)
        swap,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)
        addLiquidity,
    required TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)
        removeLiquidity,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)
        claimFarm,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)
        depositFarm,
    required TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)
        withdrawFarm,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)
        depositFarmLock,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)
        levelUpFarmLock,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)
        claimFarmLock,
    required TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)
        withdrawFarmLock,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)?
        swap,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)?
        addLiquidity,
    TResult? Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)?
        removeLiquidity,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarm,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarm,
    TResult? Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarm,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarmLock,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        levelUpFarmLock,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarmLock,
    TResult? Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarmLock,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)?
        swap,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)?
        addLiquidity,
    TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)?
        removeLiquidity,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarm,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarm,
    TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarm,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarmLock,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        levelUpFarmLock,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarmLock,
    TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarmLock,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DexNotificationSwap value) swap,
    required TResult Function(_DexNotificationAddLiquidity value) addLiquidity,
    required TResult Function(_DexNotificationRemoveLiquidity value)
        removeLiquidity,
    required TResult Function(_DexNotificationClaimFarm value) claimFarm,
    required TResult Function(_DexNotificationDepositFarm value) depositFarm,
    required TResult Function(_DexNotificationWithdrawFarm value) withdrawFarm,
    required TResult Function(_DexNotificationDepositFarmLock value)
        depositFarmLock,
    required TResult Function(_DexNotificationLevelUpFarmLock value)
        levelUpFarmLock,
    required TResult Function(_DexNotificationClaimLockFarm value)
        claimFarmLock,
    required TResult Function(_DexNotificationWithdrawFarmLock value)
        withdrawFarmLock,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DexNotificationSwap value)? swap,
    TResult? Function(_DexNotificationAddLiquidity value)? addLiquidity,
    TResult? Function(_DexNotificationRemoveLiquidity value)? removeLiquidity,
    TResult? Function(_DexNotificationClaimFarm value)? claimFarm,
    TResult? Function(_DexNotificationDepositFarm value)? depositFarm,
    TResult? Function(_DexNotificationWithdrawFarm value)? withdrawFarm,
    TResult? Function(_DexNotificationDepositFarmLock value)? depositFarmLock,
    TResult? Function(_DexNotificationLevelUpFarmLock value)? levelUpFarmLock,
    TResult? Function(_DexNotificationClaimLockFarm value)? claimFarmLock,
    TResult? Function(_DexNotificationWithdrawFarmLock value)? withdrawFarmLock,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DexNotificationSwap value)? swap,
    TResult Function(_DexNotificationAddLiquidity value)? addLiquidity,
    TResult Function(_DexNotificationRemoveLiquidity value)? removeLiquidity,
    TResult Function(_DexNotificationClaimFarm value)? claimFarm,
    TResult Function(_DexNotificationDepositFarm value)? depositFarm,
    TResult Function(_DexNotificationWithdrawFarm value)? withdrawFarm,
    TResult Function(_DexNotificationDepositFarmLock value)? depositFarmLock,
    TResult Function(_DexNotificationLevelUpFarmLock value)? levelUpFarmLock,
    TResult Function(_DexNotificationClaimLockFarm value)? claimFarmLock,
    TResult Function(_DexNotificationWithdrawFarmLock value)? withdrawFarmLock,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DexNotificationCopyWith<DexNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DexNotificationCopyWith<$Res> {
  factory $DexNotificationCopyWith(
          DexNotification value, $Res Function(DexNotification) then) =
      _$DexNotificationCopyWithImpl<$Res, DexNotification>;
  @useResult
  $Res call({DexActionType actionType, String? txAddress});
}

/// @nodoc
class _$DexNotificationCopyWithImpl<$Res, $Val extends DexNotification>
    implements $DexNotificationCopyWith<$Res> {
  _$DexNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actionType = null,
    Object? txAddress = freezed,
  }) {
    return _then(_value.copyWith(
      actionType: null == actionType
          ? _value.actionType
          : actionType // ignore: cast_nullable_to_non_nullable
              as DexActionType,
      txAddress: freezed == txAddress
          ? _value.txAddress
          : txAddress // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DexNotificationSwapImplCopyWith<$Res>
    implements $DexNotificationCopyWith<$Res> {
  factory _$$DexNotificationSwapImplCopyWith(_$DexNotificationSwapImpl value,
          $Res Function(_$DexNotificationSwapImpl) then) =
      __$$DexNotificationSwapImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DexActionType actionType,
      String? txAddress,
      double? amountSwapped,
      DexToken? tokenSwapped});

  $DexTokenCopyWith<$Res>? get tokenSwapped;
}

/// @nodoc
class __$$DexNotificationSwapImplCopyWithImpl<$Res>
    extends _$DexNotificationCopyWithImpl<$Res, _$DexNotificationSwapImpl>
    implements _$$DexNotificationSwapImplCopyWith<$Res> {
  __$$DexNotificationSwapImplCopyWithImpl(_$DexNotificationSwapImpl _value,
      $Res Function(_$DexNotificationSwapImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actionType = null,
    Object? txAddress = freezed,
    Object? amountSwapped = freezed,
    Object? tokenSwapped = freezed,
  }) {
    return _then(_$DexNotificationSwapImpl(
      actionType: null == actionType
          ? _value.actionType
          : actionType // ignore: cast_nullable_to_non_nullable
              as DexActionType,
      txAddress: freezed == txAddress
          ? _value.txAddress
          : txAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      amountSwapped: freezed == amountSwapped
          ? _value.amountSwapped
          : amountSwapped // ignore: cast_nullable_to_non_nullable
              as double?,
      tokenSwapped: freezed == tokenSwapped
          ? _value.tokenSwapped
          : tokenSwapped // ignore: cast_nullable_to_non_nullable
              as DexToken?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $DexTokenCopyWith<$Res>? get tokenSwapped {
    if (_value.tokenSwapped == null) {
      return null;
    }

    return $DexTokenCopyWith<$Res>(_value.tokenSwapped!, (value) {
      return _then(_value.copyWith(tokenSwapped: value));
    });
  }
}

/// @nodoc

class _$DexNotificationSwapImpl extends _DexNotificationSwap {
  const _$DexNotificationSwapImpl(
      {this.actionType = DexActionType.swap,
      this.txAddress,
      this.amountSwapped,
      this.tokenSwapped})
      : super._();

  @override
  @JsonKey()
  final DexActionType actionType;
  @override
  final String? txAddress;
  @override
  final double? amountSwapped;
  @override
  final DexToken? tokenSwapped;

  @override
  String toString() {
    return 'DexNotification.swap(actionType: $actionType, txAddress: $txAddress, amountSwapped: $amountSwapped, tokenSwapped: $tokenSwapped)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DexNotificationSwapImpl &&
            (identical(other.actionType, actionType) ||
                other.actionType == actionType) &&
            (identical(other.txAddress, txAddress) ||
                other.txAddress == txAddress) &&
            (identical(other.amountSwapped, amountSwapped) ||
                other.amountSwapped == amountSwapped) &&
            (identical(other.tokenSwapped, tokenSwapped) ||
                other.tokenSwapped == tokenSwapped));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, actionType, txAddress, amountSwapped, tokenSwapped);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DexNotificationSwapImplCopyWith<_$DexNotificationSwapImpl> get copyWith =>
      __$$DexNotificationSwapImplCopyWithImpl<_$DexNotificationSwapImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)
        swap,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)
        addLiquidity,
    required TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)
        removeLiquidity,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)
        claimFarm,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)
        depositFarm,
    required TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)
        withdrawFarm,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)
        depositFarmLock,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)
        levelUpFarmLock,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)
        claimFarmLock,
    required TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)
        withdrawFarmLock,
  }) {
    return swap(actionType, txAddress, amountSwapped, tokenSwapped);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)?
        swap,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)?
        addLiquidity,
    TResult? Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)?
        removeLiquidity,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarm,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarm,
    TResult? Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarm,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarmLock,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        levelUpFarmLock,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarmLock,
    TResult? Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarmLock,
  }) {
    return swap?.call(actionType, txAddress, amountSwapped, tokenSwapped);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)?
        swap,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)?
        addLiquidity,
    TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)?
        removeLiquidity,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarm,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarm,
    TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarm,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarmLock,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        levelUpFarmLock,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarmLock,
    TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarmLock,
    required TResult orElse(),
  }) {
    if (swap != null) {
      return swap(actionType, txAddress, amountSwapped, tokenSwapped);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DexNotificationSwap value) swap,
    required TResult Function(_DexNotificationAddLiquidity value) addLiquidity,
    required TResult Function(_DexNotificationRemoveLiquidity value)
        removeLiquidity,
    required TResult Function(_DexNotificationClaimFarm value) claimFarm,
    required TResult Function(_DexNotificationDepositFarm value) depositFarm,
    required TResult Function(_DexNotificationWithdrawFarm value) withdrawFarm,
    required TResult Function(_DexNotificationDepositFarmLock value)
        depositFarmLock,
    required TResult Function(_DexNotificationLevelUpFarmLock value)
        levelUpFarmLock,
    required TResult Function(_DexNotificationClaimLockFarm value)
        claimFarmLock,
    required TResult Function(_DexNotificationWithdrawFarmLock value)
        withdrawFarmLock,
  }) {
    return swap(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DexNotificationSwap value)? swap,
    TResult? Function(_DexNotificationAddLiquidity value)? addLiquidity,
    TResult? Function(_DexNotificationRemoveLiquidity value)? removeLiquidity,
    TResult? Function(_DexNotificationClaimFarm value)? claimFarm,
    TResult? Function(_DexNotificationDepositFarm value)? depositFarm,
    TResult? Function(_DexNotificationWithdrawFarm value)? withdrawFarm,
    TResult? Function(_DexNotificationDepositFarmLock value)? depositFarmLock,
    TResult? Function(_DexNotificationLevelUpFarmLock value)? levelUpFarmLock,
    TResult? Function(_DexNotificationClaimLockFarm value)? claimFarmLock,
    TResult? Function(_DexNotificationWithdrawFarmLock value)? withdrawFarmLock,
  }) {
    return swap?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DexNotificationSwap value)? swap,
    TResult Function(_DexNotificationAddLiquidity value)? addLiquidity,
    TResult Function(_DexNotificationRemoveLiquidity value)? removeLiquidity,
    TResult Function(_DexNotificationClaimFarm value)? claimFarm,
    TResult Function(_DexNotificationDepositFarm value)? depositFarm,
    TResult Function(_DexNotificationWithdrawFarm value)? withdrawFarm,
    TResult Function(_DexNotificationDepositFarmLock value)? depositFarmLock,
    TResult Function(_DexNotificationLevelUpFarmLock value)? levelUpFarmLock,
    TResult Function(_DexNotificationClaimLockFarm value)? claimFarmLock,
    TResult Function(_DexNotificationWithdrawFarmLock value)? withdrawFarmLock,
    required TResult orElse(),
  }) {
    if (swap != null) {
      return swap(this);
    }
    return orElse();
  }
}

abstract class _DexNotificationSwap extends DexNotification {
  const factory _DexNotificationSwap(
      {final DexActionType actionType,
      final String? txAddress,
      final double? amountSwapped,
      final DexToken? tokenSwapped}) = _$DexNotificationSwapImpl;
  const _DexNotificationSwap._() : super._();

  @override
  DexActionType get actionType;
  @override
  String? get txAddress;
  double? get amountSwapped;
  DexToken? get tokenSwapped;
  @override
  @JsonKey(ignore: true)
  _$$DexNotificationSwapImplCopyWith<_$DexNotificationSwapImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DexNotificationAddLiquidityImplCopyWith<$Res>
    implements $DexNotificationCopyWith<$Res> {
  factory _$$DexNotificationAddLiquidityImplCopyWith(
          _$DexNotificationAddLiquidityImpl value,
          $Res Function(_$DexNotificationAddLiquidityImpl) then) =
      __$$DexNotificationAddLiquidityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DexActionType actionType,
      String? txAddress,
      double? amount,
      DexToken? lpToken});

  $DexTokenCopyWith<$Res>? get lpToken;
}

/// @nodoc
class __$$DexNotificationAddLiquidityImplCopyWithImpl<$Res>
    extends _$DexNotificationCopyWithImpl<$Res,
        _$DexNotificationAddLiquidityImpl>
    implements _$$DexNotificationAddLiquidityImplCopyWith<$Res> {
  __$$DexNotificationAddLiquidityImplCopyWithImpl(
      _$DexNotificationAddLiquidityImpl _value,
      $Res Function(_$DexNotificationAddLiquidityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actionType = null,
    Object? txAddress = freezed,
    Object? amount = freezed,
    Object? lpToken = freezed,
  }) {
    return _then(_$DexNotificationAddLiquidityImpl(
      actionType: null == actionType
          ? _value.actionType
          : actionType // ignore: cast_nullable_to_non_nullable
              as DexActionType,
      txAddress: freezed == txAddress
          ? _value.txAddress
          : txAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      lpToken: freezed == lpToken
          ? _value.lpToken
          : lpToken // ignore: cast_nullable_to_non_nullable
              as DexToken?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $DexTokenCopyWith<$Res>? get lpToken {
    if (_value.lpToken == null) {
      return null;
    }

    return $DexTokenCopyWith<$Res>(_value.lpToken!, (value) {
      return _then(_value.copyWith(lpToken: value));
    });
  }
}

/// @nodoc

class _$DexNotificationAddLiquidityImpl extends _DexNotificationAddLiquidity {
  const _$DexNotificationAddLiquidityImpl(
      {this.actionType = DexActionType.addLiquidity,
      this.txAddress,
      this.amount,
      this.lpToken})
      : super._();

  @override
  @JsonKey()
  final DexActionType actionType;
  @override
  final String? txAddress;
  @override
  final double? amount;
  @override
  final DexToken? lpToken;

  @override
  String toString() {
    return 'DexNotification.addLiquidity(actionType: $actionType, txAddress: $txAddress, amount: $amount, lpToken: $lpToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DexNotificationAddLiquidityImpl &&
            (identical(other.actionType, actionType) ||
                other.actionType == actionType) &&
            (identical(other.txAddress, txAddress) ||
                other.txAddress == txAddress) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.lpToken, lpToken) || other.lpToken == lpToken));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, actionType, txAddress, amount, lpToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DexNotificationAddLiquidityImplCopyWith<_$DexNotificationAddLiquidityImpl>
      get copyWith => __$$DexNotificationAddLiquidityImplCopyWithImpl<
          _$DexNotificationAddLiquidityImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)
        swap,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)
        addLiquidity,
    required TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)
        removeLiquidity,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)
        claimFarm,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)
        depositFarm,
    required TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)
        withdrawFarm,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)
        depositFarmLock,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)
        levelUpFarmLock,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)
        claimFarmLock,
    required TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)
        withdrawFarmLock,
  }) {
    return addLiquidity(actionType, txAddress, amount, lpToken);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)?
        swap,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)?
        addLiquidity,
    TResult? Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)?
        removeLiquidity,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarm,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarm,
    TResult? Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarm,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarmLock,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        levelUpFarmLock,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarmLock,
    TResult? Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarmLock,
  }) {
    return addLiquidity?.call(actionType, txAddress, amount, lpToken);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)?
        swap,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)?
        addLiquidity,
    TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)?
        removeLiquidity,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarm,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarm,
    TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarm,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarmLock,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        levelUpFarmLock,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarmLock,
    TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarmLock,
    required TResult orElse(),
  }) {
    if (addLiquidity != null) {
      return addLiquidity(actionType, txAddress, amount, lpToken);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DexNotificationSwap value) swap,
    required TResult Function(_DexNotificationAddLiquidity value) addLiquidity,
    required TResult Function(_DexNotificationRemoveLiquidity value)
        removeLiquidity,
    required TResult Function(_DexNotificationClaimFarm value) claimFarm,
    required TResult Function(_DexNotificationDepositFarm value) depositFarm,
    required TResult Function(_DexNotificationWithdrawFarm value) withdrawFarm,
    required TResult Function(_DexNotificationDepositFarmLock value)
        depositFarmLock,
    required TResult Function(_DexNotificationLevelUpFarmLock value)
        levelUpFarmLock,
    required TResult Function(_DexNotificationClaimLockFarm value)
        claimFarmLock,
    required TResult Function(_DexNotificationWithdrawFarmLock value)
        withdrawFarmLock,
  }) {
    return addLiquidity(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DexNotificationSwap value)? swap,
    TResult? Function(_DexNotificationAddLiquidity value)? addLiquidity,
    TResult? Function(_DexNotificationRemoveLiquidity value)? removeLiquidity,
    TResult? Function(_DexNotificationClaimFarm value)? claimFarm,
    TResult? Function(_DexNotificationDepositFarm value)? depositFarm,
    TResult? Function(_DexNotificationWithdrawFarm value)? withdrawFarm,
    TResult? Function(_DexNotificationDepositFarmLock value)? depositFarmLock,
    TResult? Function(_DexNotificationLevelUpFarmLock value)? levelUpFarmLock,
    TResult? Function(_DexNotificationClaimLockFarm value)? claimFarmLock,
    TResult? Function(_DexNotificationWithdrawFarmLock value)? withdrawFarmLock,
  }) {
    return addLiquidity?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DexNotificationSwap value)? swap,
    TResult Function(_DexNotificationAddLiquidity value)? addLiquidity,
    TResult Function(_DexNotificationRemoveLiquidity value)? removeLiquidity,
    TResult Function(_DexNotificationClaimFarm value)? claimFarm,
    TResult Function(_DexNotificationDepositFarm value)? depositFarm,
    TResult Function(_DexNotificationWithdrawFarm value)? withdrawFarm,
    TResult Function(_DexNotificationDepositFarmLock value)? depositFarmLock,
    TResult Function(_DexNotificationLevelUpFarmLock value)? levelUpFarmLock,
    TResult Function(_DexNotificationClaimLockFarm value)? claimFarmLock,
    TResult Function(_DexNotificationWithdrawFarmLock value)? withdrawFarmLock,
    required TResult orElse(),
  }) {
    if (addLiquidity != null) {
      return addLiquidity(this);
    }
    return orElse();
  }
}

abstract class _DexNotificationAddLiquidity extends DexNotification {
  const factory _DexNotificationAddLiquidity(
      {final DexActionType actionType,
      final String? txAddress,
      final double? amount,
      final DexToken? lpToken}) = _$DexNotificationAddLiquidityImpl;
  const _DexNotificationAddLiquidity._() : super._();

  @override
  DexActionType get actionType;
  @override
  String? get txAddress;
  double? get amount;
  DexToken? get lpToken;
  @override
  @JsonKey(ignore: true)
  _$$DexNotificationAddLiquidityImplCopyWith<_$DexNotificationAddLiquidityImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DexNotificationRemoveLiquidityImplCopyWith<$Res>
    implements $DexNotificationCopyWith<$Res> {
  factory _$$DexNotificationRemoveLiquidityImplCopyWith(
          _$DexNotificationRemoveLiquidityImpl value,
          $Res Function(_$DexNotificationRemoveLiquidityImpl) then) =
      __$$DexNotificationRemoveLiquidityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DexActionType actionType,
      String? txAddress,
      double? amountToken1,
      double? amountToken2,
      double? amountLPToken,
      DexToken? token1,
      DexToken? token2,
      DexToken? lpToken});

  $DexTokenCopyWith<$Res>? get token1;
  $DexTokenCopyWith<$Res>? get token2;
  $DexTokenCopyWith<$Res>? get lpToken;
}

/// @nodoc
class __$$DexNotificationRemoveLiquidityImplCopyWithImpl<$Res>
    extends _$DexNotificationCopyWithImpl<$Res,
        _$DexNotificationRemoveLiquidityImpl>
    implements _$$DexNotificationRemoveLiquidityImplCopyWith<$Res> {
  __$$DexNotificationRemoveLiquidityImplCopyWithImpl(
      _$DexNotificationRemoveLiquidityImpl _value,
      $Res Function(_$DexNotificationRemoveLiquidityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actionType = null,
    Object? txAddress = freezed,
    Object? amountToken1 = freezed,
    Object? amountToken2 = freezed,
    Object? amountLPToken = freezed,
    Object? token1 = freezed,
    Object? token2 = freezed,
    Object? lpToken = freezed,
  }) {
    return _then(_$DexNotificationRemoveLiquidityImpl(
      actionType: null == actionType
          ? _value.actionType
          : actionType // ignore: cast_nullable_to_non_nullable
              as DexActionType,
      txAddress: freezed == txAddress
          ? _value.txAddress
          : txAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      amountToken1: freezed == amountToken1
          ? _value.amountToken1
          : amountToken1 // ignore: cast_nullable_to_non_nullable
              as double?,
      amountToken2: freezed == amountToken2
          ? _value.amountToken2
          : amountToken2 // ignore: cast_nullable_to_non_nullable
              as double?,
      amountLPToken: freezed == amountLPToken
          ? _value.amountLPToken
          : amountLPToken // ignore: cast_nullable_to_non_nullable
              as double?,
      token1: freezed == token1
          ? _value.token1
          : token1 // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      token2: freezed == token2
          ? _value.token2
          : token2 // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      lpToken: freezed == lpToken
          ? _value.lpToken
          : lpToken // ignore: cast_nullable_to_non_nullable
              as DexToken?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $DexTokenCopyWith<$Res>? get token1 {
    if (_value.token1 == null) {
      return null;
    }

    return $DexTokenCopyWith<$Res>(_value.token1!, (value) {
      return _then(_value.copyWith(token1: value));
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DexTokenCopyWith<$Res>? get token2 {
    if (_value.token2 == null) {
      return null;
    }

    return $DexTokenCopyWith<$Res>(_value.token2!, (value) {
      return _then(_value.copyWith(token2: value));
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DexTokenCopyWith<$Res>? get lpToken {
    if (_value.lpToken == null) {
      return null;
    }

    return $DexTokenCopyWith<$Res>(_value.lpToken!, (value) {
      return _then(_value.copyWith(lpToken: value));
    });
  }
}

/// @nodoc

class _$DexNotificationRemoveLiquidityImpl
    extends _DexNotificationRemoveLiquidity {
  const _$DexNotificationRemoveLiquidityImpl(
      {this.actionType = DexActionType.removeLiquidity,
      this.txAddress,
      this.amountToken1,
      this.amountToken2,
      this.amountLPToken,
      this.token1,
      this.token2,
      this.lpToken})
      : super._();

  @override
  @JsonKey()
  final DexActionType actionType;
  @override
  final String? txAddress;
  @override
  final double? amountToken1;
  @override
  final double? amountToken2;
  @override
  final double? amountLPToken;
  @override
  final DexToken? token1;
  @override
  final DexToken? token2;
  @override
  final DexToken? lpToken;

  @override
  String toString() {
    return 'DexNotification.removeLiquidity(actionType: $actionType, txAddress: $txAddress, amountToken1: $amountToken1, amountToken2: $amountToken2, amountLPToken: $amountLPToken, token1: $token1, token2: $token2, lpToken: $lpToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DexNotificationRemoveLiquidityImpl &&
            (identical(other.actionType, actionType) ||
                other.actionType == actionType) &&
            (identical(other.txAddress, txAddress) ||
                other.txAddress == txAddress) &&
            (identical(other.amountToken1, amountToken1) ||
                other.amountToken1 == amountToken1) &&
            (identical(other.amountToken2, amountToken2) ||
                other.amountToken2 == amountToken2) &&
            (identical(other.amountLPToken, amountLPToken) ||
                other.amountLPToken == amountLPToken) &&
            (identical(other.token1, token1) || other.token1 == token1) &&
            (identical(other.token2, token2) || other.token2 == token2) &&
            (identical(other.lpToken, lpToken) || other.lpToken == lpToken));
  }

  @override
  int get hashCode => Object.hash(runtimeType, actionType, txAddress,
      amountToken1, amountToken2, amountLPToken, token1, token2, lpToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DexNotificationRemoveLiquidityImplCopyWith<
          _$DexNotificationRemoveLiquidityImpl>
      get copyWith => __$$DexNotificationRemoveLiquidityImplCopyWithImpl<
          _$DexNotificationRemoveLiquidityImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)
        swap,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)
        addLiquidity,
    required TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)
        removeLiquidity,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)
        claimFarm,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)
        depositFarm,
    required TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)
        withdrawFarm,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)
        depositFarmLock,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)
        levelUpFarmLock,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)
        claimFarmLock,
    required TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)
        withdrawFarmLock,
  }) {
    return removeLiquidity(actionType, txAddress, amountToken1, amountToken2,
        amountLPToken, token1, token2, lpToken);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)?
        swap,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)?
        addLiquidity,
    TResult? Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)?
        removeLiquidity,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarm,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarm,
    TResult? Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarm,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarmLock,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        levelUpFarmLock,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarmLock,
    TResult? Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarmLock,
  }) {
    return removeLiquidity?.call(actionType, txAddress, amountToken1,
        amountToken2, amountLPToken, token1, token2, lpToken);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)?
        swap,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)?
        addLiquidity,
    TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)?
        removeLiquidity,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarm,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarm,
    TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarm,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarmLock,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        levelUpFarmLock,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarmLock,
    TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarmLock,
    required TResult orElse(),
  }) {
    if (removeLiquidity != null) {
      return removeLiquidity(actionType, txAddress, amountToken1, amountToken2,
          amountLPToken, token1, token2, lpToken);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DexNotificationSwap value) swap,
    required TResult Function(_DexNotificationAddLiquidity value) addLiquidity,
    required TResult Function(_DexNotificationRemoveLiquidity value)
        removeLiquidity,
    required TResult Function(_DexNotificationClaimFarm value) claimFarm,
    required TResult Function(_DexNotificationDepositFarm value) depositFarm,
    required TResult Function(_DexNotificationWithdrawFarm value) withdrawFarm,
    required TResult Function(_DexNotificationDepositFarmLock value)
        depositFarmLock,
    required TResult Function(_DexNotificationLevelUpFarmLock value)
        levelUpFarmLock,
    required TResult Function(_DexNotificationClaimLockFarm value)
        claimFarmLock,
    required TResult Function(_DexNotificationWithdrawFarmLock value)
        withdrawFarmLock,
  }) {
    return removeLiquidity(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DexNotificationSwap value)? swap,
    TResult? Function(_DexNotificationAddLiquidity value)? addLiquidity,
    TResult? Function(_DexNotificationRemoveLiquidity value)? removeLiquidity,
    TResult? Function(_DexNotificationClaimFarm value)? claimFarm,
    TResult? Function(_DexNotificationDepositFarm value)? depositFarm,
    TResult? Function(_DexNotificationWithdrawFarm value)? withdrawFarm,
    TResult? Function(_DexNotificationDepositFarmLock value)? depositFarmLock,
    TResult? Function(_DexNotificationLevelUpFarmLock value)? levelUpFarmLock,
    TResult? Function(_DexNotificationClaimLockFarm value)? claimFarmLock,
    TResult? Function(_DexNotificationWithdrawFarmLock value)? withdrawFarmLock,
  }) {
    return removeLiquidity?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DexNotificationSwap value)? swap,
    TResult Function(_DexNotificationAddLiquidity value)? addLiquidity,
    TResult Function(_DexNotificationRemoveLiquidity value)? removeLiquidity,
    TResult Function(_DexNotificationClaimFarm value)? claimFarm,
    TResult Function(_DexNotificationDepositFarm value)? depositFarm,
    TResult Function(_DexNotificationWithdrawFarm value)? withdrawFarm,
    TResult Function(_DexNotificationDepositFarmLock value)? depositFarmLock,
    TResult Function(_DexNotificationLevelUpFarmLock value)? levelUpFarmLock,
    TResult Function(_DexNotificationClaimLockFarm value)? claimFarmLock,
    TResult Function(_DexNotificationWithdrawFarmLock value)? withdrawFarmLock,
    required TResult orElse(),
  }) {
    if (removeLiquidity != null) {
      return removeLiquidity(this);
    }
    return orElse();
  }
}

abstract class _DexNotificationRemoveLiquidity extends DexNotification {
  const factory _DexNotificationRemoveLiquidity(
      {final DexActionType actionType,
      final String? txAddress,
      final double? amountToken1,
      final double? amountToken2,
      final double? amountLPToken,
      final DexToken? token1,
      final DexToken? token2,
      final DexToken? lpToken}) = _$DexNotificationRemoveLiquidityImpl;
  const _DexNotificationRemoveLiquidity._() : super._();

  @override
  DexActionType get actionType;
  @override
  String? get txAddress;
  double? get amountToken1;
  double? get amountToken2;
  double? get amountLPToken;
  DexToken? get token1;
  DexToken? get token2;
  DexToken? get lpToken;
  @override
  @JsonKey(ignore: true)
  _$$DexNotificationRemoveLiquidityImplCopyWith<
          _$DexNotificationRemoveLiquidityImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DexNotificationClaimFarmImplCopyWith<$Res>
    implements $DexNotificationCopyWith<$Res> {
  factory _$$DexNotificationClaimFarmImplCopyWith(
          _$DexNotificationClaimFarmImpl value,
          $Res Function(_$DexNotificationClaimFarmImpl) then) =
      __$$DexNotificationClaimFarmImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DexActionType actionType,
      String? txAddress,
      double? amount,
      DexToken? rewardToken});

  $DexTokenCopyWith<$Res>? get rewardToken;
}

/// @nodoc
class __$$DexNotificationClaimFarmImplCopyWithImpl<$Res>
    extends _$DexNotificationCopyWithImpl<$Res, _$DexNotificationClaimFarmImpl>
    implements _$$DexNotificationClaimFarmImplCopyWith<$Res> {
  __$$DexNotificationClaimFarmImplCopyWithImpl(
      _$DexNotificationClaimFarmImpl _value,
      $Res Function(_$DexNotificationClaimFarmImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actionType = null,
    Object? txAddress = freezed,
    Object? amount = freezed,
    Object? rewardToken = freezed,
  }) {
    return _then(_$DexNotificationClaimFarmImpl(
      actionType: null == actionType
          ? _value.actionType
          : actionType // ignore: cast_nullable_to_non_nullable
              as DexActionType,
      txAddress: freezed == txAddress
          ? _value.txAddress
          : txAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      rewardToken: freezed == rewardToken
          ? _value.rewardToken
          : rewardToken // ignore: cast_nullable_to_non_nullable
              as DexToken?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $DexTokenCopyWith<$Res>? get rewardToken {
    if (_value.rewardToken == null) {
      return null;
    }

    return $DexTokenCopyWith<$Res>(_value.rewardToken!, (value) {
      return _then(_value.copyWith(rewardToken: value));
    });
  }
}

/// @nodoc

class _$DexNotificationClaimFarmImpl extends _DexNotificationClaimFarm {
  const _$DexNotificationClaimFarmImpl(
      {this.actionType = DexActionType.claimFarm,
      this.txAddress,
      this.amount,
      this.rewardToken})
      : super._();

  @override
  @JsonKey()
  final DexActionType actionType;
  @override
  final String? txAddress;
  @override
  final double? amount;
  @override
  final DexToken? rewardToken;

  @override
  String toString() {
    return 'DexNotification.claimFarm(actionType: $actionType, txAddress: $txAddress, amount: $amount, rewardToken: $rewardToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DexNotificationClaimFarmImpl &&
            (identical(other.actionType, actionType) ||
                other.actionType == actionType) &&
            (identical(other.txAddress, txAddress) ||
                other.txAddress == txAddress) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.rewardToken, rewardToken) ||
                other.rewardToken == rewardToken));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, actionType, txAddress, amount, rewardToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DexNotificationClaimFarmImplCopyWith<_$DexNotificationClaimFarmImpl>
      get copyWith => __$$DexNotificationClaimFarmImplCopyWithImpl<
          _$DexNotificationClaimFarmImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)
        swap,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)
        addLiquidity,
    required TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)
        removeLiquidity,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)
        claimFarm,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)
        depositFarm,
    required TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)
        withdrawFarm,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)
        depositFarmLock,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)
        levelUpFarmLock,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)
        claimFarmLock,
    required TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)
        withdrawFarmLock,
  }) {
    return claimFarm(actionType, txAddress, amount, rewardToken);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)?
        swap,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)?
        addLiquidity,
    TResult? Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)?
        removeLiquidity,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarm,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarm,
    TResult? Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarm,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarmLock,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        levelUpFarmLock,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarmLock,
    TResult? Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarmLock,
  }) {
    return claimFarm?.call(actionType, txAddress, amount, rewardToken);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)?
        swap,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)?
        addLiquidity,
    TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)?
        removeLiquidity,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarm,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarm,
    TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarm,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarmLock,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        levelUpFarmLock,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarmLock,
    TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarmLock,
    required TResult orElse(),
  }) {
    if (claimFarm != null) {
      return claimFarm(actionType, txAddress, amount, rewardToken);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DexNotificationSwap value) swap,
    required TResult Function(_DexNotificationAddLiquidity value) addLiquidity,
    required TResult Function(_DexNotificationRemoveLiquidity value)
        removeLiquidity,
    required TResult Function(_DexNotificationClaimFarm value) claimFarm,
    required TResult Function(_DexNotificationDepositFarm value) depositFarm,
    required TResult Function(_DexNotificationWithdrawFarm value) withdrawFarm,
    required TResult Function(_DexNotificationDepositFarmLock value)
        depositFarmLock,
    required TResult Function(_DexNotificationLevelUpFarmLock value)
        levelUpFarmLock,
    required TResult Function(_DexNotificationClaimLockFarm value)
        claimFarmLock,
    required TResult Function(_DexNotificationWithdrawFarmLock value)
        withdrawFarmLock,
  }) {
    return claimFarm(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DexNotificationSwap value)? swap,
    TResult? Function(_DexNotificationAddLiquidity value)? addLiquidity,
    TResult? Function(_DexNotificationRemoveLiquidity value)? removeLiquidity,
    TResult? Function(_DexNotificationClaimFarm value)? claimFarm,
    TResult? Function(_DexNotificationDepositFarm value)? depositFarm,
    TResult? Function(_DexNotificationWithdrawFarm value)? withdrawFarm,
    TResult? Function(_DexNotificationDepositFarmLock value)? depositFarmLock,
    TResult? Function(_DexNotificationLevelUpFarmLock value)? levelUpFarmLock,
    TResult? Function(_DexNotificationClaimLockFarm value)? claimFarmLock,
    TResult? Function(_DexNotificationWithdrawFarmLock value)? withdrawFarmLock,
  }) {
    return claimFarm?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DexNotificationSwap value)? swap,
    TResult Function(_DexNotificationAddLiquidity value)? addLiquidity,
    TResult Function(_DexNotificationRemoveLiquidity value)? removeLiquidity,
    TResult Function(_DexNotificationClaimFarm value)? claimFarm,
    TResult Function(_DexNotificationDepositFarm value)? depositFarm,
    TResult Function(_DexNotificationWithdrawFarm value)? withdrawFarm,
    TResult Function(_DexNotificationDepositFarmLock value)? depositFarmLock,
    TResult Function(_DexNotificationLevelUpFarmLock value)? levelUpFarmLock,
    TResult Function(_DexNotificationClaimLockFarm value)? claimFarmLock,
    TResult Function(_DexNotificationWithdrawFarmLock value)? withdrawFarmLock,
    required TResult orElse(),
  }) {
    if (claimFarm != null) {
      return claimFarm(this);
    }
    return orElse();
  }
}

abstract class _DexNotificationClaimFarm extends DexNotification {
  const factory _DexNotificationClaimFarm(
      {final DexActionType actionType,
      final String? txAddress,
      final double? amount,
      final DexToken? rewardToken}) = _$DexNotificationClaimFarmImpl;
  const _DexNotificationClaimFarm._() : super._();

  @override
  DexActionType get actionType;
  @override
  String? get txAddress;
  double? get amount;
  DexToken? get rewardToken;
  @override
  @JsonKey(ignore: true)
  _$$DexNotificationClaimFarmImplCopyWith<_$DexNotificationClaimFarmImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DexNotificationDepositFarmImplCopyWith<$Res>
    implements $DexNotificationCopyWith<$Res> {
  factory _$$DexNotificationDepositFarmImplCopyWith(
          _$DexNotificationDepositFarmImpl value,
          $Res Function(_$DexNotificationDepositFarmImpl) then) =
      __$$DexNotificationDepositFarmImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DexActionType actionType,
      String? txAddress,
      double? amount,
      String? farmAddress,
      bool? isUCO});
}

/// @nodoc
class __$$DexNotificationDepositFarmImplCopyWithImpl<$Res>
    extends _$DexNotificationCopyWithImpl<$Res,
        _$DexNotificationDepositFarmImpl>
    implements _$$DexNotificationDepositFarmImplCopyWith<$Res> {
  __$$DexNotificationDepositFarmImplCopyWithImpl(
      _$DexNotificationDepositFarmImpl _value,
      $Res Function(_$DexNotificationDepositFarmImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actionType = null,
    Object? txAddress = freezed,
    Object? amount = freezed,
    Object? farmAddress = freezed,
    Object? isUCO = freezed,
  }) {
    return _then(_$DexNotificationDepositFarmImpl(
      actionType: null == actionType
          ? _value.actionType
          : actionType // ignore: cast_nullable_to_non_nullable
              as DexActionType,
      txAddress: freezed == txAddress
          ? _value.txAddress
          : txAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      farmAddress: freezed == farmAddress
          ? _value.farmAddress
          : farmAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      isUCO: freezed == isUCO
          ? _value.isUCO
          : isUCO // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$DexNotificationDepositFarmImpl extends _DexNotificationDepositFarm {
  const _$DexNotificationDepositFarmImpl(
      {this.actionType = DexActionType.depositFarm,
      this.txAddress,
      this.amount,
      this.farmAddress,
      this.isUCO})
      : super._();

  @override
  @JsonKey()
  final DexActionType actionType;
  @override
  final String? txAddress;
  @override
  final double? amount;
  @override
  final String? farmAddress;
  @override
  final bool? isUCO;

  @override
  String toString() {
    return 'DexNotification.depositFarm(actionType: $actionType, txAddress: $txAddress, amount: $amount, farmAddress: $farmAddress, isUCO: $isUCO)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DexNotificationDepositFarmImpl &&
            (identical(other.actionType, actionType) ||
                other.actionType == actionType) &&
            (identical(other.txAddress, txAddress) ||
                other.txAddress == txAddress) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.farmAddress, farmAddress) ||
                other.farmAddress == farmAddress) &&
            (identical(other.isUCO, isUCO) || other.isUCO == isUCO));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, actionType, txAddress, amount, farmAddress, isUCO);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DexNotificationDepositFarmImplCopyWith<_$DexNotificationDepositFarmImpl>
      get copyWith => __$$DexNotificationDepositFarmImplCopyWithImpl<
          _$DexNotificationDepositFarmImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)
        swap,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)
        addLiquidity,
    required TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)
        removeLiquidity,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)
        claimFarm,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)
        depositFarm,
    required TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)
        withdrawFarm,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)
        depositFarmLock,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)
        levelUpFarmLock,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)
        claimFarmLock,
    required TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)
        withdrawFarmLock,
  }) {
    return depositFarm(actionType, txAddress, amount, farmAddress, isUCO);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)?
        swap,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)?
        addLiquidity,
    TResult? Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)?
        removeLiquidity,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarm,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarm,
    TResult? Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarm,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarmLock,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        levelUpFarmLock,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarmLock,
    TResult? Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarmLock,
  }) {
    return depositFarm?.call(actionType, txAddress, amount, farmAddress, isUCO);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)?
        swap,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)?
        addLiquidity,
    TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)?
        removeLiquidity,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarm,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarm,
    TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarm,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarmLock,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        levelUpFarmLock,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarmLock,
    TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarmLock,
    required TResult orElse(),
  }) {
    if (depositFarm != null) {
      return depositFarm(actionType, txAddress, amount, farmAddress, isUCO);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DexNotificationSwap value) swap,
    required TResult Function(_DexNotificationAddLiquidity value) addLiquidity,
    required TResult Function(_DexNotificationRemoveLiquidity value)
        removeLiquidity,
    required TResult Function(_DexNotificationClaimFarm value) claimFarm,
    required TResult Function(_DexNotificationDepositFarm value) depositFarm,
    required TResult Function(_DexNotificationWithdrawFarm value) withdrawFarm,
    required TResult Function(_DexNotificationDepositFarmLock value)
        depositFarmLock,
    required TResult Function(_DexNotificationLevelUpFarmLock value)
        levelUpFarmLock,
    required TResult Function(_DexNotificationClaimLockFarm value)
        claimFarmLock,
    required TResult Function(_DexNotificationWithdrawFarmLock value)
        withdrawFarmLock,
  }) {
    return depositFarm(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DexNotificationSwap value)? swap,
    TResult? Function(_DexNotificationAddLiquidity value)? addLiquidity,
    TResult? Function(_DexNotificationRemoveLiquidity value)? removeLiquidity,
    TResult? Function(_DexNotificationClaimFarm value)? claimFarm,
    TResult? Function(_DexNotificationDepositFarm value)? depositFarm,
    TResult? Function(_DexNotificationWithdrawFarm value)? withdrawFarm,
    TResult? Function(_DexNotificationDepositFarmLock value)? depositFarmLock,
    TResult? Function(_DexNotificationLevelUpFarmLock value)? levelUpFarmLock,
    TResult? Function(_DexNotificationClaimLockFarm value)? claimFarmLock,
    TResult? Function(_DexNotificationWithdrawFarmLock value)? withdrawFarmLock,
  }) {
    return depositFarm?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DexNotificationSwap value)? swap,
    TResult Function(_DexNotificationAddLiquidity value)? addLiquidity,
    TResult Function(_DexNotificationRemoveLiquidity value)? removeLiquidity,
    TResult Function(_DexNotificationClaimFarm value)? claimFarm,
    TResult Function(_DexNotificationDepositFarm value)? depositFarm,
    TResult Function(_DexNotificationWithdrawFarm value)? withdrawFarm,
    TResult Function(_DexNotificationDepositFarmLock value)? depositFarmLock,
    TResult Function(_DexNotificationLevelUpFarmLock value)? levelUpFarmLock,
    TResult Function(_DexNotificationClaimLockFarm value)? claimFarmLock,
    TResult Function(_DexNotificationWithdrawFarmLock value)? withdrawFarmLock,
    required TResult orElse(),
  }) {
    if (depositFarm != null) {
      return depositFarm(this);
    }
    return orElse();
  }
}

abstract class _DexNotificationDepositFarm extends DexNotification {
  const factory _DexNotificationDepositFarm(
      {final DexActionType actionType,
      final String? txAddress,
      final double? amount,
      final String? farmAddress,
      final bool? isUCO}) = _$DexNotificationDepositFarmImpl;
  const _DexNotificationDepositFarm._() : super._();

  @override
  DexActionType get actionType;
  @override
  String? get txAddress;
  double? get amount;
  String? get farmAddress;
  bool? get isUCO;
  @override
  @JsonKey(ignore: true)
  _$$DexNotificationDepositFarmImplCopyWith<_$DexNotificationDepositFarmImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DexNotificationWithdrawFarmImplCopyWith<$Res>
    implements $DexNotificationCopyWith<$Res> {
  factory _$$DexNotificationWithdrawFarmImplCopyWith(
          _$DexNotificationWithdrawFarmImpl value,
          $Res Function(_$DexNotificationWithdrawFarmImpl) then) =
      __$$DexNotificationWithdrawFarmImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DexActionType actionType,
      String? txAddress,
      double? amountReward,
      double? amountWithdraw,
      bool? isFarmClose,
      DexToken? rewardToken});

  $DexTokenCopyWith<$Res>? get rewardToken;
}

/// @nodoc
class __$$DexNotificationWithdrawFarmImplCopyWithImpl<$Res>
    extends _$DexNotificationCopyWithImpl<$Res,
        _$DexNotificationWithdrawFarmImpl>
    implements _$$DexNotificationWithdrawFarmImplCopyWith<$Res> {
  __$$DexNotificationWithdrawFarmImplCopyWithImpl(
      _$DexNotificationWithdrawFarmImpl _value,
      $Res Function(_$DexNotificationWithdrawFarmImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actionType = null,
    Object? txAddress = freezed,
    Object? amountReward = freezed,
    Object? amountWithdraw = freezed,
    Object? isFarmClose = freezed,
    Object? rewardToken = freezed,
  }) {
    return _then(_$DexNotificationWithdrawFarmImpl(
      actionType: null == actionType
          ? _value.actionType
          : actionType // ignore: cast_nullable_to_non_nullable
              as DexActionType,
      txAddress: freezed == txAddress
          ? _value.txAddress
          : txAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      amountReward: freezed == amountReward
          ? _value.amountReward
          : amountReward // ignore: cast_nullable_to_non_nullable
              as double?,
      amountWithdraw: freezed == amountWithdraw
          ? _value.amountWithdraw
          : amountWithdraw // ignore: cast_nullable_to_non_nullable
              as double?,
      isFarmClose: freezed == isFarmClose
          ? _value.isFarmClose
          : isFarmClose // ignore: cast_nullable_to_non_nullable
              as bool?,
      rewardToken: freezed == rewardToken
          ? _value.rewardToken
          : rewardToken // ignore: cast_nullable_to_non_nullable
              as DexToken?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $DexTokenCopyWith<$Res>? get rewardToken {
    if (_value.rewardToken == null) {
      return null;
    }

    return $DexTokenCopyWith<$Res>(_value.rewardToken!, (value) {
      return _then(_value.copyWith(rewardToken: value));
    });
  }
}

/// @nodoc

class _$DexNotificationWithdrawFarmImpl extends _DexNotificationWithdrawFarm {
  const _$DexNotificationWithdrawFarmImpl(
      {this.actionType = DexActionType.withdrawFarm,
      this.txAddress,
      this.amountReward,
      this.amountWithdraw,
      this.isFarmClose,
      this.rewardToken})
      : super._();

  @override
  @JsonKey()
  final DexActionType actionType;
  @override
  final String? txAddress;
  @override
  final double? amountReward;
  @override
  final double? amountWithdraw;
  @override
  final bool? isFarmClose;
  @override
  final DexToken? rewardToken;

  @override
  String toString() {
    return 'DexNotification.withdrawFarm(actionType: $actionType, txAddress: $txAddress, amountReward: $amountReward, amountWithdraw: $amountWithdraw, isFarmClose: $isFarmClose, rewardToken: $rewardToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DexNotificationWithdrawFarmImpl &&
            (identical(other.actionType, actionType) ||
                other.actionType == actionType) &&
            (identical(other.txAddress, txAddress) ||
                other.txAddress == txAddress) &&
            (identical(other.amountReward, amountReward) ||
                other.amountReward == amountReward) &&
            (identical(other.amountWithdraw, amountWithdraw) ||
                other.amountWithdraw == amountWithdraw) &&
            (identical(other.isFarmClose, isFarmClose) ||
                other.isFarmClose == isFarmClose) &&
            (identical(other.rewardToken, rewardToken) ||
                other.rewardToken == rewardToken));
  }

  @override
  int get hashCode => Object.hash(runtimeType, actionType, txAddress,
      amountReward, amountWithdraw, isFarmClose, rewardToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DexNotificationWithdrawFarmImplCopyWith<_$DexNotificationWithdrawFarmImpl>
      get copyWith => __$$DexNotificationWithdrawFarmImplCopyWithImpl<
          _$DexNotificationWithdrawFarmImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)
        swap,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)
        addLiquidity,
    required TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)
        removeLiquidity,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)
        claimFarm,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)
        depositFarm,
    required TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)
        withdrawFarm,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)
        depositFarmLock,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)
        levelUpFarmLock,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)
        claimFarmLock,
    required TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)
        withdrawFarmLock,
  }) {
    return withdrawFarm(actionType, txAddress, amountReward, amountWithdraw,
        isFarmClose, rewardToken);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)?
        swap,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)?
        addLiquidity,
    TResult? Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)?
        removeLiquidity,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarm,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarm,
    TResult? Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarm,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarmLock,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        levelUpFarmLock,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarmLock,
    TResult? Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarmLock,
  }) {
    return withdrawFarm?.call(actionType, txAddress, amountReward,
        amountWithdraw, isFarmClose, rewardToken);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)?
        swap,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)?
        addLiquidity,
    TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)?
        removeLiquidity,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarm,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarm,
    TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarm,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarmLock,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        levelUpFarmLock,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarmLock,
    TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarmLock,
    required TResult orElse(),
  }) {
    if (withdrawFarm != null) {
      return withdrawFarm(actionType, txAddress, amountReward, amountWithdraw,
          isFarmClose, rewardToken);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DexNotificationSwap value) swap,
    required TResult Function(_DexNotificationAddLiquidity value) addLiquidity,
    required TResult Function(_DexNotificationRemoveLiquidity value)
        removeLiquidity,
    required TResult Function(_DexNotificationClaimFarm value) claimFarm,
    required TResult Function(_DexNotificationDepositFarm value) depositFarm,
    required TResult Function(_DexNotificationWithdrawFarm value) withdrawFarm,
    required TResult Function(_DexNotificationDepositFarmLock value)
        depositFarmLock,
    required TResult Function(_DexNotificationLevelUpFarmLock value)
        levelUpFarmLock,
    required TResult Function(_DexNotificationClaimLockFarm value)
        claimFarmLock,
    required TResult Function(_DexNotificationWithdrawFarmLock value)
        withdrawFarmLock,
  }) {
    return withdrawFarm(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DexNotificationSwap value)? swap,
    TResult? Function(_DexNotificationAddLiquidity value)? addLiquidity,
    TResult? Function(_DexNotificationRemoveLiquidity value)? removeLiquidity,
    TResult? Function(_DexNotificationClaimFarm value)? claimFarm,
    TResult? Function(_DexNotificationDepositFarm value)? depositFarm,
    TResult? Function(_DexNotificationWithdrawFarm value)? withdrawFarm,
    TResult? Function(_DexNotificationDepositFarmLock value)? depositFarmLock,
    TResult? Function(_DexNotificationLevelUpFarmLock value)? levelUpFarmLock,
    TResult? Function(_DexNotificationClaimLockFarm value)? claimFarmLock,
    TResult? Function(_DexNotificationWithdrawFarmLock value)? withdrawFarmLock,
  }) {
    return withdrawFarm?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DexNotificationSwap value)? swap,
    TResult Function(_DexNotificationAddLiquidity value)? addLiquidity,
    TResult Function(_DexNotificationRemoveLiquidity value)? removeLiquidity,
    TResult Function(_DexNotificationClaimFarm value)? claimFarm,
    TResult Function(_DexNotificationDepositFarm value)? depositFarm,
    TResult Function(_DexNotificationWithdrawFarm value)? withdrawFarm,
    TResult Function(_DexNotificationDepositFarmLock value)? depositFarmLock,
    TResult Function(_DexNotificationLevelUpFarmLock value)? levelUpFarmLock,
    TResult Function(_DexNotificationClaimLockFarm value)? claimFarmLock,
    TResult Function(_DexNotificationWithdrawFarmLock value)? withdrawFarmLock,
    required TResult orElse(),
  }) {
    if (withdrawFarm != null) {
      return withdrawFarm(this);
    }
    return orElse();
  }
}

abstract class _DexNotificationWithdrawFarm extends DexNotification {
  const factory _DexNotificationWithdrawFarm(
      {final DexActionType actionType,
      final String? txAddress,
      final double? amountReward,
      final double? amountWithdraw,
      final bool? isFarmClose,
      final DexToken? rewardToken}) = _$DexNotificationWithdrawFarmImpl;
  const _DexNotificationWithdrawFarm._() : super._();

  @override
  DexActionType get actionType;
  @override
  String? get txAddress;
  double? get amountReward;
  double? get amountWithdraw;
  bool? get isFarmClose;
  DexToken? get rewardToken;
  @override
  @JsonKey(ignore: true)
  _$$DexNotificationWithdrawFarmImplCopyWith<_$DexNotificationWithdrawFarmImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DexNotificationDepositFarmLockImplCopyWith<$Res>
    implements $DexNotificationCopyWith<$Res> {
  factory _$$DexNotificationDepositFarmLockImplCopyWith(
          _$DexNotificationDepositFarmLockImpl value,
          $Res Function(_$DexNotificationDepositFarmLockImpl) then) =
      __$$DexNotificationDepositFarmLockImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DexActionType actionType,
      String? txAddress,
      double? amount,
      String? farmAddress,
      bool? isUCO});
}

/// @nodoc
class __$$DexNotificationDepositFarmLockImplCopyWithImpl<$Res>
    extends _$DexNotificationCopyWithImpl<$Res,
        _$DexNotificationDepositFarmLockImpl>
    implements _$$DexNotificationDepositFarmLockImplCopyWith<$Res> {
  __$$DexNotificationDepositFarmLockImplCopyWithImpl(
      _$DexNotificationDepositFarmLockImpl _value,
      $Res Function(_$DexNotificationDepositFarmLockImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actionType = null,
    Object? txAddress = freezed,
    Object? amount = freezed,
    Object? farmAddress = freezed,
    Object? isUCO = freezed,
  }) {
    return _then(_$DexNotificationDepositFarmLockImpl(
      actionType: null == actionType
          ? _value.actionType
          : actionType // ignore: cast_nullable_to_non_nullable
              as DexActionType,
      txAddress: freezed == txAddress
          ? _value.txAddress
          : txAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      farmAddress: freezed == farmAddress
          ? _value.farmAddress
          : farmAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      isUCO: freezed == isUCO
          ? _value.isUCO
          : isUCO // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$DexNotificationDepositFarmLockImpl
    extends _DexNotificationDepositFarmLock {
  const _$DexNotificationDepositFarmLockImpl(
      {this.actionType = DexActionType.depositFarmLock,
      this.txAddress,
      this.amount,
      this.farmAddress,
      this.isUCO})
      : super._();

  @override
  @JsonKey()
  final DexActionType actionType;
  @override
  final String? txAddress;
  @override
  final double? amount;
  @override
  final String? farmAddress;
  @override
  final bool? isUCO;

  @override
  String toString() {
    return 'DexNotification.depositFarmLock(actionType: $actionType, txAddress: $txAddress, amount: $amount, farmAddress: $farmAddress, isUCO: $isUCO)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DexNotificationDepositFarmLockImpl &&
            (identical(other.actionType, actionType) ||
                other.actionType == actionType) &&
            (identical(other.txAddress, txAddress) ||
                other.txAddress == txAddress) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.farmAddress, farmAddress) ||
                other.farmAddress == farmAddress) &&
            (identical(other.isUCO, isUCO) || other.isUCO == isUCO));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, actionType, txAddress, amount, farmAddress, isUCO);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DexNotificationDepositFarmLockImplCopyWith<
          _$DexNotificationDepositFarmLockImpl>
      get copyWith => __$$DexNotificationDepositFarmLockImplCopyWithImpl<
          _$DexNotificationDepositFarmLockImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)
        swap,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)
        addLiquidity,
    required TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)
        removeLiquidity,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)
        claimFarm,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)
        depositFarm,
    required TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)
        withdrawFarm,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)
        depositFarmLock,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)
        levelUpFarmLock,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)
        claimFarmLock,
    required TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)
        withdrawFarmLock,
  }) {
    return depositFarmLock(actionType, txAddress, amount, farmAddress, isUCO);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)?
        swap,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)?
        addLiquidity,
    TResult? Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)?
        removeLiquidity,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarm,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarm,
    TResult? Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarm,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarmLock,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        levelUpFarmLock,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarmLock,
    TResult? Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarmLock,
  }) {
    return depositFarmLock?.call(
        actionType, txAddress, amount, farmAddress, isUCO);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)?
        swap,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)?
        addLiquidity,
    TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)?
        removeLiquidity,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarm,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarm,
    TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarm,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarmLock,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        levelUpFarmLock,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarmLock,
    TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarmLock,
    required TResult orElse(),
  }) {
    if (depositFarmLock != null) {
      return depositFarmLock(actionType, txAddress, amount, farmAddress, isUCO);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DexNotificationSwap value) swap,
    required TResult Function(_DexNotificationAddLiquidity value) addLiquidity,
    required TResult Function(_DexNotificationRemoveLiquidity value)
        removeLiquidity,
    required TResult Function(_DexNotificationClaimFarm value) claimFarm,
    required TResult Function(_DexNotificationDepositFarm value) depositFarm,
    required TResult Function(_DexNotificationWithdrawFarm value) withdrawFarm,
    required TResult Function(_DexNotificationDepositFarmLock value)
        depositFarmLock,
    required TResult Function(_DexNotificationLevelUpFarmLock value)
        levelUpFarmLock,
    required TResult Function(_DexNotificationClaimLockFarm value)
        claimFarmLock,
    required TResult Function(_DexNotificationWithdrawFarmLock value)
        withdrawFarmLock,
  }) {
    return depositFarmLock(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DexNotificationSwap value)? swap,
    TResult? Function(_DexNotificationAddLiquidity value)? addLiquidity,
    TResult? Function(_DexNotificationRemoveLiquidity value)? removeLiquidity,
    TResult? Function(_DexNotificationClaimFarm value)? claimFarm,
    TResult? Function(_DexNotificationDepositFarm value)? depositFarm,
    TResult? Function(_DexNotificationWithdrawFarm value)? withdrawFarm,
    TResult? Function(_DexNotificationDepositFarmLock value)? depositFarmLock,
    TResult? Function(_DexNotificationLevelUpFarmLock value)? levelUpFarmLock,
    TResult? Function(_DexNotificationClaimLockFarm value)? claimFarmLock,
    TResult? Function(_DexNotificationWithdrawFarmLock value)? withdrawFarmLock,
  }) {
    return depositFarmLock?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DexNotificationSwap value)? swap,
    TResult Function(_DexNotificationAddLiquidity value)? addLiquidity,
    TResult Function(_DexNotificationRemoveLiquidity value)? removeLiquidity,
    TResult Function(_DexNotificationClaimFarm value)? claimFarm,
    TResult Function(_DexNotificationDepositFarm value)? depositFarm,
    TResult Function(_DexNotificationWithdrawFarm value)? withdrawFarm,
    TResult Function(_DexNotificationDepositFarmLock value)? depositFarmLock,
    TResult Function(_DexNotificationLevelUpFarmLock value)? levelUpFarmLock,
    TResult Function(_DexNotificationClaimLockFarm value)? claimFarmLock,
    TResult Function(_DexNotificationWithdrawFarmLock value)? withdrawFarmLock,
    required TResult orElse(),
  }) {
    if (depositFarmLock != null) {
      return depositFarmLock(this);
    }
    return orElse();
  }
}

abstract class _DexNotificationDepositFarmLock extends DexNotification {
  const factory _DexNotificationDepositFarmLock(
      {final DexActionType actionType,
      final String? txAddress,
      final double? amount,
      final String? farmAddress,
      final bool? isUCO}) = _$DexNotificationDepositFarmLockImpl;
  const _DexNotificationDepositFarmLock._() : super._();

  @override
  DexActionType get actionType;
  @override
  String? get txAddress;
  double? get amount;
  String? get farmAddress;
  bool? get isUCO;
  @override
  @JsonKey(ignore: true)
  _$$DexNotificationDepositFarmLockImplCopyWith<
          _$DexNotificationDepositFarmLockImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DexNotificationLevelUpFarmLockImplCopyWith<$Res>
    implements $DexNotificationCopyWith<$Res> {
  factory _$$DexNotificationLevelUpFarmLockImplCopyWith(
          _$DexNotificationLevelUpFarmLockImpl value,
          $Res Function(_$DexNotificationLevelUpFarmLockImpl) then) =
      __$$DexNotificationLevelUpFarmLockImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DexActionType actionType,
      String? txAddress,
      double? amount,
      String? farmAddress,
      bool? isUCO});
}

/// @nodoc
class __$$DexNotificationLevelUpFarmLockImplCopyWithImpl<$Res>
    extends _$DexNotificationCopyWithImpl<$Res,
        _$DexNotificationLevelUpFarmLockImpl>
    implements _$$DexNotificationLevelUpFarmLockImplCopyWith<$Res> {
  __$$DexNotificationLevelUpFarmLockImplCopyWithImpl(
      _$DexNotificationLevelUpFarmLockImpl _value,
      $Res Function(_$DexNotificationLevelUpFarmLockImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actionType = null,
    Object? txAddress = freezed,
    Object? amount = freezed,
    Object? farmAddress = freezed,
    Object? isUCO = freezed,
  }) {
    return _then(_$DexNotificationLevelUpFarmLockImpl(
      actionType: null == actionType
          ? _value.actionType
          : actionType // ignore: cast_nullable_to_non_nullable
              as DexActionType,
      txAddress: freezed == txAddress
          ? _value.txAddress
          : txAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      farmAddress: freezed == farmAddress
          ? _value.farmAddress
          : farmAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      isUCO: freezed == isUCO
          ? _value.isUCO
          : isUCO // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$DexNotificationLevelUpFarmLockImpl
    extends _DexNotificationLevelUpFarmLock {
  const _$DexNotificationLevelUpFarmLockImpl(
      {this.actionType = DexActionType.levelUpFarmLock,
      this.txAddress,
      this.amount,
      this.farmAddress,
      this.isUCO})
      : super._();

  @override
  @JsonKey()
  final DexActionType actionType;
  @override
  final String? txAddress;
  @override
  final double? amount;
  @override
  final String? farmAddress;
  @override
  final bool? isUCO;

  @override
  String toString() {
    return 'DexNotification.levelUpFarmLock(actionType: $actionType, txAddress: $txAddress, amount: $amount, farmAddress: $farmAddress, isUCO: $isUCO)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DexNotificationLevelUpFarmLockImpl &&
            (identical(other.actionType, actionType) ||
                other.actionType == actionType) &&
            (identical(other.txAddress, txAddress) ||
                other.txAddress == txAddress) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.farmAddress, farmAddress) ||
                other.farmAddress == farmAddress) &&
            (identical(other.isUCO, isUCO) || other.isUCO == isUCO));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, actionType, txAddress, amount, farmAddress, isUCO);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DexNotificationLevelUpFarmLockImplCopyWith<
          _$DexNotificationLevelUpFarmLockImpl>
      get copyWith => __$$DexNotificationLevelUpFarmLockImplCopyWithImpl<
          _$DexNotificationLevelUpFarmLockImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)
        swap,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)
        addLiquidity,
    required TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)
        removeLiquidity,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)
        claimFarm,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)
        depositFarm,
    required TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)
        withdrawFarm,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)
        depositFarmLock,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)
        levelUpFarmLock,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)
        claimFarmLock,
    required TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)
        withdrawFarmLock,
  }) {
    return levelUpFarmLock(actionType, txAddress, amount, farmAddress, isUCO);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)?
        swap,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)?
        addLiquidity,
    TResult? Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)?
        removeLiquidity,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarm,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarm,
    TResult? Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarm,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarmLock,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        levelUpFarmLock,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarmLock,
    TResult? Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarmLock,
  }) {
    return levelUpFarmLock?.call(
        actionType, txAddress, amount, farmAddress, isUCO);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)?
        swap,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)?
        addLiquidity,
    TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)?
        removeLiquidity,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarm,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarm,
    TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarm,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarmLock,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        levelUpFarmLock,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarmLock,
    TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarmLock,
    required TResult orElse(),
  }) {
    if (levelUpFarmLock != null) {
      return levelUpFarmLock(actionType, txAddress, amount, farmAddress, isUCO);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DexNotificationSwap value) swap,
    required TResult Function(_DexNotificationAddLiquidity value) addLiquidity,
    required TResult Function(_DexNotificationRemoveLiquidity value)
        removeLiquidity,
    required TResult Function(_DexNotificationClaimFarm value) claimFarm,
    required TResult Function(_DexNotificationDepositFarm value) depositFarm,
    required TResult Function(_DexNotificationWithdrawFarm value) withdrawFarm,
    required TResult Function(_DexNotificationDepositFarmLock value)
        depositFarmLock,
    required TResult Function(_DexNotificationLevelUpFarmLock value)
        levelUpFarmLock,
    required TResult Function(_DexNotificationClaimLockFarm value)
        claimFarmLock,
    required TResult Function(_DexNotificationWithdrawFarmLock value)
        withdrawFarmLock,
  }) {
    return levelUpFarmLock(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DexNotificationSwap value)? swap,
    TResult? Function(_DexNotificationAddLiquidity value)? addLiquidity,
    TResult? Function(_DexNotificationRemoveLiquidity value)? removeLiquidity,
    TResult? Function(_DexNotificationClaimFarm value)? claimFarm,
    TResult? Function(_DexNotificationDepositFarm value)? depositFarm,
    TResult? Function(_DexNotificationWithdrawFarm value)? withdrawFarm,
    TResult? Function(_DexNotificationDepositFarmLock value)? depositFarmLock,
    TResult? Function(_DexNotificationLevelUpFarmLock value)? levelUpFarmLock,
    TResult? Function(_DexNotificationClaimLockFarm value)? claimFarmLock,
    TResult? Function(_DexNotificationWithdrawFarmLock value)? withdrawFarmLock,
  }) {
    return levelUpFarmLock?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DexNotificationSwap value)? swap,
    TResult Function(_DexNotificationAddLiquidity value)? addLiquidity,
    TResult Function(_DexNotificationRemoveLiquidity value)? removeLiquidity,
    TResult Function(_DexNotificationClaimFarm value)? claimFarm,
    TResult Function(_DexNotificationDepositFarm value)? depositFarm,
    TResult Function(_DexNotificationWithdrawFarm value)? withdrawFarm,
    TResult Function(_DexNotificationDepositFarmLock value)? depositFarmLock,
    TResult Function(_DexNotificationLevelUpFarmLock value)? levelUpFarmLock,
    TResult Function(_DexNotificationClaimLockFarm value)? claimFarmLock,
    TResult Function(_DexNotificationWithdrawFarmLock value)? withdrawFarmLock,
    required TResult orElse(),
  }) {
    if (levelUpFarmLock != null) {
      return levelUpFarmLock(this);
    }
    return orElse();
  }
}

abstract class _DexNotificationLevelUpFarmLock extends DexNotification {
  const factory _DexNotificationLevelUpFarmLock(
      {final DexActionType actionType,
      final String? txAddress,
      final double? amount,
      final String? farmAddress,
      final bool? isUCO}) = _$DexNotificationLevelUpFarmLockImpl;
  const _DexNotificationLevelUpFarmLock._() : super._();

  @override
  DexActionType get actionType;
  @override
  String? get txAddress;
  double? get amount;
  String? get farmAddress;
  bool? get isUCO;
  @override
  @JsonKey(ignore: true)
  _$$DexNotificationLevelUpFarmLockImplCopyWith<
          _$DexNotificationLevelUpFarmLockImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DexNotificationClaimLockFarmImplCopyWith<$Res>
    implements $DexNotificationCopyWith<$Res> {
  factory _$$DexNotificationClaimLockFarmImplCopyWith(
          _$DexNotificationClaimLockFarmImpl value,
          $Res Function(_$DexNotificationClaimLockFarmImpl) then) =
      __$$DexNotificationClaimLockFarmImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DexActionType actionType,
      String? txAddress,
      double? amount,
      DexToken? rewardToken});

  $DexTokenCopyWith<$Res>? get rewardToken;
}

/// @nodoc
class __$$DexNotificationClaimLockFarmImplCopyWithImpl<$Res>
    extends _$DexNotificationCopyWithImpl<$Res,
        _$DexNotificationClaimLockFarmImpl>
    implements _$$DexNotificationClaimLockFarmImplCopyWith<$Res> {
  __$$DexNotificationClaimLockFarmImplCopyWithImpl(
      _$DexNotificationClaimLockFarmImpl _value,
      $Res Function(_$DexNotificationClaimLockFarmImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actionType = null,
    Object? txAddress = freezed,
    Object? amount = freezed,
    Object? rewardToken = freezed,
  }) {
    return _then(_$DexNotificationClaimLockFarmImpl(
      actionType: null == actionType
          ? _value.actionType
          : actionType // ignore: cast_nullable_to_non_nullable
              as DexActionType,
      txAddress: freezed == txAddress
          ? _value.txAddress
          : txAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      rewardToken: freezed == rewardToken
          ? _value.rewardToken
          : rewardToken // ignore: cast_nullable_to_non_nullable
              as DexToken?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $DexTokenCopyWith<$Res>? get rewardToken {
    if (_value.rewardToken == null) {
      return null;
    }

    return $DexTokenCopyWith<$Res>(_value.rewardToken!, (value) {
      return _then(_value.copyWith(rewardToken: value));
    });
  }
}

/// @nodoc

class _$DexNotificationClaimLockFarmImpl extends _DexNotificationClaimLockFarm {
  const _$DexNotificationClaimLockFarmImpl(
      {this.actionType = DexActionType.claimFarmLock,
      this.txAddress,
      this.amount,
      this.rewardToken})
      : super._();

  @override
  @JsonKey()
  final DexActionType actionType;
  @override
  final String? txAddress;
  @override
  final double? amount;
  @override
  final DexToken? rewardToken;

  @override
  String toString() {
    return 'DexNotification.claimFarmLock(actionType: $actionType, txAddress: $txAddress, amount: $amount, rewardToken: $rewardToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DexNotificationClaimLockFarmImpl &&
            (identical(other.actionType, actionType) ||
                other.actionType == actionType) &&
            (identical(other.txAddress, txAddress) ||
                other.txAddress == txAddress) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.rewardToken, rewardToken) ||
                other.rewardToken == rewardToken));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, actionType, txAddress, amount, rewardToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DexNotificationClaimLockFarmImplCopyWith<
          _$DexNotificationClaimLockFarmImpl>
      get copyWith => __$$DexNotificationClaimLockFarmImplCopyWithImpl<
          _$DexNotificationClaimLockFarmImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)
        swap,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)
        addLiquidity,
    required TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)
        removeLiquidity,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)
        claimFarm,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)
        depositFarm,
    required TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)
        withdrawFarm,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)
        depositFarmLock,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)
        levelUpFarmLock,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)
        claimFarmLock,
    required TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)
        withdrawFarmLock,
  }) {
    return claimFarmLock(actionType, txAddress, amount, rewardToken);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)?
        swap,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)?
        addLiquidity,
    TResult? Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)?
        removeLiquidity,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarm,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarm,
    TResult? Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarm,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarmLock,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        levelUpFarmLock,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarmLock,
    TResult? Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarmLock,
  }) {
    return claimFarmLock?.call(actionType, txAddress, amount, rewardToken);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)?
        swap,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)?
        addLiquidity,
    TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)?
        removeLiquidity,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarm,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarm,
    TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarm,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarmLock,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        levelUpFarmLock,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarmLock,
    TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarmLock,
    required TResult orElse(),
  }) {
    if (claimFarmLock != null) {
      return claimFarmLock(actionType, txAddress, amount, rewardToken);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DexNotificationSwap value) swap,
    required TResult Function(_DexNotificationAddLiquidity value) addLiquidity,
    required TResult Function(_DexNotificationRemoveLiquidity value)
        removeLiquidity,
    required TResult Function(_DexNotificationClaimFarm value) claimFarm,
    required TResult Function(_DexNotificationDepositFarm value) depositFarm,
    required TResult Function(_DexNotificationWithdrawFarm value) withdrawFarm,
    required TResult Function(_DexNotificationDepositFarmLock value)
        depositFarmLock,
    required TResult Function(_DexNotificationLevelUpFarmLock value)
        levelUpFarmLock,
    required TResult Function(_DexNotificationClaimLockFarm value)
        claimFarmLock,
    required TResult Function(_DexNotificationWithdrawFarmLock value)
        withdrawFarmLock,
  }) {
    return claimFarmLock(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DexNotificationSwap value)? swap,
    TResult? Function(_DexNotificationAddLiquidity value)? addLiquidity,
    TResult? Function(_DexNotificationRemoveLiquidity value)? removeLiquidity,
    TResult? Function(_DexNotificationClaimFarm value)? claimFarm,
    TResult? Function(_DexNotificationDepositFarm value)? depositFarm,
    TResult? Function(_DexNotificationWithdrawFarm value)? withdrawFarm,
    TResult? Function(_DexNotificationDepositFarmLock value)? depositFarmLock,
    TResult? Function(_DexNotificationLevelUpFarmLock value)? levelUpFarmLock,
    TResult? Function(_DexNotificationClaimLockFarm value)? claimFarmLock,
    TResult? Function(_DexNotificationWithdrawFarmLock value)? withdrawFarmLock,
  }) {
    return claimFarmLock?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DexNotificationSwap value)? swap,
    TResult Function(_DexNotificationAddLiquidity value)? addLiquidity,
    TResult Function(_DexNotificationRemoveLiquidity value)? removeLiquidity,
    TResult Function(_DexNotificationClaimFarm value)? claimFarm,
    TResult Function(_DexNotificationDepositFarm value)? depositFarm,
    TResult Function(_DexNotificationWithdrawFarm value)? withdrawFarm,
    TResult Function(_DexNotificationDepositFarmLock value)? depositFarmLock,
    TResult Function(_DexNotificationLevelUpFarmLock value)? levelUpFarmLock,
    TResult Function(_DexNotificationClaimLockFarm value)? claimFarmLock,
    TResult Function(_DexNotificationWithdrawFarmLock value)? withdrawFarmLock,
    required TResult orElse(),
  }) {
    if (claimFarmLock != null) {
      return claimFarmLock(this);
    }
    return orElse();
  }
}

abstract class _DexNotificationClaimLockFarm extends DexNotification {
  const factory _DexNotificationClaimLockFarm(
      {final DexActionType actionType,
      final String? txAddress,
      final double? amount,
      final DexToken? rewardToken}) = _$DexNotificationClaimLockFarmImpl;
  const _DexNotificationClaimLockFarm._() : super._();

  @override
  DexActionType get actionType;
  @override
  String? get txAddress;
  double? get amount;
  DexToken? get rewardToken;
  @override
  @JsonKey(ignore: true)
  _$$DexNotificationClaimLockFarmImplCopyWith<
          _$DexNotificationClaimLockFarmImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DexNotificationWithdrawFarmLockImplCopyWith<$Res>
    implements $DexNotificationCopyWith<$Res> {
  factory _$$DexNotificationWithdrawFarmLockImplCopyWith(
          _$DexNotificationWithdrawFarmLockImpl value,
          $Res Function(_$DexNotificationWithdrawFarmLockImpl) then) =
      __$$DexNotificationWithdrawFarmLockImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DexActionType actionType,
      String? txAddress,
      double? amountReward,
      double? amountWithdraw,
      bool? isFarmClose,
      DexToken? rewardToken});

  $DexTokenCopyWith<$Res>? get rewardToken;
}

/// @nodoc
class __$$DexNotificationWithdrawFarmLockImplCopyWithImpl<$Res>
    extends _$DexNotificationCopyWithImpl<$Res,
        _$DexNotificationWithdrawFarmLockImpl>
    implements _$$DexNotificationWithdrawFarmLockImplCopyWith<$Res> {
  __$$DexNotificationWithdrawFarmLockImplCopyWithImpl(
      _$DexNotificationWithdrawFarmLockImpl _value,
      $Res Function(_$DexNotificationWithdrawFarmLockImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actionType = null,
    Object? txAddress = freezed,
    Object? amountReward = freezed,
    Object? amountWithdraw = freezed,
    Object? isFarmClose = freezed,
    Object? rewardToken = freezed,
  }) {
    return _then(_$DexNotificationWithdrawFarmLockImpl(
      actionType: null == actionType
          ? _value.actionType
          : actionType // ignore: cast_nullable_to_non_nullable
              as DexActionType,
      txAddress: freezed == txAddress
          ? _value.txAddress
          : txAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      amountReward: freezed == amountReward
          ? _value.amountReward
          : amountReward // ignore: cast_nullable_to_non_nullable
              as double?,
      amountWithdraw: freezed == amountWithdraw
          ? _value.amountWithdraw
          : amountWithdraw // ignore: cast_nullable_to_non_nullable
              as double?,
      isFarmClose: freezed == isFarmClose
          ? _value.isFarmClose
          : isFarmClose // ignore: cast_nullable_to_non_nullable
              as bool?,
      rewardToken: freezed == rewardToken
          ? _value.rewardToken
          : rewardToken // ignore: cast_nullable_to_non_nullable
              as DexToken?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $DexTokenCopyWith<$Res>? get rewardToken {
    if (_value.rewardToken == null) {
      return null;
    }

    return $DexTokenCopyWith<$Res>(_value.rewardToken!, (value) {
      return _then(_value.copyWith(rewardToken: value));
    });
  }
}

/// @nodoc

class _$DexNotificationWithdrawFarmLockImpl
    extends _DexNotificationWithdrawFarmLock {
  const _$DexNotificationWithdrawFarmLockImpl(
      {this.actionType = DexActionType.withdrawFarmLock,
      this.txAddress,
      this.amountReward,
      this.amountWithdraw,
      this.isFarmClose,
      this.rewardToken})
      : super._();

  @override
  @JsonKey()
  final DexActionType actionType;
  @override
  final String? txAddress;
  @override
  final double? amountReward;
  @override
  final double? amountWithdraw;
  @override
  final bool? isFarmClose;
  @override
  final DexToken? rewardToken;

  @override
  String toString() {
    return 'DexNotification.withdrawFarmLock(actionType: $actionType, txAddress: $txAddress, amountReward: $amountReward, amountWithdraw: $amountWithdraw, isFarmClose: $isFarmClose, rewardToken: $rewardToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DexNotificationWithdrawFarmLockImpl &&
            (identical(other.actionType, actionType) ||
                other.actionType == actionType) &&
            (identical(other.txAddress, txAddress) ||
                other.txAddress == txAddress) &&
            (identical(other.amountReward, amountReward) ||
                other.amountReward == amountReward) &&
            (identical(other.amountWithdraw, amountWithdraw) ||
                other.amountWithdraw == amountWithdraw) &&
            (identical(other.isFarmClose, isFarmClose) ||
                other.isFarmClose == isFarmClose) &&
            (identical(other.rewardToken, rewardToken) ||
                other.rewardToken == rewardToken));
  }

  @override
  int get hashCode => Object.hash(runtimeType, actionType, txAddress,
      amountReward, amountWithdraw, isFarmClose, rewardToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DexNotificationWithdrawFarmLockImplCopyWith<
          _$DexNotificationWithdrawFarmLockImpl>
      get copyWith => __$$DexNotificationWithdrawFarmLockImplCopyWithImpl<
          _$DexNotificationWithdrawFarmLockImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)
        swap,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)
        addLiquidity,
    required TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)
        removeLiquidity,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)
        claimFarm,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)
        depositFarm,
    required TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)
        withdrawFarm,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)
        depositFarmLock,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)
        levelUpFarmLock,
    required TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)
        claimFarmLock,
    required TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)
        withdrawFarmLock,
  }) {
    return withdrawFarmLock(actionType, txAddress, amountReward, amountWithdraw,
        isFarmClose, rewardToken);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)?
        swap,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)?
        addLiquidity,
    TResult? Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)?
        removeLiquidity,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarm,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarm,
    TResult? Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarm,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarmLock,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        levelUpFarmLock,
    TResult? Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarmLock,
    TResult? Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarmLock,
  }) {
    return withdrawFarmLock?.call(actionType, txAddress, amountReward,
        amountWithdraw, isFarmClose, rewardToken);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DexActionType actionType, String? txAddress,
            double? amountSwapped, DexToken? tokenSwapped)?
        swap,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? lpToken)?
        addLiquidity,
    TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountToken1,
            double? amountToken2,
            double? amountLPToken,
            DexToken? token1,
            DexToken? token2,
            DexToken? lpToken)?
        removeLiquidity,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarm,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarm,
    TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarm,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        depositFarmLock,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, String? farmAddress, bool? isUCO)?
        levelUpFarmLock,
    TResult Function(DexActionType actionType, String? txAddress,
            double? amount, DexToken? rewardToken)?
        claimFarmLock,
    TResult Function(
            DexActionType actionType,
            String? txAddress,
            double? amountReward,
            double? amountWithdraw,
            bool? isFarmClose,
            DexToken? rewardToken)?
        withdrawFarmLock,
    required TResult orElse(),
  }) {
    if (withdrawFarmLock != null) {
      return withdrawFarmLock(actionType, txAddress, amountReward,
          amountWithdraw, isFarmClose, rewardToken);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DexNotificationSwap value) swap,
    required TResult Function(_DexNotificationAddLiquidity value) addLiquidity,
    required TResult Function(_DexNotificationRemoveLiquidity value)
        removeLiquidity,
    required TResult Function(_DexNotificationClaimFarm value) claimFarm,
    required TResult Function(_DexNotificationDepositFarm value) depositFarm,
    required TResult Function(_DexNotificationWithdrawFarm value) withdrawFarm,
    required TResult Function(_DexNotificationDepositFarmLock value)
        depositFarmLock,
    required TResult Function(_DexNotificationLevelUpFarmLock value)
        levelUpFarmLock,
    required TResult Function(_DexNotificationClaimLockFarm value)
        claimFarmLock,
    required TResult Function(_DexNotificationWithdrawFarmLock value)
        withdrawFarmLock,
  }) {
    return withdrawFarmLock(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DexNotificationSwap value)? swap,
    TResult? Function(_DexNotificationAddLiquidity value)? addLiquidity,
    TResult? Function(_DexNotificationRemoveLiquidity value)? removeLiquidity,
    TResult? Function(_DexNotificationClaimFarm value)? claimFarm,
    TResult? Function(_DexNotificationDepositFarm value)? depositFarm,
    TResult? Function(_DexNotificationWithdrawFarm value)? withdrawFarm,
    TResult? Function(_DexNotificationDepositFarmLock value)? depositFarmLock,
    TResult? Function(_DexNotificationLevelUpFarmLock value)? levelUpFarmLock,
    TResult? Function(_DexNotificationClaimLockFarm value)? claimFarmLock,
    TResult? Function(_DexNotificationWithdrawFarmLock value)? withdrawFarmLock,
  }) {
    return withdrawFarmLock?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DexNotificationSwap value)? swap,
    TResult Function(_DexNotificationAddLiquidity value)? addLiquidity,
    TResult Function(_DexNotificationRemoveLiquidity value)? removeLiquidity,
    TResult Function(_DexNotificationClaimFarm value)? claimFarm,
    TResult Function(_DexNotificationDepositFarm value)? depositFarm,
    TResult Function(_DexNotificationWithdrawFarm value)? withdrawFarm,
    TResult Function(_DexNotificationDepositFarmLock value)? depositFarmLock,
    TResult Function(_DexNotificationLevelUpFarmLock value)? levelUpFarmLock,
    TResult Function(_DexNotificationClaimLockFarm value)? claimFarmLock,
    TResult Function(_DexNotificationWithdrawFarmLock value)? withdrawFarmLock,
    required TResult orElse(),
  }) {
    if (withdrawFarmLock != null) {
      return withdrawFarmLock(this);
    }
    return orElse();
  }
}

abstract class _DexNotificationWithdrawFarmLock extends DexNotification {
  const factory _DexNotificationWithdrawFarmLock(
      {final DexActionType actionType,
      final String? txAddress,
      final double? amountReward,
      final double? amountWithdraw,
      final bool? isFarmClose,
      final DexToken? rewardToken}) = _$DexNotificationWithdrawFarmLockImpl;
  const _DexNotificationWithdrawFarmLock._() : super._();

  @override
  DexActionType get actionType;
  @override
  String? get txAddress;
  double? get amountReward;
  double? get amountWithdraw;
  bool? get isFarmClose;
  DexToken? get rewardToken;
  @override
  @JsonKey(ignore: true)
  _$$DexNotificationWithdrawFarmLockImplCopyWith<
          _$DexNotificationWithdrawFarmLockImpl>
      get copyWith => throw _privateConstructorUsedError;
}
