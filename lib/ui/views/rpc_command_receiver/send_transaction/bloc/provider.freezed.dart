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
mixin _$SignTransactionConfirmationFormState {
  RPCCommand<RPCSendTransactionCommandData> get signTransactionCommand =>
      throw _privateConstructorUsedError;
  Account get senderAccount => throw _privateConstructorUsedError;

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
      {RPCCommand<RPCSendTransactionCommandData> signTransactionCommand,
      Account senderAccount});

  $RPCCommandCopyWith<RPCSendTransactionCommandData, $Res>
      get signTransactionCommand;
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
    Object? senderAccount = null,
  }) {
    return _then(_value.copyWith(
      signTransactionCommand: null == signTransactionCommand
          ? _value.signTransactionCommand
          : signTransactionCommand // ignore: cast_nullable_to_non_nullable
              as RPCCommand<RPCSendTransactionCommandData>,
      senderAccount: null == senderAccount
          ? _value.senderAccount
          : senderAccount // ignore: cast_nullable_to_non_nullable
              as Account,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RPCCommandCopyWith<RPCSendTransactionCommandData, $Res>
      get signTransactionCommand {
    return $RPCCommandCopyWith<RPCSendTransactionCommandData, $Res>(
        _value.signTransactionCommand, (value) {
      return _then(_value.copyWith(signTransactionCommand: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_SignTransactionConfirmationFormStateCopyWith<$Res>
    implements $SignTransactionConfirmationFormStateCopyWith<$Res> {
  factory _$$_SignTransactionConfirmationFormStateCopyWith(
          _$_SignTransactionConfirmationFormState value,
          $Res Function(_$_SignTransactionConfirmationFormState) then) =
      __$$_SignTransactionConfirmationFormStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {RPCCommand<RPCSendTransactionCommandData> signTransactionCommand,
      Account senderAccount});

  @override
  $RPCCommandCopyWith<RPCSendTransactionCommandData, $Res>
      get signTransactionCommand;
}

/// @nodoc
class __$$_SignTransactionConfirmationFormStateCopyWithImpl<$Res>
    extends _$SignTransactionConfirmationFormStateCopyWithImpl<$Res,
        _$_SignTransactionConfirmationFormState>
    implements _$$_SignTransactionConfirmationFormStateCopyWith<$Res> {
  __$$_SignTransactionConfirmationFormStateCopyWithImpl(
      _$_SignTransactionConfirmationFormState _value,
      $Res Function(_$_SignTransactionConfirmationFormState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signTransactionCommand = null,
    Object? senderAccount = null,
  }) {
    return _then(_$_SignTransactionConfirmationFormState(
      signTransactionCommand: null == signTransactionCommand
          ? _value.signTransactionCommand
          : signTransactionCommand // ignore: cast_nullable_to_non_nullable
              as RPCCommand<RPCSendTransactionCommandData>,
      senderAccount: null == senderAccount
          ? _value.senderAccount
          : senderAccount // ignore: cast_nullable_to_non_nullable
              as Account,
    ));
  }
}

/// @nodoc

class _$_SignTransactionConfirmationFormState
    extends _SignTransactionConfirmationFormState {
  const _$_SignTransactionConfirmationFormState(
      {required this.signTransactionCommand, required this.senderAccount})
      : super._();

  @override
  final RPCCommand<RPCSendTransactionCommandData> signTransactionCommand;
  @override
  final Account senderAccount;

  @override
  String toString() {
    return 'SignTransactionConfirmationFormState(signTransactionCommand: $signTransactionCommand, senderAccount: $senderAccount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SignTransactionConfirmationFormState &&
            (identical(other.signTransactionCommand, signTransactionCommand) ||
                other.signTransactionCommand == signTransactionCommand) &&
            (identical(other.senderAccount, senderAccount) ||
                other.senderAccount == senderAccount));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, signTransactionCommand, senderAccount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SignTransactionConfirmationFormStateCopyWith<
          _$_SignTransactionConfirmationFormState>
      get copyWith => __$$_SignTransactionConfirmationFormStateCopyWithImpl<
          _$_SignTransactionConfirmationFormState>(this, _$identity);
}

abstract class _SignTransactionConfirmationFormState
    extends SignTransactionConfirmationFormState {
  const factory _SignTransactionConfirmationFormState(
          {required final RPCCommand<RPCSendTransactionCommandData>
              signTransactionCommand,
          required final Account senderAccount}) =
      _$_SignTransactionConfirmationFormState;
  const _SignTransactionConfirmationFormState._() : super._();

  @override
  RPCCommand<RPCSendTransactionCommandData> get signTransactionCommand;
  @override
  Account get senderAccount;
  @override
  @JsonKey(ignore: true)
  _$$_SignTransactionConfirmationFormStateCopyWith<
          _$_SignTransactionConfirmationFormState>
      get copyWith => throw _privateConstructorUsedError;
}
