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
abstract class _$$RPCGetAccountsCommandDataImplCopyWith<$Res> {
  factory _$$RPCGetAccountsCommandDataImplCopyWith(
          _$RPCGetAccountsCommandDataImpl value,
          $Res Function(_$RPCGetAccountsCommandDataImpl) then) =
      __$$RPCGetAccountsCommandDataImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RPCGetAccountsCommandDataImplCopyWithImpl<$Res>
    extends _$RPCGetServicesFromKeychainCommandDataCopyWithImpl<$Res,
        _$RPCGetAccountsCommandDataImpl>
    implements _$$RPCGetAccountsCommandDataImplCopyWith<$Res> {
  __$$RPCGetAccountsCommandDataImplCopyWithImpl(
      _$RPCGetAccountsCommandDataImpl _value,
      $Res Function(_$RPCGetAccountsCommandDataImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$RPCGetAccountsCommandDataImpl extends _RPCGetAccountsCommandData {
  const _$RPCGetAccountsCommandDataImpl() : super._();

  @override
  String toString() {
    return 'RPCGetServicesFromKeychainCommandData()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RPCGetAccountsCommandDataImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _RPCGetAccountsCommandData
    extends RPCGetServicesFromKeychainCommandData {
  const factory _RPCGetAccountsCommandData() = _$RPCGetAccountsCommandDataImpl;
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
abstract class _$$RPCGetServicesFromKeychainResultDataImplCopyWith<$Res>
    implements $RPCGetServicesFromKeychainResultDataCopyWith<$Res> {
  factory _$$RPCGetServicesFromKeychainResultDataImplCopyWith(
          _$RPCGetServicesFromKeychainResultDataImpl value,
          $Res Function(_$RPCGetServicesFromKeychainResultDataImpl) then) =
      __$$RPCGetServicesFromKeychainResultDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Service> services});
}

/// @nodoc
class __$$RPCGetServicesFromKeychainResultDataImplCopyWithImpl<$Res>
    extends _$RPCGetServicesFromKeychainResultDataCopyWithImpl<$Res,
        _$RPCGetServicesFromKeychainResultDataImpl>
    implements _$$RPCGetServicesFromKeychainResultDataImplCopyWith<$Res> {
  __$$RPCGetServicesFromKeychainResultDataImplCopyWithImpl(
      _$RPCGetServicesFromKeychainResultDataImpl _value,
      $Res Function(_$RPCGetServicesFromKeychainResultDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? services = null,
  }) {
    return _then(_$RPCGetServicesFromKeychainResultDataImpl(
      services: null == services
          ? _value._services
          : services // ignore: cast_nullable_to_non_nullable
              as List<Service>,
    ));
  }
}

/// @nodoc

class _$RPCGetServicesFromKeychainResultDataImpl
    extends _RPCGetServicesFromKeychainResultData {
  const _$RPCGetServicesFromKeychainResultDataImpl(
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
            other is _$RPCGetServicesFromKeychainResultDataImpl &&
            const DeepCollectionEquality().equals(other._services, _services));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_services));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RPCGetServicesFromKeychainResultDataImplCopyWith<
          _$RPCGetServicesFromKeychainResultDataImpl>
      get copyWith => __$$RPCGetServicesFromKeychainResultDataImplCopyWithImpl<
          _$RPCGetServicesFromKeychainResultDataImpl>(this, _$identity);
}

abstract class _RPCGetServicesFromKeychainResultData
    extends RPCGetServicesFromKeychainResultData {
  const factory _RPCGetServicesFromKeychainResultData(
          {required final List<Service> services}) =
      _$RPCGetServicesFromKeychainResultDataImpl;
  const _RPCGetServicesFromKeychainResultData._() : super._();

  @override
  List<Service> get services;
  @override
  @JsonKey(ignore: true)
  _$$RPCGetServicesFromKeychainResultDataImplCopyWith<
          _$RPCGetServicesFromKeychainResultDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
