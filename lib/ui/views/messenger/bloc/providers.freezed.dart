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
abstract class _$$_CreateDiscussionFormStateCopyWith<$Res>
    implements $CreateDiscussionFormStateCopyWith<$Res> {
  factory _$$_CreateDiscussionFormStateCopyWith(
          _$_CreateDiscussionFormState value,
          $Res Function(_$_CreateDiscussionFormState) then) =
      __$$_CreateDiscussionFormStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, List<Contact> members, List<Contact> admins});
}

/// @nodoc
class __$$_CreateDiscussionFormStateCopyWithImpl<$Res>
    extends _$CreateDiscussionFormStateCopyWithImpl<$Res,
        _$_CreateDiscussionFormState>
    implements _$$_CreateDiscussionFormStateCopyWith<$Res> {
  __$$_CreateDiscussionFormStateCopyWithImpl(
      _$_CreateDiscussionFormState _value,
      $Res Function(_$_CreateDiscussionFormState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? members = null,
    Object? admins = null,
  }) {
    return _then(_$_CreateDiscussionFormState(
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

class _$_CreateDiscussionFormState extends _CreateDiscussionFormState {
  const _$_CreateDiscussionFormState(
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
            other is _$_CreateDiscussionFormState &&
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
  _$$_CreateDiscussionFormStateCopyWith<_$_CreateDiscussionFormState>
      get copyWith => __$$_CreateDiscussionFormStateCopyWithImpl<
          _$_CreateDiscussionFormState>(this, _$identity);
}

abstract class _CreateDiscussionFormState extends CreateDiscussionFormState {
  const factory _CreateDiscussionFormState(
      {final String name,
      final List<Contact> members,
      final List<Contact> admins}) = _$_CreateDiscussionFormState;
  const _CreateDiscussionFormState._() : super._();

  @override
  String get name;
  @override
  List<Contact> get members;
  @override
  List<Contact> get admins;
  @override
  @JsonKey(ignore: true)
  _$$_CreateDiscussionFormStateCopyWith<_$_CreateDiscussionFormState>
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

/// @nodoc
mixin _$UpdateDiscussionFormState {
  String get name => throw _privateConstructorUsedError;
  String get discussionAddress => throw _privateConstructorUsedError;
  List<String> get members => throw _privateConstructorUsedError;
  List<String> get membersToAdd => throw _privateConstructorUsedError;
  List<String> get admins => throw _privateConstructorUsedError;

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
      List<String> admins});
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UpdateDiscussionFormStateCopyWith<$Res>
    implements $UpdateDiscussionFormStateCopyWith<$Res> {
  factory _$$_UpdateDiscussionFormStateCopyWith(
          _$_UpdateDiscussionFormState value,
          $Res Function(_$_UpdateDiscussionFormState) then) =
      __$$_UpdateDiscussionFormStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String discussionAddress,
      List<String> members,
      List<String> membersToAdd,
      List<String> admins});
}

/// @nodoc
class __$$_UpdateDiscussionFormStateCopyWithImpl<$Res>
    extends _$UpdateDiscussionFormStateCopyWithImpl<$Res,
        _$_UpdateDiscussionFormState>
    implements _$$_UpdateDiscussionFormStateCopyWith<$Res> {
  __$$_UpdateDiscussionFormStateCopyWithImpl(
      _$_UpdateDiscussionFormState _value,
      $Res Function(_$_UpdateDiscussionFormState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? discussionAddress = null,
    Object? members = null,
    Object? membersToAdd = null,
    Object? admins = null,
  }) {
    return _then(_$_UpdateDiscussionFormState(
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
    ));
  }
}

/// @nodoc

class _$_UpdateDiscussionFormState extends _UpdateDiscussionFormState {
  const _$_UpdateDiscussionFormState(
      {this.name = '',
      this.discussionAddress = '',
      final List<String> members = const [],
      final List<String> membersToAdd = const [],
      final List<String> admins = const []})
      : _members = members,
        _membersToAdd = membersToAdd,
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

  @override
  String toString() {
    return 'UpdateDiscussionFormState(name: $name, discussionAddress: $discussionAddress, members: $members, membersToAdd: $membersToAdd, admins: $admins)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UpdateDiscussionFormState &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.discussionAddress, discussionAddress) ||
                other.discussionAddress == discussionAddress) &&
            const DeepCollectionEquality().equals(other._members, _members) &&
            const DeepCollectionEquality()
                .equals(other._membersToAdd, _membersToAdd) &&
            const DeepCollectionEquality().equals(other._admins, _admins));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      discussionAddress,
      const DeepCollectionEquality().hash(_members),
      const DeepCollectionEquality().hash(_membersToAdd),
      const DeepCollectionEquality().hash(_admins));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UpdateDiscussionFormStateCopyWith<_$_UpdateDiscussionFormState>
      get copyWith => __$$_UpdateDiscussionFormStateCopyWithImpl<
          _$_UpdateDiscussionFormState>(this, _$identity);
}

abstract class _UpdateDiscussionFormState extends UpdateDiscussionFormState {
  const factory _UpdateDiscussionFormState(
      {final String name,
      final String discussionAddress,
      final List<String> members,
      final List<String> membersToAdd,
      final List<String> admins}) = _$_UpdateDiscussionFormState;
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
  @JsonKey(ignore: true)
  _$$_UpdateDiscussionFormStateCopyWith<_$_UpdateDiscussionFormState>
      get copyWith => throw _privateConstructorUsedError;
}
