// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_services_from_keychain.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RPCGetServicesFromKeychainCommandData {}

/// @nodoc
abstract class $RPCGetServicesFromKeychainCommandDataCopyWith<$Res> {
  factory $RPCGetServicesFromKeychainCommandDataCopyWith(
          RPCGetServicesFromKeychainCommandData value,
          $Res Function(RPCGetServicesFromKeychainCommandData) then) =
      _$RPCGetServicesFromKeychainCommandDataCopyWithImpl<$Res,
          RPCGetServicesFromKeychainCommandData>;
}

/// @nodoc
class _$RPCGetServicesFromKeychainCommandDataCopyWithImpl<$Res,
        $Val extends RPCGetServicesFromKeychainCommandData>
    implements $RPCGetServicesFromKeychainCommandDataCopyWith<$Res> {
  _$RPCGetServicesFromKeychainCommandDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_RPCGetAccountsCommandDataCopyWith<$Res> {
  factory _$$_RPCGetAccountsCommandDataCopyWith(
          _$_RPCGetAccountsCommandData value,
          $Res Function(_$_RPCGetAccountsCommandData) then) =
      __$$_RPCGetAccountsCommandDataCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_RPCGetAccountsCommandDataCopyWithImpl<$Res>
    extends _$RPCGetServicesFromKeychainCommandDataCopyWithImpl<$Res,
        _$_RPCGetAccountsCommandData>
    implements _$$_RPCGetAccountsCommandDataCopyWith<$Res> {
  __$$_RPCGetAccountsCommandDataCopyWithImpl(
      _$_RPCGetAccountsCommandData _value,
      $Res Function(_$_RPCGetAccountsCommandData) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_RPCGetAccountsCommandData extends _RPCGetAccountsCommandData {
  const _$_RPCGetAccountsCommandData() : super._();

  @override
  String toString() {
    return 'RPCGetServicesFromKeychainCommandData()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RPCGetAccountsCommandData);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _RPCGetAccountsCommandData
    extends RPCGetServicesFromKeychainCommandData {
  const factory _RPCGetAccountsCommandData() = _$_RPCGetAccountsCommandData;
  const _RPCGetAccountsCommandData._() : super._();
}

/// @nodoc
mixin _$RPCGetServicesFromKeychainResultData {
  List<Service> get services => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RPCGetServicesFromKeychainResultDataCopyWith<
          RPCGetServicesFromKeychainResultData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RPCGetServicesFromKeychainResultDataCopyWith<$Res> {
  factory $RPCGetServicesFromKeychainResultDataCopyWith(
          RPCGetServicesFromKeychainResultData value,
          $Res Function(RPCGetServicesFromKeychainResultData) then) =
      _$RPCGetServicesFromKeychainResultDataCopyWithImpl<$Res,
          RPCGetServicesFromKeychainResultData>;
  @useResult
  $Res call({List<Service> services});
}

/// @nodoc
class _$RPCGetServicesFromKeychainResultDataCopyWithImpl<$Res,
        $Val extends RPCGetServicesFromKeychainResultData>
    implements $RPCGetServicesFromKeychainResultDataCopyWith<$Res> {
  _$RPCGetServicesFromKeychainResultDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? services = null,
  }) {
    return _then(_value.copyWith(
      services: null == services
          ? _value.services
          : services // ignore: cast_nullable_to_non_nullable
              as List<Service>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RPCGetServicesFromKeychainResultDataCopyWith<$Res>
    implements $RPCGetServicesFromKeychainResultDataCopyWith<$Res> {
  factory _$$_RPCGetServicesFromKeychainResultDataCopyWith(
          _$_RPCGetServicesFromKeychainResultData value,
          $Res Function(_$_RPCGetServicesFromKeychainResultData) then) =
      __$$_RPCGetServicesFromKeychainResultDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Service> services});
}

/// @nodoc
class __$$_RPCGetServicesFromKeychainResultDataCopyWithImpl<$Res>
    extends _$RPCGetServicesFromKeychainResultDataCopyWithImpl<$Res,
        _$_RPCGetServicesFromKeychainResultData>
    implements _$$_RPCGetServicesFromKeychainResultDataCopyWith<$Res> {
  __$$_RPCGetServicesFromKeychainResultDataCopyWithImpl(
      _$_RPCGetServicesFromKeychainResultData _value,
      $Res Function(_$_RPCGetServicesFromKeychainResultData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? services = null,
  }) {
    return _then(_$_RPCGetServicesFromKeychainResultData(
      services: null == services
          ? _value._services
          : services // ignore: cast_nullable_to_non_nullable
              as List<Service>,
    ));
  }
}

/// @nodoc

class _$_RPCGetServicesFromKeychainResultData
    extends _RPCGetServicesFromKeychainResultData {
  const _$_RPCGetServicesFromKeychainResultData(
      {required final List<Service> services})
      : _services = services,
        super._();

  final List<Service> _services;
  @override
  List<Service> get services {
    if (_services is EqualUnmodifiableListView) return _services;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_services);
  }

  @override
  String toString() {
    return 'RPCGetServicesFromKeychainResultData(services: $services)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RPCGetServicesFromKeychainResultData &&
            const DeepCollectionEquality().equals(other._services, _services));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_services));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RPCGetServicesFromKeychainResultDataCopyWith<
          _$_RPCGetServicesFromKeychainResultData>
      get copyWith => __$$_RPCGetServicesFromKeychainResultDataCopyWithImpl<
          _$_RPCGetServicesFromKeychainResultData>(this, _$identity);
}

abstract class _RPCGetServicesFromKeychainResultData
    extends RPCGetServicesFromKeychainResultData {
  const factory _RPCGetServicesFromKeychainResultData(
          {required final List<Service> services}) =
      _$_RPCGetServicesFromKeychainResultData;
  const _RPCGetServicesFromKeychainResultData._() : super._();

  @override
  List<Service> get services;
  @override
  @JsonKey(ignore: true)
  _$$_RPCGetServicesFromKeychainResultDataCopyWith<
          _$_RPCGetServicesFromKeychainResultData>
      get copyWith => throw _privateConstructorUsedError;
}
