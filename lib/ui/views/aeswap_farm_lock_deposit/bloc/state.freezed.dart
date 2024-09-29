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
mixin _$FarmLockDepositFormState {
  ProcessStep get processStep => throw _privateConstructorUsedError;
  bool get resumeProcess => throw _privateConstructorUsedError;
  int get currentStep => throw _privateConstructorUsedError;
  DexPool? get pool => throw _privateConstructorUsedError;
  DexFarmLock? get farmLock => throw _privateConstructorUsedError;
  bool get isProcessInProgress => throw _privateConstructorUsedError;
  bool get farmLockDepositOk => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  double? get aprEstimation => throw _privateConstructorUsedError;
  FarmLockDepositDurationType get farmLockDepositDuration =>
      throw _privateConstructorUsedError;
  String get level => throw _privateConstructorUsedError;
  double get lpTokenBalance => throw _privateConstructorUsedError;
  double get feesEstimatedUCO => throw _privateConstructorUsedError;
  Transaction? get transactionFarmLockDeposit =>
      throw _privateConstructorUsedError;
  Map<String, int> get filterAvailableLevels =>
      throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;
  double? get finalAmount => throw _privateConstructorUsedError;
  DateTime? get consentDateTime => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FarmLockDepositFormStateCopyWith<FarmLockDepositFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FarmLockDepositFormStateCopyWith<$Res> {
  factory $FarmLockDepositFormStateCopyWith(FarmLockDepositFormState value,
          $Res Function(FarmLockDepositFormState) then) =
      _$FarmLockDepositFormStateCopyWithImpl<$Res, FarmLockDepositFormState>;
  @useResult
  $Res call(
      {ProcessStep processStep,
      bool resumeProcess,
      int currentStep,
      DexPool? pool,
      DexFarmLock? farmLock,
      bool isProcessInProgress,
      bool farmLockDepositOk,
      double amount,
      double? aprEstimation,
      FarmLockDepositDurationType farmLockDepositDuration,
      String level,
      double lpTokenBalance,
      double feesEstimatedUCO,
      Transaction? transactionFarmLockDeposit,
      Map<String, int> filterAvailableLevels,
      Failure? failure,
      double? finalAmount,
      DateTime? consentDateTime});

  $DexPoolCopyWith<$Res>? get pool;
  $DexFarmLockCopyWith<$Res>? get farmLock;
  $TransactionCopyWith<$Res>? get transactionFarmLockDeposit;
  $FailureCopyWith<$Res>? get failure;
}

/// @nodoc
class _$FarmLockDepositFormStateCopyWithImpl<$Res,
        $Val extends FarmLockDepositFormState>
    implements $FarmLockDepositFormStateCopyWith<$Res> {
  _$FarmLockDepositFormStateCopyWithImpl(this._value, this._then);

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
    Object? farmLockDepositOk = null,
    Object? amount = null,
    Object? aprEstimation = freezed,
    Object? farmLockDepositDuration = null,
    Object? level = null,
    Object? lpTokenBalance = null,
    Object? feesEstimatedUCO = null,
    Object? transactionFarmLockDeposit = freezed,
    Object? filterAvailableLevels = null,
    Object? failure = freezed,
    Object? finalAmount = freezed,
    Object? consentDateTime = freezed,
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
      farmLockDepositOk: null == farmLockDepositOk
          ? _value.farmLockDepositOk
          : farmLockDepositOk // ignore: cast_nullable_to_non_nullable
              as bool,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      aprEstimation: freezed == aprEstimation
          ? _value.aprEstimation
          : aprEstimation // ignore: cast_nullable_to_non_nullable
              as double?,
      farmLockDepositDuration: null == farmLockDepositDuration
          ? _value.farmLockDepositDuration
          : farmLockDepositDuration // ignore: cast_nullable_to_non_nullable
              as FarmLockDepositDurationType,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as String,
      lpTokenBalance: null == lpTokenBalance
          ? _value.lpTokenBalance
          : lpTokenBalance // ignore: cast_nullable_to_non_nullable
              as double,
      feesEstimatedUCO: null == feesEstimatedUCO
          ? _value.feesEstimatedUCO
          : feesEstimatedUCO // ignore: cast_nullable_to_non_nullable
              as double,
      transactionFarmLockDeposit: freezed == transactionFarmLockDeposit
          ? _value.transactionFarmLockDeposit
          : transactionFarmLockDeposit // ignore: cast_nullable_to_non_nullable
              as Transaction?,
      filterAvailableLevels: null == filterAvailableLevels
          ? _value.filterAvailableLevels
          : filterAvailableLevels // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      finalAmount: freezed == finalAmount
          ? _value.finalAmount
          : finalAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      consentDateTime: freezed == consentDateTime
          ? _value.consentDateTime
          : consentDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
  $TransactionCopyWith<$Res>? get transactionFarmLockDeposit {
    if (_value.transactionFarmLockDeposit == null) {
      return null;
    }

    return $TransactionCopyWith<$Res>(_value.transactionFarmLockDeposit!,
        (value) {
      return _then(_value.copyWith(transactionFarmLockDeposit: value) as $Val);
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
abstract class _$$FarmLockDepositFormStateImplCopyWith<$Res>
    implements $FarmLockDepositFormStateCopyWith<$Res> {
  factory _$$FarmLockDepositFormStateImplCopyWith(
          _$FarmLockDepositFormStateImpl value,
          $Res Function(_$FarmLockDepositFormStateImpl) then) =
      __$$FarmLockDepositFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ProcessStep processStep,
      bool resumeProcess,
      int currentStep,
      DexPool? pool,
      DexFarmLock? farmLock,
      bool isProcessInProgress,
      bool farmLockDepositOk,
      double amount,
      double? aprEstimation,
      FarmLockDepositDurationType farmLockDepositDuration,
      String level,
      double lpTokenBalance,
      double feesEstimatedUCO,
      Transaction? transactionFarmLockDeposit,
      Map<String, int> filterAvailableLevels,
      Failure? failure,
      double? finalAmount,
      DateTime? consentDateTime});

  @override
  $DexPoolCopyWith<$Res>? get pool;
  @override
  $DexFarmLockCopyWith<$Res>? get farmLock;
  @override
  $TransactionCopyWith<$Res>? get transactionFarmLockDeposit;
  @override
  $FailureCopyWith<$Res>? get failure;
}

/// @nodoc
class __$$FarmLockDepositFormStateImplCopyWithImpl<$Res>
    extends _$FarmLockDepositFormStateCopyWithImpl<$Res,
        _$FarmLockDepositFormStateImpl>
    implements _$$FarmLockDepositFormStateImplCopyWith<$Res> {
  __$$FarmLockDepositFormStateImplCopyWithImpl(
      _$FarmLockDepositFormStateImpl _value,
      $Res Function(_$FarmLockDepositFormStateImpl) _then)
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
    Object? farmLockDepositOk = null,
    Object? amount = null,
    Object? aprEstimation = freezed,
    Object? farmLockDepositDuration = null,
    Object? level = null,
    Object? lpTokenBalance = null,
    Object? feesEstimatedUCO = null,
    Object? transactionFarmLockDeposit = freezed,
    Object? filterAvailableLevels = null,
    Object? failure = freezed,
    Object? finalAmount = freezed,
    Object? consentDateTime = freezed,
  }) {
    return _then(_$FarmLockDepositFormStateImpl(
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
      farmLockDepositOk: null == farmLockDepositOk
          ? _value.farmLockDepositOk
          : farmLockDepositOk // ignore: cast_nullable_to_non_nullable
              as bool,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      aprEstimation: freezed == aprEstimation
          ? _value.aprEstimation
          : aprEstimation // ignore: cast_nullable_to_non_nullable
              as double?,
      farmLockDepositDuration: null == farmLockDepositDuration
          ? _value.farmLockDepositDuration
          : farmLockDepositDuration // ignore: cast_nullable_to_non_nullable
              as FarmLockDepositDurationType,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as String,
      lpTokenBalance: null == lpTokenBalance
          ? _value.lpTokenBalance
          : lpTokenBalance // ignore: cast_nullable_to_non_nullable
              as double,
      feesEstimatedUCO: null == feesEstimatedUCO
          ? _value.feesEstimatedUCO
          : feesEstimatedUCO // ignore: cast_nullable_to_non_nullable
              as double,
      transactionFarmLockDeposit: freezed == transactionFarmLockDeposit
          ? _value.transactionFarmLockDeposit
          : transactionFarmLockDeposit // ignore: cast_nullable_to_non_nullable
              as Transaction?,
      filterAvailableLevels: null == filterAvailableLevels
          ? _value._filterAvailableLevels
          : filterAvailableLevels // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      finalAmount: freezed == finalAmount
          ? _value.finalAmount
          : finalAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      consentDateTime: freezed == consentDateTime
          ? _value.consentDateTime
          : consentDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$FarmLockDepositFormStateImpl extends _FarmLockDepositFormState {
  const _$FarmLockDepositFormStateImpl(
      {this.processStep = ProcessStep.form,
      this.resumeProcess = false,
      this.currentStep = 0,
      this.pool,
      this.farmLock,
      this.isProcessInProgress = false,
      this.farmLockDepositOk = false,
      this.amount = 0.0,
      this.aprEstimation,
      this.farmLockDepositDuration = FarmLockDepositDurationType.threeYears,
      this.level = '',
      this.lpTokenBalance = 0.0,
      this.feesEstimatedUCO = 0.0,
      this.transactionFarmLockDeposit,
      final Map<String, int> filterAvailableLevels = const {},
      this.failure,
      this.finalAmount,
      this.consentDateTime})
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
  final bool farmLockDepositOk;
  @override
  @JsonKey()
  final double amount;
  @override
  final double? aprEstimation;
  @override
  @JsonKey()
  final FarmLockDepositDurationType farmLockDepositDuration;
  @override
  @JsonKey()
  final String level;
  @override
  @JsonKey()
  final double lpTokenBalance;
  @override
  @JsonKey()
  final double feesEstimatedUCO;
  @override
  final Transaction? transactionFarmLockDeposit;
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
  final Failure? failure;
  @override
  final double? finalAmount;
  @override
  final DateTime? consentDateTime;

  @override
  String toString() {
    return 'FarmLockDepositFormState(processStep: $processStep, resumeProcess: $resumeProcess, currentStep: $currentStep, pool: $pool, farmLock: $farmLock, isProcessInProgress: $isProcessInProgress, farmLockDepositOk: $farmLockDepositOk, amount: $amount, aprEstimation: $aprEstimation, farmLockDepositDuration: $farmLockDepositDuration, level: $level, lpTokenBalance: $lpTokenBalance, feesEstimatedUCO: $feesEstimatedUCO, transactionFarmLockDeposit: $transactionFarmLockDeposit, filterAvailableLevels: $filterAvailableLevels, failure: $failure, finalAmount: $finalAmount, consentDateTime: $consentDateTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FarmLockDepositFormStateImpl &&
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
            (identical(other.farmLockDepositOk, farmLockDepositOk) ||
                other.farmLockDepositOk == farmLockDepositOk) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.aprEstimation, aprEstimation) ||
                other.aprEstimation == aprEstimation) &&
            (identical(
                    other.farmLockDepositDuration, farmLockDepositDuration) ||
                other.farmLockDepositDuration == farmLockDepositDuration) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.lpTokenBalance, lpTokenBalance) ||
                other.lpTokenBalance == lpTokenBalance) &&
            (identical(other.feesEstimatedUCO, feesEstimatedUCO) ||
                other.feesEstimatedUCO == feesEstimatedUCO) &&
            (identical(other.transactionFarmLockDeposit,
                    transactionFarmLockDeposit) ||
                other.transactionFarmLockDeposit ==
                    transactionFarmLockDeposit) &&
            const DeepCollectionEquality()
                .equals(other._filterAvailableLevels, _filterAvailableLevels) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            (identical(other.finalAmount, finalAmount) ||
                other.finalAmount == finalAmount) &&
            (identical(other.consentDateTime, consentDateTime) ||
                other.consentDateTime == consentDateTime));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      processStep,
      resumeProcess,
      currentStep,
      pool,
      farmLock,
      isProcessInProgress,
      farmLockDepositOk,
      amount,
      aprEstimation,
      farmLockDepositDuration,
      level,
      lpTokenBalance,
      feesEstimatedUCO,
      transactionFarmLockDeposit,
      const DeepCollectionEquality().hash(_filterAvailableLevels),
      failure,
      finalAmount,
      consentDateTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FarmLockDepositFormStateImplCopyWith<_$FarmLockDepositFormStateImpl>
      get copyWith => __$$FarmLockDepositFormStateImplCopyWithImpl<
          _$FarmLockDepositFormStateImpl>(this, _$identity);
}

abstract class _FarmLockDepositFormState extends FarmLockDepositFormState {
  const factory _FarmLockDepositFormState(
      {final ProcessStep processStep,
      final bool resumeProcess,
      final int currentStep,
      final DexPool? pool,
      final DexFarmLock? farmLock,
      final bool isProcessInProgress,
      final bool farmLockDepositOk,
      final double amount,
      final double? aprEstimation,
      final FarmLockDepositDurationType farmLockDepositDuration,
      final String level,
      final double lpTokenBalance,
      final double feesEstimatedUCO,
      final Transaction? transactionFarmLockDeposit,
      final Map<String, int> filterAvailableLevels,
      final Failure? failure,
      final double? finalAmount,
      final DateTime? consentDateTime}) = _$FarmLockDepositFormStateImpl;
  const _FarmLockDepositFormState._() : super._();

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
  bool get farmLockDepositOk;
  @override
  double get amount;
  @override
  double? get aprEstimation;
  @override
  FarmLockDepositDurationType get farmLockDepositDuration;
  @override
  String get level;
  @override
  double get lpTokenBalance;
  @override
  double get feesEstimatedUCO;
  @override
  Transaction? get transactionFarmLockDeposit;
  @override
  Map<String, int> get filterAvailableLevels;
  @override
  Failure? get failure;
  @override
  double? get finalAmount;
  @override
  DateTime? get consentDateTime;
  @override
  @JsonKey(ignore: true)
  _$$FarmLockDepositFormStateImplCopyWith<_$FarmLockDepositFormStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
