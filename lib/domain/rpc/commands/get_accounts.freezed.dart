// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_accounts.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RPCGetAccountsCommandData {}

/// @nodoc
abstract class $RPCGetAccountsCommandDataCopyWith<$Res> {
  factory $RPCGetAccountsCommandDataCopyWith(RPCGetAccountsCommandData value,
          $Res Function(RPCGetAccountsCommandData) then) =
      _$RPCGetAccountsCommandDataCopyWithImpl<$Res, RPCGetAccountsCommandData>;
}

/// @nodoc
class _$RPCGetAccountsCommandDataCopyWithImpl<$Res,
        $Val extends RPCGetAccountsCommandData>
    implements $RPCGetAccountsCommandDataCopyWith<$Res> {
  _$RPCGetAccountsCommandDataCopyWithImpl(this._value, this._then);

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
    extends _$RPCGetAccountsCommandDataCopyWithImpl<$Res,
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
    return 'RPCGetAccountsCommandData()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RPCGetAccountsCommandDataImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _RPCGetAccountsCommandData extends RPCGetAccountsCommandData {
  const factory _RPCGetAccountsCommandData() = _$RPCGetAccountsCommandDataImpl;
  const _RPCGetAccountsCommandData._() : super._();
}

/// @nodoc
mixin _$RPCGetAccountsResultData {
  List<AppAccount> get accounts => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RPCGetAccountsResultDataCopyWith<RPCGetAccountsResultData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RPCGetAccountsResultDataCopyWith<$Res> {
  factory $RPCGetAccountsResultDataCopyWith(RPCGetAccountsResultData value,
          $Res Function(RPCGetAccountsResultData) then) =
      _$RPCGetAccountsResultDataCopyWithImpl<$Res, RPCGetAccountsResultData>;
  @useResult
  $Res call({List<AppAccount> accounts});
}

/// @nodoc
class _$RPCGetAccountsResultDataCopyWithImpl<$Res,
        $Val extends RPCGetAccountsResultData>
    implements $RPCGetAccountsResultDataCopyWith<$Res> {
  _$RPCGetAccountsResultDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accounts = null,
  }) {
    return _then(_value.copyWith(
      accounts: null == accounts
          ? _value.accounts
          : accounts // ignore: cast_nullable_to_non_nullable
              as List<AppAccount>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RPCGetAccountsResultDataImplCopyWith<$Res>
    implements $RPCGetAccountsResultDataCopyWith<$Res> {
  factory _$$RPCGetAccountsResultDataImplCopyWith(
          _$RPCGetAccountsResultDataImpl value,
          $Res Function(_$RPCGetAccountsResultDataImpl) then) =
      __$$RPCGetAccountsResultDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<AppAccount> accounts});
}

/// @nodoc
class __$$RPCGetAccountsResultDataImplCopyWithImpl<$Res>
    extends _$RPCGetAccountsResultDataCopyWithImpl<$Res,
        _$RPCGetAccountsResultDataImpl>
    implements _$$RPCGetAccountsResultDataImplCopyWith<$Res> {
  __$$RPCGetAccountsResultDataImplCopyWithImpl(
      _$RPCGetAccountsResultDataImpl _value,
      $Res Function(_$RPCGetAccountsResultDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accounts = null,
  }) {
    return _then(_$RPCGetAccountsResultDataImpl(
      accounts: null == accounts
          ? _value._accounts
          : accounts // ignore: cast_nullable_to_non_nullable
              as List<AppAccount>,
    ));
  }
}

/// @nodoc

class _$RPCGetAccountsResultDataImpl extends _RPCGetAccountsResultData {
  const _$RPCGetAccountsResultDataImpl(
      {required final List<AppAccount> accounts})
      : _accounts = accounts,
        super._();

  final List<AppAccount> _accounts;
  @override
  List<AppAccount> get accounts {
    if (_accounts is EqualUnmodifiableListView) return _accounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_accounts);
  }

  @override
  String toString() {
    return 'RPCGetAccountsResultData(accounts: $accounts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RPCGetAccountsResultDataImpl &&
            const DeepCollectionEquality().equals(other._accounts, _accounts));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_accounts));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RPCGetAccountsResultDataImplCopyWith<_$RPCGetAccountsResultDataImpl>
      get copyWith => __$$RPCGetAccountsResultDataImplCopyWithImpl<
          _$RPCGetAccountsResultDataImpl>(this, _$identity);
}

abstract class _RPCGetAccountsResultData extends RPCGetAccountsResultData {
  const factory _RPCGetAccountsResultData(
          {required final List<AppAccount> accounts}) =
      _$RPCGetAccountsResultDataImpl;
  const _RPCGetAccountsResultData._() : super._();

  @override
  List<AppAccount> get accounts;
  @override
  @JsonKey(ignore: true)
  _$$RPCGetAccountsResultDataImplCopyWith<_$RPCGetAccountsResultDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
