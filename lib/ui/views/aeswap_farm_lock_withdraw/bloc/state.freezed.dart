// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FarmLockWithdrawFormState {
  ProcessStep get processStep => throw _privateConstructorUsedError;
  bool get resumeProcess => throw _privateConstructorUsedError;
  int get currentStep => throw _privateConstructorUsedError;
  bool get isProcessInProgress => throw _privateConstructorUsedError;
  bool get farmLockWithdrawOk => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get depositId => throw _privateConstructorUsedError;
  Transaction? get transactionWithdrawFarmLock =>
      throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;
  String? get farmAddress => throw _privateConstructorUsedError;
  DexToken? get rewardToken => throw _privateConstructorUsedError;
  DexToken? get lpToken => throw _privateConstructorUsedError;
  DexPair? get lpTokenPair => throw _privateConstructorUsedError;
  double? get finalAmountReward => throw _privateConstructorUsedError;
  double? get finalAmountWithdraw => throw _privateConstructorUsedError;
  DateTime? get consentDateTime => throw _privateConstructorUsedError;
  double? get depositedAmount => throw _privateConstructorUsedError;
  double get feesEstimatedUCO => throw _privateConstructorUsedError;
  double? get rewardAmount => throw _privateConstructorUsedError;
  String? get poolAddress => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FarmLockWithdrawFormStateCopyWith<FarmLockWithdrawFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FarmLockWithdrawFormStateCopyWith<$Res> {
  factory $FarmLockWithdrawFormStateCopyWith(FarmLockWithdrawFormState value,
          $Res Function(FarmLockWithdrawFormState) then) =
      _$FarmLockWithdrawFormStateCopyWithImpl<$Res, FarmLockWithdrawFormState>;
  @useResult
  $Res call(
      {ProcessStep processStep,
      bool resumeProcess,
      int currentStep,
      bool isProcessInProgress,
      bool farmLockWithdrawOk,
      double amount,
      String depositId,
      Transaction? transactionWithdrawFarmLock,
      Failure? failure,
      String? farmAddress,
      DexToken? rewardToken,
      DexToken? lpToken,
      DexPair? lpTokenPair,
      double? finalAmountReward,
      double? finalAmountWithdraw,
      DateTime? consentDateTime,
      double? depositedAmount,
      double feesEstimatedUCO,
      double? rewardAmount,
      String? poolAddress,
      DateTime? endDate});

  $TransactionCopyWith<$Res>? get transactionWithdrawFarmLock;
  $FailureCopyWith<$Res>? get failure;
  $DexTokenCopyWith<$Res>? get rewardToken;
  $DexTokenCopyWith<$Res>? get lpToken;
  $DexPairCopyWith<$Res>? get lpTokenPair;
}

/// @nodoc
class _$FarmLockWithdrawFormStateCopyWithImpl<$Res,
        $Val extends FarmLockWithdrawFormState>
    implements $FarmLockWithdrawFormStateCopyWith<$Res> {
  _$FarmLockWithdrawFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? processStep = null,
    Object? resumeProcess = null,
    Object? currentStep = null,
    Object? isProcessInProgress = null,
    Object? farmLockWithdrawOk = null,
    Object? amount = null,
    Object? depositId = null,
    Object? transactionWithdrawFarmLock = freezed,
    Object? failure = freezed,
    Object? farmAddress = freezed,
    Object? rewardToken = freezed,
    Object? lpToken = freezed,
    Object? lpTokenPair = freezed,
    Object? finalAmountReward = freezed,
    Object? finalAmountWithdraw = freezed,
    Object? consentDateTime = freezed,
    Object? depositedAmount = freezed,
    Object? feesEstimatedUCO = null,
    Object? rewardAmount = freezed,
    Object? poolAddress = freezed,
    Object? endDate = freezed,
  }) {
    return _then(_value.copyWith(
      processStep: null == processStep
          ? _value.processStep
          : processStep // ignore: cast_nullable_to_non_nullable
              as ProcessStep,
      resumeProcess: null == resumeProcess
          ? _value.resumeProcess
          : resumeProcess // ignore: cast_nullable_to_non_nullable
              as bool,
      currentStep: null == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
      isProcessInProgress: null == isProcessInProgress
          ? _value.isProcessInProgress
          : isProcessInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      farmLockWithdrawOk: null == farmLockWithdrawOk
          ? _value.farmLockWithdrawOk
          : farmLockWithdrawOk // ignore: cast_nullable_to_non_nullable
              as bool,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      depositId: null == depositId
          ? _value.depositId
          : depositId // ignore: cast_nullable_to_non_nullable
              as String,
      transactionWithdrawFarmLock: freezed == transactionWithdrawFarmLock
          ? _value.transactionWithdrawFarmLock
          : transactionWithdrawFarmLock // ignore: cast_nullable_to_non_nullable
              as Transaction?,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      farmAddress: freezed == farmAddress
          ? _value.farmAddress
          : farmAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      rewardToken: freezed == rewardToken
          ? _value.rewardToken
          : rewardToken // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      lpToken: freezed == lpToken
          ? _value.lpToken
          : lpToken // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      lpTokenPair: freezed == lpTokenPair
          ? _value.lpTokenPair
          : lpTokenPair // ignore: cast_nullable_to_non_nullable
              as DexPair?,
      finalAmountReward: freezed == finalAmountReward
          ? _value.finalAmountReward
          : finalAmountReward // ignore: cast_nullable_to_non_nullable
              as double?,
      finalAmountWithdraw: freezed == finalAmountWithdraw
          ? _value.finalAmountWithdraw
          : finalAmountWithdraw // ignore: cast_nullable_to_non_nullable
              as double?,
      consentDateTime: freezed == consentDateTime
          ? _value.consentDateTime
          : consentDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      depositedAmount: freezed == depositedAmount
          ? _value.depositedAmount
          : depositedAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      feesEstimatedUCO: null == feesEstimatedUCO
          ? _value.feesEstimatedUCO
          : feesEstimatedUCO // ignore: cast_nullable_to_non_nullable
              as double,
      rewardAmount: freezed == rewardAmount
          ? _value.rewardAmount
          : rewardAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      poolAddress: freezed == poolAddress
          ? _value.poolAddress
          : poolAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TransactionCopyWith<$Res>? get transactionWithdrawFarmLock {
    if (_value.transactionWithdrawFarmLock == null) {
      return null;
    }

    return $TransactionCopyWith<$Res>(_value.transactionWithdrawFarmLock!,
        (value) {
      return _then(_value.copyWith(transactionWithdrawFarmLock: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $FailureCopyWith<$Res>? get failure {
    if (_value.failure == null) {
      return null;
    }

    return $FailureCopyWith<$Res>(_value.failure!, (value) {
      return _then(_value.copyWith(failure: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DexTokenCopyWith<$Res>? get rewardToken {
    if (_value.rewardToken == null) {
      return null;
    }

    return $DexTokenCopyWith<$Res>(_value.rewardToken!, (value) {
      return _then(_value.copyWith(rewardToken: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DexTokenCopyWith<$Res>? get lpToken {
    if (_value.lpToken == null) {
      return null;
    }

    return $DexTokenCopyWith<$Res>(_value.lpToken!, (value) {
      return _then(_value.copyWith(lpToken: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DexPairCopyWith<$Res>? get lpTokenPair {
    if (_value.lpTokenPair == null) {
      return null;
    }

    return $DexPairCopyWith<$Res>(_value.lpTokenPair!, (value) {
      return _then(_value.copyWith(lpTokenPair: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FarmLockWithdrawFormStateImplCopyWith<$Res>
    implements $FarmLockWithdrawFormStateCopyWith<$Res> {
  factory _$$FarmLockWithdrawFormStateImplCopyWith(
          _$FarmLockWithdrawFormStateImpl value,
          $Res Function(_$FarmLockWithdrawFormStateImpl) then) =
      __$$FarmLockWithdrawFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ProcessStep processStep,
      bool resumeProcess,
      int currentStep,
      bool isProcessInProgress,
      bool farmLockWithdrawOk,
      double amount,
      String depositId,
      Transaction? transactionWithdrawFarmLock,
      Failure? failure,
      String? farmAddress,
      DexToken? rewardToken,
      DexToken? lpToken,
      DexPair? lpTokenPair,
      double? finalAmountReward,
      double? finalAmountWithdraw,
      DateTime? consentDateTime,
      double? depositedAmount,
      double feesEstimatedUCO,
      double? rewardAmount,
      String? poolAddress,
      DateTime? endDate});

  @override
  $TransactionCopyWith<$Res>? get transactionWithdrawFarmLock;
  @override
  $FailureCopyWith<$Res>? get failure;
  @override
  $DexTokenCopyWith<$Res>? get rewardToken;
  @override
  $DexTokenCopyWith<$Res>? get lpToken;
  @override
  $DexPairCopyWith<$Res>? get lpTokenPair;
}

/// @nodoc
class __$$FarmLockWithdrawFormStateImplCopyWithImpl<$Res>
    extends _$FarmLockWithdrawFormStateCopyWithImpl<$Res,
        _$FarmLockWithdrawFormStateImpl>
    implements _$$FarmLockWithdrawFormStateImplCopyWith<$Res> {
  __$$FarmLockWithdrawFormStateImplCopyWithImpl(
      _$FarmLockWithdrawFormStateImpl _value,
      $Res Function(_$FarmLockWithdrawFormStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? processStep = null,
    Object? resumeProcess = null,
    Object? currentStep = null,
    Object? isProcessInProgress = null,
    Object? farmLockWithdrawOk = null,
    Object? amount = null,
    Object? depositId = null,
    Object? transactionWithdrawFarmLock = freezed,
    Object? failure = freezed,
    Object? farmAddress = freezed,
    Object? rewardToken = freezed,
    Object? lpToken = freezed,
    Object? lpTokenPair = freezed,
    Object? finalAmountReward = freezed,
    Object? finalAmountWithdraw = freezed,
    Object? consentDateTime = freezed,
    Object? depositedAmount = freezed,
    Object? feesEstimatedUCO = null,
    Object? rewardAmount = freezed,
    Object? poolAddress = freezed,
    Object? endDate = freezed,
  }) {
    return _then(_$FarmLockWithdrawFormStateImpl(
      processStep: null == processStep
          ? _value.processStep
          : processStep // ignore: cast_nullable_to_non_nullable
              as ProcessStep,
      resumeProcess: null == resumeProcess
          ? _value.resumeProcess
          : resumeProcess // ignore: cast_nullable_to_non_nullable
              as bool,
      currentStep: null == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
      isProcessInProgress: null == isProcessInProgress
          ? _value.isProcessInProgress
          : isProcessInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      farmLockWithdrawOk: null == farmLockWithdrawOk
          ? _value.farmLockWithdrawOk
          : farmLockWithdrawOk // ignore: cast_nullable_to_non_nullable
              as bool,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      depositId: null == depositId
          ? _value.depositId
          : depositId // ignore: cast_nullable_to_non_nullable
              as String,
      transactionWithdrawFarmLock: freezed == transactionWithdrawFarmLock
          ? _value.transactionWithdrawFarmLock
          : transactionWithdrawFarmLock // ignore: cast_nullable_to_non_nullable
              as Transaction?,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      farmAddress: freezed == farmAddress
          ? _value.farmAddress
          : farmAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      rewardToken: freezed == rewardToken
          ? _value.rewardToken
          : rewardToken // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      lpToken: freezed == lpToken
          ? _value.lpToken
          : lpToken // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      lpTokenPair: freezed == lpTokenPair
          ? _value.lpTokenPair
          : lpTokenPair // ignore: cast_nullable_to_non_nullable
              as DexPair?,
      finalAmountReward: freezed == finalAmountReward
          ? _value.finalAmountReward
          : finalAmountReward // ignore: cast_nullable_to_non_nullable
              as double?,
      finalAmountWithdraw: freezed == finalAmountWithdraw
          ? _value.finalAmountWithdraw
          : finalAmountWithdraw // ignore: cast_nullable_to_non_nullable
              as double?,
      consentDateTime: freezed == consentDateTime
          ? _value.consentDateTime
          : consentDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      depositedAmount: freezed == depositedAmount
          ? _value.depositedAmount
          : depositedAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      feesEstimatedUCO: null == feesEstimatedUCO
          ? _value.feesEstimatedUCO
          : feesEstimatedUCO // ignore: cast_nullable_to_non_nullable
              as double,
      rewardAmount: freezed == rewardAmount
          ? _value.rewardAmount
          : rewardAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      poolAddress: freezed == poolAddress
          ? _value.poolAddress
          : poolAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$FarmLockWithdrawFormStateImpl extends _FarmLockWithdrawFormState {
  const _$FarmLockWithdrawFormStateImpl(
      {this.processStep = ProcessStep.form,
      this.resumeProcess = false,
      this.currentStep = 0,
      this.isProcessInProgress = false,
      this.farmLockWithdrawOk = false,
      this.amount = 0.0,
      this.depositId = '',
      this.transactionWithdrawFarmLock,
      this.failure,
      this.farmAddress,
      this.rewardToken,
      this.lpToken,
      this.lpTokenPair,
      this.finalAmountReward,
      this.finalAmountWithdraw,
      this.consentDateTime,
      this.depositedAmount,
      this.feesEstimatedUCO = 0.0,
      this.rewardAmount,
      this.poolAddress,
      this.endDate})
      : super._();

  @override
  @JsonKey()
  final ProcessStep processStep;
  @override
  @JsonKey()
  final bool resumeProcess;
  @override
  @JsonKey()
  final int currentStep;
  @override
  @JsonKey()
  final bool isProcessInProgress;
  @override
  @JsonKey()
  final bool farmLockWithdrawOk;
  @override
  @JsonKey()
  final double amount;
  @override
  @JsonKey()
  final String depositId;
  @override
  final Transaction? transactionWithdrawFarmLock;
  @override
  final Failure? failure;
  @override
  final String? farmAddress;
  @override
  final DexToken? rewardToken;
  @override
  final DexToken? lpToken;
  @override
  final DexPair? lpTokenPair;
  @override
  final double? finalAmountReward;
  @override
  final double? finalAmountWithdraw;
  @override
  final DateTime? consentDateTime;
  @override
  final double? depositedAmount;
  @override
  @JsonKey()
  final double feesEstimatedUCO;
  @override
  final double? rewardAmount;
  @override
  final String? poolAddress;
  @override
  final DateTime? endDate;

  @override
  String toString() {
    return 'FarmLockWithdrawFormState(processStep: $processStep, resumeProcess: $resumeProcess, currentStep: $currentStep, isProcessInProgress: $isProcessInProgress, farmLockWithdrawOk: $farmLockWithdrawOk, amount: $amount, depositId: $depositId, transactionWithdrawFarmLock: $transactionWithdrawFarmLock, failure: $failure, farmAddress: $farmAddress, rewardToken: $rewardToken, lpToken: $lpToken, lpTokenPair: $lpTokenPair, finalAmountReward: $finalAmountReward, finalAmountWithdraw: $finalAmountWithdraw, consentDateTime: $consentDateTime, depositedAmount: $depositedAmount, feesEstimatedUCO: $feesEstimatedUCO, rewardAmount: $rewardAmount, poolAddress: $poolAddress, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FarmLockWithdrawFormStateImpl &&
            (identical(other.processStep, processStep) ||
                other.processStep == processStep) &&
            (identical(other.resumeProcess, resumeProcess) ||
                other.resumeProcess == resumeProcess) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.isProcessInProgress, isProcessInProgress) ||
                other.isProcessInProgress == isProcessInProgress) &&
            (identical(other.farmLockWithdrawOk, farmLockWithdrawOk) ||
                other.farmLockWithdrawOk == farmLockWithdrawOk) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.depositId, depositId) ||
                other.depositId == depositId) &&
            (identical(other.transactionWithdrawFarmLock,
                    transactionWithdrawFarmLock) ||
                other.transactionWithdrawFarmLock ==
                    transactionWithdrawFarmLock) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            (identical(other.farmAddress, farmAddress) ||
                other.farmAddress == farmAddress) &&
            (identical(other.rewardToken, rewardToken) ||
                other.rewardToken == rewardToken) &&
            (identical(other.lpToken, lpToken) || other.lpToken == lpToken) &&
            (identical(other.lpTokenPair, lpTokenPair) ||
                other.lpTokenPair == lpTokenPair) &&
            (identical(other.finalAmountReward, finalAmountReward) ||
                other.finalAmountReward == finalAmountReward) &&
            (identical(other.finalAmountWithdraw, finalAmountWithdraw) ||
                other.finalAmountWithdraw == finalAmountWithdraw) &&
            (identical(other.consentDateTime, consentDateTime) ||
                other.consentDateTime == consentDateTime) &&
            (identical(other.depositedAmount, depositedAmount) ||
                other.depositedAmount == depositedAmount) &&
            (identical(other.feesEstimatedUCO, feesEstimatedUCO) ||
                other.feesEstimatedUCO == feesEstimatedUCO) &&
            (identical(other.rewardAmount, rewardAmount) ||
                other.rewardAmount == rewardAmount) &&
            (identical(other.poolAddress, poolAddress) ||
                other.poolAddress == poolAddress) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        processStep,
        resumeProcess,
        currentStep,
        isProcessInProgress,
        farmLockWithdrawOk,
        amount,
        depositId,
        transactionWithdrawFarmLock,
        failure,
        farmAddress,
        rewardToken,
        lpToken,
        lpTokenPair,
        finalAmountReward,
        finalAmountWithdraw,
        consentDateTime,
        depositedAmount,
        feesEstimatedUCO,
        rewardAmount,
        poolAddress,
        endDate
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FarmLockWithdrawFormStateImplCopyWith<_$FarmLockWithdrawFormStateImpl>
      get copyWith => __$$FarmLockWithdrawFormStateImplCopyWithImpl<
          _$FarmLockWithdrawFormStateImpl>(this, _$identity);
}

abstract class _FarmLockWithdrawFormState extends FarmLockWithdrawFormState {
  const factory _FarmLockWithdrawFormState(
      {final ProcessStep processStep,
      final bool resumeProcess,
      final int currentStep,
      final bool isProcessInProgress,
      final bool farmLockWithdrawOk,
      final double amount,
      final String depositId,
      final Transaction? transactionWithdrawFarmLock,
      final Failure? failure,
      final String? farmAddress,
      final DexToken? rewardToken,
      final DexToken? lpToken,
      final DexPair? lpTokenPair,
      final double? finalAmountReward,
      final double? finalAmountWithdraw,
      final DateTime? consentDateTime,
      final double? depositedAmount,
      final double feesEstimatedUCO,
      final double? rewardAmount,
      final String? poolAddress,
      final DateTime? endDate}) = _$FarmLockWithdrawFormStateImpl;
  const _FarmLockWithdrawFormState._() : super._();

  @override
  ProcessStep get processStep;
  @override
  bool get resumeProcess;
  @override
  int get currentStep;
  @override
  bool get isProcessInProgress;
  @override
  bool get farmLockWithdrawOk;
  @override
  double get amount;
  @override
  String get depositId;
  @override
  Transaction? get transactionWithdrawFarmLock;
  @override
  Failure? get failure;
  @override
  String? get farmAddress;
  @override
  DexToken? get rewardToken;
  @override
  DexToken? get lpToken;
  @override
  DexPair? get lpTokenPair;
  @override
  double? get finalAmountReward;
  @override
  double? get finalAmountWithdraw;
  @override
  DateTime? get consentDateTime;
  @override
  double? get depositedAmount;
  @override
  double get feesEstimatedUCO;
  @override
  double? get rewardAmount;
  @override
  String? get poolAddress;
  @override
  DateTime? get endDate;
  @override
  @JsonKey(ignore: true)
  _$$FarmLockWithdrawFormStateImplCopyWith<_$FarmLockWithdrawFormStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
