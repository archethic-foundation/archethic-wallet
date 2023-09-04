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
mixin _$CreateDiscussionContactFormState {
  String get name => throw _privateConstructorUsedError;
  List<AccessRecipient> get members => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreateDiscussionContactFormStateCopyWith<CreateDiscussionContactFormState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateDiscussionContactFormStateCopyWith<$Res> {
  factory $CreateDiscussionContactFormStateCopyWith(
          CreateDiscussionContactFormState value,
          $Res Function(CreateDiscussionContactFormState) then) =
      _$CreateDiscussionContactFormStateCopyWithImpl<$Res,
          CreateDiscussionContactFormState>;
  @useResult
  $Res call({String name, List<AccessRecipient> members});
}

/// @nodoc
class _$CreateDiscussionContactFormStateCopyWithImpl<$Res,
        $Val extends CreateDiscussionContactFormState>
    implements $CreateDiscussionContactFormStateCopyWith<$Res> {
  _$CreateDiscussionContactFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? members = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      members: null == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<AccessRecipient>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CreateDiscussionContactFormStateCopyWith<$Res>
    implements $CreateDiscussionContactFormStateCopyWith<$Res> {
  factory _$$_CreateDiscussionContactFormStateCopyWith(
          _$_CreateDiscussionContactFormState value,
          $Res Function(_$_CreateDiscussionContactFormState) then) =
      __$$_CreateDiscussionContactFormStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, List<AccessRecipient> members});
}

/// @nodoc
class __$$_CreateDiscussionContactFormStateCopyWithImpl<$Res>
    extends _$CreateDiscussionContactFormStateCopyWithImpl<$Res,
        _$_CreateDiscussionContactFormState>
    implements _$$_CreateDiscussionContactFormStateCopyWith<$Res> {
  __$$_CreateDiscussionContactFormStateCopyWithImpl(
      _$_CreateDiscussionContactFormState _value,
      $Res Function(_$_CreateDiscussionContactFormState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? members = null,
  }) {
    return _then(_$_CreateDiscussionContactFormState(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      members: null == members
          ? _value._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<AccessRecipient>,
    ));
  }
}

/// @nodoc

class _$_CreateDiscussionContactFormState
    extends _CreateDiscussionContactFormState {
  const _$_CreateDiscussionContactFormState(
      {this.name = '', final List<AccessRecipient> members = const []})
      : _members = members,
        super._();

  @override
  @JsonKey()
  final String name;
  final List<AccessRecipient> _members;
  @override
  @JsonKey()
  List<AccessRecipient> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  @override
  String toString() {
    return 'CreateDiscussionContactFormState(name: $name, members: $members)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CreateDiscussionContactFormState &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._members, _members));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, name, const DeepCollectionEquality().hash(_members));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CreateDiscussionContactFormStateCopyWith<
          _$_CreateDiscussionContactFormState>
      get copyWith => __$$_CreateDiscussionContactFormStateCopyWithImpl<
          _$_CreateDiscussionContactFormState>(this, _$identity);
}

abstract class _CreateDiscussionContactFormState
    extends CreateDiscussionContactFormState {
  const factory _CreateDiscussionContactFormState(
          {final String name, final List<AccessRecipient> members}) =
      _$_CreateDiscussionContactFormState;
  const _CreateDiscussionContactFormState._() : super._();

  @override
  String get name;
  @override
  List<AccessRecipient> get members;
  @override
  @JsonKey(ignore: true)
  _$$_CreateDiscussionContactFormStateCopyWith<
          _$_CreateDiscussionContactFormState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CreateDiscussionGroupFormState {
  String get name => throw _privateConstructorUsedError;
  AccessRecipient? get memberAddFieldValue =>
      throw _privateConstructorUsedError;
  List<AccessRecipient> get members => throw _privateConstructorUsedError;
  AccessRecipient? get adminAddFieldValue => throw _privateConstructorUsedError;
  List<AccessRecipient> get admins => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreateDiscussionGroupFormStateCopyWith<CreateDiscussionGroupFormState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateDiscussionGroupFormStateCopyWith<$Res> {
  factory $CreateDiscussionGroupFormStateCopyWith(
          CreateDiscussionGroupFormState value,
          $Res Function(CreateDiscussionGroupFormState) then) =
      _$CreateDiscussionGroupFormStateCopyWithImpl<$Res,
          CreateDiscussionGroupFormState>;
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
class _$CreateDiscussionGroupFormStateCopyWithImpl<$Res,
        $Val extends CreateDiscussionGroupFormState>
    implements $CreateDiscussionGroupFormStateCopyWith<$Res> {
  _$CreateDiscussionGroupFormStateCopyWithImpl(this._value, this._then);

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
abstract class _$$_CreateDiscussionGroupFormStateCopyWith<$Res>
    implements $CreateDiscussionGroupFormStateCopyWith<$Res> {
  factory _$$_CreateDiscussionGroupFormStateCopyWith(
          _$_CreateDiscussionGroupFormState value,
          $Res Function(_$_CreateDiscussionGroupFormState) then) =
      __$$_CreateDiscussionGroupFormStateCopyWithImpl<$Res>;
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
class __$$_CreateDiscussionGroupFormStateCopyWithImpl<$Res>
    extends _$CreateDiscussionGroupFormStateCopyWithImpl<$Res,
        _$_CreateDiscussionGroupFormState>
    implements _$$_CreateDiscussionGroupFormStateCopyWith<$Res> {
  __$$_CreateDiscussionGroupFormStateCopyWithImpl(
      _$_CreateDiscussionGroupFormState _value,
      $Res Function(_$_CreateDiscussionGroupFormState) _then)
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
    return _then(_$_CreateDiscussionGroupFormState(
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

class _$_CreateDiscussionGroupFormState
    extends _CreateDiscussionGroupFormState {
  const _$_CreateDiscussionGroupFormState(
      {this.name = '',
      this.memberAddFieldValue,
      final List<AccessRecipient> members = const [],
      this.adminAddFieldValue,
      final List<AccessRecipient> admins = const []})
      : _members = members,
        _admins = admins,
        super._();

  @override
  @JsonKey()
  final String name;
  @override
  final AccessRecipient? memberAddFieldValue;
  final List<AccessRecipient> _members;
  @override
  @JsonKey()
  List<AccessRecipient> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  @override
  final AccessRecipient? adminAddFieldValue;
  final List<AccessRecipient> _admins;
  @override
  @JsonKey()
  List<AccessRecipient> get admins {
    if (_admins is EqualUnmodifiableListView) return _admins;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_admins);
  }

  @override
  String toString() {
    return 'CreateDiscussionGroupFormState(name: $name, memberAddFieldValue: $memberAddFieldValue, members: $members, adminAddFieldValue: $adminAddFieldValue, admins: $admins)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CreateDiscussionGroupFormState &&
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
  _$$_CreateDiscussionGroupFormStateCopyWith<_$_CreateDiscussionGroupFormState>
      get copyWith => __$$_CreateDiscussionGroupFormStateCopyWithImpl<
          _$_CreateDiscussionGroupFormState>(this, _$identity);
}

abstract class _CreateDiscussionGroupFormState
    extends CreateDiscussionGroupFormState {
  const factory _CreateDiscussionGroupFormState(
      {final String name,
      final AccessRecipient? memberAddFieldValue,
      final List<AccessRecipient> members,
      final AccessRecipient? adminAddFieldValue,
      final List<AccessRecipient> admins}) = _$_CreateDiscussionGroupFormState;
  const _CreateDiscussionGroupFormState._() : super._();

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
  _$$_CreateDiscussionGroupFormStateCopyWith<_$_CreateDiscussionGroupFormState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MessageCreationFormState {
  String get discussionAddress => throw _privateConstructorUsedError;
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
  $Res call({String discussionAddress, String text, bool isCreating});
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
    Object? discussionAddress = null,
    Object? text = null,
    Object? isCreating = null,
  }) {
    return _then(_value.copyWith(
      discussionAddress: null == discussionAddress
          ? _value.discussionAddress
          : discussionAddress // ignore: cast_nullable_to_non_nullable
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
  $Res call({String discussionAddress, String text, bool isCreating});
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
    Object? discussionAddress = null,
    Object? text = null,
    Object? isCreating = null,
  }) {
    return _then(_$_MessageCreationFormState(
      discussionAddress: null == discussionAddress
          ? _value.discussionAddress
          : discussionAddress // ignore: cast_nullable_to_non_nullable
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
      {required this.discussionAddress,
      required this.text,
      required this.isCreating})
      : super._();

  @override
  final String discussionAddress;
  @override
  final String text;
  @override
  final bool isCreating;

  @override
  String toString() {
    return 'MessageCreationFormState(discussionAddress: $discussionAddress, text: $text, isCreating: $isCreating)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MessageCreationFormState &&
            (identical(other.discussionAddress, discussionAddress) ||
                other.discussionAddress == discussionAddress) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.isCreating, isCreating) ||
                other.isCreating == isCreating));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, discussionAddress, text, isCreating);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MessageCreationFormStateCopyWith<_$_MessageCreationFormState>
      get copyWith => __$$_MessageCreationFormStateCopyWithImpl<
          _$_MessageCreationFormState>(this, _$identity);
}

abstract class _MessageCreationFormState extends MessageCreationFormState {
  const factory _MessageCreationFormState(
      {required final String discussionAddress,
      required final String text,
      required final bool isCreating}) = _$_MessageCreationFormState;
  const _MessageCreationFormState._() : super._();

  @override
  String get discussionAddress;
  @override
  String get text;
  @override
  bool get isCreating;
  @override
  @JsonKey(ignore: true)
  _$$_MessageCreationFormStateCopyWith<_$_MessageCreationFormState>
      get copyWith => throw _privateConstructorUsedError;
}
