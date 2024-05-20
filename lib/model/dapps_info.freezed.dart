// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dapps_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DAppsInfo {
  String? get dAppName => throw _privateConstructorUsedError;
  String? get dAppDesc => throw _privateConstructorUsedError;
  String? get dAppLink => throw _privateConstructorUsedError;
  String? get dAppBackgroundImgCard => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DAppsInfoCopyWith<DAppsInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DAppsInfoCopyWith<$Res> {
  factory $DAppsInfoCopyWith(DAppsInfo value, $Res Function(DAppsInfo) then) =
      _$DAppsInfoCopyWithImpl<$Res, DAppsInfo>;
  @useResult
  $Res call(
      {String? dAppName,
      String? dAppDesc,
      String? dAppLink,
      String? dAppBackgroundImgCard});
}

/// @nodoc
class _$DAppsInfoCopyWithImpl<$Res, $Val extends DAppsInfo>
    implements $DAppsInfoCopyWith<$Res> {
  _$DAppsInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dAppName = freezed,
    Object? dAppDesc = freezed,
    Object? dAppLink = freezed,
    Object? dAppBackgroundImgCard = freezed,
  }) {
    return _then(_value.copyWith(
      dAppName: freezed == dAppName
          ? _value.dAppName
          : dAppName // ignore: cast_nullable_to_non_nullable
              as String?,
      dAppDesc: freezed == dAppDesc
          ? _value.dAppDesc
          : dAppDesc // ignore: cast_nullable_to_non_nullable
              as String?,
      dAppLink: freezed == dAppLink
          ? _value.dAppLink
          : dAppLink // ignore: cast_nullable_to_non_nullable
              as String?,
      dAppBackgroundImgCard: freezed == dAppBackgroundImgCard
          ? _value.dAppBackgroundImgCard
          : dAppBackgroundImgCard // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DAppsInfoImplCopyWith<$Res>
    implements $DAppsInfoCopyWith<$Res> {
  factory _$$DAppsInfoImplCopyWith(
          _$DAppsInfoImpl value, $Res Function(_$DAppsInfoImpl) then) =
      __$$DAppsInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? dAppName,
      String? dAppDesc,
      String? dAppLink,
      String? dAppBackgroundImgCard});
}

/// @nodoc
class __$$DAppsInfoImplCopyWithImpl<$Res>
    extends _$DAppsInfoCopyWithImpl<$Res, _$DAppsInfoImpl>
    implements _$$DAppsInfoImplCopyWith<$Res> {
  __$$DAppsInfoImplCopyWithImpl(
      _$DAppsInfoImpl _value, $Res Function(_$DAppsInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dAppName = freezed,
    Object? dAppDesc = freezed,
    Object? dAppLink = freezed,
    Object? dAppBackgroundImgCard = freezed,
  }) {
    return _then(_$DAppsInfoImpl(
      dAppName: freezed == dAppName
          ? _value.dAppName
          : dAppName // ignore: cast_nullable_to_non_nullable
              as String?,
      dAppDesc: freezed == dAppDesc
          ? _value.dAppDesc
          : dAppDesc // ignore: cast_nullable_to_non_nullable
              as String?,
      dAppLink: freezed == dAppLink
          ? _value.dAppLink
          : dAppLink // ignore: cast_nullable_to_non_nullable
              as String?,
      dAppBackgroundImgCard: freezed == dAppBackgroundImgCard
          ? _value.dAppBackgroundImgCard
          : dAppBackgroundImgCard // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$DAppsInfoImpl extends _DAppsInfo {
  const _$DAppsInfoImpl(
      {this.dAppName, this.dAppDesc, this.dAppLink, this.dAppBackgroundImgCard})
      : super._();

  @override
  final String? dAppName;
  @override
  final String? dAppDesc;
  @override
  final String? dAppLink;
  @override
  final String? dAppBackgroundImgCard;

  @override
  String toString() {
    return 'DAppsInfo(dAppName: $dAppName, dAppDesc: $dAppDesc, dAppLink: $dAppLink, dAppBackgroundImgCard: $dAppBackgroundImgCard)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DAppsInfoImpl &&
            (identical(other.dAppName, dAppName) ||
                other.dAppName == dAppName) &&
            (identical(other.dAppDesc, dAppDesc) ||
                other.dAppDesc == dAppDesc) &&
            (identical(other.dAppLink, dAppLink) ||
                other.dAppLink == dAppLink) &&
            (identical(other.dAppBackgroundImgCard, dAppBackgroundImgCard) ||
                other.dAppBackgroundImgCard == dAppBackgroundImgCard));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, dAppName, dAppDesc, dAppLink, dAppBackgroundImgCard);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DAppsInfoImplCopyWith<_$DAppsInfoImpl> get copyWith =>
      __$$DAppsInfoImplCopyWithImpl<_$DAppsInfoImpl>(this, _$identity);
}

abstract class _DAppsInfo extends DAppsInfo {
  const factory _DAppsInfo(
      {final String? dAppName,
      final String? dAppDesc,
      final String? dAppLink,
      final String? dAppBackgroundImgCard}) = _$DAppsInfoImpl;
  const _DAppsInfo._() : super._();

  @override
  String? get dAppName;
  @override
  String? get dAppDesc;
  @override
  String? get dAppLink;
  @override
  String? get dAppBackgroundImgCard;
  @override
  @JsonKey(ignore: true)
  _$$DAppsInfoImplCopyWith<_$DAppsInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
