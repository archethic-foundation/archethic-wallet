// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_current_account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RPCGetCurrentAccountCommandData {}

/// @nodoc
abstract class $RPCGetCurrentAccountCommandDataCopyWith<$Res> {
  factory $RPCGetCurrentAccountCommandDataCopyWith(
          RPCGetCurrentAccountCommandData value,
          $Res Function(RPCGetCurrentAccountCommandData) then) =
      _$RPCGetCurrentAccountCommandDataCopyWithImpl<$Res,
          RPCGetCurrentAccountCommandData>;
}

/// @nodoc
class _$RPCGetCurrentAccountCommandDataCopyWithImpl<$Res,
        $Val extends RPCGetCurrentAccountCommandData>
    implements $RPCGetCurrentAccountCommandDataCopyWith<$Res> {
  _$RPCGetCurrentAccountCommandDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_RPCGetCurrentAccountCommandDataCopyWith<$Res> {
  factory _$$_RPCGetCurrentAccountCommandDataCopyWith(
          _$_RPCGetCurrentAccountCommandData value,
          $Res Function(_$_RPCGetCurrentAccountCommandData) then) =
      __$$_RPCGetCurrentAccountCommandDataCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_RPCGetCurrentAccountCommandDataCopyWithImpl<$Res>
    extends _$RPCGetCurrentAccountCommandDataCopyWithImpl<$Res,
        _$_RPCGetCurrentAccountCommandData>
    implements _$$_RPCGetCurrentAccountCommandDataCopyWith<$Res> {
  __$$_RPCGetCurrentAccountCommandDataCopyWithImpl(
      _$_RPCGetCurrentAccountCommandData _value,
      $Res Function(_$_RPCGetCurrentAccountCommandData) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_RPCGetCurrentAccountCommandData
    extends _RPCGetCurrentAccountCommandData {
  const _$_RPCGetCurrentAccountCommandData() : super._();

  @override
  String toString() {
    return 'RPCGetCurrentAccountCommandData()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RPCGetCurrentAccountCommandData);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _RPCGetCurrentAccountCommandData
    extends RPCGetCurrentAccountCommandData {
  const factory _RPCGetCurrentAccountCommandData() =
      _$_RPCGetCurrentAccountCommandData;
  const _RPCGetCurrentAccountCommandData._() : super._();
}

/// @nodoc
mixin _$RPCGetCurrentAccountResultData {
  AppAccount get account => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RPCGetCurrentAccountResultDataCopyWith<RPCGetCurrentAccountResultData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RPCGetCurrentAccountResultDataCopyWith<$Res> {
  factory $RPCGetCurrentAccountResultDataCopyWith(
          RPCGetCurrentAccountResultData value,
          $Res Function(RPCGetCurrentAccountResultData) then) =
      _$RPCGetCurrentAccountResultDataCopyWithImpl<$Res,
          RPCGetCurrentAccountResultData>;
  @useResult
  $Res call({AppAccount account});

  $AppAccountCopyWith<$Res> get account;
}

/// @nodoc
class _$RPCGetCurrentAccountResultDataCopyWithImpl<$Res,
        $Val extends RPCGetCurrentAccountResultData>
    implements $RPCGetCurrentAccountResultDataCopyWith<$Res> {
  _$RPCGetCurrentAccountResultDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? account = null,
  }) {
    return _then(_value.copyWith(
      account: null == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as AppAccount,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AppAccountCopyWith<$Res> get account {
    return $AppAccountCopyWith<$Res>(_value.account, (value) {
      return _then(_value.copyWith(account: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_RPCGetCurrentAccountResultDataCopyWith<$Res>
    implements $RPCGetCurrentAccountResultDataCopyWith<$Res> {
  factory _$$_RPCGetCurrentAccountResultDataCopyWith(
          _$_RPCGetCurrentAccountResultData value,
          $Res Function(_$_RPCGetCurrentAccountResultData) then) =
      __$$_RPCGetCurrentAccountResultDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AppAccount account});

  @override
  $AppAccountCopyWith<$Res> get account;
}

/// @nodoc
class __$$_RPCGetCurrentAccountResultDataCopyWithImpl<$Res>
    extends _$RPCGetCurrentAccountResultDataCopyWithImpl<$Res,
        _$_RPCGetCurrentAccountResultData>
    implements _$$_RPCGetCurrentAccountResultDataCopyWith<$Res> {
  __$$_RPCGetCurrentAccountResultDataCopyWithImpl(
      _$_RPCGetCurrentAccountResultData _value,
      $Res Function(_$_RPCGetCurrentAccountResultData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? account = null,
  }) {
    return _then(_$_RPCGetCurrentAccountResultData(
      account: null == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as AppAccount,
    ));
  }
}

/// @nodoc

class _$_RPCGetCurrentAccountResultData
    extends _RPCGetCurrentAccountResultData {
  const _$_RPCGetCurrentAccountResultData({required this.account}) : super._();

  @override
  final AppAccount account;

  @override
  String toString() {
    return 'RPCGetCurrentAccountResultData(account: $account)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RPCGetCurrentAccountResultData &&
            (identical(other.account, account) || other.account == account));
  }

  @override
  int get hashCode => Object.hash(runtimeType, account);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RPCGetCurrentAccountResultDataCopyWith<_$_RPCGetCurrentAccountResultData>
      get copyWith => __$$_RPCGetCurrentAccountResultDataCopyWithImpl<
          _$_RPCGetCurrentAccountResultData>(this, _$identity);
}

abstract class _RPCGetCurrentAccountResultData
    extends RPCGetCurrentAccountResultData {
  const factory _RPCGetCurrentAccountResultData(
      {required final AppAccount account}) = _$_RPCGetCurrentAccountResultData;
  const _RPCGetCurrentAccountResultData._() : super._();

  @override
  AppAccount get account;
  @override
  @JsonKey(ignore: true)
  _$$_RPCGetCurrentAccountResultDataCopyWith<_$_RPCGetCurrentAccountResultData>
      get copyWith => throw _privateConstructorUsedError;
}
