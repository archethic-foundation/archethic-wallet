// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'keychain_secured_infos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

KeychainSecuredInfos _$KeychainSecuredInfosFromJson(Map<String, dynamic> json) {
  return _KeychainSecuredInfos.fromJson(json);
}

/// @nodoc
mixin _$KeychainSecuredInfos {
  List<int> get seed => throw _privateConstructorUsedError;
  int get version => throw _privateConstructorUsedError;
  Map<String, KeychainSecuredInfosService> get services =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KeychainSecuredInfosCopyWith<KeychainSecuredInfos> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KeychainSecuredInfosCopyWith<$Res> {
  factory $KeychainSecuredInfosCopyWith(KeychainSecuredInfos value,
          $Res Function(KeychainSecuredInfos) then) =
      _$KeychainSecuredInfosCopyWithImpl<$Res, KeychainSecuredInfos>;
  @useResult
  $Res call(
      {List<int> seed,
      int version,
      Map<String, KeychainSecuredInfosService> services});
}

/// @nodoc
class _$KeychainSecuredInfosCopyWithImpl<$Res,
        $Val extends KeychainSecuredInfos>
    implements $KeychainSecuredInfosCopyWith<$Res> {
  _$KeychainSecuredInfosCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seed = null,
    Object? version = null,
    Object? services = null,
  }) {
    return _then(_value.copyWith(
      seed: null == seed
          ? _value.seed
          : seed // ignore: cast_nullable_to_non_nullable
              as List<int>,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      services: null == services
          ? _value.services
          : services // ignore: cast_nullable_to_non_nullable
              as Map<String, KeychainSecuredInfosService>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KeychainSecuredInfosImplCopyWith<$Res>
    implements $KeychainSecuredInfosCopyWith<$Res> {
  factory _$$KeychainSecuredInfosImplCopyWith(_$KeychainSecuredInfosImpl value,
          $Res Function(_$KeychainSecuredInfosImpl) then) =
      __$$KeychainSecuredInfosImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<int> seed,
      int version,
      Map<String, KeychainSecuredInfosService> services});
}

/// @nodoc
class __$$KeychainSecuredInfosImplCopyWithImpl<$Res>
    extends _$KeychainSecuredInfosCopyWithImpl<$Res, _$KeychainSecuredInfosImpl>
    implements _$$KeychainSecuredInfosImplCopyWith<$Res> {
  __$$KeychainSecuredInfosImplCopyWithImpl(_$KeychainSecuredInfosImpl _value,
      $Res Function(_$KeychainSecuredInfosImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seed = null,
    Object? version = null,
    Object? services = null,
  }) {
    return _then(_$KeychainSecuredInfosImpl(
      seed: null == seed
          ? _value._seed
          : seed // ignore: cast_nullable_to_non_nullable
              as List<int>,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      services: null == services
          ? _value._services
          : services // ignore: cast_nullable_to_non_nullable
              as Map<String, KeychainSecuredInfosService>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KeychainSecuredInfosImpl extends _KeychainSecuredInfos {
  const _$KeychainSecuredInfosImpl(
      {required final List<int> seed,
      required this.version,
      final Map<String, KeychainSecuredInfosService> services = const {}})
      : _seed = seed,
        _services = services,
        super._();

  factory _$KeychainSecuredInfosImpl.fromJson(Map<String, dynamic> json) =>
      _$$KeychainSecuredInfosImplFromJson(json);

  final List<int> _seed;
  @override
  List<int> get seed {
    if (_seed is EqualUnmodifiableListView) return _seed;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_seed);
  }

  @override
  final int version;
  final Map<String, KeychainSecuredInfosService> _services;
  @override
  @JsonKey()
  Map<String, KeychainSecuredInfosService> get services {
    if (_services is EqualUnmodifiableMapView) return _services;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_services);
  }

  @override
  String toString() {
    return 'KeychainSecuredInfos(seed: $seed, version: $version, services: $services)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KeychainSecuredInfosImpl &&
            const DeepCollectionEquality().equals(other._seed, _seed) &&
            (identical(other.version, version) || other.version == version) &&
            const DeepCollectionEquality().equals(other._services, _services));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_seed),
      version,
      const DeepCollectionEquality().hash(_services));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KeychainSecuredInfosImplCopyWith<_$KeychainSecuredInfosImpl>
      get copyWith =>
          __$$KeychainSecuredInfosImplCopyWithImpl<_$KeychainSecuredInfosImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KeychainSecuredInfosImplToJson(
      this,
    );
  }
}

abstract class _KeychainSecuredInfos extends KeychainSecuredInfos {
  const factory _KeychainSecuredInfos(
          {required final List<int> seed,
          required final int version,
          final Map<String, KeychainSecuredInfosService> services}) =
      _$KeychainSecuredInfosImpl;
  const _KeychainSecuredInfos._() : super._();

  factory _KeychainSecuredInfos.fromJson(Map<String, dynamic> json) =
      _$KeychainSecuredInfosImpl.fromJson;

  @override
  List<int> get seed;
  @override
  int get version;
  @override
  Map<String, KeychainSecuredInfosService> get services;
  @override
  @JsonKey(ignore: true)
  _$$KeychainSecuredInfosImplCopyWith<_$KeychainSecuredInfosImpl>
      get copyWith => throw _privateConstructorUsedError;
}
