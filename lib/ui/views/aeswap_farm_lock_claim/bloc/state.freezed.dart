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
mixin _$FarmLockClaimFormState {
  ProcessStep get processStep => throw _privateConstructorUsedError;
  bool get resumeProcess => throw _privateConstructorUsedError;
  int get currentStep => throw _privateConstructorUsedError;
  bool get isProcessInProgress => throw _privateConstructorUsedError;
  bool get farmLockClaimOk => throw _privateConstructorUsedError;
  Transaction? get transactionClaimFarmLock =>
      throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;
  double? get finalAmount => throw _privateConstructorUsedError;
  String? get farmAddress => throw _privateConstructorUsedError;
  String? get poolAddress => throw _privateConstructorUsedError;
  DexToken? get rewardToken => throw _privateConstructorUsedError;
  String? get depositId => throw _privateConstructorUsedError;
  double get feesEstimatedUCO => throw _privateConstructorUsedError;
  String? get lpTokenAddress => throw _privateConstructorUsedError;
  DateTime? get consentDateTime => throw _privateConstructorUsedError;
  double? get rewardAmount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FarmLockClaimFormStateCopyWith<FarmLockClaimFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FarmLockClaimFormStateCopyWith<$Res> {
  factory $FarmLockClaimFormStateCopyWith(FarmLockClaimFormState value,
          $Res Function(FarmLockClaimFormState) then) =
      _$FarmLockClaimFormStateCopyWithImpl<$Res, FarmLockClaimFormState>;
  @useResult
  $Res call(
      {ProcessStep processStep,
      bool resumeProcess,
      int currentStep,
      bool isProcessInProgress,
      bool farmLockClaimOk,
      Transaction? transactionClaimFarmLock,
      Failure? failure,
      double? finalAmount,
      String? farmAddress,
      String? poolAddress,
      DexToken? rewardToken,
      String? depositId,
      double feesEstimatedUCO,
      String? lpTokenAddress,
      DateTime? consentDateTime,
      double? rewardAmount});

  $TransactionCopyWith<$Res>? get transactionClaimFarmLock;
  $FailureCopyWith<$Res>? get failure;
  $DexTokenCopyWith<$Res>? get rewardToken;
}

/// @nodoc
class _$FarmLockClaimFormStateCopyWithImpl<$Res,
        $Val extends FarmLockClaimFormState>
    implements $FarmLockClaimFormStateCopyWith<$Res> {
  _$FarmLockClaimFormStateCopyWithImpl(this._value, this._then);

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
    Object? farmLockClaimOk = null,
    Object? transactionClaimFarmLock = freezed,
    Object? failure = freezed,
    Object? finalAmount = freezed,
    Object? farmAddress = freezed,
    Object? poolAddress = freezed,
    Object? rewardToken = freezed,
    Object? depositId = freezed,
    Object? feesEstimatedUCO = null,
    Object? lpTokenAddress = freezed,
    Object? consentDateTime = freezed,
    Object? rewardAmount = freezed,
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
      farmLockClaimOk: null == farmLockClaimOk
          ? _value.farmLockClaimOk
          : farmLockClaimOk // ignore: cast_nullable_to_non_nullable
              as bool,
      transactionClaimFarmLock: freezed == transactionClaimFarmLock
          ? _value.transactionClaimFarmLock
          : transactionClaimFarmLock // ignore: cast_nullable_to_non_nullable
              as Transaction?,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      finalAmount: freezed == finalAmount
          ? _value.finalAmount
          : finalAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      farmAddress: freezed == farmAddress
          ? _value.farmAddress
          : farmAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      poolAddress: freezed == poolAddress
          ? _value.poolAddress
          : poolAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      rewardToken: freezed == rewardToken
          ? _value.rewardToken
          : rewardToken // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      depositId: freezed == depositId
          ? _value.depositId
          : depositId // ignore: cast_nullable_to_non_nullable
              as String?,
      feesEstimatedUCO: null == feesEstimatedUCO
          ? _value.feesEstimatedUCO
          : feesEstimatedUCO // ignore: cast_nullable_to_non_nullable
              as double,
      lpTokenAddress: freezed == lpTokenAddress
          ? _value.lpTokenAddress
          : lpTokenAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      consentDateTime: freezed == consentDateTime
          ? _value.consentDateTime
          : consentDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      rewardAmount: freezed == rewardAmount
          ? _value.rewardAmount
          : rewardAmount // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TransactionCopyWith<$Res>? get transactionClaimFarmLock {
    if (_value.transactionClaimFarmLock == null) {
      return null;
    }

    return $TransactionCopyWith<$Res>(_value.transactionClaimFarmLock!,
        (value) {
      return _then(_value.copyWith(transactionClaimFarmLock: value) as $Val);
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
}

/// @nodoc
abstract class _$$FarmLockClaimFormStateImplCopyWith<$Res>
    implements $FarmLockClaimFormStateCopyWith<$Res> {
  factory _$$FarmLockClaimFormStateImplCopyWith(
          _$FarmLockClaimFormStateImpl value,
          $Res Function(_$FarmLockClaimFormStateImpl) then) =
      __$$FarmLockClaimFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ProcessStep processStep,
      bool resumeProcess,
      int currentStep,
      bool isProcessInProgress,
      bool farmLockClaimOk,
      Transaction? transactionClaimFarmLock,
      Failure? failure,
      double? finalAmount,
      String? farmAddress,
      String? poolAddress,
      DexToken? rewardToken,
      String? depositId,
      double feesEstimatedUCO,
      String? lpTokenAddress,
      DateTime? consentDateTime,
      double? rewardAmount});

  @override
  $TransactionCopyWith<$Res>? get transactionClaimFarmLock;
  @override
  $FailureCopyWith<$Res>? get failure;
  @override
  $DexTokenCopyWith<$Res>? get rewardToken;
}

/// @nodoc
class __$$FarmLockClaimFormStateImplCopyWithImpl<$Res>
    extends _$FarmLockClaimFormStateCopyWithImpl<$Res,
        _$FarmLockClaimFormStateImpl>
    implements _$$FarmLockClaimFormStateImplCopyWith<$Res> {
  __$$FarmLockClaimFormStateImplCopyWithImpl(
      _$FarmLockClaimFormStateImpl _value,
      $Res Function(_$FarmLockClaimFormStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? processStep = null,
    Object? resumeProcess = null,
    Object? currentStep = null,
    Object? isProcessInProgress = null,
    Object? farmLockClaimOk = null,
    Object? transactionClaimFarmLock = freezed,
    Object? failure = freezed,
    Object? finalAmount = freezed,
    Object? farmAddress = freezed,
    Object? poolAddress = freezed,
    Object? rewardToken = freezed,
    Object? depositId = freezed,
    Object? feesEstimatedUCO = null,
    Object? lpTokenAddress = freezed,
    Object? consentDateTime = freezed,
    Object? rewardAmount = freezed,
  }) {
    return _then(_$FarmLockClaimFormStateImpl(
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
      farmLockClaimOk: null == farmLockClaimOk
          ? _value.farmLockClaimOk
          : farmLockClaimOk // ignore: cast_nullable_to_non_nullable
              as bool,
      transactionClaimFarmLock: freezed == transactionClaimFarmLock
          ? _value.transactionClaimFarmLock
          : transactionClaimFarmLock // ignore: cast_nullable_to_non_nullable
              as Transaction?,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      finalAmount: freezed == finalAmount
          ? _value.finalAmount
          : finalAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      farmAddress: freezed == farmAddress
          ? _value.farmAddress
          : farmAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      poolAddress: freezed == poolAddress
          ? _value.poolAddress
          : poolAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      rewardToken: freezed == rewardToken
          ? _value.rewardToken
          : rewardToken // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      depositId: freezed == depositId
          ? _value.depositId
          : depositId // ignore: cast_nullable_to_non_nullable
              as String?,
      feesEstimatedUCO: null == feesEstimatedUCO
          ? _value.feesEstimatedUCO
          : feesEstimatedUCO // ignore: cast_nullable_to_non_nullable
              as double,
      lpTokenAddress: freezed == lpTokenAddress
          ? _value.lpTokenAddress
          : lpTokenAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      consentDateTime: freezed == consentDateTime
          ? _value.consentDateTime
          : consentDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      rewardAmount: freezed == rewardAmount
          ? _value.rewardAmount
          : rewardAmount // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class _$FarmLockClaimFormStateImpl extends _FarmLockClaimFormState {
  const _$FarmLockClaimFormStateImpl(
      {this.processStep = ProcessStep.form,
      this.resumeProcess = false,
      this.currentStep = 0,
      this.isProcessInProgress = false,
      this.farmLockClaimOk = false,
      this.transactionClaimFarmLock,
      this.failure,
      this.finalAmount,
      this.farmAddress,
      this.poolAddress,
      this.rewardToken,
      this.depositId,
      this.feesEstimatedUCO = 0.0,
      this.lpTokenAddress,
      this.consentDateTime,
      this.rewardAmount})
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
  final bool farmLockClaimOk;
  @override
  final Transaction? transactionClaimFarmLock;
  @override
  final Failure? failure;
  @override
  final double? finalAmount;
  @override
  final String? farmAddress;
  @override
  final String? poolAddress;
  @override
  final DexToken? rewardToken;
  @override
  final String? depositId;
  @override
  @JsonKey()
  final double feesEstimatedUCO;
  @override
  final String? lpTokenAddress;
  @override
  final DateTime? consentDateTime;
  @override
  final double? rewardAmount;

  @override
  String toString() {
    return 'FarmLockClaimFormState(processStep: $processStep, resumeProcess: $resumeProcess, currentStep: $currentStep, isProcessInProgress: $isProcessInProgress, farmLockClaimOk: $farmLockClaimOk, transactionClaimFarmLock: $transactionClaimFarmLock, failure: $failure, finalAmount: $finalAmount, farmAddress: $farmAddress, poolAddress: $poolAddress, rewardToken: $rewardToken, depositId: $depositId, feesEstimatedUCO: $feesEstimatedUCO, lpTokenAddress: $lpTokenAddress, consentDateTime: $consentDateTime, rewardAmount: $rewardAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FarmLockClaimFormStateImpl &&
            (identical(other.processStep, processStep) ||
                other.processStep == processStep) &&
            (identical(other.resumeProcess, resumeProcess) ||
                other.resumeProcess == resumeProcess) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.isProcessInProgress, isProcessInProgress) ||
                other.isProcessInProgress == isProcessInProgress) &&
            (identical(other.farmLockClaimOk, farmLockClaimOk) ||
                other.farmLockClaimOk == farmLockClaimOk) &&
            (identical(
                    other.transactionClaimFarmLock, transactionClaimFarmLock) ||
                other.transactionClaimFarmLock == transactionClaimFarmLock) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            (identical(other.finalAmount, finalAmount) ||
                other.finalAmount == finalAmount) &&
            (identical(other.farmAddress, farmAddress) ||
                other.farmAddress == farmAddress) &&
            (identical(other.poolAddress, poolAddress) ||
                other.poolAddress == poolAddress) &&
            (identical(other.rewardToken, rewardToken) ||
                other.rewardToken == rewardToken) &&
            (identical(other.depositId, depositId) ||
                other.depositId == depositId) &&
            (identical(other.feesEstimatedUCO, feesEstimatedUCO) ||
                other.feesEstimatedUCO == feesEstimatedUCO) &&
            (identical(other.lpTokenAddress, lpTokenAddress) ||
                other.lpTokenAddress == lpTokenAddress) &&
            (identical(other.consentDateTime, consentDateTime) ||
                other.consentDateTime == consentDateTime) &&
            (identical(other.rewardAmount, rewardAmount) ||
                other.rewardAmount == rewardAmount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      processStep,
      resumeProcess,
      currentStep,
      isProcessInProgress,
      farmLockClaimOk,
      transactionClaimFarmLock,
      failure,
      finalAmount,
      farmAddress,
      poolAddress,
      rewardToken,
      depositId,
      feesEstimatedUCO,
      lpTokenAddress,
      consentDateTime,
      rewardAmount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FarmLockClaimFormStateImplCopyWith<_$FarmLockClaimFormStateImpl>
      get copyWith => __$$FarmLockClaimFormStateImplCopyWithImpl<
          _$FarmLockClaimFormStateImpl>(this, _$identity);
}

abstract class _FarmLockClaimFormState extends FarmLockClaimFormState {
  const factory _FarmLockClaimFormState(
      {final ProcessStep processStep,
      final bool resumeProcess,
      final int currentStep,
      final bool isProcessInProgress,
      final bool farmLockClaimOk,
      final Transaction? transactionClaimFarmLock,
      final Failure? failure,
      final double? finalAmount,
      final String? farmAddress,
      final String? poolAddress,
      final DexToken? rewardToken,
      final String? depositId,
      final double feesEstimatedUCO,
      final String? lpTokenAddress,
      final DateTime? consentDateTime,
      final double? rewardAmount}) = _$FarmLockClaimFormStateImpl;
  const _FarmLockClaimFormState._() : super._();

  @override
  ProcessStep get processStep;
  @override
  bool get resumeProcess;
  @override
  int get currentStep;
  @override
  bool get isProcessInProgress;
  @override
  bool get farmLockClaimOk;
  @override
  Transaction? get transactionClaimFarmLock;
  @override
  Failure? get failure;
  @override
  double? get finalAmount;
  @override
  String? get farmAddress;
  @override
  String? get poolAddress;
  @override
  DexToken? get rewardToken;
  @override
  String? get depositId;
  @override
  double get feesEstimatedUCO;
  @override
  String? get lpTokenAddress;
  @override
  DateTime? get consentDateTime;
  @override
  double? get rewardAmount;
  @override
  @JsonKey(ignore: true)
  _$$FarmLockClaimFormStateImplCopyWith<_$FarmLockClaimFormStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
