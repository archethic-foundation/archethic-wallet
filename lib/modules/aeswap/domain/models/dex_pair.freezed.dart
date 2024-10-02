// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dex_pair.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DexPair _$DexPairFromJson(Map<String, dynamic> json) {
  return _DexPair.fromJson(json);
}

/// @nodoc
mixin _$DexPair {
  DexToken get token1 => throw _privateConstructorUsedError;
  DexToken get token2 => throw _privateConstructorUsedError;

  /// Serializes this DexPair to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DexPair
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DexPairCopyWith<DexPair> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DexPairCopyWith<$Res> {
  factory $DexPairCopyWith(DexPair value, $Res Function(DexPair) then) =
      _$DexPairCopyWithImpl<$Res, DexPair>;
  @useResult
  $Res call({DexToken token1, DexToken token2});

  $DexTokenCopyWith<$Res> get token1;
  $DexTokenCopyWith<$Res> get token2;
}

/// @nodoc
class _$DexPairCopyWithImpl<$Res, $Val extends DexPair>
    implements $DexPairCopyWith<$Res> {
  _$DexPairCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DexPair
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token1 = null,
    Object? token2 = null,
  }) {
    return _then(_value.copyWith(
      token1: null == token1
          ? _value.token1
          : token1 // ignore: cast_nullable_to_non_nullable
              as DexToken,
      token2: null == token2
          ? _value.token2
          : token2 // ignore: cast_nullable_to_non_nullable
              as DexToken,
    ) as $Val);
  }

  /// Create a copy of DexPair
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DexTokenCopyWith<$Res> get token1 {
    return $DexTokenCopyWith<$Res>(_value.token1, (value) {
      return _then(_value.copyWith(token1: value) as $Val);
    });
  }

  /// Create a copy of DexPair
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DexTokenCopyWith<$Res> get token2 {
    return $DexTokenCopyWith<$Res>(_value.token2, (value) {
      return _then(_value.copyWith(token2: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DexPairImplCopyWith<$Res> implements $DexPairCopyWith<$Res> {
  factory _$$DexPairImplCopyWith(
          _$DexPairImpl value, $Res Function(_$DexPairImpl) then) =
      __$$DexPairImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DexToken token1, DexToken token2});

  @override
  $DexTokenCopyWith<$Res> get token1;
  @override
  $DexTokenCopyWith<$Res> get token2;
}

/// @nodoc
class __$$DexPairImplCopyWithImpl<$Res>
    extends _$DexPairCopyWithImpl<$Res, _$DexPairImpl>
    implements _$$DexPairImplCopyWith<$Res> {
  __$$DexPairImplCopyWithImpl(
      _$DexPairImpl _value, $Res Function(_$DexPairImpl) _then)
      : super(_value, _then);

  /// Create a copy of DexPair
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token1 = null,
    Object? token2 = null,
  }) {
    return _then(_$DexPairImpl(
      token1: null == token1
          ? _value.token1
          : token1 // ignore: cast_nullable_to_non_nullable
              as DexToken,
      token2: null == token2
          ? _value.token2
          : token2 // ignore: cast_nullable_to_non_nullable
              as DexToken,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DexPairImpl implements _DexPair {
  const _$DexPairImpl({required this.token1, required this.token2});

  factory _$DexPairImpl.fromJson(Map<String, dynamic> json) =>
      _$$DexPairImplFromJson(json);

  @override
  final DexToken token1;
  @override
  final DexToken token2;

  @override
  String toString() {
    return 'DexPair(token1: $token1, token2: $token2)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DexPairImpl &&
            (identical(other.token1, token1) || other.token1 == token1) &&
            (identical(other.token2, token2) || other.token2 == token2));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, token1, token2);

  /// Create a copy of DexPair
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DexPairImplCopyWith<_$DexPairImpl> get copyWith =>
      __$$DexPairImplCopyWithImpl<_$DexPairImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DexPairImplToJson(
      this,
    );
  }
}

abstract class _DexPair implements DexPair {
  const factory _DexPair(
      {required final DexToken token1,
      required final DexToken token2}) = _$DexPairImpl;

  factory _DexPair.fromJson(Map<String, dynamic> json) = _$DexPairImpl.fromJson;

  @override
  DexToken get token1;
  @override
  DexToken get token2;

  /// Create a copy of DexPair
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DexPairImplCopyWith<_$DexPairImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
