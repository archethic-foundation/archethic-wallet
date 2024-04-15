// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dapp.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DApp _$DAppFromJson(Map<String, dynamic> json) {
  return _DApp.fromJson(json);
}

/// @nodoc
mixin _$DApp {
  String get code => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String? get accessToken => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DAppCopyWith<DApp> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DAppCopyWith<$Res> {
  factory $DAppCopyWith(DApp value, $Res Function(DApp) then) =
      _$DAppCopyWithImpl<$Res, DApp>;
  @useResult
  $Res call({String code, String url, String? accessToken});
}

/// @nodoc
class _$DAppCopyWithImpl<$Res, $Val extends DApp>
    implements $DAppCopyWith<$Res> {
  _$DAppCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? url = null,
    Object? accessToken = freezed,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DAppImplCopyWith<$Res> implements $DAppCopyWith<$Res> {
  factory _$$DAppImplCopyWith(
          _$DAppImpl value, $Res Function(_$DAppImpl) then) =
      __$$DAppImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code, String url, String? accessToken});
}

/// @nodoc
class __$$DAppImplCopyWithImpl<$Res>
    extends _$DAppCopyWithImpl<$Res, _$DAppImpl>
    implements _$$DAppImplCopyWith<$Res> {
  __$$DAppImplCopyWithImpl(_$DAppImpl _value, $Res Function(_$DAppImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? url = null,
    Object? accessToken = freezed,
  }) {
    return _then(_$DAppImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DAppImpl implements _DApp {
  const _$DAppImpl({required this.code, required this.url, this.accessToken});

  factory _$DAppImpl.fromJson(Map<String, dynamic> json) =>
      _$$DAppImplFromJson(json);

  @override
  final String code;
  @override
  final String url;
  @override
  final String? accessToken;

  @override
  String toString() {
    return 'DApp(code: $code, url: $url, accessToken: $accessToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DAppImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, url, accessToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DAppImplCopyWith<_$DAppImpl> get copyWith =>
      __$$DAppImplCopyWithImpl<_$DAppImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DAppImplToJson(
      this,
    );
  }
}

abstract class _DApp implements DApp {
  const factory _DApp(
      {required final String code,
      required final String url,
      final String? accessToken}) = _$DAppImpl;

  factory _DApp.fromJson(Map<String, dynamic> json) = _$DAppImpl.fromJson;

  @override
  String get code;
  @override
  String get url;
  @override
  String? get accessToken;
  @override
  @JsonKey(ignore: true)
  _$$DAppImplCopyWith<_$DAppImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
