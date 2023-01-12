// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_version_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppVersionInfo {
  String get storeVersion => throw _privateConstructorUsedError;
  String get storeUrl => throw _privateConstructorUsedError;
  bool get canUpdate => throw _privateConstructorUsedError;
  TargetPlatform? get platform => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppVersionInfoCopyWith<AppVersionInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppVersionInfoCopyWith<$Res> {
  factory $AppVersionInfoCopyWith(
          AppVersionInfo value, $Res Function(AppVersionInfo) then) =
      _$AppVersionInfoCopyWithImpl<$Res, AppVersionInfo>;
  @useResult
  $Res call(
      {String storeVersion,
      String storeUrl,
      bool canUpdate,
      TargetPlatform? platform});
}

/// @nodoc
class _$AppVersionInfoCopyWithImpl<$Res, $Val extends AppVersionInfo>
    implements $AppVersionInfoCopyWith<$Res> {
  _$AppVersionInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeVersion = null,
    Object? storeUrl = null,
    Object? canUpdate = null,
    Object? platform = freezed,
  }) {
    return _then(_value.copyWith(
      storeVersion: null == storeVersion
          ? _value.storeVersion
          : storeVersion // ignore: cast_nullable_to_non_nullable
              as String,
      storeUrl: null == storeUrl
          ? _value.storeUrl
          : storeUrl // ignore: cast_nullable_to_non_nullable
              as String,
      canUpdate: null == canUpdate
          ? _value.canUpdate
          : canUpdate // ignore: cast_nullable_to_non_nullable
              as bool,
      platform: freezed == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as TargetPlatform?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AppVersionInfoCopyWith<$Res>
    implements $AppVersionInfoCopyWith<$Res> {
  factory _$$_AppVersionInfoCopyWith(
          _$_AppVersionInfo value, $Res Function(_$_AppVersionInfo) then) =
      __$$_AppVersionInfoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String storeVersion,
      String storeUrl,
      bool canUpdate,
      TargetPlatform? platform});
}

/// @nodoc
class __$$_AppVersionInfoCopyWithImpl<$Res>
    extends _$AppVersionInfoCopyWithImpl<$Res, _$_AppVersionInfo>
    implements _$$_AppVersionInfoCopyWith<$Res> {
  __$$_AppVersionInfoCopyWithImpl(
      _$_AppVersionInfo _value, $Res Function(_$_AppVersionInfo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeVersion = null,
    Object? storeUrl = null,
    Object? canUpdate = null,
    Object? platform = freezed,
  }) {
    return _then(_$_AppVersionInfo(
      storeVersion: null == storeVersion
          ? _value.storeVersion
          : storeVersion // ignore: cast_nullable_to_non_nullable
              as String,
      storeUrl: null == storeUrl
          ? _value.storeUrl
          : storeUrl // ignore: cast_nullable_to_non_nullable
              as String,
      canUpdate: null == canUpdate
          ? _value.canUpdate
          : canUpdate // ignore: cast_nullable_to_non_nullable
              as bool,
      platform: freezed == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as TargetPlatform?,
    ));
  }
}

/// @nodoc

class _$_AppVersionInfo extends _AppVersionInfo with DiagnosticableTreeMixin {
  const _$_AppVersionInfo(
      {required this.storeVersion,
      required this.storeUrl,
      this.canUpdate = false,
      this.platform})
      : super._();

  @override
  final String storeVersion;
  @override
  final String storeUrl;
  @override
  @JsonKey()
  final bool canUpdate;
  @override
  final TargetPlatform? platform;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppVersionInfo(storeVersion: $storeVersion, storeUrl: $storeUrl, canUpdate: $canUpdate, platform: $platform)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppVersionInfo'))
      ..add(DiagnosticsProperty('storeVersion', storeVersion))
      ..add(DiagnosticsProperty('storeUrl', storeUrl))
      ..add(DiagnosticsProperty('canUpdate', canUpdate))
      ..add(DiagnosticsProperty('platform', platform));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppVersionInfo &&
            (identical(other.storeVersion, storeVersion) ||
                other.storeVersion == storeVersion) &&
            (identical(other.storeUrl, storeUrl) ||
                other.storeUrl == storeUrl) &&
            (identical(other.canUpdate, canUpdate) ||
                other.canUpdate == canUpdate) &&
            (identical(other.platform, platform) ||
                other.platform == platform));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, storeVersion, storeUrl, canUpdate, platform);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppVersionInfoCopyWith<_$_AppVersionInfo> get copyWith =>
      __$$_AppVersionInfoCopyWithImpl<_$_AppVersionInfo>(this, _$identity);
}

abstract class _AppVersionInfo extends AppVersionInfo {
  const factory _AppVersionInfo(
      {required final String storeVersion,
      required final String storeUrl,
      final bool canUpdate,
      final TargetPlatform? platform}) = _$_AppVersionInfo;
  const _AppVersionInfo._() : super._();

  @override
  String get storeVersion;
  @override
  String get storeUrl;
  @override
  bool get canUpdate;
  @override
  TargetPlatform? get platform;
  @override
  @JsonKey(ignore: true)
  _$$_AppVersionInfoCopyWith<_$_AppVersionInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
