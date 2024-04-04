// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dapps.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DApps _$DAppsFromJson(Map<String, dynamic> json) {
  return _DApps.fromJson(json);
}

/// @nodoc
mixin _$DApps {
  String get code => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String? get accessToken => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DAppsCopyWith<DApps> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DAppsCopyWith<$Res> {
  factory $DAppsCopyWith(DApps value, $Res Function(DApps) then) =
      _$DAppsCopyWithImpl<$Res, DApps>;
  @useResult
  $Res call({String code, String url, String? accessToken});
}

/// @nodoc
class _$DAppsCopyWithImpl<$Res, $Val extends DApps>
    implements $DAppsCopyWith<$Res> {
  _$DAppsCopyWithImpl(this._value, this._then);

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
abstract class _$$DAppsImplCopyWith<$Res> implements $DAppsCopyWith<$Res> {
  factory _$$DAppsImplCopyWith(
          _$DAppsImpl value, $Res Function(_$DAppsImpl) then) =
      __$$DAppsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code, String url, String? accessToken});
}

/// @nodoc
class __$$DAppsImplCopyWithImpl<$Res>
    extends _$DAppsCopyWithImpl<$Res, _$DAppsImpl>
    implements _$$DAppsImplCopyWith<$Res> {
  __$$DAppsImplCopyWithImpl(
      _$DAppsImpl _value, $Res Function(_$DAppsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? url = null,
    Object? accessToken = freezed,
  }) {
    return _then(_$DAppsImpl(
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
class _$DAppsImpl implements _DApps {
  const _$DAppsImpl({required this.code, required this.url, this.accessToken});

  factory _$DAppsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DAppsImplFromJson(json);

  @override
  final String code;
  @override
  final String url;
  @override
  final String? accessToken;

  @override
  String toString() {
    return 'DApps(code: $code, url: $url, accessToken: $accessToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DAppsImpl &&
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
  _$$DAppsImplCopyWith<_$DAppsImpl> get copyWith =>
      __$$DAppsImplCopyWithImpl<_$DAppsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DAppsImplToJson(
      this,
    );
  }
}

abstract class _DApps implements DApps {
  const factory _DApps(
      {required final String code,
      required final String url,
      final String? accessToken}) = _$DAppsImpl;

  factory _DApps.fromJson(Map<String, dynamic> json) = _$DAppsImpl.fromJson;

  @override
  String get code;
  @override
  String get url;
  @override
  String? get accessToken;
  @override
  @JsonKey(ignore: true)
  _$$DAppsImplCopyWith<_$DAppsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
