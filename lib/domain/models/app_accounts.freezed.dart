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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppAccount {
  String get name => throw _privateConstructorUsedError;
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
  $Res call({String name, String genesisAddress});
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
    Object? name = null,
    Object? genesisAddress = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      genesisAddress: null == genesisAddress
          ? _value.genesisAddress
          : genesisAddress // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AppAccountCopyWith<$Res>
    implements $AppAccountCopyWith<$Res> {
  factory _$$_AppAccountCopyWith(
          _$_AppAccount value, $Res Function(_$_AppAccount) then) =
      __$$_AppAccountCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String genesisAddress});
}

/// @nodoc
class __$$_AppAccountCopyWithImpl<$Res>
    extends _$AppAccountCopyWithImpl<$Res, _$_AppAccount>
    implements _$$_AppAccountCopyWith<$Res> {
  __$$_AppAccountCopyWithImpl(
      _$_AppAccount _value, $Res Function(_$_AppAccount) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? genesisAddress = null,
  }) {
    return _then(_$_AppAccount(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      genesisAddress: null == genesisAddress
          ? _value.genesisAddress
          : genesisAddress // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_AppAccount extends _AppAccount {
  const _$_AppAccount({required this.name, required this.genesisAddress})
      : super._();

  @override
  final String name;
  @override
  final String genesisAddress;

  @override
  String toString() {
    return 'AppAccount(name: $name, genesisAddress: $genesisAddress)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppAccount &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.genesisAddress, genesisAddress) ||
                other.genesisAddress == genesisAddress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, genesisAddress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppAccountCopyWith<_$_AppAccount> get copyWith =>
      __$$_AppAccountCopyWithImpl<_$_AppAccount>(this, _$identity);
}

abstract class _AppAccount extends AppAccount {
  const factory _AppAccount(
      {required final String name,
      required final String genesisAddress}) = _$_AppAccount;
  const _AppAccount._() : super._();

  @override
  String get name;
  @override
  String get genesisAddress;
  @override
  @JsonKey(ignore: true)
  _$$_AppAccountCopyWith<_$_AppAccount> get copyWith =>
      throw _privateConstructorUsedError;
}
