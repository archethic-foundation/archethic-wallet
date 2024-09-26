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
mixin _$FarmLockLevelUpFormState {
  ProcessStep get processStep => throw _privateConstructorUsedError;
  bool get resumeProcess => throw _privateConstructorUsedError;
  int get currentStep => throw _privateConstructorUsedError;
  DexPool? get pool => throw _privateConstructorUsedError;
  DexFarmLock? get farmLock => throw _privateConstructorUsedError;
  bool get isProcessInProgress => throw _privateConstructorUsedError;
  bool get farmLockLevelUpOk => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  double? get aprEstimation => throw _privateConstructorUsedError;
  FarmLockDepositDurationType get farmLockLevelUpDuration =>
      throw _privateConstructorUsedError;
  double get lpTokenBalance => throw _privateConstructorUsedError;
  Transaction? get transactionFarmLockLevelUp =>
      throw _privateConstructorUsedError;
  Map<String, int> get filterAvailableLevels =>
      throw _privateConstructorUsedError;
  String get level => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;
  double get feesEstimatedUCO => throw _privateConstructorUsedError;
  double? get finalAmount => throw _privateConstructorUsedError;
  DateTime? get consentDateTime => throw _privateConstructorUsedError;
  String? get depositId => throw _privateConstructorUsedError;
  String? get currentLevel => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FarmLockLevelUpFormStateCopyWith<FarmLockLevelUpFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FarmLockLevelUpFormStateCopyWith<$Res> {
  factory $FarmLockLevelUpFormStateCopyWith(FarmLockLevelUpFormState value,
          $Res Function(FarmLockLevelUpFormState) then) =
      _$FarmLockLevelUpFormStateCopyWithImpl<$Res, FarmLockLevelUpFormState>;
  @useResult
  $Res call(
      {ProcessStep processStep,
      bool resumeProcess,
      int currentStep,
      DexPool? pool,
      DexFarmLock? farmLock,
      bool isProcessInProgress,
      bool farmLockLevelUpOk,
      double amount,
      double? aprEstimation,
      FarmLockDepositDurationType farmLockLevelUpDuration,
      double lpTokenBalance,
      Transaction? transactionFarmLockLevelUp,
      Map<String, int> filterAvailableLevels,
      String level,
      Failure? failure,
      double feesEstimatedUCO,
      double? finalAmount,
      DateTime? consentDateTime,
      String? depositId,
      String? currentLevel});

  $DexPoolCopyWith<$Res>? get pool;
  $DexFarmLockCopyWith<$Res>? get farmLock;
  $TransactionCopyWith<$Res>? get transactionFarmLockLevelUp;
  $FailureCopyWith<$Res>? get failure;
}

/// @nodoc
class _$FarmLockLevelUpFormStateCopyWithImpl<$Res,
        $Val extends FarmLockLevelUpFormState>
    implements $FarmLockLevelUpFormStateCopyWith<$Res> {
  _$FarmLockLevelUpFormStateCopyWithImpl(this._value, this._then);

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
    Object? pool = freezed,
    Object? farmLock = freezed,
    Object? isProcessInProgress = null,
    Object? farmLockLevelUpOk = null,
    Object? amount = null,
    Object? aprEstimation = freezed,
    Object? farmLockLevelUpDuration = null,
    Object? lpTokenBalance = null,
    Object? transactionFarmLockLevelUp = freezed,
    Object? filterAvailableLevels = null,
    Object? level = null,
    Object? failure = freezed,
    Object? feesEstimatedUCO = null,
    Object? finalAmount = freezed,
    Object? consentDateTime = freezed,
    Object? depositId = freezed,
    Object? currentLevel = freezed,
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
      pool: freezed == pool
          ? _value.pool
          : pool // ignore: cast_nullable_to_non_nullable
              as DexPool?,
      farmLock: freezed == farmLock
          ? _value.farmLock
          : farmLock // ignore: cast_nullable_to_non_nullable
              as DexFarmLock?,
      isProcessInProgress: null == isProcessInProgress
          ? _value.isProcessInProgress
          : isProcessInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      farmLockLevelUpOk: null == farmLockLevelUpOk
          ? _value.farmLockLevelUpOk
          : farmLockLevelUpOk // ignore: cast_nullable_to_non_nullable
              as bool,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      aprEstimation: freezed == aprEstimation
          ? _value.aprEstimation
          : aprEstimation // ignore: cast_nullable_to_non_nullable
              as double?,
      farmLockLevelUpDuration: null == farmLockLevelUpDuration
          ? _value.farmLockLevelUpDuration
          : farmLockLevelUpDuration // ignore: cast_nullable_to_non_nullable
              as FarmLockDepositDurationType,
      lpTokenBalance: null == lpTokenBalance
          ? _value.lpTokenBalance
          : lpTokenBalance // ignore: cast_nullable_to_non_nullable
              as double,
      transactionFarmLockLevelUp: freezed == transactionFarmLockLevelUp
          ? _value.transactionFarmLockLevelUp
          : transactionFarmLockLevelUp // ignore: cast_nullable_to_non_nullable
              as Transaction?,
      filterAvailableLevels: null == filterAvailableLevels
          ? _value.filterAvailableLevels
          : filterAvailableLevels // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as String,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      feesEstimatedUCO: null == feesEstimatedUCO
          ? _value.feesEstimatedUCO
          : feesEstimatedUCO // ignore: cast_nullable_to_non_nullable
              as double,
      finalAmount: freezed == finalAmount
          ? _value.finalAmount
          : finalAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      consentDateTime: freezed == consentDateTime
          ? _value.consentDateTime
          : consentDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      depositId: freezed == depositId
          ? _value.depositId
          : depositId // ignore: cast_nullable_to_non_nullable
              as String?,
      currentLevel: freezed == currentLevel
          ? _value.currentLevel
          : currentLevel // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DexPoolCopyWith<$Res>? get pool {
    if (_value.pool == null) {
      return null;
    }

    return $DexPoolCopyWith<$Res>(_value.pool!, (value) {
      return _then(_value.copyWith(pool: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DexFarmLockCopyWith<$Res>? get farmLock {
    if (_value.farmLock == null) {
      return null;
    }

    return $DexFarmLockCopyWith<$Res>(_value.farmLock!, (value) {
      return _then(_value.copyWith(farmLock: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TransactionCopyWith<$Res>? get transactionFarmLockLevelUp {
    if (_value.transactionFarmLockLevelUp == null) {
      return null;
    }

    return $TransactionCopyWith<$Res>(_value.transactionFarmLockLevelUp!,
        (value) {
      return _then(_value.copyWith(transactionFarmLockLevelUp: value) as $Val);
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
}

/// @nodoc
abstract class _$$FarmLockLevelUpFormStateImplCopyWith<$Res>
    implements $FarmLockLevelUpFormStateCopyWith<$Res> {
  factory _$$FarmLockLevelUpFormStateImplCopyWith(
          _$FarmLockLevelUpFormStateImpl value,
          $Res Function(_$FarmLockLevelUpFormStateImpl) then) =
      __$$FarmLockLevelUpFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ProcessStep processStep,
      bool resumeProcess,
      int currentStep,
      DexPool? pool,
      DexFarmLock? farmLock,
      bool isProcessInProgress,
      bool farmLockLevelUpOk,
      double amount,
      double? aprEstimation,
      FarmLockDepositDurationType farmLockLevelUpDuration,
      double lpTokenBalance,
      Transaction? transactionFarmLockLevelUp,
      Map<String, int> filterAvailableLevels,
      String level,
      Failure? failure,
      double feesEstimatedUCO,
      double? finalAmount,
      DateTime? consentDateTime,
      String? depositId,
      String? currentLevel});

  @override
  $DexPoolCopyWith<$Res>? get pool;
  @override
  $DexFarmLockCopyWith<$Res>? get farmLock;
  @override
  $TransactionCopyWith<$Res>? get transactionFarmLockLevelUp;
  @override
  $FailureCopyWith<$Res>? get failure;
}

/// @nodoc
class __$$FarmLockLevelUpFormStateImplCopyWithImpl<$Res>
    extends _$FarmLockLevelUpFormStateCopyWithImpl<$Res,
        _$FarmLockLevelUpFormStateImpl>
    implements _$$FarmLockLevelUpFormStateImplCopyWith<$Res> {
  __$$FarmLockLevelUpFormStateImplCopyWithImpl(
      _$FarmLockLevelUpFormStateImpl _value,
      $Res Function(_$FarmLockLevelUpFormStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? processStep = null,
    Object? resumeProcess = null,
    Object? currentStep = null,
    Object? pool = freezed,
    Object? farmLock = freezed,
    Object? isProcessInProgress = null,
    Object? farmLockLevelUpOk = null,
    Object? amount = null,
    Object? aprEstimation = freezed,
    Object? farmLockLevelUpDuration = null,
    Object? lpTokenBalance = null,
    Object? transactionFarmLockLevelUp = freezed,
    Object? filterAvailableLevels = null,
    Object? level = null,
    Object? failure = freezed,
    Object? feesEstimatedUCO = null,
    Object? finalAmount = freezed,
    Object? consentDateTime = freezed,
    Object? depositId = freezed,
    Object? currentLevel = freezed,
  }) {
    return _then(_$FarmLockLevelUpFormStateImpl(
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
      pool: freezed == pool
          ? _value.pool
          : pool // ignore: cast_nullable_to_non_nullable
              as DexPool?,
      farmLock: freezed == farmLock
          ? _value.farmLock
          : farmLock // ignore: cast_nullable_to_non_nullable
              as DexFarmLock?,
      isProcessInProgress: null == isProcessInProgress
          ? _value.isProcessInProgress
          : isProcessInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      farmLockLevelUpOk: null == farmLockLevelUpOk
          ? _value.farmLockLevelUpOk
          : farmLockLevelUpOk // ignore: cast_nullable_to_non_nullable
              as bool,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      aprEstimation: freezed == aprEstimation
          ? _value.aprEstimation
          : aprEstimation // ignore: cast_nullable_to_non_nullable
              as double?,
      farmLockLevelUpDuration: null == farmLockLevelUpDuration
          ? _value.farmLockLevelUpDuration
          : farmLockLevelUpDuration // ignore: cast_nullable_to_non_nullable
              as FarmLockDepositDurationType,
      lpTokenBalance: null == lpTokenBalance
          ? _value.lpTokenBalance
          : lpTokenBalance // ignore: cast_nullable_to_non_nullable
              as double,
      transactionFarmLockLevelUp: freezed == transactionFarmLockLevelUp
          ? _value.transactionFarmLockLevelUp
          : transactionFarmLockLevelUp // ignore: cast_nullable_to_non_nullable
              as Transaction?,
      filterAvailableLevels: null == filterAvailableLevels
          ? _value._filterAvailableLevels
          : filterAvailableLevels // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as String,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      feesEstimatedUCO: null == feesEstimatedUCO
          ? _value.feesEstimatedUCO
          : feesEstimatedUCO // ignore: cast_nullable_to_non_nullable
              as double,
      finalAmount: freezed == finalAmount
          ? _value.finalAmount
          : finalAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      consentDateTime: freezed == consentDateTime
          ? _value.consentDateTime
          : consentDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      depositId: freezed == depositId
          ? _value.depositId
          : depositId // ignore: cast_nullable_to_non_nullable
              as String?,
      currentLevel: freezed == currentLevel
          ? _value.currentLevel
          : currentLevel // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$FarmLockLevelUpFormStateImpl extends _FarmLockLevelUpFormState {
  const _$FarmLockLevelUpFormStateImpl(
      {this.processStep = ProcessStep.form,
      this.resumeProcess = false,
      this.currentStep = 0,
      this.pool,
      this.farmLock,
      this.isProcessInProgress = false,
      this.farmLockLevelUpOk = false,
      this.amount = 0.0,
      this.aprEstimation,
      this.farmLockLevelUpDuration = FarmLockDepositDurationType.threeYears,
      this.lpTokenBalance = 0.0,
      this.transactionFarmLockLevelUp,
      final Map<String, int> filterAvailableLevels = const {},
      this.level = '',
      this.failure,
      this.feesEstimatedUCO = 0.0,
      this.finalAmount,
      this.consentDateTime,
      this.depositId,
      this.currentLevel})
      : _filterAvailableLevels = filterAvailableLevels,
        super._();

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
  final DexPool? pool;
  @override
  final DexFarmLock? farmLock;
  @override
  @JsonKey()
  final bool isProcessInProgress;
  @override
  @JsonKey()
  final bool farmLockLevelUpOk;
  @override
  @JsonKey()
  final double amount;
  @override
  final double? aprEstimation;
  @override
  @JsonKey()
  final FarmLockDepositDurationType farmLockLevelUpDuration;
  @override
  @JsonKey()
  final double lpTokenBalance;
  @override
  final Transaction? transactionFarmLockLevelUp;
  final Map<String, int> _filterAvailableLevels;
  @override
  @JsonKey()
  Map<String, int> get filterAvailableLevels {
    if (_filterAvailableLevels is EqualUnmodifiableMapView)
      return _filterAvailableLevels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_filterAvailableLevels);
  }

  @override
  @JsonKey()
  final String level;
  @override
  final Failure? failure;
  @override
  @JsonKey()
  final double feesEstimatedUCO;
  @override
  final double? finalAmount;
  @override
  final DateTime? consentDateTime;
  @override
  final String? depositId;
  @override
  final String? currentLevel;

  @override
  String toString() {
    return 'FarmLockLevelUpFormState(processStep: $processStep, resumeProcess: $resumeProcess, currentStep: $currentStep, pool: $pool, farmLock: $farmLock, isProcessInProgress: $isProcessInProgress, farmLockLevelUpOk: $farmLockLevelUpOk, amount: $amount, aprEstimation: $aprEstimation, farmLockLevelUpDuration: $farmLockLevelUpDuration, lpTokenBalance: $lpTokenBalance, transactionFarmLockLevelUp: $transactionFarmLockLevelUp, filterAvailableLevels: $filterAvailableLevels, level: $level, failure: $failure, feesEstimatedUCO: $feesEstimatedUCO, finalAmount: $finalAmount, consentDateTime: $consentDateTime, depositId: $depositId, currentLevel: $currentLevel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FarmLockLevelUpFormStateImpl &&
            (identical(other.processStep, processStep) ||
                other.processStep == processStep) &&
            (identical(other.resumeProcess, resumeProcess) ||
                other.resumeProcess == resumeProcess) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.pool, pool) || other.pool == pool) &&
            (identical(other.farmLock, farmLock) ||
                other.farmLock == farmLock) &&
            (identical(other.isProcessInProgress, isProcessInProgress) ||
                other.isProcessInProgress == isProcessInProgress) &&
            (identical(other.farmLockLevelUpOk, farmLockLevelUpOk) ||
                other.farmLockLevelUpOk == farmLockLevelUpOk) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.aprEstimation, aprEstimation) ||
                other.aprEstimation == aprEstimation) &&
            (identical(
                    other.farmLockLevelUpDuration, farmLockLevelUpDuration) ||
                other.farmLockLevelUpDuration == farmLockLevelUpDuration) &&
            (identical(other.lpTokenBalance, lpTokenBalance) ||
                other.lpTokenBalance == lpTokenBalance) &&
            (identical(other.transactionFarmLockLevelUp,
                    transactionFarmLockLevelUp) ||
                other.transactionFarmLockLevelUp ==
                    transactionFarmLockLevelUp) &&
            const DeepCollectionEquality()
                .equals(other._filterAvailableLevels, _filterAvailableLevels) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            (identical(other.feesEstimatedUCO, feesEstimatedUCO) ||
                other.feesEstimatedUCO == feesEstimatedUCO) &&
            (identical(other.finalAmount, finalAmount) ||
                other.finalAmount == finalAmount) &&
            (identical(other.consentDateTime, consentDateTime) ||
                other.consentDateTime == consentDateTime) &&
            (identical(other.depositId, depositId) ||
                other.depositId == depositId) &&
            (identical(other.currentLevel, currentLevel) ||
                other.currentLevel == currentLevel));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        processStep,
        resumeProcess,
        currentStep,
        pool,
        farmLock,
        isProcessInProgress,
        farmLockLevelUpOk,
        amount,
        aprEstimation,
        farmLockLevelUpDuration,
        lpTokenBalance,
        transactionFarmLockLevelUp,
        const DeepCollectionEquality().hash(_filterAvailableLevels),
        level,
        failure,
        feesEstimatedUCO,
        finalAmount,
        consentDateTime,
        depositId,
        currentLevel
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FarmLockLevelUpFormStateImplCopyWith<_$FarmLockLevelUpFormStateImpl>
      get copyWith => __$$FarmLockLevelUpFormStateImplCopyWithImpl<
          _$FarmLockLevelUpFormStateImpl>(this, _$identity);
}

abstract class _FarmLockLevelUpFormState extends FarmLockLevelUpFormState {
  const factory _FarmLockLevelUpFormState(
      {final ProcessStep processStep,
      final bool resumeProcess,
      final int currentStep,
      final DexPool? pool,
      final DexFarmLock? farmLock,
      final bool isProcessInProgress,
      final bool farmLockLevelUpOk,
      final double amount,
      final double? aprEstimation,
      final FarmLockDepositDurationType farmLockLevelUpDuration,
      final double lpTokenBalance,
      final Transaction? transactionFarmLockLevelUp,
      final Map<String, int> filterAvailableLevels,
      final String level,
      final Failure? failure,
      final double feesEstimatedUCO,
      final double? finalAmount,
      final DateTime? consentDateTime,
      final String? depositId,
      final String? currentLevel}) = _$FarmLockLevelUpFormStateImpl;
  const _FarmLockLevelUpFormState._() : super._();

  @override
  ProcessStep get processStep;
  @override
  bool get resumeProcess;
  @override
  int get currentStep;
  @override
  DexPool? get pool;
  @override
  DexFarmLock? get farmLock;
  @override
  bool get isProcessInProgress;
  @override
  bool get farmLockLevelUpOk;
  @override
  double get amount;
  @override
  double? get aprEstimation;
  @override
  FarmLockDepositDurationType get farmLockLevelUpDuration;
  @override
  double get lpTokenBalance;
  @override
  Transaction? get transactionFarmLockLevelUp;
  @override
  Map<String, int> get filterAvailableLevels;
  @override
  String get level;
  @override
  Failure? get failure;
  @override
  double get feesEstimatedUCO;
  @override
  double? get finalAmount;
  @override
  DateTime? get consentDateTime;
  @override
  String? get depositId;
  @override
  String? get currentLevel;
  @override
  @JsonKey(ignore: true)
  _$$FarmLockLevelUpFormStateImplCopyWith<_$FarmLockLevelUpFormStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
