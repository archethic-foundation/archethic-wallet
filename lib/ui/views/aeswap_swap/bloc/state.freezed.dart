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
mixin _$SwapFormState {
  ProcessStep get processStep => throw _privateConstructorUsedError;
  bool get resumeProcess => throw _privateConstructorUsedError;
  bool get calculateAmountToSwap => throw _privateConstructorUsedError;
  bool get calculateAmountSwapped => throw _privateConstructorUsedError;
  int get currentStep => throw _privateConstructorUsedError;
  int get tokenFormSelected => throw _privateConstructorUsedError;
  String get poolGenesisAddress => throw _privateConstructorUsedError;
  DexToken? get tokenToSwap => throw _privateConstructorUsedError;
  bool get isProcessInProgress => throw _privateConstructorUsedError;
  bool get swapOk => throw _privateConstructorUsedError;
  bool get messageMaxHalfUCO => throw _privateConstructorUsedError;
  double get tokenToSwapBalance => throw _privateConstructorUsedError;
  double get tokenToSwapAmount => throw _privateConstructorUsedError;
  DexToken? get tokenSwapped => throw _privateConstructorUsedError;
  double get tokenSwappedBalance => throw _privateConstructorUsedError;
  double get tokenSwappedAmount => throw _privateConstructorUsedError;
  double get ratio => throw _privateConstructorUsedError;
  double get swapFees => throw _privateConstructorUsedError;
  double get swapProtocolFees => throw _privateConstructorUsedError;
  double get slippageTolerance => throw _privateConstructorUsedError;
  double get minToReceive => throw _privateConstructorUsedError;
  double get priceImpact => throw _privateConstructorUsedError;
  double get estimatedReceived => throw _privateConstructorUsedError;
  double get feesEstimatedUCO => throw _privateConstructorUsedError;
  double? get finalAmount => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;
  Transaction? get recoveryTransactionSwap =>
      throw _privateConstructorUsedError;
  bool get calculationInProgress => throw _privateConstructorUsedError;
  DexPool? get pool => throw _privateConstructorUsedError;
  DexPoolInfos? get poolInfos => throw _privateConstructorUsedError;
  DateTime? get consentDateTime => throw _privateConstructorUsedError;

  /// Create a copy of SwapFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SwapFormStateCopyWith<SwapFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SwapFormStateCopyWith<$Res> {
  factory $SwapFormStateCopyWith(
          SwapFormState value, $Res Function(SwapFormState) then) =
      _$SwapFormStateCopyWithImpl<$Res, SwapFormState>;
  @useResult
  $Res call(
      {ProcessStep processStep,
      bool resumeProcess,
      bool calculateAmountToSwap,
      bool calculateAmountSwapped,
      int currentStep,
      int tokenFormSelected,
      String poolGenesisAddress,
      DexToken? tokenToSwap,
      bool isProcessInProgress,
      bool swapOk,
      bool messageMaxHalfUCO,
      double tokenToSwapBalance,
      double tokenToSwapAmount,
      DexToken? tokenSwapped,
      double tokenSwappedBalance,
      double tokenSwappedAmount,
      double ratio,
      double swapFees,
      double swapProtocolFees,
      double slippageTolerance,
      double minToReceive,
      double priceImpact,
      double estimatedReceived,
      double feesEstimatedUCO,
      double? finalAmount,
      Failure? failure,
      Transaction? recoveryTransactionSwap,
      bool calculationInProgress,
      DexPool? pool,
      DexPoolInfos? poolInfos,
      DateTime? consentDateTime});

  $DexTokenCopyWith<$Res>? get tokenToSwap;
  $DexTokenCopyWith<$Res>? get tokenSwapped;
  $FailureCopyWith<$Res>? get failure;
  $TransactionCopyWith<$Res>? get recoveryTransactionSwap;
  $DexPoolCopyWith<$Res>? get pool;
  $DexPoolInfosCopyWith<$Res>? get poolInfos;
}

/// @nodoc
class _$SwapFormStateCopyWithImpl<$Res, $Val extends SwapFormState>
    implements $SwapFormStateCopyWith<$Res> {
  _$SwapFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SwapFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? processStep = null,
    Object? resumeProcess = null,
    Object? calculateAmountToSwap = null,
    Object? calculateAmountSwapped = null,
    Object? currentStep = null,
    Object? tokenFormSelected = null,
    Object? poolGenesisAddress = null,
    Object? tokenToSwap = freezed,
    Object? isProcessInProgress = null,
    Object? swapOk = null,
    Object? messageMaxHalfUCO = null,
    Object? tokenToSwapBalance = null,
    Object? tokenToSwapAmount = null,
    Object? tokenSwapped = freezed,
    Object? tokenSwappedBalance = null,
    Object? tokenSwappedAmount = null,
    Object? ratio = null,
    Object? swapFees = null,
    Object? swapProtocolFees = null,
    Object? slippageTolerance = null,
    Object? minToReceive = null,
    Object? priceImpact = null,
    Object? estimatedReceived = null,
    Object? feesEstimatedUCO = null,
    Object? finalAmount = freezed,
    Object? failure = freezed,
    Object? recoveryTransactionSwap = freezed,
    Object? calculationInProgress = null,
    Object? pool = freezed,
    Object? poolInfos = freezed,
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
      calculateAmountToSwap: null == calculateAmountToSwap
          ? _value.calculateAmountToSwap
          : calculateAmountToSwap // ignore: cast_nullable_to_non_nullable
              as bool,
      calculateAmountSwapped: null == calculateAmountSwapped
          ? _value.calculateAmountSwapped
          : calculateAmountSwapped // ignore: cast_nullable_to_non_nullable
              as bool,
      currentStep: null == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
      tokenFormSelected: null == tokenFormSelected
          ? _value.tokenFormSelected
          : tokenFormSelected // ignore: cast_nullable_to_non_nullable
              as int,
      poolGenesisAddress: null == poolGenesisAddress
          ? _value.poolGenesisAddress
          : poolGenesisAddress // ignore: cast_nullable_to_non_nullable
              as String,
      tokenToSwap: freezed == tokenToSwap
          ? _value.tokenToSwap
          : tokenToSwap // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      isProcessInProgress: null == isProcessInProgress
          ? _value.isProcessInProgress
          : isProcessInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      swapOk: null == swapOk
          ? _value.swapOk
          : swapOk // ignore: cast_nullable_to_non_nullable
              as bool,
      messageMaxHalfUCO: null == messageMaxHalfUCO
          ? _value.messageMaxHalfUCO
          : messageMaxHalfUCO // ignore: cast_nullable_to_non_nullable
              as bool,
      tokenToSwapBalance: null == tokenToSwapBalance
          ? _value.tokenToSwapBalance
          : tokenToSwapBalance // ignore: cast_nullable_to_non_nullable
              as double,
      tokenToSwapAmount: null == tokenToSwapAmount
          ? _value.tokenToSwapAmount
          : tokenToSwapAmount // ignore: cast_nullable_to_non_nullable
              as double,
      tokenSwapped: freezed == tokenSwapped
          ? _value.tokenSwapped
          : tokenSwapped // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      tokenSwappedBalance: null == tokenSwappedBalance
          ? _value.tokenSwappedBalance
          : tokenSwappedBalance // ignore: cast_nullable_to_non_nullable
              as double,
      tokenSwappedAmount: null == tokenSwappedAmount
          ? _value.tokenSwappedAmount
          : tokenSwappedAmount // ignore: cast_nullable_to_non_nullable
              as double,
      ratio: null == ratio
          ? _value.ratio
          : ratio // ignore: cast_nullable_to_non_nullable
              as double,
      swapFees: null == swapFees
          ? _value.swapFees
          : swapFees // ignore: cast_nullable_to_non_nullable
              as double,
      swapProtocolFees: null == swapProtocolFees
          ? _value.swapProtocolFees
          : swapProtocolFees // ignore: cast_nullable_to_non_nullable
              as double,
      slippageTolerance: null == slippageTolerance
          ? _value.slippageTolerance
          : slippageTolerance // ignore: cast_nullable_to_non_nullable
              as double,
      minToReceive: null == minToReceive
          ? _value.minToReceive
          : minToReceive // ignore: cast_nullable_to_non_nullable
              as double,
      priceImpact: null == priceImpact
          ? _value.priceImpact
          : priceImpact // ignore: cast_nullable_to_non_nullable
              as double,
      estimatedReceived: null == estimatedReceived
          ? _value.estimatedReceived
          : estimatedReceived // ignore: cast_nullable_to_non_nullable
              as double,
      feesEstimatedUCO: null == feesEstimatedUCO
          ? _value.feesEstimatedUCO
          : feesEstimatedUCO // ignore: cast_nullable_to_non_nullable
              as double,
      finalAmount: freezed == finalAmount
          ? _value.finalAmount
          : finalAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      recoveryTransactionSwap: freezed == recoveryTransactionSwap
          ? _value.recoveryTransactionSwap
          : recoveryTransactionSwap // ignore: cast_nullable_to_non_nullable
              as Transaction?,
      calculationInProgress: null == calculationInProgress
          ? _value.calculationInProgress
          : calculationInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      pool: freezed == pool
          ? _value.pool
          : pool // ignore: cast_nullable_to_non_nullable
              as DexPool?,
      poolInfos: freezed == poolInfos
          ? _value.poolInfos
          : poolInfos // ignore: cast_nullable_to_non_nullable
              as DexPoolInfos?,
      consentDateTime: freezed == consentDateTime
          ? _value.consentDateTime
          : consentDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of SwapFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DexTokenCopyWith<$Res>? get tokenToSwap {
    if (_value.tokenToSwap == null) {
      return null;
    }

    return $DexTokenCopyWith<$Res>(_value.tokenToSwap!, (value) {
      return _then(_value.copyWith(tokenToSwap: value) as $Val);
    });
  }

  /// Create a copy of SwapFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DexTokenCopyWith<$Res>? get tokenSwapped {
    if (_value.tokenSwapped == null) {
      return null;
    }

    return $DexTokenCopyWith<$Res>(_value.tokenSwapped!, (value) {
      return _then(_value.copyWith(tokenSwapped: value) as $Val);
    });
  }

  /// Create a copy of SwapFormState
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of SwapFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransactionCopyWith<$Res>? get recoveryTransactionSwap {
    if (_value.recoveryTransactionSwap == null) {
      return null;
    }

    return $TransactionCopyWith<$Res>(_value.recoveryTransactionSwap!, (value) {
      return _then(_value.copyWith(recoveryTransactionSwap: value) as $Val);
    });
  }

  /// Create a copy of SwapFormState
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of SwapFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DexPoolInfosCopyWith<$Res>? get poolInfos {
    if (_value.poolInfos == null) {
      return null;
    }

    return $DexPoolInfosCopyWith<$Res>(_value.poolInfos!, (value) {
      return _then(_value.copyWith(poolInfos: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SwapFormStateImplCopyWith<$Res>
    implements $SwapFormStateCopyWith<$Res> {
  factory _$$SwapFormStateImplCopyWith(
          _$SwapFormStateImpl value, $Res Function(_$SwapFormStateImpl) then) =
      __$$SwapFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ProcessStep processStep,
      bool resumeProcess,
      bool calculateAmountToSwap,
      bool calculateAmountSwapped,
      int currentStep,
      int tokenFormSelected,
      String poolGenesisAddress,
      DexToken? tokenToSwap,
      bool isProcessInProgress,
      bool swapOk,
      bool messageMaxHalfUCO,
      double tokenToSwapBalance,
      double tokenToSwapAmount,
      DexToken? tokenSwapped,
      double tokenSwappedBalance,
      double tokenSwappedAmount,
      double ratio,
      double swapFees,
      double swapProtocolFees,
      double slippageTolerance,
      double minToReceive,
      double priceImpact,
      double estimatedReceived,
      double feesEstimatedUCO,
      double? finalAmount,
      Failure? failure,
      Transaction? recoveryTransactionSwap,
      bool calculationInProgress,
      DexPool? pool,
      DexPoolInfos? poolInfos,
      DateTime? consentDateTime});

  @override
  $DexTokenCopyWith<$Res>? get tokenToSwap;
  @override
  $DexTokenCopyWith<$Res>? get tokenSwapped;
  @override
  $FailureCopyWith<$Res>? get failure;
  @override
  $TransactionCopyWith<$Res>? get recoveryTransactionSwap;
  @override
  $DexPoolCopyWith<$Res>? get pool;
  @override
  $DexPoolInfosCopyWith<$Res>? get poolInfos;
}

/// @nodoc
class __$$SwapFormStateImplCopyWithImpl<$Res>
    extends _$SwapFormStateCopyWithImpl<$Res, _$SwapFormStateImpl>
    implements _$$SwapFormStateImplCopyWith<$Res> {
  __$$SwapFormStateImplCopyWithImpl(
      _$SwapFormStateImpl _value, $Res Function(_$SwapFormStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SwapFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? processStep = null,
    Object? resumeProcess = null,
    Object? calculateAmountToSwap = null,
    Object? calculateAmountSwapped = null,
    Object? currentStep = null,
    Object? tokenFormSelected = null,
    Object? poolGenesisAddress = null,
    Object? tokenToSwap = freezed,
    Object? isProcessInProgress = null,
    Object? swapOk = null,
    Object? messageMaxHalfUCO = null,
    Object? tokenToSwapBalance = null,
    Object? tokenToSwapAmount = null,
    Object? tokenSwapped = freezed,
    Object? tokenSwappedBalance = null,
    Object? tokenSwappedAmount = null,
    Object? ratio = null,
    Object? swapFees = null,
    Object? swapProtocolFees = null,
    Object? slippageTolerance = null,
    Object? minToReceive = null,
    Object? priceImpact = null,
    Object? estimatedReceived = null,
    Object? feesEstimatedUCO = null,
    Object? finalAmount = freezed,
    Object? failure = freezed,
    Object? recoveryTransactionSwap = freezed,
    Object? calculationInProgress = null,
    Object? pool = freezed,
    Object? poolInfos = freezed,
    Object? consentDateTime = freezed,
  }) {
    return _then(_$SwapFormStateImpl(
      processStep: null == processStep
          ? _value.processStep
          : processStep // ignore: cast_nullable_to_non_nullable
              as ProcessStep,
      resumeProcess: null == resumeProcess
          ? _value.resumeProcess
          : resumeProcess // ignore: cast_nullable_to_non_nullable
              as bool,
      calculateAmountToSwap: null == calculateAmountToSwap
          ? _value.calculateAmountToSwap
          : calculateAmountToSwap // ignore: cast_nullable_to_non_nullable
              as bool,
      calculateAmountSwapped: null == calculateAmountSwapped
          ? _value.calculateAmountSwapped
          : calculateAmountSwapped // ignore: cast_nullable_to_non_nullable
              as bool,
      currentStep: null == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
      tokenFormSelected: null == tokenFormSelected
          ? _value.tokenFormSelected
          : tokenFormSelected // ignore: cast_nullable_to_non_nullable
              as int,
      poolGenesisAddress: null == poolGenesisAddress
          ? _value.poolGenesisAddress
          : poolGenesisAddress // ignore: cast_nullable_to_non_nullable
              as String,
      tokenToSwap: freezed == tokenToSwap
          ? _value.tokenToSwap
          : tokenToSwap // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      isProcessInProgress: null == isProcessInProgress
          ? _value.isProcessInProgress
          : isProcessInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      swapOk: null == swapOk
          ? _value.swapOk
          : swapOk // ignore: cast_nullable_to_non_nullable
              as bool,
      messageMaxHalfUCO: null == messageMaxHalfUCO
          ? _value.messageMaxHalfUCO
          : messageMaxHalfUCO // ignore: cast_nullable_to_non_nullable
              as bool,
      tokenToSwapBalance: null == tokenToSwapBalance
          ? _value.tokenToSwapBalance
          : tokenToSwapBalance // ignore: cast_nullable_to_non_nullable
              as double,
      tokenToSwapAmount: null == tokenToSwapAmount
          ? _value.tokenToSwapAmount
          : tokenToSwapAmount // ignore: cast_nullable_to_non_nullable
              as double,
      tokenSwapped: freezed == tokenSwapped
          ? _value.tokenSwapped
          : tokenSwapped // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      tokenSwappedBalance: null == tokenSwappedBalance
          ? _value.tokenSwappedBalance
          : tokenSwappedBalance // ignore: cast_nullable_to_non_nullable
              as double,
      tokenSwappedAmount: null == tokenSwappedAmount
          ? _value.tokenSwappedAmount
          : tokenSwappedAmount // ignore: cast_nullable_to_non_nullable
              as double,
      ratio: null == ratio
          ? _value.ratio
          : ratio // ignore: cast_nullable_to_non_nullable
              as double,
      swapFees: null == swapFees
          ? _value.swapFees
          : swapFees // ignore: cast_nullable_to_non_nullable
              as double,
      swapProtocolFees: null == swapProtocolFees
          ? _value.swapProtocolFees
          : swapProtocolFees // ignore: cast_nullable_to_non_nullable
              as double,
      slippageTolerance: null == slippageTolerance
          ? _value.slippageTolerance
          : slippageTolerance // ignore: cast_nullable_to_non_nullable
              as double,
      minToReceive: null == minToReceive
          ? _value.minToReceive
          : minToReceive // ignore: cast_nullable_to_non_nullable
              as double,
      priceImpact: null == priceImpact
          ? _value.priceImpact
          : priceImpact // ignore: cast_nullable_to_non_nullable
              as double,
      estimatedReceived: null == estimatedReceived
          ? _value.estimatedReceived
          : estimatedReceived // ignore: cast_nullable_to_non_nullable
              as double,
      feesEstimatedUCO: null == feesEstimatedUCO
          ? _value.feesEstimatedUCO
          : feesEstimatedUCO // ignore: cast_nullable_to_non_nullable
              as double,
      finalAmount: freezed == finalAmount
          ? _value.finalAmount
          : finalAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      recoveryTransactionSwap: freezed == recoveryTransactionSwap
          ? _value.recoveryTransactionSwap
          : recoveryTransactionSwap // ignore: cast_nullable_to_non_nullable
              as Transaction?,
      calculationInProgress: null == calculationInProgress
          ? _value.calculationInProgress
          : calculationInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      pool: freezed == pool
          ? _value.pool
          : pool // ignore: cast_nullable_to_non_nullable
              as DexPool?,
      poolInfos: freezed == poolInfos
          ? _value.poolInfos
          : poolInfos // ignore: cast_nullable_to_non_nullable
              as DexPoolInfos?,
      consentDateTime: freezed == consentDateTime
          ? _value.consentDateTime
          : consentDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$SwapFormStateImpl extends _SwapFormState {
  const _$SwapFormStateImpl(
      {this.processStep = ProcessStep.form,
      this.resumeProcess = false,
      this.calculateAmountToSwap = false,
      this.calculateAmountSwapped = false,
      this.currentStep = 0,
      this.tokenFormSelected = 1,
      this.poolGenesisAddress = '',
      this.tokenToSwap,
      this.isProcessInProgress = false,
      this.swapOk = false,
      this.messageMaxHalfUCO = false,
      this.tokenToSwapBalance = 0,
      this.tokenToSwapAmount = 0,
      this.tokenSwapped,
      this.tokenSwappedBalance = 0,
      this.tokenSwappedAmount = 0,
      this.ratio = 0.0,
      this.swapFees = 0.0,
      this.swapProtocolFees = 0.0,
      this.slippageTolerance = 0.5,
      this.minToReceive = 0.0,
      this.priceImpact = 0.0,
      this.estimatedReceived = 0.0,
      this.feesEstimatedUCO = 0.0,
      this.finalAmount,
      this.failure,
      this.recoveryTransactionSwap,
      this.calculationInProgress = false,
      this.pool,
      this.poolInfos,
      this.consentDateTime})
      : super._();

  @override
  @JsonKey()
  final ProcessStep processStep;
  @override
  @JsonKey()
  final bool resumeProcess;
  @override
  @JsonKey()
  final bool calculateAmountToSwap;
  @override
  @JsonKey()
  final bool calculateAmountSwapped;
  @override
  @JsonKey()
  final int currentStep;
  @override
  @JsonKey()
  final int tokenFormSelected;
  @override
  @JsonKey()
  final String poolGenesisAddress;
  @override
  final DexToken? tokenToSwap;
  @override
  @JsonKey()
  final bool isProcessInProgress;
  @override
  @JsonKey()
  final bool swapOk;
  @override
  @JsonKey()
  final bool messageMaxHalfUCO;
  @override
  @JsonKey()
  final double tokenToSwapBalance;
  @override
  @JsonKey()
  final double tokenToSwapAmount;
  @override
  final DexToken? tokenSwapped;
  @override
  @JsonKey()
  final double tokenSwappedBalance;
  @override
  @JsonKey()
  final double tokenSwappedAmount;
  @override
  @JsonKey()
  final double ratio;
  @override
  @JsonKey()
  final double swapFees;
  @override
  @JsonKey()
  final double swapProtocolFees;
  @override
  @JsonKey()
  final double slippageTolerance;
  @override
  @JsonKey()
  final double minToReceive;
  @override
  @JsonKey()
  final double priceImpact;
  @override
  @JsonKey()
  final double estimatedReceived;
  @override
  @JsonKey()
  final double feesEstimatedUCO;
  @override
  final double? finalAmount;
  @override
  final Failure? failure;
  @override
  final Transaction? recoveryTransactionSwap;
  @override
  @JsonKey()
  final bool calculationInProgress;
  @override
  final DexPool? pool;
  @override
  final DexPoolInfos? poolInfos;
  @override
  final DateTime? consentDateTime;

  @override
  String toString() {
    return 'SwapFormState(processStep: $processStep, resumeProcess: $resumeProcess, calculateAmountToSwap: $calculateAmountToSwap, calculateAmountSwapped: $calculateAmountSwapped, currentStep: $currentStep, tokenFormSelected: $tokenFormSelected, poolGenesisAddress: $poolGenesisAddress, tokenToSwap: $tokenToSwap, isProcessInProgress: $isProcessInProgress, swapOk: $swapOk, messageMaxHalfUCO: $messageMaxHalfUCO, tokenToSwapBalance: $tokenToSwapBalance, tokenToSwapAmount: $tokenToSwapAmount, tokenSwapped: $tokenSwapped, tokenSwappedBalance: $tokenSwappedBalance, tokenSwappedAmount: $tokenSwappedAmount, ratio: $ratio, swapFees: $swapFees, swapProtocolFees: $swapProtocolFees, slippageTolerance: $slippageTolerance, minToReceive: $minToReceive, priceImpact: $priceImpact, estimatedReceived: $estimatedReceived, feesEstimatedUCO: $feesEstimatedUCO, finalAmount: $finalAmount, failure: $failure, recoveryTransactionSwap: $recoveryTransactionSwap, calculationInProgress: $calculationInProgress, pool: $pool, poolInfos: $poolInfos, consentDateTime: $consentDateTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SwapFormStateImpl &&
            (identical(other.processStep, processStep) ||
                other.processStep == processStep) &&
            (identical(other.resumeProcess, resumeProcess) ||
                other.resumeProcess == resumeProcess) &&
            (identical(other.calculateAmountToSwap, calculateAmountToSwap) ||
                other.calculateAmountToSwap == calculateAmountToSwap) &&
            (identical(other.calculateAmountSwapped, calculateAmountSwapped) ||
                other.calculateAmountSwapped == calculateAmountSwapped) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.tokenFormSelected, tokenFormSelected) ||
                other.tokenFormSelected == tokenFormSelected) &&
            (identical(other.poolGenesisAddress, poolGenesisAddress) ||
                other.poolGenesisAddress == poolGenesisAddress) &&
            (identical(other.tokenToSwap, tokenToSwap) ||
                other.tokenToSwap == tokenToSwap) &&
            (identical(other.isProcessInProgress, isProcessInProgress) ||
                other.isProcessInProgress == isProcessInProgress) &&
            (identical(other.swapOk, swapOk) || other.swapOk == swapOk) &&
            (identical(other.messageMaxHalfUCO, messageMaxHalfUCO) ||
                other.messageMaxHalfUCO == messageMaxHalfUCO) &&
            (identical(other.tokenToSwapBalance, tokenToSwapBalance) ||
                other.tokenToSwapBalance == tokenToSwapBalance) &&
            (identical(other.tokenToSwapAmount, tokenToSwapAmount) ||
                other.tokenToSwapAmount == tokenToSwapAmount) &&
            (identical(other.tokenSwapped, tokenSwapped) ||
                other.tokenSwapped == tokenSwapped) &&
            (identical(other.tokenSwappedBalance, tokenSwappedBalance) ||
                other.tokenSwappedBalance == tokenSwappedBalance) &&
            (identical(other.tokenSwappedAmount, tokenSwappedAmount) ||
                other.tokenSwappedAmount == tokenSwappedAmount) &&
            (identical(other.ratio, ratio) || other.ratio == ratio) &&
            (identical(other.swapFees, swapFees) ||
                other.swapFees == swapFees) &&
            (identical(other.swapProtocolFees, swapProtocolFees) ||
                other.swapProtocolFees == swapProtocolFees) &&
            (identical(other.slippageTolerance, slippageTolerance) ||
                other.slippageTolerance == slippageTolerance) &&
            (identical(other.minToReceive, minToReceive) ||
                other.minToReceive == minToReceive) &&
            (identical(other.priceImpact, priceImpact) ||
                other.priceImpact == priceImpact) &&
            (identical(other.estimatedReceived, estimatedReceived) ||
                other.estimatedReceived == estimatedReceived) &&
            (identical(other.feesEstimatedUCO, feesEstimatedUCO) ||
                other.feesEstimatedUCO == feesEstimatedUCO) &&
            (identical(other.finalAmount, finalAmount) ||
                other.finalAmount == finalAmount) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            (identical(
                    other.recoveryTransactionSwap, recoveryTransactionSwap) ||
                other.recoveryTransactionSwap == recoveryTransactionSwap) &&
            (identical(other.calculationInProgress, calculationInProgress) ||
                other.calculationInProgress == calculationInProgress) &&
            (identical(other.pool, pool) || other.pool == pool) &&
            (identical(other.poolInfos, poolInfos) ||
                other.poolInfos == poolInfos) &&
            (identical(other.consentDateTime, consentDateTime) ||
                other.consentDateTime == consentDateTime));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        processStep,
        resumeProcess,
        calculateAmountToSwap,
        calculateAmountSwapped,
        currentStep,
        tokenFormSelected,
        poolGenesisAddress,
        tokenToSwap,
        isProcessInProgress,
        swapOk,
        messageMaxHalfUCO,
        tokenToSwapBalance,
        tokenToSwapAmount,
        tokenSwapped,
        tokenSwappedBalance,
        tokenSwappedAmount,
        ratio,
        swapFees,
        swapProtocolFees,
        slippageTolerance,
        minToReceive,
        priceImpact,
        estimatedReceived,
        feesEstimatedUCO,
        finalAmount,
        failure,
        recoveryTransactionSwap,
        calculationInProgress,
        pool,
        poolInfos,
        consentDateTime
      ]);

  /// Create a copy of SwapFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SwapFormStateImplCopyWith<_$SwapFormStateImpl> get copyWith =>
      __$$SwapFormStateImplCopyWithImpl<_$SwapFormStateImpl>(this, _$identity);
}

abstract class _SwapFormState extends SwapFormState {
  const factory _SwapFormState(
      {final ProcessStep processStep,
      final bool resumeProcess,
      final bool calculateAmountToSwap,
      final bool calculateAmountSwapped,
      final int currentStep,
      final int tokenFormSelected,
      final String poolGenesisAddress,
      final DexToken? tokenToSwap,
      final bool isProcessInProgress,
      final bool swapOk,
      final bool messageMaxHalfUCO,
      final double tokenToSwapBalance,
      final double tokenToSwapAmount,
      final DexToken? tokenSwapped,
      final double tokenSwappedBalance,
      final double tokenSwappedAmount,
      final double ratio,
      final double swapFees,
      final double swapProtocolFees,
      final double slippageTolerance,
      final double minToReceive,
      final double priceImpact,
      final double estimatedReceived,
      final double feesEstimatedUCO,
      final double? finalAmount,
      final Failure? failure,
      final Transaction? recoveryTransactionSwap,
      final bool calculationInProgress,
      final DexPool? pool,
      final DexPoolInfos? poolInfos,
      final DateTime? consentDateTime}) = _$SwapFormStateImpl;
  const _SwapFormState._() : super._();

  @override
  ProcessStep get processStep;
  @override
  bool get resumeProcess;
  @override
  bool get calculateAmountToSwap;
  @override
  bool get calculateAmountSwapped;
  @override
  int get currentStep;
  @override
  int get tokenFormSelected;
  @override
  String get poolGenesisAddress;
  @override
  DexToken? get tokenToSwap;
  @override
  bool get isProcessInProgress;
  @override
  bool get swapOk;
  @override
  bool get messageMaxHalfUCO;
  @override
  double get tokenToSwapBalance;
  @override
  double get tokenToSwapAmount;
  @override
  DexToken? get tokenSwapped;
  @override
  double get tokenSwappedBalance;
  @override
  double get tokenSwappedAmount;
  @override
  double get ratio;
  @override
  double get swapFees;
  @override
  double get swapProtocolFees;
  @override
  double get slippageTolerance;
  @override
  double get minToReceive;
  @override
  double get priceImpact;
  @override
  double get estimatedReceived;
  @override
  double get feesEstimatedUCO;
  @override
  double? get finalAmount;
  @override
  Failure? get failure;
  @override
  Transaction? get recoveryTransactionSwap;
  @override
  bool get calculationInProgress;
  @override
  DexPool? get pool;
  @override
  DexPoolInfos? get poolInfos;
  @override
  DateTime? get consentDateTime;

  /// Create a copy of SwapFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SwapFormStateImplCopyWith<_$SwapFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
