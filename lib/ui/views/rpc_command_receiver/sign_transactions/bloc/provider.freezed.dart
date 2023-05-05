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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SignTransactionsConfirmationFormState {
  RPCCommand<RPCSignTransactionsCommandData> get signTransactionCommand =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
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
  $Res call(
      {RPCCommand<RPCSignTransactionsCommandData> signTransactionCommand});

  $RPCCommandCopyWith<RPCSignTransactionsCommandData, $Res>
      get signTransactionCommand;
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

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signTransactionCommand = null,
  }) {
    return _then(_value.copyWith(
      signTransactionCommand: null == signTransactionCommand
          ? _value.signTransactionCommand
          : signTransactionCommand // ignore: cast_nullable_to_non_nullable
              as RPCCommand<RPCSignTransactionsCommandData>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RPCCommandCopyWith<RPCSignTransactionsCommandData, $Res>
      get signTransactionCommand {
    return $RPCCommandCopyWith<RPCSignTransactionsCommandData, $Res>(
        _value.signTransactionCommand, (value) {
      return _then(_value.copyWith(signTransactionCommand: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_SignTransactionsConfirmationFormStateCopyWith<$Res>
    implements $SignTransactionsConfirmationFormStateCopyWith<$Res> {
  factory _$$_SignTransactionsConfirmationFormStateCopyWith(
          _$_SignTransactionsConfirmationFormState value,
          $Res Function(_$_SignTransactionsConfirmationFormState) then) =
      __$$_SignTransactionsConfirmationFormStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {RPCCommand<RPCSignTransactionsCommandData> signTransactionCommand});

  @override
  $RPCCommandCopyWith<RPCSignTransactionsCommandData, $Res>
      get signTransactionCommand;
}

/// @nodoc
class __$$_SignTransactionsConfirmationFormStateCopyWithImpl<$Res>
    extends _$SignTransactionsConfirmationFormStateCopyWithImpl<$Res,
        _$_SignTransactionsConfirmationFormState>
    implements _$$_SignTransactionsConfirmationFormStateCopyWith<$Res> {
  __$$_SignTransactionsConfirmationFormStateCopyWithImpl(
      _$_SignTransactionsConfirmationFormState _value,
      $Res Function(_$_SignTransactionsConfirmationFormState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signTransactionCommand = null,
  }) {
    return _then(_$_SignTransactionsConfirmationFormState(
      signTransactionCommand: null == signTransactionCommand
          ? _value.signTransactionCommand
          : signTransactionCommand // ignore: cast_nullable_to_non_nullable
              as RPCCommand<RPCSignTransactionsCommandData>,
    ));
  }
}

/// @nodoc

class _$_SignTransactionsConfirmationFormState
    extends _SignTransactionsConfirmationFormState {
  const _$_SignTransactionsConfirmationFormState(
      {required this.signTransactionCommand})
      : super._();

  @override
  final RPCCommand<RPCSignTransactionsCommandData> signTransactionCommand;

  @override
  String toString() {
    return 'SignTransactionsConfirmationFormState(signTransactionCommand: $signTransactionCommand)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SignTransactionsConfirmationFormState &&
            (identical(other.signTransactionCommand, signTransactionCommand) ||
                other.signTransactionCommand == signTransactionCommand));
  }

  @override
  int get hashCode => Object.hash(runtimeType, signTransactionCommand);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SignTransactionsConfirmationFormStateCopyWith<
          _$_SignTransactionsConfirmationFormState>
      get copyWith => __$$_SignTransactionsConfirmationFormStateCopyWithImpl<
          _$_SignTransactionsConfirmationFormState>(this, _$identity);
}

abstract class _SignTransactionsConfirmationFormState
    extends SignTransactionsConfirmationFormState {
  const factory _SignTransactionsConfirmationFormState(
      {required final RPCCommand<RPCSignTransactionsCommandData>
          signTransactionCommand}) = _$_SignTransactionsConfirmationFormState;
  const _SignTransactionsConfirmationFormState._() : super._();

  @override
  RPCCommand<RPCSignTransactionsCommandData> get signTransactionCommand;
  @override
  @JsonKey(ignore: true)
  _$$_SignTransactionsConfirmationFormStateCopyWith<
          _$_SignTransactionsConfirmationFormState>
      get copyWith => throw _privateConstructorUsedError;
}
