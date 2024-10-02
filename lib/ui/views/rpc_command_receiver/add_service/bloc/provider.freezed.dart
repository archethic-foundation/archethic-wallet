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
mixin _$AddServiceConfirmationFormState {
  RPCCommand<SendTransactionRequest> get signTransactionCommand =>
      throw _privateConstructorUsedError;

  /// Create a copy of AddServiceConfirmationFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
  $Res call({RPCCommand<SendTransactionRequest> signTransactionCommand});

  $RPCCommandCopyWith<SendTransactionRequest, $Res> get signTransactionCommand;
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

  /// Create a copy of AddServiceConfirmationFormState
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
              as RPCCommand<SendTransactionRequest>,
    ) as $Val);
  }

  /// Create a copy of AddServiceConfirmationFormState
  /// with the given fields replaced by the non-null parameter values.
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
abstract class _$$AddServiceConfirmationFormStateImplCopyWith<$Res>
    implements $AddServiceConfirmationFormStateCopyWith<$Res> {
  factory _$$AddServiceConfirmationFormStateImplCopyWith(
          _$AddServiceConfirmationFormStateImpl value,
          $Res Function(_$AddServiceConfirmationFormStateImpl) then) =
      __$$AddServiceConfirmationFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({RPCCommand<SendTransactionRequest> signTransactionCommand});

  @override
  $RPCCommandCopyWith<SendTransactionRequest, $Res> get signTransactionCommand;
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

  /// Create a copy of AddServiceConfirmationFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signTransactionCommand = null,
  }) {
    return _then(_$AddServiceConfirmationFormStateImpl(
      signTransactionCommand: null == signTransactionCommand
          ? _value.signTransactionCommand
          : signTransactionCommand // ignore: cast_nullable_to_non_nullable
              as RPCCommand<SendTransactionRequest>,
    ));
  }
}

/// @nodoc

class _$AddServiceConfirmationFormStateImpl
    extends _AddServiceConfirmationFormState {
  const _$AddServiceConfirmationFormStateImpl(
      {required this.signTransactionCommand})
      : super._();

  @override
  final RPCCommand<SendTransactionRequest> signTransactionCommand;

  @override
  String toString() {
    return 'AddServiceConfirmationFormState(signTransactionCommand: $signTransactionCommand)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddServiceConfirmationFormStateImpl &&
            (identical(other.signTransactionCommand, signTransactionCommand) ||
                other.signTransactionCommand == signTransactionCommand));
  }

  @override
  int get hashCode => Object.hash(runtimeType, signTransactionCommand);

  /// Create a copy of AddServiceConfirmationFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      {required final RPCCommand<SendTransactionRequest>
          signTransactionCommand}) = _$AddServiceConfirmationFormStateImpl;
  const _AddServiceConfirmationFormState._() : super._();

  @override
  RPCCommand<SendTransactionRequest> get signTransactionCommand;

  /// Create a copy of AddServiceConfirmationFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddServiceConfirmationFormStateImplCopyWith<
          _$AddServiceConfirmationFormStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
