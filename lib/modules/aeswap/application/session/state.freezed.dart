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
mixin _$SessionAESwap {
  Environment get environment => throw _privateConstructorUsedError;

  /// Create a copy of SessionAESwap
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionAESwapCopyWith<SessionAESwap> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionAESwapCopyWith<$Res> {
  factory $SessionAESwapCopyWith(
          SessionAESwap value, $Res Function(SessionAESwap) then) =
      _$SessionAESwapCopyWithImpl<$Res, SessionAESwap>;
  @useResult
  $Res call({Environment environment});
}

/// @nodoc
class _$SessionAESwapCopyWithImpl<$Res, $Val extends SessionAESwap>
    implements $SessionAESwapCopyWith<$Res> {
  _$SessionAESwapCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SessionAESwap
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? environment = null,
  }) {
    return _then(_value.copyWith(
      environment: null == environment
          ? _value.environment
          : environment // ignore: cast_nullable_to_non_nullable
              as Environment,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SessionAESwapImplCopyWith<$Res>
    implements $SessionAESwapCopyWith<$Res> {
  factory _$$SessionAESwapImplCopyWith(
          _$SessionAESwapImpl value, $Res Function(_$SessionAESwapImpl) then) =
      __$$SessionAESwapImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Environment environment});
}

/// @nodoc
class __$$SessionAESwapImplCopyWithImpl<$Res>
    extends _$SessionAESwapCopyWithImpl<$Res, _$SessionAESwapImpl>
    implements _$$SessionAESwapImplCopyWith<$Res> {
  __$$SessionAESwapImplCopyWithImpl(
      _$SessionAESwapImpl _value, $Res Function(_$SessionAESwapImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionAESwap
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? environment = null,
  }) {
    return _then(_$SessionAESwapImpl(
      environment: null == environment
          ? _value.environment
          : environment // ignore: cast_nullable_to_non_nullable
              as Environment,
    ));
  }
}

/// @nodoc

class _$SessionAESwapImpl extends _SessionAESwap {
  const _$SessionAESwapImpl({required this.environment}) : super._();

  @override
  final Environment environment;

  @override
  String toString() {
    return 'SessionAESwap(environment: $environment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionAESwapImpl &&
            (identical(other.environment, environment) ||
                other.environment == environment));
  }

  @override
  int get hashCode => Object.hash(runtimeType, environment);

  /// Create a copy of SessionAESwap
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionAESwapImplCopyWith<_$SessionAESwapImpl> get copyWith =>
      __$$SessionAESwapImplCopyWithImpl<_$SessionAESwapImpl>(this, _$identity);
}

abstract class _SessionAESwap extends SessionAESwap {
  const factory _SessionAESwap({required final Environment environment}) =
      _$SessionAESwapImpl;
  const _SessionAESwap._() : super._();

  @override
  Environment get environment;

  /// Create a copy of SessionAESwap
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionAESwapImplCopyWith<_$SessionAESwapImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
