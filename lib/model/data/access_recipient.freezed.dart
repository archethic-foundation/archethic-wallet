// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'access_recipient.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AccessRecipient {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(@HiveField(0) String publicKey) publicKey,
    required TResult Function(@HiveField(0) Contact contact) contact,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(@HiveField(0) String publicKey)? publicKey,
    TResult? Function(@HiveField(0) Contact contact)? contact,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(@HiveField(0) String publicKey)? publicKey,
    TResult Function(@HiveField(0) Contact contact)? contact,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AccessPublicKey value) publicKey,
    required TResult Function(_AccessContact value) contact,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AccessPublicKey value)? publicKey,
    TResult? Function(_AccessContact value)? contact,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AccessPublicKey value)? publicKey,
    TResult Function(_AccessContact value)? contact,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccessRecipientCopyWith<$Res> {
  factory $AccessRecipientCopyWith(
          AccessRecipient value, $Res Function(AccessRecipient) then) =
      _$AccessRecipientCopyWithImpl<$Res, AccessRecipient>;
}

/// @nodoc
class _$AccessRecipientCopyWithImpl<$Res, $Val extends AccessRecipient>
    implements $AccessRecipientCopyWith<$Res> {
  _$AccessRecipientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AccessPublicKeyImplCopyWith<$Res> {
  factory _$$AccessPublicKeyImplCopyWith(_$AccessPublicKeyImpl value,
          $Res Function(_$AccessPublicKeyImpl) then) =
      __$$AccessPublicKeyImplCopyWithImpl<$Res>;
  @useResult
  $Res call({@HiveField(0) String publicKey});
}

/// @nodoc
class __$$AccessPublicKeyImplCopyWithImpl<$Res>
    extends _$AccessRecipientCopyWithImpl<$Res, _$AccessPublicKeyImpl>
    implements _$$AccessPublicKeyImplCopyWith<$Res> {
  __$$AccessPublicKeyImplCopyWithImpl(
      _$AccessPublicKeyImpl _value, $Res Function(_$AccessPublicKeyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? publicKey = null,
  }) {
    return _then(_$AccessPublicKeyImpl(
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@HiveType(
    adapterName: 'PubKeyAccessRecipientAdapter',
    typeId: HiveTypeIds.pubKeyAccessRecipient)
class _$AccessPublicKeyImpl extends _AccessPublicKey {
  const _$AccessPublicKeyImpl({@HiveField(0) required this.publicKey})
      : super._();

  @override
  @HiveField(0)
  final String publicKey;

  @override
  String toString() {
    return 'AccessRecipient.publicKey(publicKey: $publicKey)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccessPublicKeyImpl &&
            (identical(other.publicKey, publicKey) ||
                other.publicKey == publicKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, publicKey);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AccessPublicKeyImplCopyWith<_$AccessPublicKeyImpl> get copyWith =>
      __$$AccessPublicKeyImplCopyWithImpl<_$AccessPublicKeyImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(@HiveField(0) String publicKey) publicKey,
    required TResult Function(@HiveField(0) Contact contact) contact,
  }) {
    return publicKey(this.publicKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(@HiveField(0) String publicKey)? publicKey,
    TResult? Function(@HiveField(0) Contact contact)? contact,
  }) {
    return publicKey?.call(this.publicKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(@HiveField(0) String publicKey)? publicKey,
    TResult Function(@HiveField(0) Contact contact)? contact,
    required TResult orElse(),
  }) {
    if (publicKey != null) {
      return publicKey(this.publicKey);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AccessPublicKey value) publicKey,
    required TResult Function(_AccessContact value) contact,
  }) {
    return publicKey(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AccessPublicKey value)? publicKey,
    TResult? Function(_AccessContact value)? contact,
  }) {
    return publicKey?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AccessPublicKey value)? publicKey,
    TResult Function(_AccessContact value)? contact,
    required TResult orElse(),
  }) {
    if (publicKey != null) {
      return publicKey(this);
    }
    return orElse();
  }
}

abstract class _AccessPublicKey extends AccessRecipient {
  const factory _AccessPublicKey(
      {@HiveField(0) required final String publicKey}) = _$AccessPublicKeyImpl;
  const _AccessPublicKey._() : super._();

  @HiveField(0)
  String get publicKey;
  @JsonKey(ignore: true)
  _$$AccessPublicKeyImplCopyWith<_$AccessPublicKeyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AccessContactImplCopyWith<$Res> {
  factory _$$AccessContactImplCopyWith(
          _$AccessContactImpl value, $Res Function(_$AccessContactImpl) then) =
      __$$AccessContactImplCopyWithImpl<$Res>;
  @useResult
  $Res call({@HiveField(0) Contact contact});
}

/// @nodoc
class __$$AccessContactImplCopyWithImpl<$Res>
    extends _$AccessRecipientCopyWithImpl<$Res, _$AccessContactImpl>
    implements _$$AccessContactImplCopyWith<$Res> {
  __$$AccessContactImplCopyWithImpl(
      _$AccessContactImpl _value, $Res Function(_$AccessContactImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contact = null,
  }) {
    return _then(_$AccessContactImpl(
      contact: null == contact
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as Contact,
    ));
  }
}

/// @nodoc

@HiveType(
    adapterName: 'ContactAccessRecipientAdapter',
    typeId: HiveTypeIds.contactAccessRecipient)
class _$AccessContactImpl extends _AccessContact {
  const _$AccessContactImpl({@HiveField(0) required this.contact}) : super._();

  @override
  @HiveField(0)
  final Contact contact;

  @override
  String toString() {
    return 'AccessRecipient.contact(contact: $contact)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccessContactImpl &&
            (identical(other.contact, contact) || other.contact == contact));
  }

  @override
  int get hashCode => Object.hash(runtimeType, contact);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AccessContactImplCopyWith<_$AccessContactImpl> get copyWith =>
      __$$AccessContactImplCopyWithImpl<_$AccessContactImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(@HiveField(0) String publicKey) publicKey,
    required TResult Function(@HiveField(0) Contact contact) contact,
  }) {
    return contact(this.contact);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(@HiveField(0) String publicKey)? publicKey,
    TResult? Function(@HiveField(0) Contact contact)? contact,
  }) {
    return contact?.call(this.contact);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(@HiveField(0) String publicKey)? publicKey,
    TResult Function(@HiveField(0) Contact contact)? contact,
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
    required TResult Function(_AccessPublicKey value) publicKey,
    required TResult Function(_AccessContact value) contact,
  }) {
    return contact(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AccessPublicKey value)? publicKey,
    TResult? Function(_AccessContact value)? contact,
  }) {
    return contact?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AccessPublicKey value)? publicKey,
    TResult Function(_AccessContact value)? contact,
    required TResult orElse(),
  }) {
    if (contact != null) {
      return contact(this);
    }
    return orElse();
  }
}

abstract class _AccessContact extends AccessRecipient {
  const factory _AccessContact({@HiveField(0) required final Contact contact}) =
      _$AccessContactImpl;
  const _AccessContact._() : super._();

  @HiveField(0)
  Contact get contact;
  @JsonKey(ignore: true)
  _$$AccessContactImplCopyWith<_$AccessContactImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
