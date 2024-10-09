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
mixin _$SignTransactionsConfirmationFormState {
  RPCCommand<SignTransactionRequest> get signTransactionCommand =>
      throw _privateConstructorUsedError;

  /// Create a copy of SignTransactionsConfirmationFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SignTransactionsConfirmationFormStateCopyWith<
          SignTransactionsConfirmationFormState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignTransactionsConfirmationFormStateCopyWith<$Res> {
  factory $SignTransactionsConfirmationFormStateCopyWith(
          SignTransactionsConfirmationFormState value,
          $Res Function(SignTransactionsConfirmationFormState) then) =
      _$SignTransactionsConfirmationFormStateCopyWithImpl<$Res,
          SignTransactionsConfirmationFormState>;
  @useResult
  $Res call({RPCCommand<SignTransactionRequest> signTransactionCommand});

  $RPCCommandCopyWith<SignTransactionRequest, $Res> get signTransactionCommand;
}

/// @nodoc
class _$SignTransactionsConfirmationFormStateCopyWithImpl<$Res,
        $Val extends SignTransactionsConfirmationFormState>
    implements $SignTransactionsConfirmationFormStateCopyWith<$Res> {
  _$SignTransactionsConfirmationFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignTransactionsConfirmationFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signTransactionCommand = null,
  }) {
    return _then(_value.copyWith(
      signTransactionCommand: null == signTransactionCommand
          ? _value.signTransactionCommand
          : signTransactionCommand // ignore: cast_nullable_to_non_nullable
              as RPCCommand<SignTransactionRequest>,
    ) as $Val);
  }

  /// Create a copy of SignTransactionsConfirmationFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RPCCommandCopyWith<SignTransactionRequest, $Res> get signTransactionCommand {
    return $RPCCommandCopyWith<SignTransactionRequest, $Res>(
        _value.signTransactionCommand, (value) {
      return _then(_value.copyWith(signTransactionCommand: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SignTransactionsConfirmationFormStateImplCopyWith<$Res>
    implements $SignTransactionsConfirmationFormStateCopyWith<$Res> {
  factory _$$SignTransactionsConfirmationFormStateImplCopyWith(
          _$SignTransactionsConfirmationFormStateImpl value,
          $Res Function(_$SignTransactionsConfirmationFormStateImpl) then) =
      __$$SignTransactionsConfirmationFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({RPCCommand<SignTransactionRequest> signTransactionCommand});

  @override
  $RPCCommandCopyWith<SignTransactionRequest, $Res> get signTransactionCommand;
}

/// @nodoc
class __$$SignTransactionsConfirmationFormStateImplCopyWithImpl<$Res>
    extends _$SignTransactionsConfirmationFormStateCopyWithImpl<$Res,
        _$SignTransactionsConfirmationFormStateImpl>
    implements _$$SignTransactionsConfirmationFormStateImplCopyWith<$Res> {
  __$$SignTransactionsConfirmationFormStateImplCopyWithImpl(
      _$SignTransactionsConfirmationFormStateImpl _value,
      $Res Function(_$SignTransactionsConfirmationFormStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignTransactionsConfirmationFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signTransactionCommand = null,
  }) {
    return _then(_$SignTransactionsConfirmationFormStateImpl(
      signTransactionCommand: null == signTransactionCommand
          ? _value.signTransactionCommand
          : signTransactionCommand // ignore: cast_nullable_to_non_nullable
              as RPCCommand<SignTransactionRequest>,
    ));
  }
}

/// @nodoc

class _$SignTransactionsConfirmationFormStateImpl
    extends _SignTransactionsConfirmationFormState {
  const _$SignTransactionsConfirmationFormStateImpl(
      {required this.signTransactionCommand})
      : super._();

  @override
  final RPCCommand<SignTransactionRequest> signTransactionCommand;

  @override
  String toString() {
    return 'SignTransactionsConfirmationFormState(signTransactionCommand: $signTransactionCommand)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignTransactionsConfirmationFormStateImpl &&
            (identical(other.signTransactionCommand, signTransactionCommand) ||
                other.signTransactionCommand == signTransactionCommand));
  }

  @override
  int get hashCode => Object.hash(runtimeType, signTransactionCommand);

  /// Create a copy of SignTransactionsConfirmationFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignTransactionsConfirmationFormStateImplCopyWith<
          _$SignTransactionsConfirmationFormStateImpl>
      get copyWith => __$$SignTransactionsConfirmationFormStateImplCopyWithImpl<
          _$SignTransactionsConfirmationFormStateImpl>(this, _$identity);
}

abstract class _SignTransactionsConfirmationFormState
    extends SignTransactionsConfirmationFormState {
  const factory _SignTransactionsConfirmationFormState(
          {required final RPCCommand<SignTransactionRequest>
              signTransactionCommand}) =
      _$SignTransactionsConfirmationFormStateImpl;
  const _SignTransactionsConfirmationFormState._() : super._();

  @override
  RPCCommand<SignTransactionRequest> get signTransactionCommand;

  /// Create a copy of SignTransactionsConfirmationFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignTransactionsConfirmationFormStateImplCopyWith<
          _$SignTransactionsConfirmationFormStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
