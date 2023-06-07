// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_talk.dart';

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
    required TResult Function(PublicKey publicKey) publicKey,
    required TResult Function(Contact contact) contact,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PublicKey publicKey)? publicKey,
    TResult? Function(Contact contact)? contact,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PublicKey publicKey)? publicKey,
    TResult Function(Contact contact)? contact,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PropertyAccessPublicKey value) publicKey,
    required TResult Function(_PropertyAccessContact value) contact,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PropertyAccessPublicKey value)? publicKey,
    TResult? Function(_PropertyAccessContact value)? contact,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PropertyAccessPublicKey value)? publicKey,
    TResult Function(_PropertyAccessContact value)? contact,
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
abstract class _$$_PropertyAccessPublicKeyCopyWith<$Res> {
  factory _$$_PropertyAccessPublicKeyCopyWith(_$_PropertyAccessPublicKey value,
          $Res Function(_$_PropertyAccessPublicKey) then) =
      __$$_PropertyAccessPublicKeyCopyWithImpl<$Res>;
  @useResult
  $Res call({PublicKey publicKey});
}

/// @nodoc
class __$$_PropertyAccessPublicKeyCopyWithImpl<$Res>
    extends _$AccessRecipientCopyWithImpl<$Res, _$_PropertyAccessPublicKey>
    implements _$$_PropertyAccessPublicKeyCopyWith<$Res> {
  __$$_PropertyAccessPublicKeyCopyWithImpl(_$_PropertyAccessPublicKey _value,
      $Res Function(_$_PropertyAccessPublicKey) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? publicKey = null,
  }) {
    return _then(_$_PropertyAccessPublicKey(
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as PublicKey,
    ));
  }
}

/// @nodoc

class _$_PropertyAccessPublicKey extends _PropertyAccessPublicKey {
  const _$_PropertyAccessPublicKey({required this.publicKey}) : super._();

  @override
  final PublicKey publicKey;

  @override
  String toString() {
    return 'AccessRecipient.publicKey(publicKey: $publicKey)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PropertyAccessPublicKey &&
            (identical(other.publicKey, publicKey) ||
                other.publicKey == publicKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, publicKey);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PropertyAccessPublicKeyCopyWith<_$_PropertyAccessPublicKey>
      get copyWith =>
          __$$_PropertyAccessPublicKeyCopyWithImpl<_$_PropertyAccessPublicKey>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PublicKey publicKey) publicKey,
    required TResult Function(Contact contact) contact,
  }) {
    return publicKey(this.publicKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PublicKey publicKey)? publicKey,
    TResult? Function(Contact contact)? contact,
  }) {
    return publicKey?.call(this.publicKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PublicKey publicKey)? publicKey,
    TResult Function(Contact contact)? contact,
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
    required TResult Function(_PropertyAccessPublicKey value) publicKey,
    required TResult Function(_PropertyAccessContact value) contact,
  }) {
    return publicKey(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PropertyAccessPublicKey value)? publicKey,
    TResult? Function(_PropertyAccessContact value)? contact,
  }) {
    return publicKey?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PropertyAccessPublicKey value)? publicKey,
    TResult Function(_PropertyAccessContact value)? contact,
    required TResult orElse(),
  }) {
    if (publicKey != null) {
      return publicKey(this);
    }
    return orElse();
  }
}

abstract class _PropertyAccessPublicKey extends AccessRecipient {
  const factory _PropertyAccessPublicKey({required final PublicKey publicKey}) =
      _$_PropertyAccessPublicKey;
  const _PropertyAccessPublicKey._() : super._();

  PublicKey get publicKey;
  @JsonKey(ignore: true)
  _$$_PropertyAccessPublicKeyCopyWith<_$_PropertyAccessPublicKey>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_PropertyAccessContactCopyWith<$Res> {
  factory _$$_PropertyAccessContactCopyWith(_$_PropertyAccessContact value,
          $Res Function(_$_PropertyAccessContact) then) =
      __$$_PropertyAccessContactCopyWithImpl<$Res>;
  @useResult
  $Res call({Contact contact});
}

/// @nodoc
class __$$_PropertyAccessContactCopyWithImpl<$Res>
    extends _$AccessRecipientCopyWithImpl<$Res, _$_PropertyAccessContact>
    implements _$$_PropertyAccessContactCopyWith<$Res> {
  __$$_PropertyAccessContactCopyWithImpl(_$_PropertyAccessContact _value,
      $Res Function(_$_PropertyAccessContact) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contact = null,
  }) {
    return _then(_$_PropertyAccessContact(
      contact: null == contact
          ? _value.contact
          : contact // ignore: cast_nullable_to_non_nullable
              as Contact,
    ));
  }
}

/// @nodoc

class _$_PropertyAccessContact extends _PropertyAccessContact {
  const _$_PropertyAccessContact({required this.contact}) : super._();

  @override
  final Contact contact;

  @override
  String toString() {
    return 'AccessRecipient.contact(contact: $contact)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PropertyAccessContact &&
            (identical(other.contact, contact) || other.contact == contact));
  }

  @override
  int get hashCode => Object.hash(runtimeType, contact);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PropertyAccessContactCopyWith<_$_PropertyAccessContact> get copyWith =>
      __$$_PropertyAccessContactCopyWithImpl<_$_PropertyAccessContact>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PublicKey publicKey) publicKey,
    required TResult Function(Contact contact) contact,
  }) {
    return contact(this.contact);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PublicKey publicKey)? publicKey,
    TResult? Function(Contact contact)? contact,
  }) {
    return contact?.call(this.contact);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PublicKey publicKey)? publicKey,
    TResult Function(Contact contact)? contact,
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
    required TResult Function(_PropertyAccessPublicKey value) publicKey,
    required TResult Function(_PropertyAccessContact value) contact,
  }) {
    return contact(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PropertyAccessPublicKey value)? publicKey,
    TResult? Function(_PropertyAccessContact value)? contact,
  }) {
    return contact?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PropertyAccessPublicKey value)? publicKey,
    TResult Function(_PropertyAccessContact value)? contact,
    required TResult orElse(),
  }) {
    if (contact != null) {
      return contact(this);
    }
    return orElse();
  }
}

abstract class _PropertyAccessContact extends AccessRecipient {
  const factory _PropertyAccessContact({required final Contact contact}) =
      _$_PropertyAccessContact;
  const _PropertyAccessContact._() : super._();

  Contact get contact;
  @JsonKey(ignore: true)
  _$$_PropertyAccessContactCopyWith<_$_PropertyAccessContact> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CreateTalkFormState {
  String get name => throw _privateConstructorUsedError;
  AccessRecipient? get memberAddFieldValue =>
      throw _privateConstructorUsedError;
  List<AccessRecipient> get members => throw _privateConstructorUsedError;
  AccessRecipient? get adminAddFieldValue => throw _privateConstructorUsedError;
  List<AccessRecipient> get admins => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreateTalkFormStateCopyWith<CreateTalkFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateTalkFormStateCopyWith<$Res> {
  factory $CreateTalkFormStateCopyWith(
          CreateTalkFormState value, $Res Function(CreateTalkFormState) then) =
      _$CreateTalkFormStateCopyWithImpl<$Res, CreateTalkFormState>;
  @useResult
  $Res call(
      {String name,
      AccessRecipient? memberAddFieldValue,
      List<AccessRecipient> members,
      AccessRecipient? adminAddFieldValue,
      List<AccessRecipient> admins});

  $AccessRecipientCopyWith<$Res>? get memberAddFieldValue;
  $AccessRecipientCopyWith<$Res>? get adminAddFieldValue;
}

/// @nodoc
class _$CreateTalkFormStateCopyWithImpl<$Res, $Val extends CreateTalkFormState>
    implements $CreateTalkFormStateCopyWith<$Res> {
  _$CreateTalkFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? memberAddFieldValue = freezed,
    Object? members = null,
    Object? adminAddFieldValue = freezed,
    Object? admins = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      memberAddFieldValue: freezed == memberAddFieldValue
          ? _value.memberAddFieldValue
          : memberAddFieldValue // ignore: cast_nullable_to_non_nullable
              as AccessRecipient?,
      members: null == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<AccessRecipient>,
      adminAddFieldValue: freezed == adminAddFieldValue
          ? _value.adminAddFieldValue
          : adminAddFieldValue // ignore: cast_nullable_to_non_nullable
              as AccessRecipient?,
      admins: null == admins
          ? _value.admins
          : admins // ignore: cast_nullable_to_non_nullable
              as List<AccessRecipient>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AccessRecipientCopyWith<$Res>? get memberAddFieldValue {
    if (_value.memberAddFieldValue == null) {
      return null;
    }

    return $AccessRecipientCopyWith<$Res>(_value.memberAddFieldValue!, (value) {
      return _then(_value.copyWith(memberAddFieldValue: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AccessRecipientCopyWith<$Res>? get adminAddFieldValue {
    if (_value.adminAddFieldValue == null) {
      return null;
    }

    return $AccessRecipientCopyWith<$Res>(_value.adminAddFieldValue!, (value) {
      return _then(_value.copyWith(adminAddFieldValue: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CreateTalkFormStateCopyWith<$Res>
    implements $CreateTalkFormStateCopyWith<$Res> {
  factory _$$_CreateTalkFormStateCopyWith(_$_CreateTalkFormState value,
          $Res Function(_$_CreateTalkFormState) then) =
      __$$_CreateTalkFormStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      AccessRecipient? memberAddFieldValue,
      List<AccessRecipient> members,
      AccessRecipient? adminAddFieldValue,
      List<AccessRecipient> admins});

  @override
  $AccessRecipientCopyWith<$Res>? get memberAddFieldValue;
  @override
  $AccessRecipientCopyWith<$Res>? get adminAddFieldValue;
}

/// @nodoc
class __$$_CreateTalkFormStateCopyWithImpl<$Res>
    extends _$CreateTalkFormStateCopyWithImpl<$Res, _$_CreateTalkFormState>
    implements _$$_CreateTalkFormStateCopyWith<$Res> {
  __$$_CreateTalkFormStateCopyWithImpl(_$_CreateTalkFormState _value,
      $Res Function(_$_CreateTalkFormState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? memberAddFieldValue = freezed,
    Object? members = null,
    Object? adminAddFieldValue = freezed,
    Object? admins = null,
  }) {
    return _then(_$_CreateTalkFormState(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      memberAddFieldValue: freezed == memberAddFieldValue
          ? _value.memberAddFieldValue
          : memberAddFieldValue // ignore: cast_nullable_to_non_nullable
              as AccessRecipient?,
      members: null == members
          ? _value._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<AccessRecipient>,
      adminAddFieldValue: freezed == adminAddFieldValue
          ? _value.adminAddFieldValue
          : adminAddFieldValue // ignore: cast_nullable_to_non_nullable
              as AccessRecipient?,
      admins: null == admins
          ? _value._admins
          : admins // ignore: cast_nullable_to_non_nullable
              as List<AccessRecipient>,
    ));
  }
}

/// @nodoc

class _$_CreateTalkFormState extends _CreateTalkFormState {
  const _$_CreateTalkFormState(
      {required this.name,
      this.memberAddFieldValue,
      required final List<AccessRecipient> members,
      this.adminAddFieldValue,
      required final List<AccessRecipient> admins})
      : _members = members,
        _admins = admins,
        super._();

  @override
  final String name;
  @override
  final AccessRecipient? memberAddFieldValue;
  final List<AccessRecipient> _members;
  @override
  List<AccessRecipient> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  @override
  final AccessRecipient? adminAddFieldValue;
  final List<AccessRecipient> _admins;
  @override
  List<AccessRecipient> get admins {
    if (_admins is EqualUnmodifiableListView) return _admins;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_admins);
  }

  @override
  String toString() {
    return 'CreateTalkFormState(name: $name, memberAddFieldValue: $memberAddFieldValue, members: $members, adminAddFieldValue: $adminAddFieldValue, admins: $admins)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CreateTalkFormState &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.memberAddFieldValue, memberAddFieldValue) ||
                other.memberAddFieldValue == memberAddFieldValue) &&
            const DeepCollectionEquality().equals(other._members, _members) &&
            (identical(other.adminAddFieldValue, adminAddFieldValue) ||
                other.adminAddFieldValue == adminAddFieldValue) &&
            const DeepCollectionEquality().equals(other._admins, _admins));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      memberAddFieldValue,
      const DeepCollectionEquality().hash(_members),
      adminAddFieldValue,
      const DeepCollectionEquality().hash(_admins));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CreateTalkFormStateCopyWith<_$_CreateTalkFormState> get copyWith =>
      __$$_CreateTalkFormStateCopyWithImpl<_$_CreateTalkFormState>(
          this, _$identity);
}

abstract class _CreateTalkFormState extends CreateTalkFormState {
  const factory _CreateTalkFormState(
      {required final String name,
      final AccessRecipient? memberAddFieldValue,
      required final List<AccessRecipient> members,
      final AccessRecipient? adminAddFieldValue,
      required final List<AccessRecipient> admins}) = _$_CreateTalkFormState;
  const _CreateTalkFormState._() : super._();

  @override
  String get name;
  @override
  AccessRecipient? get memberAddFieldValue;
  @override
  List<AccessRecipient> get members;
  @override
  AccessRecipient? get adminAddFieldValue;
  @override
  List<AccessRecipient> get admins;
  @override
  @JsonKey(ignore: true)
  _$$_CreateTalkFormStateCopyWith<_$_CreateTalkFormState> get copyWith =>
      throw _privateConstructorUsedError;
}
