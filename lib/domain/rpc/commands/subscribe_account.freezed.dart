// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscribe_account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RPCSubscribeAccountCommandData {
  String get accountName => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RPCSubscribeAccountCommandDataCopyWith<RPCSubscribeAccountCommandData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RPCSubscribeAccountCommandDataCopyWith<$Res> {
  factory $RPCSubscribeAccountCommandDataCopyWith(
          RPCSubscribeAccountCommandData value,
          $Res Function(RPCSubscribeAccountCommandData) then) =
      _$RPCSubscribeAccountCommandDataCopyWithImpl<$Res,
          RPCSubscribeAccountCommandData>;
  @useResult
  $Res call({String accountName});
}

/// @nodoc
class _$RPCSubscribeAccountCommandDataCopyWithImpl<$Res,
        $Val extends RPCSubscribeAccountCommandData>
    implements $RPCSubscribeAccountCommandDataCopyWith<$Res> {
  _$RPCSubscribeAccountCommandDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountName = null,
  }) {
    return _then(_value.copyWith(
      accountName: null == accountName
          ? _value.accountName
          : accountName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RPCSubscribeAccountCommandDataImplCopyWith<$Res>
    implements $RPCSubscribeAccountCommandDataCopyWith<$Res> {
  factory _$$RPCSubscribeAccountCommandDataImplCopyWith(
          _$RPCSubscribeAccountCommandDataImpl value,
          $Res Function(_$RPCSubscribeAccountCommandDataImpl) then) =
      __$$RPCSubscribeAccountCommandDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String accountName});
}

/// @nodoc
class __$$RPCSubscribeAccountCommandDataImplCopyWithImpl<$Res>
    extends _$RPCSubscribeAccountCommandDataCopyWithImpl<$Res,
        _$RPCSubscribeAccountCommandDataImpl>
    implements _$$RPCSubscribeAccountCommandDataImplCopyWith<$Res> {
  __$$RPCSubscribeAccountCommandDataImplCopyWithImpl(
      _$RPCSubscribeAccountCommandDataImpl _value,
      $Res Function(_$RPCSubscribeAccountCommandDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountName = null,
  }) {
    return _then(_$RPCSubscribeAccountCommandDataImpl(
      accountName: null == accountName
          ? _value.accountName
          : accountName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RPCSubscribeAccountCommandDataImpl
    extends _RPCSubscribeAccountCommandData {
  const _$RPCSubscribeAccountCommandDataImpl({required this.accountName})
      : super._();

  @override
  final String accountName;

  @override
  String toString() {
    return 'RPCSubscribeAccountCommandData(accountName: $accountName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RPCSubscribeAccountCommandDataImpl &&
            (identical(other.accountName, accountName) ||
                other.accountName == accountName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, accountName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RPCSubscribeAccountCommandDataImplCopyWith<
          _$RPCSubscribeAccountCommandDataImpl>
      get copyWith => __$$RPCSubscribeAccountCommandDataImplCopyWithImpl<
          _$RPCSubscribeAccountCommandDataImpl>(this, _$identity);
}

abstract class _RPCSubscribeAccountCommandData
    extends RPCSubscribeAccountCommandData {
  const factory _RPCSubscribeAccountCommandData(
          {required final String accountName}) =
      _$RPCSubscribeAccountCommandDataImpl;
  const _RPCSubscribeAccountCommandData._() : super._();

  @override
  String get accountName;
  @override
  @JsonKey(ignore: true)
  _$$RPCSubscribeAccountCommandDataImplCopyWith<
          _$RPCSubscribeAccountCommandDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
