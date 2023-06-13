// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'providers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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

/// @nodoc
mixin _$MessageCreationFormState {
  String get talkAddress => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  bool get isCreating => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MessageCreationFormStateCopyWith<MessageCreationFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageCreationFormStateCopyWith<$Res> {
  factory $MessageCreationFormStateCopyWith(MessageCreationFormState value,
          $Res Function(MessageCreationFormState) then) =
      _$MessageCreationFormStateCopyWithImpl<$Res, MessageCreationFormState>;
  @useResult
  $Res call({String talkAddress, String text, bool isCreating});
}

/// @nodoc
class _$MessageCreationFormStateCopyWithImpl<$Res,
        $Val extends MessageCreationFormState>
    implements $MessageCreationFormStateCopyWith<$Res> {
  _$MessageCreationFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? talkAddress = null,
    Object? text = null,
    Object? isCreating = null,
  }) {
    return _then(_value.copyWith(
      talkAddress: null == talkAddress
          ? _value.talkAddress
          : talkAddress // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      isCreating: null == isCreating
          ? _value.isCreating
          : isCreating // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MessageCreationFormStateCopyWith<$Res>
    implements $MessageCreationFormStateCopyWith<$Res> {
  factory _$$_MessageCreationFormStateCopyWith(
          _$_MessageCreationFormState value,
          $Res Function(_$_MessageCreationFormState) then) =
      __$$_MessageCreationFormStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String talkAddress, String text, bool isCreating});
}

/// @nodoc
class __$$_MessageCreationFormStateCopyWithImpl<$Res>
    extends _$MessageCreationFormStateCopyWithImpl<$Res,
        _$_MessageCreationFormState>
    implements _$$_MessageCreationFormStateCopyWith<$Res> {
  __$$_MessageCreationFormStateCopyWithImpl(_$_MessageCreationFormState _value,
      $Res Function(_$_MessageCreationFormState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? talkAddress = null,
    Object? text = null,
    Object? isCreating = null,
  }) {
    return _then(_$_MessageCreationFormState(
      talkAddress: null == talkAddress
          ? _value.talkAddress
          : talkAddress // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      isCreating: null == isCreating
          ? _value.isCreating
          : isCreating // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_MessageCreationFormState extends _MessageCreationFormState {
  const _$_MessageCreationFormState(
      {required this.talkAddress, required this.text, required this.isCreating})
      : super._();

  @override
  final String talkAddress;
  @override
  final String text;
  @override
  final bool isCreating;

  @override
  String toString() {
    return 'MessageCreationFormState(talkAddress: $talkAddress, text: $text, isCreating: $isCreating)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MessageCreationFormState &&
            (identical(other.talkAddress, talkAddress) ||
                other.talkAddress == talkAddress) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.isCreating, isCreating) ||
                other.isCreating == isCreating));
  }

  @override
  int get hashCode => Object.hash(runtimeType, talkAddress, text, isCreating);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MessageCreationFormStateCopyWith<_$_MessageCreationFormState>
      get copyWith => __$$_MessageCreationFormStateCopyWithImpl<
          _$_MessageCreationFormState>(this, _$identity);
}

abstract class _MessageCreationFormState extends MessageCreationFormState {
  const factory _MessageCreationFormState(
      {required final String talkAddress,
      required final String text,
      required final bool isCreating}) = _$_MessageCreationFormState;
  const _MessageCreationFormState._() : super._();

  @override
  String get talkAddress;
  @override
  String get text;
  @override
  bool get isCreating;
  @override
  @JsonKey(ignore: true)
  _$$_MessageCreationFormStateCopyWith<_$_MessageCreationFormState>
      get copyWith => throw _privateConstructorUsedError;
}
