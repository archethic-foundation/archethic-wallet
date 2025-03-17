// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'airdrop_banner_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AirdropBannerStatus {
  AirdropState get state => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;

  /// Create a copy of AirdropBannerStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AirdropBannerStatusCopyWith<AirdropBannerStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AirdropBannerStatusCopyWith<$Res> {
  factory $AirdropBannerStatusCopyWith(
          AirdropBannerStatus value, $Res Function(AirdropBannerStatus) then) =
      _$AirdropBannerStatusCopyWithImpl<$Res, AirdropBannerStatus>;
  @useResult
  $Res call({AirdropState state, String? email});
}

/// @nodoc
class _$AirdropBannerStatusCopyWithImpl<$Res, $Val extends AirdropBannerStatus>
    implements $AirdropBannerStatusCopyWith<$Res> {
  _$AirdropBannerStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AirdropBannerStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = null,
    Object? email = freezed,
  }) {
    return _then(_value.copyWith(
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as AirdropState,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AirdropBannerStatusImplCopyWith<$Res>
    implements $AirdropBannerStatusCopyWith<$Res> {
  factory _$$AirdropBannerStatusImplCopyWith(_$AirdropBannerStatusImpl value,
          $Res Function(_$AirdropBannerStatusImpl) then) =
      __$$AirdropBannerStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AirdropState state, String? email});
}

/// @nodoc
class __$$AirdropBannerStatusImplCopyWithImpl<$Res>
    extends _$AirdropBannerStatusCopyWithImpl<$Res, _$AirdropBannerStatusImpl>
    implements _$$AirdropBannerStatusImplCopyWith<$Res> {
  __$$AirdropBannerStatusImplCopyWithImpl(_$AirdropBannerStatusImpl _value,
      $Res Function(_$AirdropBannerStatusImpl) _then)
      : super(_value, _then);

  /// Create a copy of AirdropBannerStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = null,
    Object? email = freezed,
  }) {
    return _then(_$AirdropBannerStatusImpl(
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as AirdropState,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AirdropBannerStatusImpl implements _AirdropBannerStatus {
  const _$AirdropBannerStatusImpl({required this.state, this.email});

  @override
  final AirdropState state;
  @override
  final String? email;

  @override
  String toString() {
    return 'AirdropBannerStatus(state: $state, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AirdropBannerStatusImpl &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, state, email);

  /// Create a copy of AirdropBannerStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AirdropBannerStatusImplCopyWith<_$AirdropBannerStatusImpl> get copyWith =>
      __$$AirdropBannerStatusImplCopyWithImpl<_$AirdropBannerStatusImpl>(
          this, _$identity);
}

abstract class _AirdropBannerStatus implements AirdropBannerStatus {
  const factory _AirdropBannerStatus(
      {required final AirdropState state,
      final String? email}) = _$AirdropBannerStatusImpl;

  @override
  AirdropState get state;
  @override
  String? get email;

  /// Create a copy of AirdropBannerStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AirdropBannerStatusImplCopyWith<_$AirdropBannerStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
