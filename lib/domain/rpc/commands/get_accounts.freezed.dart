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
abstract class _$$_RPCGetAccountsCommandDataCopyWith<$Res> {
  factory _$$_RPCGetAccountsCommandDataCopyWith(
          _$_RPCGetAccountsCommandData value,
          $Res Function(_$_RPCGetAccountsCommandData) then) =
      __$$_RPCGetAccountsCommandDataCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_RPCGetAccountsCommandDataCopyWithImpl<$Res>
    extends _$RPCGetAccountsCommandDataCopyWithImpl<$Res,
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
    return 'RPCGetAccountsCommandData()';
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

abstract class _RPCGetAccountsCommandData extends RPCGetAccountsCommandData {
  const factory _RPCGetAccountsCommandData() = _$_RPCGetAccountsCommandData;
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
abstract class _$$_RPCGetAccountsResultDataCopyWith<$Res>
    implements $RPCGetAccountsResultDataCopyWith<$Res> {
  factory _$$_RPCGetAccountsResultDataCopyWith(
          _$_RPCGetAccountsResultData value,
          $Res Function(_$_RPCGetAccountsResultData) then) =
      __$$_RPCGetAccountsResultDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<AppAccount> accounts});
}

/// @nodoc
class __$$_RPCGetAccountsResultDataCopyWithImpl<$Res>
    extends _$RPCGetAccountsResultDataCopyWithImpl<$Res,
        _$_RPCGetAccountsResultData>
    implements _$$_RPCGetAccountsResultDataCopyWith<$Res> {
  __$$_RPCGetAccountsResultDataCopyWithImpl(_$_RPCGetAccountsResultData _value,
      $Res Function(_$_RPCGetAccountsResultData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accounts = null,
  }) {
    return _then(_$_RPCGetAccountsResultData(
      accounts: null == accounts
          ? _value._accounts
          : accounts // ignore: cast_nullable_to_non_nullable
              as List<AppAccount>,
    ));
  }
}

/// @nodoc

class _$_RPCGetAccountsResultData extends _RPCGetAccountsResultData {
  const _$_RPCGetAccountsResultData({required final List<AppAccount> accounts})
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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RPCGetAccountsResultData &&
            const DeepCollectionEquality().equals(other._accounts, _accounts));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_accounts));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RPCGetAccountsResultDataCopyWith<_$_RPCGetAccountsResultData>
      get copyWith => __$$_RPCGetAccountsResultDataCopyWithImpl<
          _$_RPCGetAccountsResultData>(this, _$identity);
}

abstract class _RPCGetAccountsResultData extends RPCGetAccountsResultData {
  const factory _RPCGetAccountsResultData(
      {required final List<AppAccount> accounts}) = _$_RPCGetAccountsResultData;
  const _RPCGetAccountsResultData._() : super._();

  @override
  List<AppAccount> get accounts;
  @override
  @JsonKey(ignore: true)
  _$$_RPCGetAccountsResultDataCopyWith<_$_RPCGetAccountsResultData>
      get copyWith => throw _privateConstructorUsedError;
}
