// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_accounts.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AppAccount {
  String get shortName => throw _privateConstructorUsedError;
  String get serviceName => throw _privateConstructorUsedError;
  String get genesisAddress => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppAccountCopyWith<AppAccount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppAccountCopyWith<$Res> {
  factory $AppAccountCopyWith(
          AppAccount value, $Res Function(AppAccount) then) =
      _$AppAccountCopyWithImpl<$Res, AppAccount>;
  @useResult
  $Res call({String shortName, String serviceName, String genesisAddress});
}

/// @nodoc
class _$AppAccountCopyWithImpl<$Res, $Val extends AppAccount>
    implements $AppAccountCopyWith<$Res> {
  _$AppAccountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shortName = null,
    Object? serviceName = null,
    Object? genesisAddress = null,
  }) {
    return _then(_value.copyWith(
      shortName: null == shortName
          ? _value.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: null == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      genesisAddress: null == genesisAddress
          ? _value.genesisAddress
          : genesisAddress // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppAccountImplCopyWith<$Res>
    implements $AppAccountCopyWith<$Res> {
  factory _$$AppAccountImplCopyWith(
          _$AppAccountImpl value, $Res Function(_$AppAccountImpl) then) =
      __$$AppAccountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String shortName, String serviceName, String genesisAddress});
}

/// @nodoc
class __$$AppAccountImplCopyWithImpl<$Res>
    extends _$AppAccountCopyWithImpl<$Res, _$AppAccountImpl>
    implements _$$AppAccountImplCopyWith<$Res> {
  __$$AppAccountImplCopyWithImpl(
      _$AppAccountImpl _value, $Res Function(_$AppAccountImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shortName = null,
    Object? serviceName = null,
    Object? genesisAddress = null,
  }) {
    return _then(_$AppAccountImpl(
      shortName: null == shortName
          ? _value.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: null == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      genesisAddress: null == genesisAddress
          ? _value.genesisAddress
          : genesisAddress // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AppAccountImpl extends _AppAccount {
  const _$AppAccountImpl(
      {required this.shortName,
      required this.serviceName,
      required this.genesisAddress})
      : super._();

  @override
  final String shortName;
  @override
  final String serviceName;
  @override
  final String genesisAddress;

  @override
  String toString() {
    return 'AppAccount(shortName: $shortName, serviceName: $serviceName, genesisAddress: $genesisAddress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppAccountImpl &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName) &&
            (identical(other.serviceName, serviceName) ||
                other.serviceName == serviceName) &&
            (identical(other.genesisAddress, genesisAddress) ||
                other.genesisAddress == genesisAddress));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, shortName, serviceName, genesisAddress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppAccountImplCopyWith<_$AppAccountImpl> get copyWith =>
      __$$AppAccountImplCopyWithImpl<_$AppAccountImpl>(this, _$identity);
}

abstract class _AppAccount extends AppAccount {
  const factory _AppAccount(
      {required final String shortName,
      required final String serviceName,
      required final String genesisAddress}) = _$AppAccountImpl;
  const _AppAccount._() : super._();

  @override
  String get shortName;
  @override
  String get serviceName;
  @override
  String get genesisAddress;
  @override
  @JsonKey(ignore: true)
  _$$AppAccountImplCopyWith<_$AppAccountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
