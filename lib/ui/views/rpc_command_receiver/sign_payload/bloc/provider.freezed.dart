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
mixin _$SignPayloadsConfirmationFormState {
  RPCCommand<SignPayloadRequest> get signTransactionCommand =>
      throw _privateConstructorUsedError;

  /// Create a copy of SignPayloadsConfirmationFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SignPayloadsConfirmationFormStateCopyWith<SignPayloadsConfirmationFormState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignPayloadsConfirmationFormStateCopyWith<$Res> {
  factory $SignPayloadsConfirmationFormStateCopyWith(
          SignPayloadsConfirmationFormState value,
          $Res Function(SignPayloadsConfirmationFormState) then) =
      _$SignPayloadsConfirmationFormStateCopyWithImpl<$Res,
          SignPayloadsConfirmationFormState>;
  @useResult
  $Res call({RPCCommand<SignPayloadRequest> signTransactionCommand});

  $RPCCommandCopyWith<SignPayloadRequest, $Res> get signTransactionCommand;
}

/// @nodoc
class _$SignPayloadsConfirmationFormStateCopyWithImpl<$Res,
        $Val extends SignPayloadsConfirmationFormState>
    implements $SignPayloadsConfirmationFormStateCopyWith<$Res> {
  _$SignPayloadsConfirmationFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignPayloadsConfirmationFormState
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
              as RPCCommand<SignPayloadRequest>,
    ) as $Val);
  }

  /// Create a copy of SignPayloadsConfirmationFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RPCCommandCopyWith<SignPayloadRequest, $Res> get signTransactionCommand {
    return $RPCCommandCopyWith<SignPayloadRequest, $Res>(
        _value.signTransactionCommand, (value) {
      return _then(_value.copyWith(signTransactionCommand: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SignPayloadsConfirmationFormStateImplCopyWith<$Res>
    implements $SignPayloadsConfirmationFormStateCopyWith<$Res> {
  factory _$$SignPayloadsConfirmationFormStateImplCopyWith(
          _$SignPayloadsConfirmationFormStateImpl value,
          $Res Function(_$SignPayloadsConfirmationFormStateImpl) then) =
      __$$SignPayloadsConfirmationFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({RPCCommand<SignPayloadRequest> signTransactionCommand});

  @override
  $RPCCommandCopyWith<SignPayloadRequest, $Res> get signTransactionCommand;
}

/// @nodoc
class __$$SignPayloadsConfirmationFormStateImplCopyWithImpl<$Res>
    extends _$SignPayloadsConfirmationFormStateCopyWithImpl<$Res,
        _$SignPayloadsConfirmationFormStateImpl>
    implements _$$SignPayloadsConfirmationFormStateImplCopyWith<$Res> {
  __$$SignPayloadsConfirmationFormStateImplCopyWithImpl(
      _$SignPayloadsConfirmationFormStateImpl _value,
      $Res Function(_$SignPayloadsConfirmationFormStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignPayloadsConfirmationFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signTransactionCommand = null,
  }) {
    return _then(_$SignPayloadsConfirmationFormStateImpl(
      signTransactionCommand: null == signTransactionCommand
          ? _value.signTransactionCommand
          : signTransactionCommand // ignore: cast_nullable_to_non_nullable
              as RPCCommand<SignPayloadRequest>,
    ));
  }
}

/// @nodoc

class _$SignPayloadsConfirmationFormStateImpl
    extends _SignPayloadsConfirmationFormState {
  const _$SignPayloadsConfirmationFormStateImpl(
      {required this.signTransactionCommand})
      : super._();

  @override
  final RPCCommand<SignPayloadRequest> signTransactionCommand;

  @override
  String toString() {
    return 'SignPayloadsConfirmationFormState(signTransactionCommand: $signTransactionCommand)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignPayloadsConfirmationFormStateImpl &&
            (identical(other.signTransactionCommand, signTransactionCommand) ||
                other.signTransactionCommand == signTransactionCommand));
  }

  @override
  int get hashCode => Object.hash(runtimeType, signTransactionCommand);

  /// Create a copy of SignPayloadsConfirmationFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignPayloadsConfirmationFormStateImplCopyWith<
          _$SignPayloadsConfirmationFormStateImpl>
      get copyWith => __$$SignPayloadsConfirmationFormStateImplCopyWithImpl<
          _$SignPayloadsConfirmationFormStateImpl>(this, _$identity);
}

abstract class _SignPayloadsConfirmationFormState
    extends SignPayloadsConfirmationFormState {
  const factory _SignPayloadsConfirmationFormState(
      {required final RPCCommand<SignPayloadRequest>
          signTransactionCommand}) = _$SignPayloadsConfirmationFormStateImpl;
  const _SignPayloadsConfirmationFormState._() : super._();

  @override
  RPCCommand<SignPayloadRequest> get signTransactionCommand;

  /// Create a copy of SignPayloadsConfirmationFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignPayloadsConfirmationFormStateImplCopyWith<
          _$SignPayloadsConfirmationFormStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
