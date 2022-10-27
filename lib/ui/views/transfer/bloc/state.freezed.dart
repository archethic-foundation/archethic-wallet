// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TransferFormState {
  TransferType get transferType => throw _privateConstructorUsedError;
  String get seed => throw _privateConstructorUsedError;
  TransferProcessStep get transferProcessStep =>
      throw _privateConstructorUsedError;
  AsyncValue<double> get feeEstimation => throw _privateConstructorUsedError;
  bool get defineMaxAmountInProgress => throw _privateConstructorUsedError;
  double get amount =>
      throw _privateConstructorUsedError; // Amount converted in UCO if primary currency is native. Else in fiat currency
  double get amountConverted => throw _privateConstructorUsedError;
  double get accountBalance => throw _privateConstructorUsedError;
  TransferRecipient get recipient => throw _privateConstructorUsedError;
  AccountToken? get accountToken => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get errorAddressText => throw _privateConstructorUsedError;
  String get errorAmountText => throw _privateConstructorUsedError;
  String get errorMessageText => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TransferFormStateCopyWith<TransferFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferFormStateCopyWith<$Res> {
  factory $TransferFormStateCopyWith(
          TransferFormState value, $Res Function(TransferFormState) then) =
      _$TransferFormStateCopyWithImpl<$Res>;
  $Res call(
      {TransferType transferType,
      String seed,
      TransferProcessStep transferProcessStep,
      AsyncValue<double> feeEstimation,
      bool defineMaxAmountInProgress,
      double amount,
      double amountConverted,
      double accountBalance,
      TransferRecipient recipient,
      AccountToken? accountToken,
      String message,
      String errorAddressText,
      String errorAmountText,
      String errorMessageText});

  $TransferRecipientCopyWith<$Res> get recipient;
}

/// @nodoc
class _$TransferFormStateCopyWithImpl<$Res>
    implements $TransferFormStateCopyWith<$Res> {
  _$TransferFormStateCopyWithImpl(this._value, this._then);

  final TransferFormState _value;
  // ignore: unused_field
  final $Res Function(TransferFormState) _then;

  @override
  $Res call({
    Object? transferType = freezed,
    Object? seed = freezed,
    Object? transferProcessStep = freezed,
    Object? feeEstimation = freezed,
    Object? defineMaxAmountInProgress = freezed,
    Object? amount = freezed,
    Object? amountConverted = freezed,
    Object? accountBalance = freezed,
    Object? recipient = freezed,
    Object? accountToken = freezed,
    Object? message = freezed,
    Object? errorAddressText = freezed,
    Object? errorAmountText = freezed,
    Object? errorMessageText = freezed,
  }) {
    return _then(_value.copyWith(
      transferType: transferType == freezed
          ? _value.transferType
          : transferType // ignore: cast_nullable_to_non_nullable
              as TransferType,
      seed: seed == freezed
          ? _value.seed
          : seed // ignore: cast_nullable_to_non_nullable
              as String,
      transferProcessStep: transferProcessStep == freezed
          ? _value.transferProcessStep
          : transferProcessStep // ignore: cast_nullable_to_non_nullable
              as TransferProcessStep,
      feeEstimation: feeEstimation == freezed
          ? _value.feeEstimation
          : feeEstimation // ignore: cast_nullable_to_non_nullable
              as AsyncValue<double>,
      defineMaxAmountInProgress: defineMaxAmountInProgress == freezed
          ? _value.defineMaxAmountInProgress
          : defineMaxAmountInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      amountConverted: amountConverted == freezed
          ? _value.amountConverted
          : amountConverted // ignore: cast_nullable_to_non_nullable
              as double,
      accountBalance: accountBalance == freezed
          ? _value.accountBalance
          : accountBalance // ignore: cast_nullable_to_non_nullable
              as double,
      recipient: recipient == freezed
          ? _value.recipient
          : recipient // ignore: cast_nullable_to_non_nullable
              as TransferRecipient,
      accountToken: accountToken == freezed
          ? _value.accountToken
          : accountToken // ignore: cast_nullable_to_non_nullable
              as AccountToken?,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      errorAddressText: errorAddressText == freezed
          ? _value.errorAddressText
          : errorAddressText // ignore: cast_nullable_to_non_nullable
              as String,
      errorAmountText: errorAmountText == freezed
          ? _value.errorAmountText
          : errorAmountText // ignore: cast_nullable_to_non_nullable
              as String,
      errorMessageText: errorMessageText == freezed
          ? _value.errorMessageText
          : errorMessageText // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  $TransferRecipientCopyWith<$Res> get recipient {
    return $TransferRecipientCopyWith<$Res>(_value.recipient, (value) {
      return _then(_value.copyWith(recipient: value));
    });
  }
}

/// @nodoc
abstract class _$$_TransferFormStateCopyWith<$Res>
    implements $TransferFormStateCopyWith<$Res> {
  factory _$$_TransferFormStateCopyWith(_$_TransferFormState value,
          $Res Function(_$_TransferFormState) then) =
      __$$_TransferFormStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {TransferType transferType,
      String seed,
      TransferProcessStep transferProcessStep,
      AsyncValue<double> feeEstimation,
      bool defineMaxAmountInProgress,
      double amount,
      double amountConverted,
      double accountBalance,
      TransferRecipient recipient,
      AccountToken? accountToken,
      String message,
      String errorAddressText,
      String errorAmountText,
      String errorMessageText});

  @override
  $TransferRecipientCopyWith<$Res> get recipient;
}

/// @nodoc
class __$$_TransferFormStateCopyWithImpl<$Res>
    extends _$TransferFormStateCopyWithImpl<$Res>
    implements _$$_TransferFormStateCopyWith<$Res> {
  __$$_TransferFormStateCopyWithImpl(
      _$_TransferFormState _value, $Res Function(_$_TransferFormState) _then)
      : super(_value, (v) => _then(v as _$_TransferFormState));

  @override
  _$_TransferFormState get _value => super._value as _$_TransferFormState;

  @override
  $Res call({
    Object? transferType = freezed,
    Object? seed = freezed,
    Object? transferProcessStep = freezed,
    Object? feeEstimation = freezed,
    Object? defineMaxAmountInProgress = freezed,
    Object? amount = freezed,
    Object? amountConverted = freezed,
    Object? accountBalance = freezed,
    Object? recipient = freezed,
    Object? accountToken = freezed,
    Object? message = freezed,
    Object? errorAddressText = freezed,
    Object? errorAmountText = freezed,
    Object? errorMessageText = freezed,
  }) {
    return _then(_$_TransferFormState(
      transferType: transferType == freezed
          ? _value.transferType
          : transferType // ignore: cast_nullable_to_non_nullable
              as TransferType,
      seed: seed == freezed
          ? _value.seed
          : seed // ignore: cast_nullable_to_non_nullable
              as String,
      transferProcessStep: transferProcessStep == freezed
          ? _value.transferProcessStep
          : transferProcessStep // ignore: cast_nullable_to_non_nullable
              as TransferProcessStep,
      feeEstimation: feeEstimation == freezed
          ? _value.feeEstimation
          : feeEstimation // ignore: cast_nullable_to_non_nullable
              as AsyncValue<double>,
      defineMaxAmountInProgress: defineMaxAmountInProgress == freezed
          ? _value.defineMaxAmountInProgress
          : defineMaxAmountInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      amountConverted: amountConverted == freezed
          ? _value.amountConverted
          : amountConverted // ignore: cast_nullable_to_non_nullable
              as double,
      accountBalance: accountBalance == freezed
          ? _value.accountBalance
          : accountBalance // ignore: cast_nullable_to_non_nullable
              as double,
      recipient: recipient == freezed
          ? _value.recipient
          : recipient // ignore: cast_nullable_to_non_nullable
              as TransferRecipient,
      accountToken: accountToken == freezed
          ? _value.accountToken
          : accountToken // ignore: cast_nullable_to_non_nullable
              as AccountToken?,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      errorAddressText: errorAddressText == freezed
          ? _value.errorAddressText
          : errorAddressText // ignore: cast_nullable_to_non_nullable
              as String,
      errorAmountText: errorAmountText == freezed
          ? _value.errorAmountText
          : errorAmountText // ignore: cast_nullable_to_non_nullable
              as String,
      errorMessageText: errorMessageText == freezed
          ? _value.errorMessageText
          : errorMessageText // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_TransferFormState extends _TransferFormState {
  const _$_TransferFormState(
      {this.transferType = TransferType.uco,
      required this.seed,
      this.transferProcessStep = TransferProcessStep.form,
      required this.feeEstimation,
      this.defineMaxAmountInProgress = false,
      this.amount = 0.0,
      this.amountConverted = 0.0,
      required this.accountBalance,
      required this.recipient,
      this.accountToken,
      this.message = '',
      this.errorAddressText = '',
      this.errorAmountText = '',
      this.errorMessageText = ''})
      : super._();

  @override
  @JsonKey()
  final TransferType transferType;
  @override
  final String seed;
  @override
  @JsonKey()
  final TransferProcessStep transferProcessStep;
  @override
  final AsyncValue<double> feeEstimation;
  @override
  @JsonKey()
  final bool defineMaxAmountInProgress;
  @override
  @JsonKey()
  final double amount;
// Amount converted in UCO if primary currency is native. Else in fiat currency
  @override
  @JsonKey()
  final double amountConverted;
  @override
  final double accountBalance;
  @override
  final TransferRecipient recipient;
  @override
  final AccountToken? accountToken;
  @override
  @JsonKey()
  final String message;
  @override
  @JsonKey()
  final String errorAddressText;
  @override
  @JsonKey()
  final String errorAmountText;
  @override
  @JsonKey()
  final String errorMessageText;

  @override
  String toString() {
    return 'TransferFormState(transferType: $transferType, seed: $seed, transferProcessStep: $transferProcessStep, feeEstimation: $feeEstimation, defineMaxAmountInProgress: $defineMaxAmountInProgress, amount: $amount, amountConverted: $amountConverted, accountBalance: $accountBalance, recipient: $recipient, accountToken: $accountToken, message: $message, errorAddressText: $errorAddressText, errorAmountText: $errorAmountText, errorMessageText: $errorMessageText)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransferFormState &&
            const DeepCollectionEquality()
                .equals(other.transferType, transferType) &&
            const DeepCollectionEquality().equals(other.seed, seed) &&
            const DeepCollectionEquality()
                .equals(other.transferProcessStep, transferProcessStep) &&
            const DeepCollectionEquality()
                .equals(other.feeEstimation, feeEstimation) &&
            const DeepCollectionEquality().equals(
                other.defineMaxAmountInProgress, defineMaxAmountInProgress) &&
            const DeepCollectionEquality().equals(other.amount, amount) &&
            const DeepCollectionEquality()
                .equals(other.amountConverted, amountConverted) &&
            const DeepCollectionEquality()
                .equals(other.accountBalance, accountBalance) &&
            const DeepCollectionEquality().equals(other.recipient, recipient) &&
            const DeepCollectionEquality()
                .equals(other.accountToken, accountToken) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality()
                .equals(other.errorAddressText, errorAddressText) &&
            const DeepCollectionEquality()
                .equals(other.errorAmountText, errorAmountText) &&
            const DeepCollectionEquality()
                .equals(other.errorMessageText, errorMessageText));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(transferType),
      const DeepCollectionEquality().hash(seed),
      const DeepCollectionEquality().hash(transferProcessStep),
      const DeepCollectionEquality().hash(feeEstimation),
      const DeepCollectionEquality().hash(defineMaxAmountInProgress),
      const DeepCollectionEquality().hash(amount),
      const DeepCollectionEquality().hash(amountConverted),
      const DeepCollectionEquality().hash(accountBalance),
      const DeepCollectionEquality().hash(recipient),
      const DeepCollectionEquality().hash(accountToken),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(errorAddressText),
      const DeepCollectionEquality().hash(errorAmountText),
      const DeepCollectionEquality().hash(errorMessageText));

  @JsonKey(ignore: true)
  @override
  _$$_TransferFormStateCopyWith<_$_TransferFormState> get copyWith =>
      __$$_TransferFormStateCopyWithImpl<_$_TransferFormState>(
          this, _$identity);
}

abstract class _TransferFormState extends TransferFormState {
  const factory _TransferFormState(
      {final TransferType transferType,
      required final String seed,
      final TransferProcessStep transferProcessStep,
      required final AsyncValue<double> feeEstimation,
      final bool defineMaxAmountInProgress,
      final double amount,
      final double amountConverted,
      required final double accountBalance,
      required final TransferRecipient recipient,
      final AccountToken? accountToken,
      final String message,
      final String errorAddressText,
      final String errorAmountText,
      final String errorMessageText}) = _$_TransferFormState;
  const _TransferFormState._() : super._();

  @override
  TransferType get transferType;
  @override
  String get seed;
  @override
  TransferProcessStep get transferProcessStep;
  @override
  AsyncValue<double> get feeEstimation;
  @override
  bool get defineMaxAmountInProgress;
  @override
  double get amount;
  @override // Amount converted in UCO if primary currency is native. Else in fiat currency
  double get amountConverted;
  @override
  double get accountBalance;
  @override
  TransferRecipient get recipient;
  @override
  AccountToken? get accountToken;
  @override
  String get message;
  @override
  String get errorAddressText;
  @override
  String get errorAmountText;
  @override
  String get errorMessageText;
  @override
  @JsonKey(ignore: true)
  _$$_TransferFormStateCopyWith<_$_TransferFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TransferRecipient {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Address address) address,
    required TResult Function(Contact contact) contact,
    required TResult Function(String name) unknownContact,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Address address)? address,
    TResult Function(Contact contact)? contact,
    TResult Function(String name)? unknownContact,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Address address)? address,
    TResult Function(Contact contact)? contact,
    TResult Function(String name)? unknownContact,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransferDestinationAddress value) address,
    required TResult Function(_TransferDestinationContact value) contact,
    required TResult Function(_TransferDestinationUnknownContact value)
        unknownContact,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_TransferDestinationAddress value)? address,
    TResult Function(_TransferDestinationContact value)? contact,
    TResult Function(_TransferDestinationUnknownContact value)? unknownContact,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransferDestinationAddress value)? address,
    TResult Function(_TransferDestinationContact value)? contact,
    TResult Function(_TransferDestinationUnknownContact value)? unknownContact,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferRecipientCopyWith<$Res> {
  factory $TransferRecipientCopyWith(
          TransferRecipient value, $Res Function(TransferRecipient) then) =
      _$TransferRecipientCopyWithImpl<$Res>;
}

/// @nodoc
class _$TransferRecipientCopyWithImpl<$Res>
    implements $TransferRecipientCopyWith<$Res> {
  _$TransferRecipientCopyWithImpl(this._value, this._then);

  final TransferRecipient _value;
  // ignore: unused_field
  final $Res Function(TransferRecipient) _then;
}

/// @nodoc
abstract class _$$_TransferDestinationAddressCopyWith<$Res> {
  factory _$$_TransferDestinationAddressCopyWith(
          _$_TransferDestinationAddress value,
          $Res Function(_$_TransferDestinationAddress) then) =
      __$$_TransferDestinationAddressCopyWithImpl<$Res>;
  $Res call({Address address});
}

/// @nodoc
class __$$_TransferDestinationAddressCopyWithImpl<$Res>
    extends _$TransferRecipientCopyWithImpl<$Res>
    implements _$$_TransferDestinationAddressCopyWith<$Res> {
  __$$_TransferDestinationAddressCopyWithImpl(
      _$_TransferDestinationAddress _value,
      $Res Function(_$_TransferDestinationAddress) _then)
      : super(_value, (v) => _then(v as _$_TransferDestinationAddress));

  @override
  _$_TransferDestinationAddress get _value =>
      super._value as _$_TransferDestinationAddress;

  @override
  $Res call({
    Object? address = freezed,
  }) {
    return _then(_$_TransferDestinationAddress(
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
    ));
  }
}

/// @nodoc

class _$_TransferDestinationAddress extends _TransferDestinationAddress {
  const _$_TransferDestinationAddress({required this.address}) : super._();

  @override
  final Address address;

  @override
  String toString() {
    return 'TransferRecipient.address(address: $address)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransferDestinationAddress &&
            const DeepCollectionEquality().equals(other.address, address));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(address));

  @JsonKey(ignore: true)
  @override
  _$$_TransferDestinationAddressCopyWith<_$_TransferDestinationAddress>
      get copyWith => __$$_TransferDestinationAddressCopyWithImpl<
          _$_TransferDestinationAddress>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Address address) address,
    required TResult Function(Contact contact) contact,
    required TResult Function(String name) unknownContact,
  }) {
    return address(this.address);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Address address)? address,
    TResult Function(Contact contact)? contact,
    TResult Function(String name)? unknownContact,
  }) {
    return address?.call(this.address);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Address address)? address,
    TResult Function(Contact contact)? contact,
    TResult Function(String name)? unknownContact,
    required TResult orElse(),
  }) {
    if (address != null) {
      return address(this.address);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransferDestinationAddress value) address,
    required TResult Function(_TransferDestinationContact value) contact,
    required TResult Function(_TransferDestinationUnknownContact value)
        unknownContact,
  }) {
    return address(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_TransferDestinationAddress value)? address,
    TResult Function(_TransferDestinationContact value)? contact,
    TResult Function(_TransferDestinationUnknownContact value)? unknownContact,
  }) {
    return address?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransferDestinationAddress value)? address,
    TResult Function(_TransferDestinationContact value)? contact,
    TResult Function(_TransferDestinationUnknownContact value)? unknownContact,
    required TResult orElse(),
  }) {
    if (address != null) {
      return address(this);
    }
    return orElse();
  }
}

abstract class _TransferDestinationAddress extends TransferRecipient {
  const factory _TransferDestinationAddress({required final Address address}) =
      _$_TransferDestinationAddress;
  const _TransferDestinationAddress._() : super._();

  Address get address;
  @JsonKey(ignore: true)
  _$$_TransferDestinationAddressCopyWith<_$_TransferDestinationAddress>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_TransferDestinationContactCopyWith<$Res> {
  factory _$$_TransferDestinationContactCopyWith(
          _$_TransferDestinationContact value,
          $Res Function(_$_TransferDestinationContact) then) =
      __$$_TransferDestinationContactCopyWithImpl<$Res>;
  $Res call({Contact contact});
}

/// @nodoc
class __$$_TransferDestinationContactCopyWithImpl<$Res>
    extends _$TransferRecipientCopyWithImpl<$Res>
    implements _$$_TransferDestinationContactCopyWith<$Res> {
  __$$_TransferDestinationContactCopyWithImpl(
      _$_TransferDestinationContact _value,
      $Res Function(_$_TransferDestinationContact) _then)
      : super(_value, (v) => _then(v as _$_TransferDestinationContact));

  @override
  _$_TransferDestinationContact get _value =>
      super._value as _$_TransferDestinationContact;

  @override
  $Res call({
    Object? contact = freezed,
  }) {
    return _then(_$_TransferDestinationContact(
      contact: contact == freezed
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as Contact,
    ));
  }
}

/// @nodoc

class _$_TransferDestinationContact extends _TransferDestinationContact {
  const _$_TransferDestinationContact({required this.contact}) : super._();

  @override
  final Contact contact;

  @override
  String toString() {
    return 'TransferRecipient.contact(contact: $contact)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransferDestinationContact &&
            const DeepCollectionEquality().equals(other.contact, contact));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(contact));

  @JsonKey(ignore: true)
  @override
  _$$_TransferDestinationContactCopyWith<_$_TransferDestinationContact>
      get copyWith => __$$_TransferDestinationContactCopyWithImpl<
          _$_TransferDestinationContact>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Address address) address,
    required TResult Function(Contact contact) contact,
    required TResult Function(String name) unknownContact,
  }) {
    return contact(this.contact);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Address address)? address,
    TResult Function(Contact contact)? contact,
    TResult Function(String name)? unknownContact,
  }) {
    return contact?.call(this.contact);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Address address)? address,
    TResult Function(Contact contact)? contact,
    TResult Function(String name)? unknownContact,
    required TResult orElse(),
  }) {
    if (contact != null) {
      return contact(this.contact);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransferDestinationAddress value) address,
    required TResult Function(_TransferDestinationContact value) contact,
    required TResult Function(_TransferDestinationUnknownContact value)
        unknownContact,
  }) {
    return contact(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_TransferDestinationAddress value)? address,
    TResult Function(_TransferDestinationContact value)? contact,
    TResult Function(_TransferDestinationUnknownContact value)? unknownContact,
  }) {
    return contact?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransferDestinationAddress value)? address,
    TResult Function(_TransferDestinationContact value)? contact,
    TResult Function(_TransferDestinationUnknownContact value)? unknownContact,
    required TResult orElse(),
  }) {
    if (contact != null) {
      return contact(this);
    }
    return orElse();
  }
}

abstract class _TransferDestinationContact extends TransferRecipient {
  const factory _TransferDestinationContact({required final Contact contact}) =
      _$_TransferDestinationContact;
  const _TransferDestinationContact._() : super._();

  Contact get contact;
  @JsonKey(ignore: true)
  _$$_TransferDestinationContactCopyWith<_$_TransferDestinationContact>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_TransferDestinationUnknownContactCopyWith<$Res> {
  factory _$$_TransferDestinationUnknownContactCopyWith(
          _$_TransferDestinationUnknownContact value,
          $Res Function(_$_TransferDestinationUnknownContact) then) =
      __$$_TransferDestinationUnknownContactCopyWithImpl<$Res>;
  $Res call({String name});
}

/// @nodoc
class __$$_TransferDestinationUnknownContactCopyWithImpl<$Res>
    extends _$TransferRecipientCopyWithImpl<$Res>
    implements _$$_TransferDestinationUnknownContactCopyWith<$Res> {
  __$$_TransferDestinationUnknownContactCopyWithImpl(
      _$_TransferDestinationUnknownContact _value,
      $Res Function(_$_TransferDestinationUnknownContact) _then)
      : super(_value, (v) => _then(v as _$_TransferDestinationUnknownContact));

  @override
  _$_TransferDestinationUnknownContact get _value =>
      super._value as _$_TransferDestinationUnknownContact;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_$_TransferDestinationUnknownContact(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_TransferDestinationUnknownContact
    extends _TransferDestinationUnknownContact {
  const _$_TransferDestinationUnknownContact({required this.name}) : super._();

  @override
  final String name;

  @override
  String toString() {
    return 'TransferRecipient.unknownContact(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransferDestinationUnknownContact &&
            const DeepCollectionEquality().equals(other.name, name));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(name));

  @JsonKey(ignore: true)
  @override
  _$$_TransferDestinationUnknownContactCopyWith<
          _$_TransferDestinationUnknownContact>
      get copyWith => __$$_TransferDestinationUnknownContactCopyWithImpl<
          _$_TransferDestinationUnknownContact>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Address address) address,
    required TResult Function(Contact contact) contact,
    required TResult Function(String name) unknownContact,
  }) {
    return unknownContact(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Address address)? address,
    TResult Function(Contact contact)? contact,
    TResult Function(String name)? unknownContact,
  }) {
    return unknownContact?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Address address)? address,
    TResult Function(Contact contact)? contact,
    TResult Function(String name)? unknownContact,
    required TResult orElse(),
  }) {
    if (unknownContact != null) {
      return unknownContact(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransferDestinationAddress value) address,
    required TResult Function(_TransferDestinationContact value) contact,
    required TResult Function(_TransferDestinationUnknownContact value)
        unknownContact,
  }) {
    return unknownContact(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_TransferDestinationAddress value)? address,
    TResult Function(_TransferDestinationContact value)? contact,
    TResult Function(_TransferDestinationUnknownContact value)? unknownContact,
  }) {
    return unknownContact?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransferDestinationAddress value)? address,
    TResult Function(_TransferDestinationContact value)? contact,
    TResult Function(_TransferDestinationUnknownContact value)? unknownContact,
    required TResult orElse(),
  }) {
    if (unknownContact != null) {
      return unknownContact(this);
    }
    return orElse();
  }
}

abstract class _TransferDestinationUnknownContact extends TransferRecipient {
  const factory _TransferDestinationUnknownContact(
      {required final String name}) = _$_TransferDestinationUnknownContact;
  const _TransferDestinationUnknownContact._() : super._();

  String get name;
  @JsonKey(ignore: true)
  _$$_TransferDestinationUnknownContactCopyWith<
          _$_TransferDestinationUnknownContact>
      get copyWith => throw _privateConstructorUsedError;
}
