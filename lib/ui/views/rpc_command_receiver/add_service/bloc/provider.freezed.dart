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
  RPCSessionOrigin get sessionOrigin => throw _privateConstructorUsedError;
  SendTransactionRequest get signTransactionCommand =>
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
  $Res call(
      {RPCSessionOrigin sessionOrigin,
      SendTransactionRequest signTransactionCommand});

  $RPCSessionOriginCopyWith<$Res> get sessionOrigin;
  $SendTransactionRequestCopyWith<$Res> get signTransactionCommand;
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
    Object? sessionOrigin = null,
    Object? signTransactionCommand = null,
  }) {
    return _then(_value.copyWith(
      sessionOrigin: null == sessionOrigin
          ? _value.sessionOrigin
          : sessionOrigin // ignore: cast_nullable_to_non_nullable
              as RPCSessionOrigin,
      signTransactionCommand: null == signTransactionCommand
          ? _value.signTransactionCommand
          : signTransactionCommand // ignore: cast_nullable_to_non_nullable
              as SendTransactionRequest,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RPCSessionOriginCopyWith<$Res> get sessionOrigin {
    return $RPCSessionOriginCopyWith<$Res>(_value.sessionOrigin, (value) {
      return _then(_value.copyWith(sessionOrigin: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SendTransactionRequestCopyWith<$Res> get signTransactionCommand {
    return $SendTransactionRequestCopyWith<$Res>(_value.signTransactionCommand,
        (value) {
      return _then(_value.copyWith(signTransactionCommand: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AddServiceConfirmationFormStateImplCopyWith<$Res>
    implements $AddServiceConfirmationFormStateCopyWith<$Res> {
  factory _$$AddServiceConfirmationFormStateImplCopyWith(
          _$AddServiceConfirmationFormStateImpl value,
          $Res Function(_$AddServiceConfirmationFormStateImpl) then) =
      __$$AddServiceConfirmationFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {RPCSessionOrigin sessionOrigin,
      SendTransactionRequest signTransactionCommand});

  @override
  $RPCSessionOriginCopyWith<$Res> get sessionOrigin;
  @override
  $SendTransactionRequestCopyWith<$Res> get signTransactionCommand;
}

/// @nodoc
class __$$AddServiceConfirmationFormStateImplCopyWithImpl<$Res>
    extends _$AddServiceConfirmationFormStateCopyWithImpl<$Res,
        _$AddServiceConfirmationFormStateImpl>
    implements _$$AddServiceConfirmationFormStateImplCopyWith<$Res> {
  __$$AddServiceConfirmationFormStateImplCopyWithImpl(
      _$AddServiceConfirmationFormStateImpl _value,
      $Res Function(_$AddServiceConfirmationFormStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionOrigin = null,
    Object? signTransactionCommand = null,
  }) {
    return _then(_$AddServiceConfirmationFormStateImpl(
      sessionOrigin: null == sessionOrigin
          ? _value.sessionOrigin
          : sessionOrigin // ignore: cast_nullable_to_non_nullable
              as RPCSessionOrigin,
      signTransactionCommand: null == signTransactionCommand
          ? _value.signTransactionCommand
          : signTransactionCommand // ignore: cast_nullable_to_non_nullable
              as SendTransactionRequest,
    ));
  }
}

/// @nodoc

class _$AddServiceConfirmationFormStateImpl
    extends _AddServiceConfirmationFormState {
  const _$AddServiceConfirmationFormStateImpl(
      {required this.sessionOrigin, required this.signTransactionCommand})
      : super._();

  @override
  final RPCSessionOrigin sessionOrigin;
  @override
  final SendTransactionRequest signTransactionCommand;

  @override
  String toString() {
    return 'AddServiceConfirmationFormState(sessionOrigin: $sessionOrigin, signTransactionCommand: $signTransactionCommand)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddServiceConfirmationFormStateImpl &&
            (identical(other.sessionOrigin, sessionOrigin) ||
                other.sessionOrigin == sessionOrigin) &&
            (identical(other.signTransactionCommand, signTransactionCommand) ||
                other.signTransactionCommand == signTransactionCommand));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, sessionOrigin, signTransactionCommand);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddServiceConfirmationFormStateImplCopyWith<
          _$AddServiceConfirmationFormStateImpl>
      get copyWith => __$$AddServiceConfirmationFormStateImplCopyWithImpl<
          _$AddServiceConfirmationFormStateImpl>(this, _$identity);
}

abstract class _AddServiceConfirmationFormState
    extends AddServiceConfirmationFormState {
  const factory _AddServiceConfirmationFormState(
          {required final RPCSessionOrigin sessionOrigin,
          required final SendTransactionRequest signTransactionCommand}) =
      _$AddServiceConfirmationFormStateImpl;
  const _AddServiceConfirmationFormState._() : super._();

  @override
  RPCSessionOrigin get sessionOrigin;
  @override
  SendTransactionRequest get signTransactionCommand;
  @override
  @JsonKey(ignore: true)
  _$$AddServiceConfirmationFormStateImplCopyWith<
          _$AddServiceConfirmationFormStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
