// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'discussion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Discussion {
  @HiveField(0)
  String get address => throw _privateConstructorUsedError;
  @HiveField(1)
  String? get name => throw _privateConstructorUsedError;
  @HiveField(2)
  List<String> get membersPubKeys => throw _privateConstructorUsedError;
  @HiveField(3)
  List<String> get adminsPubKeys => throw _privateConstructorUsedError;
  @HiveField(4)
  DateTime get creationDate => throw _privateConstructorUsedError;
  @HiveField(5)
  DiscussionMessage? get lastMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DiscussionCopyWith<Discussion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscussionCopyWith<$Res> {
  factory $DiscussionCopyWith(
          Discussion value, $Res Function(Discussion) then) =
      _$DiscussionCopyWithImpl<$Res, Discussion>;
  @useResult
  $Res call(
      {@HiveField(0) String address,
      @HiveField(1) String? name,
      @HiveField(2) List<String> membersPubKeys,
      @HiveField(3) List<String> adminsPubKeys,
      @HiveField(4) DateTime creationDate,
      @HiveField(5) DiscussionMessage? lastMessage});

  $DiscussionMessageCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class _$DiscussionCopyWithImpl<$Res, $Val extends Discussion>
    implements $DiscussionCopyWith<$Res> {
  _$DiscussionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? name = freezed,
    Object? membersPubKeys = null,
    Object? adminsPubKeys = null,
    Object? creationDate = null,
    Object? lastMessage = freezed,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      membersPubKeys: null == membersPubKeys
          ? _value.membersPubKeys
          : membersPubKeys // ignore: cast_nullable_to_non_nullable
              as List<String>,
      adminsPubKeys: null == adminsPubKeys
          ? _value.adminsPubKeys
          : adminsPubKeys // ignore: cast_nullable_to_non_nullable
              as List<String>,
      creationDate: null == creationDate
          ? _value.creationDate
          : creationDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as DiscussionMessage?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DiscussionMessageCopyWith<$Res>? get lastMessage {
    if (_value.lastMessage == null) {
      return null;
    }

    return $DiscussionMessageCopyWith<$Res>(_value.lastMessage!, (value) {
      return _then(_value.copyWith(lastMessage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_DiscussionCopyWith<$Res>
    implements $DiscussionCopyWith<$Res> {
  factory _$$_DiscussionCopyWith(
          _$_Discussion value, $Res Function(_$_Discussion) then) =
      __$$_DiscussionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String address,
      @HiveField(1) String? name,
      @HiveField(2) List<String> membersPubKeys,
      @HiveField(3) List<String> adminsPubKeys,
      @HiveField(4) DateTime creationDate,
      @HiveField(5) DiscussionMessage? lastMessage});

  @override
  $DiscussionMessageCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class __$$_DiscussionCopyWithImpl<$Res>
    extends _$DiscussionCopyWithImpl<$Res, _$_Discussion>
    implements _$$_DiscussionCopyWith<$Res> {
  __$$_DiscussionCopyWithImpl(
      _$_Discussion _value, $Res Function(_$_Discussion) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? name = freezed,
    Object? membersPubKeys = null,
    Object? adminsPubKeys = null,
    Object? creationDate = null,
    Object? lastMessage = freezed,
  }) {
    return _then(_$_Discussion(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      membersPubKeys: null == membersPubKeys
          ? _value._membersPubKeys
          : membersPubKeys // ignore: cast_nullable_to_non_nullable
              as List<String>,
      adminsPubKeys: null == adminsPubKeys
          ? _value._adminsPubKeys
          : adminsPubKeys // ignore: cast_nullable_to_non_nullable
              as List<String>,
      creationDate: null == creationDate
          ? _value.creationDate
          : creationDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as DiscussionMessage?,
    ));
  }
}

/// @nodoc

@HiveType(typeId: HiveTypeIds.discussion)
class _$_Discussion extends _Discussion {
  const _$_Discussion(
      {@HiveField(0) required this.address,
      @HiveField(1) this.name,
      @HiveField(2) required final List<String> membersPubKeys,
      @HiveField(3) required final List<String> adminsPubKeys,
      @HiveField(4) required this.creationDate,
      @HiveField(5) this.lastMessage})
      : _membersPubKeys = membersPubKeys,
        _adminsPubKeys = adminsPubKeys,
        super._();

  @override
  @HiveField(0)
  final String address;
  @override
  @HiveField(1)
  final String? name;
  final List<String> _membersPubKeys;
  @override
  @HiveField(2)
  List<String> get membersPubKeys {
    if (_membersPubKeys is EqualUnmodifiableListView) return _membersPubKeys;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_membersPubKeys);
  }

  final List<String> _adminsPubKeys;
  @override
  @HiveField(3)
  List<String> get adminsPubKeys {
    if (_adminsPubKeys is EqualUnmodifiableListView) return _adminsPubKeys;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_adminsPubKeys);
  }

  @override
  @HiveField(4)
  final DateTime creationDate;
  @override
  @HiveField(5)
  final DiscussionMessage? lastMessage;

  @override
  String toString() {
    return 'Discussion(address: $address, name: $name, membersPubKeys: $membersPubKeys, adminsPubKeys: $adminsPubKeys, creationDate: $creationDate, lastMessage: $lastMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Discussion &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._membersPubKeys, _membersPubKeys) &&
            const DeepCollectionEquality()
                .equals(other._adminsPubKeys, _adminsPubKeys) &&
            (identical(other.creationDate, creationDate) ||
                other.creationDate == creationDate) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      address,
      name,
      const DeepCollectionEquality().hash(_membersPubKeys),
      const DeepCollectionEquality().hash(_adminsPubKeys),
      creationDate,
      lastMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DiscussionCopyWith<_$_Discussion> get copyWith =>
      __$$_DiscussionCopyWithImpl<_$_Discussion>(this, _$identity);
}

abstract class _Discussion extends Discussion {
  const factory _Discussion(
      {@HiveField(0) required final String address,
      @HiveField(1) final String? name,
      @HiveField(2) required final List<String> membersPubKeys,
      @HiveField(3) required final List<String> adminsPubKeys,
      @HiveField(4) required final DateTime creationDate,
      @HiveField(5) final DiscussionMessage? lastMessage}) = _$_Discussion;
  const _Discussion._() : super._();

  @override
  @HiveField(0)
  String get address;
  @override
  @HiveField(1)
  String? get name;
  @override
  @HiveField(2)
  List<String> get membersPubKeys;
  @override
  @HiveField(3)
  List<String> get adminsPubKeys;
  @override
  @HiveField(4)
  DateTime get creationDate;
  @override
  @HiveField(5)
  DiscussionMessage? get lastMessage;
  @override
  @JsonKey(ignore: true)
  _$$_DiscussionCopyWith<_$_Discussion> get copyWith =>
      throw _privateConstructorUsedError;
}
