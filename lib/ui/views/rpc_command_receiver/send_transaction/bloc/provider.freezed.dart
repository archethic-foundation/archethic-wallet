// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SignTransactionConfirmationFormState {
  RPCCommand<SendTransactionRequest> get signTransactionCommand =>
      throw _privateConstructorUsedError;
  double get feesEstimation => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SignTransactionConfirmationFormStateCopyWith<
          SignTransactionConfirmationFormState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignTransactionConfirmationFormStateCopyWith<$Res> {
  factory $SignTransactionConfirmationFormStateCopyWith(
          SignTransactionConfirmationFormState value,
          $Res Function(SignTransactionConfirmationFormState) then) =
      _$SignTransactionConfirmationFormStateCopyWithImpl<$Res,
          SignTransactionConfirmationFormState>;
  @useResult
  $Res call(
      {RPCCommand<SendTransactionRequest> signTransactionCommand,
      double feesEstimation});

  $RPCCommandCopyWith<SendTransactionRequest, $Res> get signTransactionCommand;
}

/// @nodoc
class _$SignTransactionConfirmationFormStateCopyWithImpl<$Res,
        $Val extends SignTransactionConfirmationFormState>
    implements $SignTransactionConfirmationFormStateCopyWith<$Res> {
  _$SignTransactionConfirmationFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signTransactionCommand = null,
    Object? feesEstimation = null,
  }) {
    return _then(_value.copyWith(
      signTransactionCommand: null == signTransactionCommand
          ? _value.signTransactionCommand
          : signTransactionCommand // ignore: cast_nullable_to_non_nullable
              as RPCCommand<SendTransactionRequest>,
      feesEstimation: null == feesEstimation
          ? _value.feesEstimation
          : feesEstimation // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RPCCommandCopyWith<SendTransactionRequest, $Res> get signTransactionCommand {
    return $RPCCommandCopyWith<SendTransactionRequest, $Res>(
        _value.signTransactionCommand, (value) {
      return _then(_value.copyWith(signTransactionCommand: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SignTransactionConfirmationFormStateImplCopyWith<$Res>
    implements $SignTransactionConfirmationFormStateCopyWith<$Res> {
  factory _$$SignTransactionConfirmationFormStateImplCopyWith(
          _$SignTransactionConfirmationFormStateImpl value,
          $Res Function(_$SignTransactionConfirmationFormStateImpl) then) =
      __$$SignTransactionConfirmationFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {RPCCommand<SendTransactionRequest> signTransactionCommand,
      double feesEstimation});

  @override
  $RPCCommandCopyWith<SendTransactionRequest, $Res> get signTransactionCommand;
}

/// @nodoc
class __$$SignTransactionConfirmationFormStateImplCopyWithImpl<$Res>
    extends _$SignTransactionConfirmationFormStateCopyWithImpl<$Res,
        _$SignTransactionConfirmationFormStateImpl>
    implements _$$SignTransactionConfirmationFormStateImplCopyWith<$Res> {
  __$$SignTransactionConfirmationFormStateImplCopyWithImpl(
      _$SignTransactionConfirmationFormStateImpl _value,
      $Res Function(_$SignTransactionConfirmationFormStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signTransactionCommand = null,
    Object? feesEstimation = null,
  }) {
    return _then(_$SignTransactionConfirmationFormStateImpl(
      signTransactionCommand: null == signTransactionCommand
          ? _value.signTransactionCommand
          : signTransactionCommand // ignore: cast_nullable_to_non_nullable
              as RPCCommand<SendTransactionRequest>,
      feesEstimation: null == feesEstimation
          ? _value.feesEstimation
          : feesEstimation // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$SignTransactionConfirmationFormStateImpl
    extends _SignTransactionConfirmationFormState {
  const _$SignTransactionConfirmationFormStateImpl(
      {required this.signTransactionCommand, required this.feesEstimation})
      : super._();

  @override
  final RPCCommand<SendTransactionRequest> signTransactionCommand;
  @override
  final double feesEstimation;

  @override
  String toString() {
    return 'SignTransactionConfirmationFormState(signTransactionCommand: $signTransactionCommand, feesEstimation: $feesEstimation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignTransactionConfirmationFormStateImpl &&
            (identical(other.signTransactionCommand, signTransactionCommand) ||
                other.signTransactionCommand == signTransactionCommand) &&
            (identical(other.feesEstimation, feesEstimation) ||
                other.feesEstimation == feesEstimation));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, signTransactionCommand, feesEstimation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SignTransactionConfirmationFormStateImplCopyWith<
          _$SignTransactionConfirmationFormStateImpl>
      get copyWith => __$$SignTransactionConfirmationFormStateImplCopyWithImpl<
          _$SignTransactionConfirmationFormStateImpl>(this, _$identity);
}

abstract class _SignTransactionConfirmationFormState
    extends SignTransactionConfirmationFormState {
  const factory _SignTransactionConfirmationFormState(
      {required final RPCCommand<SendTransactionRequest> signTransactionCommand,
      required final double
          feesEstimation}) = _$SignTransactionConfirmationFormStateImpl;
  const _SignTransactionConfirmationFormState._() : super._();

  @override
  RPCCommand<SendTransactionRequest> get signTransactionCommand;
  @override
  double get feesEstimation;
  @override
  @JsonKey(ignore: true)
  _$$SignTransactionConfirmationFormStateImplCopyWith<
          _$SignTransactionConfirmationFormStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
