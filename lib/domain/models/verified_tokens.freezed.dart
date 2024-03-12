// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verified_tokens.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VerifiedTokens _$VerifiedTokensFromJson(Map<String, dynamic> json) {
  return _VerifiedTokens.fromJson(json);
}

/// @nodoc
mixin _$VerifiedTokens {
  List<String> get devnet => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VerifiedTokensCopyWith<VerifiedTokens> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerifiedTokensCopyWith<$Res> {
  factory $VerifiedTokensCopyWith(
          VerifiedTokens value, $Res Function(VerifiedTokens) then) =
      _$VerifiedTokensCopyWithImpl<$Res, VerifiedTokens>;
  @useResult
  $Res call({List<String> devnet});
}

/// @nodoc
class _$VerifiedTokensCopyWithImpl<$Res, $Val extends VerifiedTokens>
    implements $VerifiedTokensCopyWith<$Res> {
  _$VerifiedTokensCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? devnet = null,
  }) {
    return _then(_value.copyWith(
      devnet: null == devnet
          ? _value.devnet
          : devnet // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VerifiedTokensImplCopyWith<$Res>
    implements $VerifiedTokensCopyWith<$Res> {
  factory _$$VerifiedTokensImplCopyWith(_$VerifiedTokensImpl value,
          $Res Function(_$VerifiedTokensImpl) then) =
      __$$VerifiedTokensImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> devnet});
}

/// @nodoc
class __$$VerifiedTokensImplCopyWithImpl<$Res>
    extends _$VerifiedTokensCopyWithImpl<$Res, _$VerifiedTokensImpl>
    implements _$$VerifiedTokensImplCopyWith<$Res> {
  __$$VerifiedTokensImplCopyWithImpl(
      _$VerifiedTokensImpl _value, $Res Function(_$VerifiedTokensImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? devnet = null,
  }) {
    return _then(_$VerifiedTokensImpl(
      devnet: null == devnet
          ? _value._devnet
          : devnet // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VerifiedTokensImpl implements _VerifiedTokens {
  const _$VerifiedTokensImpl({required final List<String> devnet})
      : _devnet = devnet;

  factory _$VerifiedTokensImpl.fromJson(Map<String, dynamic> json) =>
      _$$VerifiedTokensImplFromJson(json);

  final List<String> _devnet;
  @override
  List<String> get devnet {
    if (_devnet is EqualUnmodifiableListView) return _devnet;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_devnet);
  }

  @override
  String toString() {
    return 'VerifiedTokens(devnet: $devnet)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifiedTokensImpl &&
            const DeepCollectionEquality().equals(other._devnet, _devnet));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_devnet));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VerifiedTokensImplCopyWith<_$VerifiedTokensImpl> get copyWith =>
      __$$VerifiedTokensImplCopyWithImpl<_$VerifiedTokensImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VerifiedTokensImplToJson(
      this,
    );
  }
}

abstract class _VerifiedTokens implements VerifiedTokens {
  const factory _VerifiedTokens({required final List<String> devnet}) =
      _$VerifiedTokensImpl;

  factory _VerifiedTokens.fromJson(Map<String, dynamic> json) =
      _$VerifiedTokensImpl.fromJson;

  @override
  List<String> get devnet;
  @override
  @JsonKey(ignore: true)
  _$$VerifiedTokensImplCopyWith<_$VerifiedTokensImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
