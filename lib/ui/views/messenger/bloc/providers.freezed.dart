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
mixin _$CreateDiscussionFormState {
  String get name => throw _privateConstructorUsedError;
  List<Contact> get members => throw _privateConstructorUsedError;
  List<Contact> get admins => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreateDiscussionFormStateCopyWith<CreateDiscussionFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateDiscussionFormStateCopyWith<$Res> {
  factory $CreateDiscussionFormStateCopyWith(CreateDiscussionFormState value,
          $Res Function(CreateDiscussionFormState) then) =
      _$CreateDiscussionFormStateCopyWithImpl<$Res, CreateDiscussionFormState>;
  @useResult
  $Res call({String name, List<Contact> members, List<Contact> admins});
}

/// @nodoc
class _$CreateDiscussionFormStateCopyWithImpl<$Res,
        $Val extends CreateDiscussionFormState>
    implements $CreateDiscussionFormStateCopyWith<$Res> {
  _$CreateDiscussionFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? members = null,
    Object? admins = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      members: null == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<Contact>,
      admins: null == admins
          ? _value.admins
          : admins // ignore: cast_nullable_to_non_nullable
              as List<Contact>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateDiscussionFormStateImplCopyWith<$Res>
    implements $CreateDiscussionFormStateCopyWith<$Res> {
  factory _$$CreateDiscussionFormStateImplCopyWith(
          _$CreateDiscussionFormStateImpl value,
          $Res Function(_$CreateDiscussionFormStateImpl) then) =
      __$$CreateDiscussionFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, List<Contact> members, List<Contact> admins});
}

/// @nodoc
class __$$CreateDiscussionFormStateImplCopyWithImpl<$Res>
    extends _$CreateDiscussionFormStateCopyWithImpl<$Res,
        _$CreateDiscussionFormStateImpl>
    implements _$$CreateDiscussionFormStateImplCopyWith<$Res> {
  __$$CreateDiscussionFormStateImplCopyWithImpl(
      _$CreateDiscussionFormStateImpl _value,
      $Res Function(_$CreateDiscussionFormStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? members = null,
    Object? admins = null,
  }) {
    return _then(_$CreateDiscussionFormStateImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      members: null == members
          ? _value._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<Contact>,
      admins: null == admins
          ? _value._admins
          : admins // ignore: cast_nullable_to_non_nullable
              as List<Contact>,
    ));
  }
}

/// @nodoc

class _$CreateDiscussionFormStateImpl extends _CreateDiscussionFormState {
  const _$CreateDiscussionFormStateImpl(
      {this.name = '',
      final List<Contact> members = const [],
      final List<Contact> admins = const []})
      : _members = members,
        _admins = admins,
        super._();

  @override
  @JsonKey()
  final String name;
  final List<Contact> _members;
  @override
  @JsonKey()
  List<Contact> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  final List<Contact> _admins;
  @override
  @JsonKey()
  List<Contact> get admins {
    if (_admins is EqualUnmodifiableListView) return _admins;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_admins);
  }

  @override
  String toString() {
    return 'CreateDiscussionFormState(name: $name, members: $members, admins: $admins)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateDiscussionFormStateImpl &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._members, _members) &&
            const DeepCollectionEquality().equals(other._admins, _admins));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      const DeepCollectionEquality().hash(_members),
      const DeepCollectionEquality().hash(_admins));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateDiscussionFormStateImplCopyWith<_$CreateDiscussionFormStateImpl>
      get copyWith => __$$CreateDiscussionFormStateImplCopyWithImpl<
          _$CreateDiscussionFormStateImpl>(this, _$identity);
}

abstract class _CreateDiscussionFormState extends CreateDiscussionFormState {
  const factory _CreateDiscussionFormState(
      {final String name,
      final List<Contact> members,
      final List<Contact> admins}) = _$CreateDiscussionFormStateImpl;
  const _CreateDiscussionFormState._() : super._();

  @override
  String get name;
  @override
  List<Contact> get members;
  @override
  List<Contact> get admins;
  @override
  @JsonKey(ignore: true)
  _$$CreateDiscussionFormStateImplCopyWith<_$CreateDiscussionFormStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DiscussionDetailsFormState {
  String get name => throw _privateConstructorUsedError;
  String get discussionAddress => throw _privateConstructorUsedError;
  List<String> get members => throw _privateConstructorUsedError;
  List<String> get admins => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DiscussionDetailsFormStateCopyWith<DiscussionDetailsFormState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscussionDetailsFormStateCopyWith<$Res> {
  factory $DiscussionDetailsFormStateCopyWith(DiscussionDetailsFormState value,
          $Res Function(DiscussionDetailsFormState) then) =
      _$DiscussionDetailsFormStateCopyWithImpl<$Res,
          DiscussionDetailsFormState>;
  @useResult
  $Res call(
      {String name,
      String discussionAddress,
      List<String> members,
      List<String> admins});
}

/// @nodoc
class _$DiscussionDetailsFormStateCopyWithImpl<$Res,
        $Val extends DiscussionDetailsFormState>
    implements $DiscussionDetailsFormStateCopyWith<$Res> {
  _$DiscussionDetailsFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? discussionAddress = null,
    Object? members = null,
    Object? admins = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      discussionAddress: null == discussionAddress
          ? _value.discussionAddress
          : discussionAddress // ignore: cast_nullable_to_non_nullable
              as String,
      members: null == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<String>,
      admins: null == admins
          ? _value.admins
          : admins // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DiscussionDetailsFormStateImplCopyWith<$Res>
    implements $DiscussionDetailsFormStateCopyWith<$Res> {
  factory _$$DiscussionDetailsFormStateImplCopyWith(
          _$DiscussionDetailsFormStateImpl value,
          $Res Function(_$DiscussionDetailsFormStateImpl) then) =
      __$$DiscussionDetailsFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String discussionAddress,
      List<String> members,
      List<String> admins});
}

/// @nodoc
class __$$DiscussionDetailsFormStateImplCopyWithImpl<$Res>
    extends _$DiscussionDetailsFormStateCopyWithImpl<$Res,
        _$DiscussionDetailsFormStateImpl>
    implements _$$DiscussionDetailsFormStateImplCopyWith<$Res> {
  __$$DiscussionDetailsFormStateImplCopyWithImpl(
      _$DiscussionDetailsFormStateImpl _value,
      $Res Function(_$DiscussionDetailsFormStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? discussionAddress = null,
    Object? members = null,
    Object? admins = null,
  }) {
    return _then(_$DiscussionDetailsFormStateImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      discussionAddress: null == discussionAddress
          ? _value.discussionAddress
          : discussionAddress // ignore: cast_nullable_to_non_nullable
              as String,
      members: null == members
          ? _value._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<String>,
      admins: null == admins
          ? _value._admins
          : admins // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$DiscussionDetailsFormStateImpl extends _DiscussionDetailsFormState {
  const _$DiscussionDetailsFormStateImpl(
      {this.name = '',
      this.discussionAddress = '',
      final List<String> members = const [],
      final List<String> admins = const []})
      : _members = members,
        _admins = admins,
        super._();

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String discussionAddress;
  final List<String> _members;
  @override
  @JsonKey()
  List<String> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  final List<String> _admins;
  @override
  @JsonKey()
  List<String> get admins {
    if (_admins is EqualUnmodifiableListView) return _admins;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_admins);
  }

  @override
  String toString() {
    return 'DiscussionDetailsFormState(name: $name, discussionAddress: $discussionAddress, members: $members, admins: $admins)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscussionDetailsFormStateImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.discussionAddress, discussionAddress) ||
                other.discussionAddress == discussionAddress) &&
            const DeepCollectionEquality().equals(other._members, _members) &&
            const DeepCollectionEquality().equals(other._admins, _admins));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      discussionAddress,
      const DeepCollectionEquality().hash(_members),
      const DeepCollectionEquality().hash(_admins));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscussionDetailsFormStateImplCopyWith<_$DiscussionDetailsFormStateImpl>
      get copyWith => __$$DiscussionDetailsFormStateImplCopyWithImpl<
          _$DiscussionDetailsFormStateImpl>(this, _$identity);
}

abstract class _DiscussionDetailsFormState extends DiscussionDetailsFormState {
  const factory _DiscussionDetailsFormState(
      {final String name,
      final String discussionAddress,
      final List<String> members,
      final List<String> admins}) = _$DiscussionDetailsFormStateImpl;
  const _DiscussionDetailsFormState._() : super._();

  @override
  String get name;
  @override
  String get discussionAddress;
  @override
  List<String> get members;
  @override
  List<String> get admins;
  @override
  @JsonKey(ignore: true)
  _$$DiscussionDetailsFormStateImplCopyWith<_$DiscussionDetailsFormStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MessageCreationFormState {
  Discussion get discussion => throw _privateConstructorUsedError;
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
  $Res call({Discussion discussion, String text, bool isCreating});

  $DiscussionCopyWith<$Res> get discussion;
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
    Object? discussion = null,
    Object? text = null,
    Object? isCreating = null,
  }) {
    return _then(_value.copyWith(
      discussion: null == discussion
          ? _value.discussion
          : discussion // ignore: cast_nullable_to_non_nullable
              as Discussion,
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

  @override
  @pragma('vm:prefer-inline')
  $DiscussionCopyWith<$Res> get discussion {
    return $DiscussionCopyWith<$Res>(_value.discussion, (value) {
      return _then(_value.copyWith(discussion: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MessageCreationFormStateImplCopyWith<$Res>
    implements $MessageCreationFormStateCopyWith<$Res> {
  factory _$$MessageCreationFormStateImplCopyWith(
          _$MessageCreationFormStateImpl value,
          $Res Function(_$MessageCreationFormStateImpl) then) =
      __$$MessageCreationFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Discussion discussion, String text, bool isCreating});

  @override
  $DiscussionCopyWith<$Res> get discussion;
}

/// @nodoc
class __$$MessageCreationFormStateImplCopyWithImpl<$Res>
    extends _$MessageCreationFormStateCopyWithImpl<$Res,
        _$MessageCreationFormStateImpl>
    implements _$$MessageCreationFormStateImplCopyWith<$Res> {
  __$$MessageCreationFormStateImplCopyWithImpl(
      _$MessageCreationFormStateImpl _value,
      $Res Function(_$MessageCreationFormStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? discussion = null,
    Object? text = null,
    Object? isCreating = null,
  }) {
    return _then(_$MessageCreationFormStateImpl(
      discussion: null == discussion
          ? _value.discussion
          : discussion // ignore: cast_nullable_to_non_nullable
              as Discussion,
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

class _$MessageCreationFormStateImpl extends _MessageCreationFormState {
  const _$MessageCreationFormStateImpl(
      {required this.discussion, required this.text, required this.isCreating})
      : super._();

  @override
  final Discussion discussion;
  @override
  final String text;
  @override
  final bool isCreating;

  @override
  String toString() {
    return 'MessageCreationFormState(discussion: $discussion, text: $text, isCreating: $isCreating)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageCreationFormStateImpl &&
            (identical(other.discussion, discussion) ||
                other.discussion == discussion) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.isCreating, isCreating) ||
                other.isCreating == isCreating));
  }

  @override
  int get hashCode => Object.hash(runtimeType, discussion, text, isCreating);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageCreationFormStateImplCopyWith<_$MessageCreationFormStateImpl>
      get copyWith => __$$MessageCreationFormStateImplCopyWithImpl<
          _$MessageCreationFormStateImpl>(this, _$identity);
}

abstract class _MessageCreationFormState extends MessageCreationFormState {
  const factory _MessageCreationFormState(
      {required final Discussion discussion,
      required final String text,
      required final bool isCreating}) = _$MessageCreationFormStateImpl;
  const _MessageCreationFormState._() : super._();

  @override
  Discussion get discussion;
  @override
  String get text;
  @override
  bool get isCreating;
  @override
  @JsonKey(ignore: true)
  _$$MessageCreationFormStateImplCopyWith<_$MessageCreationFormStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$UpdateDiscussionFormState {
  String get name => throw _privateConstructorUsedError;
  String get discussionAddress => throw _privateConstructorUsedError;
  List<String> get members => throw _privateConstructorUsedError;
  List<String> get membersToAdd => throw _privateConstructorUsedError;
  List<String> get admins => throw _privateConstructorUsedError;
  List<String> get initialMembers => throw _privateConstructorUsedError;
  List<String> get initialAdmins => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UpdateDiscussionFormStateCopyWith<UpdateDiscussionFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateDiscussionFormStateCopyWith<$Res> {
  factory $UpdateDiscussionFormStateCopyWith(UpdateDiscussionFormState value,
          $Res Function(UpdateDiscussionFormState) then) =
      _$UpdateDiscussionFormStateCopyWithImpl<$Res, UpdateDiscussionFormState>;
  @useResult
  $Res call(
      {String name,
      String discussionAddress,
      List<String> members,
      List<String> membersToAdd,
      List<String> admins,
      List<String> initialMembers,
      List<String> initialAdmins});
}

/// @nodoc
class _$UpdateDiscussionFormStateCopyWithImpl<$Res,
        $Val extends UpdateDiscussionFormState>
    implements $UpdateDiscussionFormStateCopyWith<$Res> {
  _$UpdateDiscussionFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? discussionAddress = null,
    Object? members = null,
    Object? membersToAdd = null,
    Object? admins = null,
    Object? initialMembers = null,
    Object? initialAdmins = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      discussionAddress: null == discussionAddress
          ? _value.discussionAddress
          : discussionAddress // ignore: cast_nullable_to_non_nullable
              as String,
      members: null == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<String>,
      membersToAdd: null == membersToAdd
          ? _value.membersToAdd
          : membersToAdd // ignore: cast_nullable_to_non_nullable
              as List<String>,
      admins: null == admins
          ? _value.admins
          : admins // ignore: cast_nullable_to_non_nullable
              as List<String>,
      initialMembers: null == initialMembers
          ? _value.initialMembers
          : initialMembers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      initialAdmins: null == initialAdmins
          ? _value.initialAdmins
          : initialAdmins // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdateDiscussionFormStateImplCopyWith<$Res>
    implements $UpdateDiscussionFormStateCopyWith<$Res> {
  factory _$$UpdateDiscussionFormStateImplCopyWith(
          _$UpdateDiscussionFormStateImpl value,
          $Res Function(_$UpdateDiscussionFormStateImpl) then) =
      __$$UpdateDiscussionFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String discussionAddress,
      List<String> members,
      List<String> membersToAdd,
      List<String> admins,
      List<String> initialMembers,
      List<String> initialAdmins});
}

/// @nodoc
class __$$UpdateDiscussionFormStateImplCopyWithImpl<$Res>
    extends _$UpdateDiscussionFormStateCopyWithImpl<$Res,
        _$UpdateDiscussionFormStateImpl>
    implements _$$UpdateDiscussionFormStateImplCopyWith<$Res> {
  __$$UpdateDiscussionFormStateImplCopyWithImpl(
      _$UpdateDiscussionFormStateImpl _value,
      $Res Function(_$UpdateDiscussionFormStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? discussionAddress = null,
    Object? members = null,
    Object? membersToAdd = null,
    Object? admins = null,
    Object? initialMembers = null,
    Object? initialAdmins = null,
  }) {
    return _then(_$UpdateDiscussionFormStateImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      discussionAddress: null == discussionAddress
          ? _value.discussionAddress
          : discussionAddress // ignore: cast_nullable_to_non_nullable
              as String,
      members: null == members
          ? _value._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<String>,
      membersToAdd: null == membersToAdd
          ? _value._membersToAdd
          : membersToAdd // ignore: cast_nullable_to_non_nullable
              as List<String>,
      admins: null == admins
          ? _value._admins
          : admins // ignore: cast_nullable_to_non_nullable
              as List<String>,
      initialMembers: null == initialMembers
          ? _value._initialMembers
          : initialMembers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      initialAdmins: null == initialAdmins
          ? _value._initialAdmins
          : initialAdmins // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$UpdateDiscussionFormStateImpl extends _UpdateDiscussionFormState {
  const _$UpdateDiscussionFormStateImpl(
      {this.name = '',
      this.discussionAddress = '',
      final List<String> members = const [],
      final List<String> membersToAdd = const [],
      final List<String> admins = const [],
      final List<String> initialMembers = const [],
      final List<String> initialAdmins = const []})
      : _members = members,
        _membersToAdd = membersToAdd,
        _admins = admins,
        _initialMembers = initialMembers,
        _initialAdmins = initialAdmins,
        super._();

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String discussionAddress;
  final List<String> _members;
  @override
  @JsonKey()
  List<String> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  final List<String> _membersToAdd;
  @override
  @JsonKey()
  List<String> get membersToAdd {
    if (_membersToAdd is EqualUnmodifiableListView) return _membersToAdd;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_membersToAdd);
  }

  final List<String> _admins;
  @override
  @JsonKey()
  List<String> get admins {
    if (_admins is EqualUnmodifiableListView) return _admins;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_admins);
  }

  final List<String> _initialMembers;
  @override
  @JsonKey()
  List<String> get initialMembers {
    if (_initialMembers is EqualUnmodifiableListView) return _initialMembers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_initialMembers);
  }

  final List<String> _initialAdmins;
  @override
  @JsonKey()
  List<String> get initialAdmins {
    if (_initialAdmins is EqualUnmodifiableListView) return _initialAdmins;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_initialAdmins);
  }

  @override
  String toString() {
    return 'UpdateDiscussionFormState(name: $name, discussionAddress: $discussionAddress, members: $members, membersToAdd: $membersToAdd, admins: $admins, initialMembers: $initialMembers, initialAdmins: $initialAdmins)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateDiscussionFormStateImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.discussionAddress, discussionAddress) ||
                other.discussionAddress == discussionAddress) &&
            const DeepCollectionEquality().equals(other._members, _members) &&
            const DeepCollectionEquality()
                .equals(other._membersToAdd, _membersToAdd) &&
            const DeepCollectionEquality().equals(other._admins, _admins) &&
            const DeepCollectionEquality()
                .equals(other._initialMembers, _initialMembers) &&
            const DeepCollectionEquality()
                .equals(other._initialAdmins, _initialAdmins));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      discussionAddress,
      const DeepCollectionEquality().hash(_members),
      const DeepCollectionEquality().hash(_membersToAdd),
      const DeepCollectionEquality().hash(_admins),
      const DeepCollectionEquality().hash(_initialMembers),
      const DeepCollectionEquality().hash(_initialAdmins));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateDiscussionFormStateImplCopyWith<_$UpdateDiscussionFormStateImpl>
      get copyWith => __$$UpdateDiscussionFormStateImplCopyWithImpl<
          _$UpdateDiscussionFormStateImpl>(this, _$identity);
}

abstract class _UpdateDiscussionFormState extends UpdateDiscussionFormState {
  const factory _UpdateDiscussionFormState(
      {final String name,
      final String discussionAddress,
      final List<String> members,
      final List<String> membersToAdd,
      final List<String> admins,
      final List<String> initialMembers,
      final List<String> initialAdmins}) = _$UpdateDiscussionFormStateImpl;
  const _UpdateDiscussionFormState._() : super._();

  @override
  String get name;
  @override
  String get discussionAddress;
  @override
  List<String> get members;
  @override
  List<String> get membersToAdd;
  @override
  List<String> get admins;
  @override
  List<String> get initialMembers;
  @override
  List<String> get initialAdmins;
  @override
  @JsonKey(ignore: true)
  _$$UpdateDiscussionFormStateImplCopyWith<_$UpdateDiscussionFormStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
