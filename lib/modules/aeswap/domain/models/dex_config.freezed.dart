// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dex_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DexConfig _$DexConfigFromJson(Map<String, dynamic> json) {
  return _DexConfig.fromJson(json);
}

/// @nodoc
mixin _$DexConfig {
  String get name => throw _privateConstructorUsedError;
  String get routerGenesisAddress => throw _privateConstructorUsedError;
  String get factoryGenesisAddress => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DexConfigCopyWith<DexConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DexConfigCopyWith<$Res> {
  factory $DexConfigCopyWith(DexConfig value, $Res Function(DexConfig) then) =
      _$DexConfigCopyWithImpl<$Res, DexConfig>;
  @useResult
  $Res call(
      {String name, String routerGenesisAddress, String factoryGenesisAddress});
}

/// @nodoc
class _$DexConfigCopyWithImpl<$Res, $Val extends DexConfig>
    implements $DexConfigCopyWith<$Res> {
  _$DexConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? routerGenesisAddress = null,
    Object? factoryGenesisAddress = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      routerGenesisAddress: null == routerGenesisAddress
          ? _value.routerGenesisAddress
          : routerGenesisAddress // ignore: cast_nullable_to_non_nullable
              as String,
      factoryGenesisAddress: null == factoryGenesisAddress
          ? _value.factoryGenesisAddress
          : factoryGenesisAddress // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DexConfigImplCopyWith<$Res>
    implements $DexConfigCopyWith<$Res> {
  factory _$$DexConfigImplCopyWith(
          _$DexConfigImpl value, $Res Function(_$DexConfigImpl) then) =
      __$$DexConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name, String routerGenesisAddress, String factoryGenesisAddress});
}

/// @nodoc
class __$$DexConfigImplCopyWithImpl<$Res>
    extends _$DexConfigCopyWithImpl<$Res, _$DexConfigImpl>
    implements _$$DexConfigImplCopyWith<$Res> {
  __$$DexConfigImplCopyWithImpl(
      _$DexConfigImpl _value, $Res Function(_$DexConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? routerGenesisAddress = null,
    Object? factoryGenesisAddress = null,
  }) {
    return _then(_$DexConfigImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      routerGenesisAddress: null == routerGenesisAddress
          ? _value.routerGenesisAddress
          : routerGenesisAddress // ignore: cast_nullable_to_non_nullable
              as String,
      factoryGenesisAddress: null == factoryGenesisAddress
          ? _value.factoryGenesisAddress
          : factoryGenesisAddress // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DexConfigImpl extends _DexConfig {
  const _$DexConfigImpl(
      {this.name = '',
      this.routerGenesisAddress = '',
      this.factoryGenesisAddress = ''})
      : super._();

  factory _$DexConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$DexConfigImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String routerGenesisAddress;
  @override
  @JsonKey()
  final String factoryGenesisAddress;

  @override
  String toString() {
    return 'DexConfig(name: $name, routerGenesisAddress: $routerGenesisAddress, factoryGenesisAddress: $factoryGenesisAddress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DexConfigImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.routerGenesisAddress, routerGenesisAddress) ||
                other.routerGenesisAddress == routerGenesisAddress) &&
            (identical(other.factoryGenesisAddress, factoryGenesisAddress) ||
                other.factoryGenesisAddress == factoryGenesisAddress));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, routerGenesisAddress, factoryGenesisAddress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DexConfigImplCopyWith<_$DexConfigImpl> get copyWith =>
      __$$DexConfigImplCopyWithImpl<_$DexConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DexConfigImplToJson(
      this,
    );
  }
}

abstract class _DexConfig extends DexConfig {
  const factory _DexConfig(
      {final String name,
      final String routerGenesisAddress,
      final String factoryGenesisAddress}) = _$DexConfigImpl;
  const _DexConfig._() : super._();

  factory _DexConfig.fromJson(Map<String, dynamic> json) =
      _$DexConfigImpl.fromJson;

  @override
  String get name;
  @override
  String get routerGenesisAddress;
  @override
  String get factoryGenesisAddress;
  @override
  @JsonKey(ignore: true)
  _$$DexConfigImplCopyWith<_$DexConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
