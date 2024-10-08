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
mixin _$LiquidityAddFormState {
  ProcessStep get processStep => throw _privateConstructorUsedError;
  bool get resumeProcess => throw _privateConstructorUsedError;
  bool get calculateToken1 => throw _privateConstructorUsedError;
  bool get calculateToken2 => throw _privateConstructorUsedError;
  int get tokenFormSelected => throw _privateConstructorUsedError;
  int get currentStep => throw _privateConstructorUsedError;
  bool get isProcessInProgress => throw _privateConstructorUsedError;
  bool get liquidityAddOk => throw _privateConstructorUsedError;
  bool get messageMaxHalfUCO => throw _privateConstructorUsedError;
  DexToken? get token1 => throw _privateConstructorUsedError;
  DexToken? get token2 => throw _privateConstructorUsedError;
  double get ratio => throw _privateConstructorUsedError;
  double get slippageTolerance => throw _privateConstructorUsedError;
  double get token1Balance => throw _privateConstructorUsedError;
  double get token1Amount => throw _privateConstructorUsedError;
  double get token2Balance => throw _privateConstructorUsedError;
  double get token2Amount => throw _privateConstructorUsedError;
  double get token1minAmount => throw _privateConstructorUsedError;
  double get token2minAmount => throw _privateConstructorUsedError;
  double get networkFees => throw _privateConstructorUsedError;
  double get expectedTokenLP => throw _privateConstructorUsedError;
  double get feesEstimatedUCO => throw _privateConstructorUsedError;
  DexPool? get pool => throw _privateConstructorUsedError;
  double get lpTokenBalance => throw _privateConstructorUsedError;
  Transaction? get transactionAddLiquidity =>
      throw _privateConstructorUsedError;
  bool get calculationInProgress => throw _privateConstructorUsedError;
  double? get finalAmount => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;
  DateTime? get consentDateTime => throw _privateConstructorUsedError;

  /// Create a copy of LiquidityAddFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LiquidityAddFormStateCopyWith<LiquidityAddFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LiquidityAddFormStateCopyWith<$Res> {
  factory $LiquidityAddFormStateCopyWith(LiquidityAddFormState value,
          $Res Function(LiquidityAddFormState) then) =
      _$LiquidityAddFormStateCopyWithImpl<$Res, LiquidityAddFormState>;
  @useResult
  $Res call(
      {ProcessStep processStep,
      bool resumeProcess,
      bool calculateToken1,
      bool calculateToken2,
      int tokenFormSelected,
      int currentStep,
      bool isProcessInProgress,
      bool liquidityAddOk,
      bool messageMaxHalfUCO,
      DexToken? token1,
      DexToken? token2,
      double ratio,
      double slippageTolerance,
      double token1Balance,
      double token1Amount,
      double token2Balance,
      double token2Amount,
      double token1minAmount,
      double token2minAmount,
      double networkFees,
      double expectedTokenLP,
      double feesEstimatedUCO,
      DexPool? pool,
      double lpTokenBalance,
      Transaction? transactionAddLiquidity,
      bool calculationInProgress,
      double? finalAmount,
      Failure? failure,
      DateTime? consentDateTime});

  $DexTokenCopyWith<$Res>? get token1;
  $DexTokenCopyWith<$Res>? get token2;
  $DexPoolCopyWith<$Res>? get pool;
  $TransactionCopyWith<$Res>? get transactionAddLiquidity;
  $FailureCopyWith<$Res>? get failure;
}

/// @nodoc
class _$LiquidityAddFormStateCopyWithImpl<$Res,
        $Val extends LiquidityAddFormState>
    implements $LiquidityAddFormStateCopyWith<$Res> {
  _$LiquidityAddFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LiquidityAddFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? processStep = null,
    Object? resumeProcess = null,
    Object? calculateToken1 = null,
    Object? calculateToken2 = null,
    Object? tokenFormSelected = null,
    Object? currentStep = null,
    Object? isProcessInProgress = null,
    Object? liquidityAddOk = null,
    Object? messageMaxHalfUCO = null,
    Object? token1 = freezed,
    Object? token2 = freezed,
    Object? ratio = null,
    Object? slippageTolerance = null,
    Object? token1Balance = null,
    Object? token1Amount = null,
    Object? token2Balance = null,
    Object? token2Amount = null,
    Object? token1minAmount = null,
    Object? token2minAmount = null,
    Object? networkFees = null,
    Object? expectedTokenLP = null,
    Object? feesEstimatedUCO = null,
    Object? pool = freezed,
    Object? lpTokenBalance = null,
    Object? transactionAddLiquidity = freezed,
    Object? calculationInProgress = null,
    Object? finalAmount = freezed,
    Object? failure = freezed,
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
      calculateToken1: null == calculateToken1
          ? _value.calculateToken1
          : calculateToken1 // ignore: cast_nullable_to_non_nullable
              as bool,
      calculateToken2: null == calculateToken2
          ? _value.calculateToken2
          : calculateToken2 // ignore: cast_nullable_to_non_nullable
              as bool,
      tokenFormSelected: null == tokenFormSelected
          ? _value.tokenFormSelected
          : tokenFormSelected // ignore: cast_nullable_to_non_nullable
              as int,
      currentStep: null == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
      isProcessInProgress: null == isProcessInProgress
          ? _value.isProcessInProgress
          : isProcessInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      liquidityAddOk: null == liquidityAddOk
          ? _value.liquidityAddOk
          : liquidityAddOk // ignore: cast_nullable_to_non_nullable
              as bool,
      messageMaxHalfUCO: null == messageMaxHalfUCO
          ? _value.messageMaxHalfUCO
          : messageMaxHalfUCO // ignore: cast_nullable_to_non_nullable
              as bool,
      token1: freezed == token1
          ? _value.token1
          : token1 // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      token2: freezed == token2
          ? _value.token2
          : token2 // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      ratio: null == ratio
          ? _value.ratio
          : ratio // ignore: cast_nullable_to_non_nullable
              as double,
      slippageTolerance: null == slippageTolerance
          ? _value.slippageTolerance
          : slippageTolerance // ignore: cast_nullable_to_non_nullable
              as double,
      token1Balance: null == token1Balance
          ? _value.token1Balance
          : token1Balance // ignore: cast_nullable_to_non_nullable
              as double,
      token1Amount: null == token1Amount
          ? _value.token1Amount
          : token1Amount // ignore: cast_nullable_to_non_nullable
              as double,
      token2Balance: null == token2Balance
          ? _value.token2Balance
          : token2Balance // ignore: cast_nullable_to_non_nullable
              as double,
      token2Amount: null == token2Amount
          ? _value.token2Amount
          : token2Amount // ignore: cast_nullable_to_non_nullable
              as double,
      token1minAmount: null == token1minAmount
          ? _value.token1minAmount
          : token1minAmount // ignore: cast_nullable_to_non_nullable
              as double,
      token2minAmount: null == token2minAmount
          ? _value.token2minAmount
          : token2minAmount // ignore: cast_nullable_to_non_nullable
              as double,
      networkFees: null == networkFees
          ? _value.networkFees
          : networkFees // ignore: cast_nullable_to_non_nullable
              as double,
      expectedTokenLP: null == expectedTokenLP
          ? _value.expectedTokenLP
          : expectedTokenLP // ignore: cast_nullable_to_non_nullable
              as double,
      feesEstimatedUCO: null == feesEstimatedUCO
          ? _value.feesEstimatedUCO
          : feesEstimatedUCO // ignore: cast_nullable_to_non_nullable
              as double,
      pool: freezed == pool
          ? _value.pool
          : pool // ignore: cast_nullable_to_non_nullable
              as DexPool?,
      lpTokenBalance: null == lpTokenBalance
          ? _value.lpTokenBalance
          : lpTokenBalance // ignore: cast_nullable_to_non_nullable
              as double,
      transactionAddLiquidity: freezed == transactionAddLiquidity
          ? _value.transactionAddLiquidity
          : transactionAddLiquidity // ignore: cast_nullable_to_non_nullable
              as Transaction?,
      calculationInProgress: null == calculationInProgress
          ? _value.calculationInProgress
          : calculationInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      finalAmount: freezed == finalAmount
          ? _value.finalAmount
          : finalAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      consentDateTime: freezed == consentDateTime
          ? _value.consentDateTime
          : consentDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of LiquidityAddFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DexTokenCopyWith<$Res>? get token1 {
    if (_value.token1 == null) {
      return null;
    }

    return $DexTokenCopyWith<$Res>(_value.token1!, (value) {
      return _then(_value.copyWith(token1: value) as $Val);
    });
  }

  /// Create a copy of LiquidityAddFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DexTokenCopyWith<$Res>? get token2 {
    if (_value.token2 == null) {
      return null;
    }

    return $DexTokenCopyWith<$Res>(_value.token2!, (value) {
      return _then(_value.copyWith(token2: value) as $Val);
    });
  }

  /// Create a copy of LiquidityAddFormState
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

  /// Create a copy of LiquidityAddFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransactionCopyWith<$Res>? get transactionAddLiquidity {
    if (_value.transactionAddLiquidity == null) {
      return null;
    }

    return $TransactionCopyWith<$Res>(_value.transactionAddLiquidity!, (value) {
      return _then(_value.copyWith(transactionAddLiquidity: value) as $Val);
    });
  }

  /// Create a copy of LiquidityAddFormState
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
}

/// @nodoc
abstract class _$$LiquidityAddFormStateImplCopyWith<$Res>
    implements $LiquidityAddFormStateCopyWith<$Res> {
  factory _$$LiquidityAddFormStateImplCopyWith(
          _$LiquidityAddFormStateImpl value,
          $Res Function(_$LiquidityAddFormStateImpl) then) =
      __$$LiquidityAddFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ProcessStep processStep,
      bool resumeProcess,
      bool calculateToken1,
      bool calculateToken2,
      int tokenFormSelected,
      int currentStep,
      bool isProcessInProgress,
      bool liquidityAddOk,
      bool messageMaxHalfUCO,
      DexToken? token1,
      DexToken? token2,
      double ratio,
      double slippageTolerance,
      double token1Balance,
      double token1Amount,
      double token2Balance,
      double token2Amount,
      double token1minAmount,
      double token2minAmount,
      double networkFees,
      double expectedTokenLP,
      double feesEstimatedUCO,
      DexPool? pool,
      double lpTokenBalance,
      Transaction? transactionAddLiquidity,
      bool calculationInProgress,
      double? finalAmount,
      Failure? failure,
      DateTime? consentDateTime});

  @override
  $DexTokenCopyWith<$Res>? get token1;
  @override
  $DexTokenCopyWith<$Res>? get token2;
  @override
  $DexPoolCopyWith<$Res>? get pool;
  @override
  $TransactionCopyWith<$Res>? get transactionAddLiquidity;
  @override
  $FailureCopyWith<$Res>? get failure;
}

/// @nodoc
class __$$LiquidityAddFormStateImplCopyWithImpl<$Res>
    extends _$LiquidityAddFormStateCopyWithImpl<$Res,
        _$LiquidityAddFormStateImpl>
    implements _$$LiquidityAddFormStateImplCopyWith<$Res> {
  __$$LiquidityAddFormStateImplCopyWithImpl(_$LiquidityAddFormStateImpl _value,
      $Res Function(_$LiquidityAddFormStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of LiquidityAddFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? processStep = null,
    Object? resumeProcess = null,
    Object? calculateToken1 = null,
    Object? calculateToken2 = null,
    Object? tokenFormSelected = null,
    Object? currentStep = null,
    Object? isProcessInProgress = null,
    Object? liquidityAddOk = null,
    Object? messageMaxHalfUCO = null,
    Object? token1 = freezed,
    Object? token2 = freezed,
    Object? ratio = null,
    Object? slippageTolerance = null,
    Object? token1Balance = null,
    Object? token1Amount = null,
    Object? token2Balance = null,
    Object? token2Amount = null,
    Object? token1minAmount = null,
    Object? token2minAmount = null,
    Object? networkFees = null,
    Object? expectedTokenLP = null,
    Object? feesEstimatedUCO = null,
    Object? pool = freezed,
    Object? lpTokenBalance = null,
    Object? transactionAddLiquidity = freezed,
    Object? calculationInProgress = null,
    Object? finalAmount = freezed,
    Object? failure = freezed,
    Object? consentDateTime = freezed,
  }) {
    return _then(_$LiquidityAddFormStateImpl(
      processStep: null == processStep
          ? _value.processStep
          : processStep // ignore: cast_nullable_to_non_nullable
              as ProcessStep,
      resumeProcess: null == resumeProcess
          ? _value.resumeProcess
          : resumeProcess // ignore: cast_nullable_to_non_nullable
              as bool,
      calculateToken1: null == calculateToken1
          ? _value.calculateToken1
          : calculateToken1 // ignore: cast_nullable_to_non_nullable
              as bool,
      calculateToken2: null == calculateToken2
          ? _value.calculateToken2
          : calculateToken2 // ignore: cast_nullable_to_non_nullable
              as bool,
      tokenFormSelected: null == tokenFormSelected
          ? _value.tokenFormSelected
          : tokenFormSelected // ignore: cast_nullable_to_non_nullable
              as int,
      currentStep: null == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
      isProcessInProgress: null == isProcessInProgress
          ? _value.isProcessInProgress
          : isProcessInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      liquidityAddOk: null == liquidityAddOk
          ? _value.liquidityAddOk
          : liquidityAddOk // ignore: cast_nullable_to_non_nullable
              as bool,
      messageMaxHalfUCO: null == messageMaxHalfUCO
          ? _value.messageMaxHalfUCO
          : messageMaxHalfUCO // ignore: cast_nullable_to_non_nullable
              as bool,
      token1: freezed == token1
          ? _value.token1
          : token1 // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      token2: freezed == token2
          ? _value.token2
          : token2 // ignore: cast_nullable_to_non_nullable
              as DexToken?,
      ratio: null == ratio
          ? _value.ratio
          : ratio // ignore: cast_nullable_to_non_nullable
              as double,
      slippageTolerance: null == slippageTolerance
          ? _value.slippageTolerance
          : slippageTolerance // ignore: cast_nullable_to_non_nullable
              as double,
      token1Balance: null == token1Balance
          ? _value.token1Balance
          : token1Balance // ignore: cast_nullable_to_non_nullable
              as double,
      token1Amount: null == token1Amount
          ? _value.token1Amount
          : token1Amount // ignore: cast_nullable_to_non_nullable
              as double,
      token2Balance: null == token2Balance
          ? _value.token2Balance
          : token2Balance // ignore: cast_nullable_to_non_nullable
              as double,
      token2Amount: null == token2Amount
          ? _value.token2Amount
          : token2Amount // ignore: cast_nullable_to_non_nullable
              as double,
      token1minAmount: null == token1minAmount
          ? _value.token1minAmount
          : token1minAmount // ignore: cast_nullable_to_non_nullable
              as double,
      token2minAmount: null == token2minAmount
          ? _value.token2minAmount
          : token2minAmount // ignore: cast_nullable_to_non_nullable
              as double,
      networkFees: null == networkFees
          ? _value.networkFees
          : networkFees // ignore: cast_nullable_to_non_nullable
              as double,
      expectedTokenLP: null == expectedTokenLP
          ? _value.expectedTokenLP
          : expectedTokenLP // ignore: cast_nullable_to_non_nullable
              as double,
      feesEstimatedUCO: null == feesEstimatedUCO
          ? _value.feesEstimatedUCO
          : feesEstimatedUCO // ignore: cast_nullable_to_non_nullable
              as double,
      pool: freezed == pool
          ? _value.pool
          : pool // ignore: cast_nullable_to_non_nullable
              as DexPool?,
      lpTokenBalance: null == lpTokenBalance
          ? _value.lpTokenBalance
          : lpTokenBalance // ignore: cast_nullable_to_non_nullable
              as double,
      transactionAddLiquidity: freezed == transactionAddLiquidity
          ? _value.transactionAddLiquidity
          : transactionAddLiquidity // ignore: cast_nullable_to_non_nullable
              as Transaction?,
      calculationInProgress: null == calculationInProgress
          ? _value.calculationInProgress
          : calculationInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      finalAmount: freezed == finalAmount
          ? _value.finalAmount
          : finalAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      consentDateTime: freezed == consentDateTime
          ? _value.consentDateTime
          : consentDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$LiquidityAddFormStateImpl extends _LiquidityAddFormState {
  const _$LiquidityAddFormStateImpl(
      {this.processStep = ProcessStep.form,
      this.resumeProcess = false,
      this.calculateToken1 = false,
      this.calculateToken2 = false,
      this.tokenFormSelected = 1,
      this.currentStep = 0,
      this.isProcessInProgress = false,
      this.liquidityAddOk = false,
      this.messageMaxHalfUCO = false,
      this.token1,
      this.token2,
      this.ratio = 0.0,
      this.slippageTolerance = 0.5,
      this.token1Balance = 0.0,
      this.token1Amount = 0.0,
      this.token2Balance = 0.0,
      this.token2Amount = 0.0,
      this.token1minAmount = 0.0,
      this.token2minAmount = 0.0,
      this.networkFees = 0.0,
      this.expectedTokenLP = 0.0,
      this.feesEstimatedUCO = 0.0,
      this.pool,
      this.lpTokenBalance = 0.0,
      this.transactionAddLiquidity,
      this.calculationInProgress = false,
      this.finalAmount,
      this.failure,
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
  final bool calculateToken1;
  @override
  @JsonKey()
  final bool calculateToken2;
  @override
  @JsonKey()
  final int tokenFormSelected;
  @override
  @JsonKey()
  final int currentStep;
  @override
  @JsonKey()
  final bool isProcessInProgress;
  @override
  @JsonKey()
  final bool liquidityAddOk;
  @override
  @JsonKey()
  final bool messageMaxHalfUCO;
  @override
  final DexToken? token1;
  @override
  final DexToken? token2;
  @override
  @JsonKey()
  final double ratio;
  @override
  @JsonKey()
  final double slippageTolerance;
  @override
  @JsonKey()
  final double token1Balance;
  @override
  @JsonKey()
  final double token1Amount;
  @override
  @JsonKey()
  final double token2Balance;
  @override
  @JsonKey()
  final double token2Amount;
  @override
  @JsonKey()
  final double token1minAmount;
  @override
  @JsonKey()
  final double token2minAmount;
  @override
  @JsonKey()
  final double networkFees;
  @override
  @JsonKey()
  final double expectedTokenLP;
  @override
  @JsonKey()
  final double feesEstimatedUCO;
  @override
  final DexPool? pool;
  @override
  @JsonKey()
  final double lpTokenBalance;
  @override
  final Transaction? transactionAddLiquidity;
  @override
  @JsonKey()
  final bool calculationInProgress;
  @override
  final double? finalAmount;
  @override
  final Failure? failure;
  @override
  final DateTime? consentDateTime;

  @override
  String toString() {
    return 'LiquidityAddFormState(processStep: $processStep, resumeProcess: $resumeProcess, calculateToken1: $calculateToken1, calculateToken2: $calculateToken2, tokenFormSelected: $tokenFormSelected, currentStep: $currentStep, isProcessInProgress: $isProcessInProgress, liquidityAddOk: $liquidityAddOk, messageMaxHalfUCO: $messageMaxHalfUCO, token1: $token1, token2: $token2, ratio: $ratio, slippageTolerance: $slippageTolerance, token1Balance: $token1Balance, token1Amount: $token1Amount, token2Balance: $token2Balance, token2Amount: $token2Amount, token1minAmount: $token1minAmount, token2minAmount: $token2minAmount, networkFees: $networkFees, expectedTokenLP: $expectedTokenLP, feesEstimatedUCO: $feesEstimatedUCO, pool: $pool, lpTokenBalance: $lpTokenBalance, transactionAddLiquidity: $transactionAddLiquidity, calculationInProgress: $calculationInProgress, finalAmount: $finalAmount, failure: $failure, consentDateTime: $consentDateTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LiquidityAddFormStateImpl &&
            (identical(other.processStep, processStep) ||
                other.processStep == processStep) &&
            (identical(other.resumeProcess, resumeProcess) ||
                other.resumeProcess == resumeProcess) &&
            (identical(other.calculateToken1, calculateToken1) ||
                other.calculateToken1 == calculateToken1) &&
            (identical(other.calculateToken2, calculateToken2) ||
                other.calculateToken2 == calculateToken2) &&
            (identical(other.tokenFormSelected, tokenFormSelected) ||
                other.tokenFormSelected == tokenFormSelected) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.isProcessInProgress, isProcessInProgress) ||
                other.isProcessInProgress == isProcessInProgress) &&
            (identical(other.liquidityAddOk, liquidityAddOk) ||
                other.liquidityAddOk == liquidityAddOk) &&
            (identical(other.messageMaxHalfUCO, messageMaxHalfUCO) ||
                other.messageMaxHalfUCO == messageMaxHalfUCO) &&
            (identical(other.token1, token1) || other.token1 == token1) &&
            (identical(other.token2, token2) || other.token2 == token2) &&
            (identical(other.ratio, ratio) || other.ratio == ratio) &&
            (identical(other.slippageTolerance, slippageTolerance) ||
                other.slippageTolerance == slippageTolerance) &&
            (identical(other.token1Balance, token1Balance) ||
                other.token1Balance == token1Balance) &&
            (identical(other.token1Amount, token1Amount) ||
                other.token1Amount == token1Amount) &&
            (identical(other.token2Balance, token2Balance) ||
                other.token2Balance == token2Balance) &&
            (identical(other.token2Amount, token2Amount) ||
                other.token2Amount == token2Amount) &&
            (identical(other.token1minAmount, token1minAmount) ||
                other.token1minAmount == token1minAmount) &&
            (identical(other.token2minAmount, token2minAmount) ||
                other.token2minAmount == token2minAmount) &&
            (identical(other.networkFees, networkFees) ||
                other.networkFees == networkFees) &&
            (identical(other.expectedTokenLP, expectedTokenLP) ||
                other.expectedTokenLP == expectedTokenLP) &&
            (identical(other.feesEstimatedUCO, feesEstimatedUCO) ||
                other.feesEstimatedUCO == feesEstimatedUCO) &&
            (identical(other.pool, pool) || other.pool == pool) &&
            (identical(other.lpTokenBalance, lpTokenBalance) ||
                other.lpTokenBalance == lpTokenBalance) &&
            (identical(
                    other.transactionAddLiquidity, transactionAddLiquidity) ||
                other.transactionAddLiquidity == transactionAddLiquidity) &&
            (identical(other.calculationInProgress, calculationInProgress) ||
                other.calculationInProgress == calculationInProgress) &&
            (identical(other.finalAmount, finalAmount) ||
                other.finalAmount == finalAmount) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            (identical(other.consentDateTime, consentDateTime) ||
                other.consentDateTime == consentDateTime));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        processStep,
        resumeProcess,
        calculateToken1,
        calculateToken2,
        tokenFormSelected,
        currentStep,
        isProcessInProgress,
        liquidityAddOk,
        messageMaxHalfUCO,
        token1,
        token2,
        ratio,
        slippageTolerance,
        token1Balance,
        token1Amount,
        token2Balance,
        token2Amount,
        token1minAmount,
        token2minAmount,
        networkFees,
        expectedTokenLP,
        feesEstimatedUCO,
        pool,
        lpTokenBalance,
        transactionAddLiquidity,
        calculationInProgress,
        finalAmount,
        failure,
        consentDateTime
      ]);

  /// Create a copy of LiquidityAddFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LiquidityAddFormStateImplCopyWith<_$LiquidityAddFormStateImpl>
      get copyWith => __$$LiquidityAddFormStateImplCopyWithImpl<
          _$LiquidityAddFormStateImpl>(this, _$identity);
}

abstract class _LiquidityAddFormState extends LiquidityAddFormState {
  const factory _LiquidityAddFormState(
      {final ProcessStep processStep,
      final bool resumeProcess,
      final bool calculateToken1,
      final bool calculateToken2,
      final int tokenFormSelected,
      final int currentStep,
      final bool isProcessInProgress,
      final bool liquidityAddOk,
      final bool messageMaxHalfUCO,
      final DexToken? token1,
      final DexToken? token2,
      final double ratio,
      final double slippageTolerance,
      final double token1Balance,
      final double token1Amount,
      final double token2Balance,
      final double token2Amount,
      final double token1minAmount,
      final double token2minAmount,
      final double networkFees,
      final double expectedTokenLP,
      final double feesEstimatedUCO,
      final DexPool? pool,
      final double lpTokenBalance,
      final Transaction? transactionAddLiquidity,
      final bool calculationInProgress,
      final double? finalAmount,
      final Failure? failure,
      final DateTime? consentDateTime}) = _$LiquidityAddFormStateImpl;
  const _LiquidityAddFormState._() : super._();

  @override
  ProcessStep get processStep;
  @override
  bool get resumeProcess;
  @override
  bool get calculateToken1;
  @override
  bool get calculateToken2;
  @override
  int get tokenFormSelected;
  @override
  int get currentStep;
  @override
  bool get isProcessInProgress;
  @override
  bool get liquidityAddOk;
  @override
  bool get messageMaxHalfUCO;
  @override
  DexToken? get token1;
  @override
  DexToken? get token2;
  @override
  double get ratio;
  @override
  double get slippageTolerance;
  @override
  double get token1Balance;
  @override
  double get token1Amount;
  @override
  double get token2Balance;
  @override
  double get token2Amount;
  @override
  double get token1minAmount;
  @override
  double get token2minAmount;
  @override
  double get networkFees;
  @override
  double get expectedTokenLP;
  @override
  double get feesEstimatedUCO;
  @override
  DexPool? get pool;
  @override
  double get lpTokenBalance;
  @override
  Transaction? get transactionAddLiquidity;
  @override
  bool get calculationInProgress;
  @override
  double? get finalAmount;
  @override
  Failure? get failure;
  @override
  DateTime? get consentDateTime;

  /// Create a copy of LiquidityAddFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LiquidityAddFormStateImplCopyWith<_$LiquidityAddFormStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
