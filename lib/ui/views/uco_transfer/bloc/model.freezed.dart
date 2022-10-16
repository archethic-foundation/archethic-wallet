// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Transfer {
  double get feeEstimation => throw _privateConstructorUsedError;
  bool get canTransfer => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get addressRecipient => throw _privateConstructorUsedError;
  Contact? get contactRecipient => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  bool get isMaxSend => throw _privateConstructorUsedError;
  bool get isContact => throw _privateConstructorUsedError;
  Transaction? get transaction => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TransferCopyWith<Transfer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferCopyWith<$Res> {
  factory $TransferCopyWith(Transfer value, $Res Function(Transfer) then) =
      _$TransferCopyWithImpl<$Res>;
  $Res call(
      {double feeEstimation,
      bool canTransfer,
      double amount,
      String addressRecipient,
      Contact? contactRecipient,
      String message,
      bool isMaxSend,
      bool isContact,
      Transaction? transaction});
}

/// @nodoc
class _$TransferCopyWithImpl<$Res> implements $TransferCopyWith<$Res> {
  _$TransferCopyWithImpl(this._value, this._then);

  final Transfer _value;
  // ignore: unused_field
  final $Res Function(Transfer) _then;

  @override
  $Res call({
    Object? feeEstimation = freezed,
    Object? canTransfer = freezed,
    Object? amount = freezed,
    Object? addressRecipient = freezed,
    Object? contactRecipient = freezed,
    Object? message = freezed,
    Object? isMaxSend = freezed,
    Object? isContact = freezed,
    Object? transaction = freezed,
  }) {
    return _then(_value.copyWith(
      feeEstimation: feeEstimation == freezed
          ? _value.feeEstimation
          : feeEstimation // ignore: cast_nullable_to_non_nullable
              as double,
      canTransfer: canTransfer == freezed
          ? _value.canTransfer
          : canTransfer // ignore: cast_nullable_to_non_nullable
              as bool,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      addressRecipient: addressRecipient == freezed
          ? _value.addressRecipient
          : addressRecipient // ignore: cast_nullable_to_non_nullable
              as String,
      contactRecipient: contactRecipient == freezed
          ? _value.contactRecipient
          : contactRecipient // ignore: cast_nullable_to_non_nullable
              as Contact?,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      isMaxSend: isMaxSend == freezed
          ? _value.isMaxSend
          : isMaxSend // ignore: cast_nullable_to_non_nullable
              as bool,
      isContact: isContact == freezed
          ? _value.isContact
          : isContact // ignore: cast_nullable_to_non_nullable
              as bool,
      transaction: transaction == freezed
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as Transaction?,
    ));
  }
}

/// @nodoc
abstract class _$$_TransferCopyWith<$Res> implements $TransferCopyWith<$Res> {
  factory _$$_TransferCopyWith(
          _$_Transfer value, $Res Function(_$_Transfer) then) =
      __$$_TransferCopyWithImpl<$Res>;
  @override
  $Res call(
      {double feeEstimation,
      bool canTransfer,
      double amount,
      String addressRecipient,
      Contact? contactRecipient,
      String message,
      bool isMaxSend,
      bool isContact,
      Transaction? transaction});
}

/// @nodoc
class __$$_TransferCopyWithImpl<$Res> extends _$TransferCopyWithImpl<$Res>
    implements _$$_TransferCopyWith<$Res> {
  __$$_TransferCopyWithImpl(
      _$_Transfer _value, $Res Function(_$_Transfer) _then)
      : super(_value, (v) => _then(v as _$_Transfer));

  @override
  _$_Transfer get _value => super._value as _$_Transfer;

  @override
  $Res call({
    Object? feeEstimation = freezed,
    Object? canTransfer = freezed,
    Object? amount = freezed,
    Object? addressRecipient = freezed,
    Object? contactRecipient = freezed,
    Object? message = freezed,
    Object? isMaxSend = freezed,
    Object? isContact = freezed,
    Object? transaction = freezed,
  }) {
    return _then(_$_Transfer(
      feeEstimation: feeEstimation == freezed
          ? _value.feeEstimation
          : feeEstimation // ignore: cast_nullable_to_non_nullable
              as double,
      canTransfer: canTransfer == freezed
          ? _value.canTransfer
          : canTransfer // ignore: cast_nullable_to_non_nullable
              as bool,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      addressRecipient: addressRecipient == freezed
          ? _value.addressRecipient
          : addressRecipient // ignore: cast_nullable_to_non_nullable
              as String,
      contactRecipient: contactRecipient == freezed
          ? _value.contactRecipient
          : contactRecipient // ignore: cast_nullable_to_non_nullable
              as Contact?,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      isMaxSend: isMaxSend == freezed
          ? _value.isMaxSend
          : isMaxSend // ignore: cast_nullable_to_non_nullable
              as bool,
      isContact: isContact == freezed
          ? _value.isContact
          : isContact // ignore: cast_nullable_to_non_nullable
              as bool,
      transaction: transaction == freezed
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as Transaction?,
    ));
  }
}

/// @nodoc

class _$_Transfer extends _Transfer {
  const _$_Transfer(
      {this.feeEstimation = 0.0,
      this.canTransfer = false,
      this.amount = 0.0,
      this.addressRecipient = '',
      this.contactRecipient,
      this.message = '',
      this.isMaxSend = false,
      this.isContact = false,
      this.transaction})
      : super._();

  @override
  @JsonKey()
  final double feeEstimation;
  @override
  @JsonKey()
  final bool canTransfer;
  @override
  @JsonKey()
  final double amount;
  @override
  @JsonKey()
  final String addressRecipient;
  @override
  final Contact? contactRecipient;
  @override
  @JsonKey()
  final String message;
  @override
  @JsonKey()
  final bool isMaxSend;
  @override
  @JsonKey()
  final bool isContact;
  @override
  final Transaction? transaction;

  @override
  String toString() {
    return 'Transfer(feeEstimation: $feeEstimation, canTransfer: $canTransfer, amount: $amount, addressRecipient: $addressRecipient, contactRecipient: $contactRecipient, message: $message, isMaxSend: $isMaxSend, isContact: $isContact, transaction: $transaction)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Transfer &&
            const DeepCollectionEquality()
                .equals(other.feeEstimation, feeEstimation) &&
            const DeepCollectionEquality()
                .equals(other.canTransfer, canTransfer) &&
            const DeepCollectionEquality().equals(other.amount, amount) &&
            const DeepCollectionEquality()
                .equals(other.addressRecipient, addressRecipient) &&
            const DeepCollectionEquality()
                .equals(other.contactRecipient, contactRecipient) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.isMaxSend, isMaxSend) &&
            const DeepCollectionEquality().equals(other.isContact, isContact) &&
            const DeepCollectionEquality()
                .equals(other.transaction, transaction));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(feeEstimation),
      const DeepCollectionEquality().hash(canTransfer),
      const DeepCollectionEquality().hash(amount),
      const DeepCollectionEquality().hash(addressRecipient),
      const DeepCollectionEquality().hash(contactRecipient),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(isMaxSend),
      const DeepCollectionEquality().hash(isContact),
      const DeepCollectionEquality().hash(transaction));

  @JsonKey(ignore: true)
  @override
  _$$_TransferCopyWith<_$_Transfer> get copyWith =>
      __$$_TransferCopyWithImpl<_$_Transfer>(this, _$identity);
}

abstract class _Transfer extends Transfer {
  const factory _Transfer(
      {final double feeEstimation,
      final bool canTransfer,
      final double amount,
      final String addressRecipient,
      final Contact? contactRecipient,
      final String message,
      final bool isMaxSend,
      final bool isContact,
      final Transaction? transaction}) = _$_Transfer;
  const _Transfer._() : super._();

  @override
  double get feeEstimation;
  @override
  bool get canTransfer;
  @override
  double get amount;
  @override
  String get addressRecipient;
  @override
  Contact? get contactRecipient;
  @override
  String get message;
  @override
  bool get isMaxSend;
  @override
  bool get isContact;
  @override
  Transaction? get transaction;
  @override
  @JsonKey(ignore: true)
  _$$_TransferCopyWith<_$_Transfer> get copyWith =>
      throw _privateConstructorUsedError;
}
