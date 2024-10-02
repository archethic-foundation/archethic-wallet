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
mixin _$LiquidityRemoveFormState {
  ProcessStep get processStep => throw _privateConstructorUsedError;
  bool get resumeProcess => throw _privateConstructorUsedError;
  int get currentStep => throw _privateConstructorUsedError;
  DexPool? get pool => throw _privateConstructorUsedError;
  bool get isProcessInProgress => throw _privateConstructorUsedError;
  bool get liquidityRemoveOk => throw _privateConstructorUsedError;
  DexToken? get token1 => throw _privateConstructorUsedError;
  DexToken? get token2 => throw _privateConstructorUsedError;
  DexToken? get lpToken => throw _privateConstructorUsedError;
  double get lpTokenBalance => throw _privateConstructorUsedError;
  double get lpTokenAmount => throw _privateConstructorUsedError;
  double get token1AmountGetBack => throw _privateConstructorUsedError;
  double get token2AmountGetBack => throw _privateConstructorUsedError;
  double get networkFees => throw _privateConstructorUsedError;
  double get token1Balance => throw _privateConstructorUsedError;
  double get token2Balance => throw _privateConstructorUsedError;
  Transaction? get transactionRemoveLiquidity =>
      throw _privateConstructorUsedError;
  double get feesEstimatedUCO => throw _privateConstructorUsedError;
  double? get finalAmountToken1 => throw _privateConstructorUsedError;
  double? get finalAmountToken2 => throw _privateConstructorUsedError;
  double? get finalAmountLPToken => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;
  bool get calculationInProgress => throw _privateConstructorUsedError;
  DateTime? get consentDateTime => throw _privateConstructorUsedError;

  /// Create a copy of LiquidityRemoveFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LiquidityRemoveFormStateCopyWith<LiquidityRemoveFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LiquidityRemoveFormStateCopyWith<$Res> {
  factory $LiquidityRemoveFormStateCopyWith(LiquidityRemoveFormState value,
          $Res Function(LiquidityRemoveFormState) then) =
      _$LiquidityRemoveFormStateCopyWithImpl<$Res, LiquidityRemoveFormState>;
  @useResult
  $Res call(
      {ProcessStep processStep,
      bool resumeProcess,
      int currentStep,
      DexPool? pool,
      bool isProcessInProgress,
      bool liquidityRemoveOk,
      DexToken? token1,
      DexToken? token2,
      DexToken? lpToken,
      double lpTokenBalance,
      double lpTokenAmount,
      double token1AmountGetBack,
      double token2AmountGetBack,
      double networkFees,
      double token1Balance,
      double token2Balance,
      Transaction? transactionRemoveLiquidity,
      double feesEstimatedUCO,
      double? finalAmountToken1,
      double? finalAmountToken2,
      double? finalAmountLPToken,
      Failure? failure,
      bool calculationInProgress,
      DateTime? consentDateTime});

  $DexPoolCopyWith<$Res>? get pool;
  $DexTokenCopyWith<$Res>? get token1;
  $DexTokenCopyWith<$Res>? get token2;
  $DexTokenCopyWith<$Res>? get lpToken;
  $TransactionCopyWith<$Res>? get transactionRemoveLiquidity;
  $FailureCopyWith<$Res>? get failure;
}

/// @nodoc
class _$LiquidityRemoveFormStateCopyWithImpl<$Res,
        $Val extends LiquidityRemoveFormState>
    implements $LiquidityRemoveFormStateCopyWith<$Res> {
  _$LiquidityRemoveFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LiquidityRemoveFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? processStep = null,
    Object? resumeProcess = null,
    Object? currentStep = null,
    Object? pool = freezed,
    Object? isProcessInProgress = null,
    Object? liquidityRemoveOk = null,
    Object? token1 = freezed,
    Object? token2 = freezed,
    Object? lpToken = freezed,
    Object? lpTokenBalance = null,
    Object? lpTokenAmount = null,
    Object? token1AmountGetBack = null,
    Object? token2AmountGetBack = null,
    Object? networkFees = null,
    Object? token1Balance = null,
    Object? token2Balance = null,
    Object? transactionRemoveLiquidity = freezed,
    Object? feesEstimatedUCO = null,
    Object? finalAmountToken1 = freezed,
    Object? finalAmountToken2 = freezed,
    Object? finalAmountLPToken = freezed,
    Object? failure = freezed,
    Object? calculationInProgress = null,
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
      isProcessInProgress: null == isProcessInProgress
          ? _value.isProcessInProgress
          : isProcessInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      liquidityRemoveOk: null == liquidityRemoveOk
          ? _value.liquidityRemoveOk
          : liquidityRemoveOk // ignore: cast_nullable_to_non_nullable
              as bool,
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
      lpTokenBalance: null == lpTokenBalance
          ? _value.lpTokenBalance
          : lpTokenBalance // ignore: cast_nullable_to_non_nullable
              as double,
      lpTokenAmount: null == lpTokenAmount
          ? _value.lpTokenAmount
          : lpTokenAmount // ignore: cast_nullable_to_non_nullable
              as double,
      token1AmountGetBack: null == token1AmountGetBack
          ? _value.token1AmountGetBack
          : token1AmountGetBack // ignore: cast_nullable_to_non_nullable
              as double,
      token2AmountGetBack: null == token2AmountGetBack
          ? _value.token2AmountGetBack
          : token2AmountGetBack // ignore: cast_nullable_to_non_nullable
              as double,
      networkFees: null == networkFees
          ? _value.networkFees
          : networkFees // ignore: cast_nullable_to_non_nullable
              as double,
      token1Balance: null == token1Balance
          ? _value.token1Balance
          : token1Balance // ignore: cast_nullable_to_non_nullable
              as double,
      token2Balance: null == token2Balance
          ? _value.token2Balance
          : token2Balance // ignore: cast_nullable_to_non_nullable
              as double,
      transactionRemoveLiquidity: freezed == transactionRemoveLiquidity
          ? _value.transactionRemoveLiquidity
          : transactionRemoveLiquidity // ignore: cast_nullable_to_non_nullable
              as Transaction?,
      feesEstimatedUCO: null == feesEstimatedUCO
          ? _value.feesEstimatedUCO
          : feesEstimatedUCO // ignore: cast_nullable_to_non_nullable
              as double,
      finalAmountToken1: freezed == finalAmountToken1
          ? _value.finalAmountToken1
          : finalAmountToken1 // ignore: cast_nullable_to_non_nullable
              as double?,
      finalAmountToken2: freezed == finalAmountToken2
          ? _value.finalAmountToken2
          : finalAmountToken2 // ignore: cast_nullable_to_non_nullable
              as double?,
      finalAmountLPToken: freezed == finalAmountLPToken
          ? _value.finalAmountLPToken
          : finalAmountLPToken // ignore: cast_nullable_to_non_nullable
              as double?,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      calculationInProgress: null == calculationInProgress
          ? _value.calculationInProgress
          : calculationInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      consentDateTime: freezed == consentDateTime
          ? _value.consentDateTime
          : consentDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of LiquidityRemoveFormState
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

  /// Create a copy of LiquidityRemoveFormState
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

  /// Create a copy of LiquidityRemoveFormState
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

  /// Create a copy of LiquidityRemoveFormState
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of LiquidityRemoveFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransactionCopyWith<$Res>? get transactionRemoveLiquidity {
    if (_value.transactionRemoveLiquidity == null) {
      return null;
    }

    return $TransactionCopyWith<$Res>(_value.transactionRemoveLiquidity!,
        (value) {
      return _then(_value.copyWith(transactionRemoveLiquidity: value) as $Val);
    });
  }

  /// Create a copy of LiquidityRemoveFormState
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
abstract class _$$LiquidityRemoveFormStateImplCopyWith<$Res>
    implements $LiquidityRemoveFormStateCopyWith<$Res> {
  factory _$$LiquidityRemoveFormStateImplCopyWith(
          _$LiquidityRemoveFormStateImpl value,
          $Res Function(_$LiquidityRemoveFormStateImpl) then) =
      __$$LiquidityRemoveFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ProcessStep processStep,
      bool resumeProcess,
      int currentStep,
      DexPool? pool,
      bool isProcessInProgress,
      bool liquidityRemoveOk,
      DexToken? token1,
      DexToken? token2,
      DexToken? lpToken,
      double lpTokenBalance,
      double lpTokenAmount,
      double token1AmountGetBack,
      double token2AmountGetBack,
      double networkFees,
      double token1Balance,
      double token2Balance,
      Transaction? transactionRemoveLiquidity,
      double feesEstimatedUCO,
      double? finalAmountToken1,
      double? finalAmountToken2,
      double? finalAmountLPToken,
      Failure? failure,
      bool calculationInProgress,
      DateTime? consentDateTime});

  @override
  $DexPoolCopyWith<$Res>? get pool;
  @override
  $DexTokenCopyWith<$Res>? get token1;
  @override
  $DexTokenCopyWith<$Res>? get token2;
  @override
  $DexTokenCopyWith<$Res>? get lpToken;
  @override
  $TransactionCopyWith<$Res>? get transactionRemoveLiquidity;
  @override
  $FailureCopyWith<$Res>? get failure;
}

/// @nodoc
class __$$LiquidityRemoveFormStateImplCopyWithImpl<$Res>
    extends _$LiquidityRemoveFormStateCopyWithImpl<$Res,
        _$LiquidityRemoveFormStateImpl>
    implements _$$LiquidityRemoveFormStateImplCopyWith<$Res> {
  __$$LiquidityRemoveFormStateImplCopyWithImpl(
      _$LiquidityRemoveFormStateImpl _value,
      $Res Function(_$LiquidityRemoveFormStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of LiquidityRemoveFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? processStep = null,
    Object? resumeProcess = null,
    Object? currentStep = null,
    Object? pool = freezed,
    Object? isProcessInProgress = null,
    Object? liquidityRemoveOk = null,
    Object? token1 = freezed,
    Object? token2 = freezed,
    Object? lpToken = freezed,
    Object? lpTokenBalance = null,
    Object? lpTokenAmount = null,
    Object? token1AmountGetBack = null,
    Object? token2AmountGetBack = null,
    Object? networkFees = null,
    Object? token1Balance = null,
    Object? token2Balance = null,
    Object? transactionRemoveLiquidity = freezed,
    Object? feesEstimatedUCO = null,
    Object? finalAmountToken1 = freezed,
    Object? finalAmountToken2 = freezed,
    Object? finalAmountLPToken = freezed,
    Object? failure = freezed,
    Object? calculationInProgress = null,
    Object? consentDateTime = freezed,
  }) {
    return _then(_$LiquidityRemoveFormStateImpl(
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
      isProcessInProgress: null == isProcessInProgress
          ? _value.isProcessInProgress
          : isProcessInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      liquidityRemoveOk: null == liquidityRemoveOk
          ? _value.liquidityRemoveOk
          : liquidityRemoveOk // ignore: cast_nullable_to_non_nullable
              as bool,
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
      lpTokenBalance: null == lpTokenBalance
          ? _value.lpTokenBalance
          : lpTokenBalance // ignore: cast_nullable_to_non_nullable
              as double,
      lpTokenAmount: null == lpTokenAmount
          ? _value.lpTokenAmount
          : lpTokenAmount // ignore: cast_nullable_to_non_nullable
              as double,
      token1AmountGetBack: null == token1AmountGetBack
          ? _value.token1AmountGetBack
          : token1AmountGetBack // ignore: cast_nullable_to_non_nullable
              as double,
      token2AmountGetBack: null == token2AmountGetBack
          ? _value.token2AmountGetBack
          : token2AmountGetBack // ignore: cast_nullable_to_non_nullable
              as double,
      networkFees: null == networkFees
          ? _value.networkFees
          : networkFees // ignore: cast_nullable_to_non_nullable
              as double,
      token1Balance: null == token1Balance
          ? _value.token1Balance
          : token1Balance // ignore: cast_nullable_to_non_nullable
              as double,
      token2Balance: null == token2Balance
          ? _value.token2Balance
          : token2Balance // ignore: cast_nullable_to_non_nullable
              as double,
      transactionRemoveLiquidity: freezed == transactionRemoveLiquidity
          ? _value.transactionRemoveLiquidity
          : transactionRemoveLiquidity // ignore: cast_nullable_to_non_nullable
              as Transaction?,
      feesEstimatedUCO: null == feesEstimatedUCO
          ? _value.feesEstimatedUCO
          : feesEstimatedUCO // ignore: cast_nullable_to_non_nullable
              as double,
      finalAmountToken1: freezed == finalAmountToken1
          ? _value.finalAmountToken1
          : finalAmountToken1 // ignore: cast_nullable_to_non_nullable
              as double?,
      finalAmountToken2: freezed == finalAmountToken2
          ? _value.finalAmountToken2
          : finalAmountToken2 // ignore: cast_nullable_to_non_nullable
              as double?,
      finalAmountLPToken: freezed == finalAmountLPToken
          ? _value.finalAmountLPToken
          : finalAmountLPToken // ignore: cast_nullable_to_non_nullable
              as double?,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      calculationInProgress: null == calculationInProgress
          ? _value.calculationInProgress
          : calculationInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      consentDateTime: freezed == consentDateTime
          ? _value.consentDateTime
          : consentDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$LiquidityRemoveFormStateImpl extends _LiquidityRemoveFormState {
  const _$LiquidityRemoveFormStateImpl(
      {this.processStep = ProcessStep.form,
      this.resumeProcess = false,
      this.currentStep = 0,
      this.pool,
      this.isProcessInProgress = false,
      this.liquidityRemoveOk = false,
      this.token1,
      this.token2,
      this.lpToken,
      this.lpTokenBalance = 0.0,
      this.lpTokenAmount = 0.0,
      this.token1AmountGetBack = 0.0,
      this.token2AmountGetBack = 0.0,
      this.networkFees = 0.0,
      this.token1Balance = 0.0,
      this.token2Balance = 0.0,
      this.transactionRemoveLiquidity,
      this.feesEstimatedUCO = 0.0,
      this.finalAmountToken1,
      this.finalAmountToken2,
      this.finalAmountLPToken,
      this.failure,
      this.calculationInProgress = false,
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
  final int currentStep;
  @override
  final DexPool? pool;
  @override
  @JsonKey()
  final bool isProcessInProgress;
  @override
  @JsonKey()
  final bool liquidityRemoveOk;
  @override
  final DexToken? token1;
  @override
  final DexToken? token2;
  @override
  final DexToken? lpToken;
  @override
  @JsonKey()
  final double lpTokenBalance;
  @override
  @JsonKey()
  final double lpTokenAmount;
  @override
  @JsonKey()
  final double token1AmountGetBack;
  @override
  @JsonKey()
  final double token2AmountGetBack;
  @override
  @JsonKey()
  final double networkFees;
  @override
  @JsonKey()
  final double token1Balance;
  @override
  @JsonKey()
  final double token2Balance;
  @override
  final Transaction? transactionRemoveLiquidity;
  @override
  @JsonKey()
  final double feesEstimatedUCO;
  @override
  final double? finalAmountToken1;
  @override
  final double? finalAmountToken2;
  @override
  final double? finalAmountLPToken;
  @override
  final Failure? failure;
  @override
  @JsonKey()
  final bool calculationInProgress;
  @override
  final DateTime? consentDateTime;

  @override
  String toString() {
    return 'LiquidityRemoveFormState(processStep: $processStep, resumeProcess: $resumeProcess, currentStep: $currentStep, pool: $pool, isProcessInProgress: $isProcessInProgress, liquidityRemoveOk: $liquidityRemoveOk, token1: $token1, token2: $token2, lpToken: $lpToken, lpTokenBalance: $lpTokenBalance, lpTokenAmount: $lpTokenAmount, token1AmountGetBack: $token1AmountGetBack, token2AmountGetBack: $token2AmountGetBack, networkFees: $networkFees, token1Balance: $token1Balance, token2Balance: $token2Balance, transactionRemoveLiquidity: $transactionRemoveLiquidity, feesEstimatedUCO: $feesEstimatedUCO, finalAmountToken1: $finalAmountToken1, finalAmountToken2: $finalAmountToken2, finalAmountLPToken: $finalAmountLPToken, failure: $failure, calculationInProgress: $calculationInProgress, consentDateTime: $consentDateTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LiquidityRemoveFormStateImpl &&
            (identical(other.processStep, processStep) ||
                other.processStep == processStep) &&
            (identical(other.resumeProcess, resumeProcess) ||
                other.resumeProcess == resumeProcess) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.pool, pool) || other.pool == pool) &&
            (identical(other.isProcessInProgress, isProcessInProgress) ||
                other.isProcessInProgress == isProcessInProgress) &&
            (identical(other.liquidityRemoveOk, liquidityRemoveOk) ||
                other.liquidityRemoveOk == liquidityRemoveOk) &&
            (identical(other.token1, token1) || other.token1 == token1) &&
            (identical(other.token2, token2) || other.token2 == token2) &&
            (identical(other.lpToken, lpToken) || other.lpToken == lpToken) &&
            (identical(other.lpTokenBalance, lpTokenBalance) ||
                other.lpTokenBalance == lpTokenBalance) &&
            (identical(other.lpTokenAmount, lpTokenAmount) ||
                other.lpTokenAmount == lpTokenAmount) &&
            (identical(other.token1AmountGetBack, token1AmountGetBack) ||
                other.token1AmountGetBack == token1AmountGetBack) &&
            (identical(other.token2AmountGetBack, token2AmountGetBack) ||
                other.token2AmountGetBack == token2AmountGetBack) &&
            (identical(other.networkFees, networkFees) ||
                other.networkFees == networkFees) &&
            (identical(other.token1Balance, token1Balance) ||
                other.token1Balance == token1Balance) &&
            (identical(other.token2Balance, token2Balance) ||
                other.token2Balance == token2Balance) &&
            (identical(other.transactionRemoveLiquidity,
                    transactionRemoveLiquidity) ||
                other.transactionRemoveLiquidity ==
                    transactionRemoveLiquidity) &&
            (identical(other.feesEstimatedUCO, feesEstimatedUCO) ||
                other.feesEstimatedUCO == feesEstimatedUCO) &&
            (identical(other.finalAmountToken1, finalAmountToken1) ||
                other.finalAmountToken1 == finalAmountToken1) &&
            (identical(other.finalAmountToken2, finalAmountToken2) ||
                other.finalAmountToken2 == finalAmountToken2) &&
            (identical(other.finalAmountLPToken, finalAmountLPToken) ||
                other.finalAmountLPToken == finalAmountLPToken) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            (identical(other.calculationInProgress, calculationInProgress) ||
                other.calculationInProgress == calculationInProgress) &&
            (identical(other.consentDateTime, consentDateTime) ||
                other.consentDateTime == consentDateTime));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        processStep,
        resumeProcess,
        currentStep,
        pool,
        isProcessInProgress,
        liquidityRemoveOk,
        token1,
        token2,
        lpToken,
        lpTokenBalance,
        lpTokenAmount,
        token1AmountGetBack,
        token2AmountGetBack,
        networkFees,
        token1Balance,
        token2Balance,
        transactionRemoveLiquidity,
        feesEstimatedUCO,
        finalAmountToken1,
        finalAmountToken2,
        finalAmountLPToken,
        failure,
        calculationInProgress,
        consentDateTime
      ]);

  /// Create a copy of LiquidityRemoveFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LiquidityRemoveFormStateImplCopyWith<_$LiquidityRemoveFormStateImpl>
      get copyWith => __$$LiquidityRemoveFormStateImplCopyWithImpl<
          _$LiquidityRemoveFormStateImpl>(this, _$identity);
}

abstract class _LiquidityRemoveFormState extends LiquidityRemoveFormState {
  const factory _LiquidityRemoveFormState(
      {final ProcessStep processStep,
      final bool resumeProcess,
      final int currentStep,
      final DexPool? pool,
      final bool isProcessInProgress,
      final bool liquidityRemoveOk,
      final DexToken? token1,
      final DexToken? token2,
      final DexToken? lpToken,
      final double lpTokenBalance,
      final double lpTokenAmount,
      final double token1AmountGetBack,
      final double token2AmountGetBack,
      final double networkFees,
      final double token1Balance,
      final double token2Balance,
      final Transaction? transactionRemoveLiquidity,
      final double feesEstimatedUCO,
      final double? finalAmountToken1,
      final double? finalAmountToken2,
      final double? finalAmountLPToken,
      final Failure? failure,
      final bool calculationInProgress,
      final DateTime? consentDateTime}) = _$LiquidityRemoveFormStateImpl;
  const _LiquidityRemoveFormState._() : super._();

  @override
  ProcessStep get processStep;
  @override
  bool get resumeProcess;
  @override
  int get currentStep;
  @override
  DexPool? get pool;
  @override
  bool get isProcessInProgress;
  @override
  bool get liquidityRemoveOk;
  @override
  DexToken? get token1;
  @override
  DexToken? get token2;
  @override
  DexToken? get lpToken;
  @override
  double get lpTokenBalance;
  @override
  double get lpTokenAmount;
  @override
  double get token1AmountGetBack;
  @override
  double get token2AmountGetBack;
  @override
  double get networkFees;
  @override
  double get token1Balance;
  @override
  double get token2Balance;
  @override
  Transaction? get transactionRemoveLiquidity;
  @override
  double get feesEstimatedUCO;
  @override
  double? get finalAmountToken1;
  @override
  double? get finalAmountToken2;
  @override
  double? get finalAmountLPToken;
  @override
  Failure? get failure;
  @override
  bool get calculationInProgress;
  @override
  DateTime? get consentDateTime;

  /// Create a copy of LiquidityRemoveFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LiquidityRemoveFormStateImplCopyWith<_$LiquidityRemoveFormStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
