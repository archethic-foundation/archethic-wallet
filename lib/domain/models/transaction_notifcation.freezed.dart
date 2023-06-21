// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_notifcation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TransactionNotification {
  String get txAddress => throw _privateConstructorUsedError;
  String get txChainGenesisAddress => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TransactionNotificationCopyWith<TransactionNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionNotificationCopyWith<$Res> {
  factory $TransactionNotificationCopyWith(TransactionNotification value,
          $Res Function(TransactionNotification) then) =
      _$TransactionNotificationCopyWithImpl<$Res, TransactionNotification>;
  @useResult
  $Res call({String txAddress, String txChainGenesisAddress});
}

/// @nodoc
class _$TransactionNotificationCopyWithImpl<$Res,
        $Val extends TransactionNotification>
    implements $TransactionNotificationCopyWith<$Res> {
  _$TransactionNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? txAddress = null,
    Object? txChainGenesisAddress = null,
  }) {
    return _then(_value.copyWith(
      txAddress: null == txAddress
          ? _value.txAddress
          : txAddress // ignore: cast_nullable_to_non_nullable
              as String,
      txChainGenesisAddress: null == txChainGenesisAddress
          ? _value.txChainGenesisAddress
          : txChainGenesisAddress // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TransactionNotificationCopyWith<$Res>
    implements $TransactionNotificationCopyWith<$Res> {
  factory _$$_TransactionNotificationCopyWith(_$_TransactionNotification value,
          $Res Function(_$_TransactionNotification) then) =
      __$$_TransactionNotificationCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String txAddress, String txChainGenesisAddress});
}

/// @nodoc
class __$$_TransactionNotificationCopyWithImpl<$Res>
    extends _$TransactionNotificationCopyWithImpl<$Res,
        _$_TransactionNotification>
    implements _$$_TransactionNotificationCopyWith<$Res> {
  __$$_TransactionNotificationCopyWithImpl(_$_TransactionNotification _value,
      $Res Function(_$_TransactionNotification) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? txAddress = null,
    Object? txChainGenesisAddress = null,
  }) {
    return _then(_$_TransactionNotification(
      txAddress: null == txAddress
          ? _value.txAddress
          : txAddress // ignore: cast_nullable_to_non_nullable
              as String,
      txChainGenesisAddress: null == txChainGenesisAddress
          ? _value.txChainGenesisAddress
          : txChainGenesisAddress // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_TransactionNotification extends _TransactionNotification {
  const _$_TransactionNotification(
      {required this.txAddress, required this.txChainGenesisAddress})
      : super._();

  @override
  final String txAddress;
  @override
  final String txChainGenesisAddress;

  @override
  String toString() {
    return 'TransactionNotification(txAddress: $txAddress, txChainGenesisAddress: $txChainGenesisAddress)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransactionNotification &&
            (identical(other.txAddress, txAddress) ||
                other.txAddress == txAddress) &&
            (identical(other.txChainGenesisAddress, txChainGenesisAddress) ||
                other.txChainGenesisAddress == txChainGenesisAddress));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, txAddress, txChainGenesisAddress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransactionNotificationCopyWith<_$_TransactionNotification>
      get copyWith =>
          __$$_TransactionNotificationCopyWithImpl<_$_TransactionNotification>(
              this, _$identity);
}

abstract class _TransactionNotification extends TransactionNotification {
  const factory _TransactionNotification(
          {required final String txAddress,
          required final String txChainGenesisAddress}) =
      _$_TransactionNotification;
  const _TransactionNotification._() : super._();

  @override
  String get txAddress;
  @override
  String get txChainGenesisAddress;
  @override
  @JsonKey(ignore: true)
  _$$_TransactionNotificationCopyWith<_$_TransactionNotification>
      get copyWith => throw _privateConstructorUsedError;
}
