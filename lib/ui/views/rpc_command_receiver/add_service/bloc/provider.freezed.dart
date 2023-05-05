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
mixin _$AddServiceConfirmationFormState {
  RPCCommand<RPCSendTransactionCommandData> get signTransactionCommand =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AddServiceConfirmationFormStateCopyWith<AddServiceConfirmationFormState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddServiceConfirmationFormStateCopyWith<$Res> {
  factory $AddServiceConfirmationFormStateCopyWith(
          AddServiceConfirmationFormState value,
          $Res Function(AddServiceConfirmationFormState) then) =
      _$AddServiceConfirmationFormStateCopyWithImpl<$Res,
          AddServiceConfirmationFormState>;
  @useResult
  $Res call({RPCCommand<RPCSendTransactionCommandData> signTransactionCommand});

  $RPCCommandCopyWith<RPCSendTransactionCommandData, $Res>
      get signTransactionCommand;
}

/// @nodoc
class _$AddServiceConfirmationFormStateCopyWithImpl<$Res,
        $Val extends AddServiceConfirmationFormState>
    implements $AddServiceConfirmationFormStateCopyWith<$Res> {
  _$AddServiceConfirmationFormStateCopyWithImpl(this._value, this._then);

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
              as RPCCommand<RPCSendTransactionCommandData>,
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
abstract class _$$_AddServiceConfirmationFormStateCopyWith<$Res>
    implements $AddServiceConfirmationFormStateCopyWith<$Res> {
  factory _$$_AddServiceConfirmationFormStateCopyWith(
          _$_AddServiceConfirmationFormState value,
          $Res Function(_$_AddServiceConfirmationFormState) then) =
      __$$_AddServiceConfirmationFormStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({RPCCommand<RPCSendTransactionCommandData> signTransactionCommand});

  @override
  $RPCCommandCopyWith<RPCSendTransactionCommandData, $Res>
      get signTransactionCommand;
}

/// @nodoc
class __$$_AddServiceConfirmationFormStateCopyWithImpl<$Res>
    extends _$AddServiceConfirmationFormStateCopyWithImpl<$Res,
        _$_AddServiceConfirmationFormState>
    implements _$$_AddServiceConfirmationFormStateCopyWith<$Res> {
  __$$_AddServiceConfirmationFormStateCopyWithImpl(
      _$_AddServiceConfirmationFormState _value,
      $Res Function(_$_AddServiceConfirmationFormState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signTransactionCommand = null,
  }) {
    return _then(_$_AddServiceConfirmationFormState(
      signTransactionCommand: null == signTransactionCommand
          ? _value.signTransactionCommand
          : signTransactionCommand // ignore: cast_nullable_to_non_nullable
              as RPCCommand<RPCSendTransactionCommandData>,
    ));
  }
}

/// @nodoc

class _$_AddServiceConfirmationFormState
    extends _AddServiceConfirmationFormState {
  const _$_AddServiceConfirmationFormState(
      {required this.signTransactionCommand})
      : super._();

  @override
  final RPCCommand<RPCSendTransactionCommandData> signTransactionCommand;

  @override
  String toString() {
    return 'AddServiceConfirmationFormState(signTransactionCommand: $signTransactionCommand)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AddServiceConfirmationFormState &&
            (identical(other.signTransactionCommand, signTransactionCommand) ||
                other.signTransactionCommand == signTransactionCommand));
  }

  @override
  int get hashCode => Object.hash(runtimeType, signTransactionCommand);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AddServiceConfirmationFormStateCopyWith<
          _$_AddServiceConfirmationFormState>
      get copyWith => __$$_AddServiceConfirmationFormStateCopyWithImpl<
          _$_AddServiceConfirmationFormState>(this, _$identity);
}

abstract class _AddServiceConfirmationFormState
    extends AddServiceConfirmationFormState {
  const factory _AddServiceConfirmationFormState(
      {required final RPCCommand<RPCSendTransactionCommandData>
          signTransactionCommand}) = _$_AddServiceConfirmationFormState;
  const _AddServiceConfirmationFormState._() : super._();

  @override
  RPCCommand<RPCSendTransactionCommandData> get signTransactionCommand;
  @override
  @JsonKey(ignore: true)
  _$$_AddServiceConfirmationFormStateCopyWith<
          _$_AddServiceConfirmationFormState>
      get copyWith => throw _privateConstructorUsedError;
}
