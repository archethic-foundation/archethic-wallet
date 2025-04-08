// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ae_discussion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AEDiscussion _$AEDiscussionFromJson(Map<String, dynamic> json) {
  return _AEDiscussion.fromJson(json);
}

/// @nodoc
mixin _$AEDiscussion {
  String get discussionName => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  List<String> get usersPubKey => throw _privateConstructorUsedError;
  List<String> get adminPublicKey => throw _privateConstructorUsedError;
  int get timestampLastUpdate => throw _privateConstructorUsedError;

  /// Serializes this AEDiscussion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AEDiscussion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AEDiscussionCopyWith<AEDiscussion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AEDiscussionCopyWith<$Res> {
  factory $AEDiscussionCopyWith(
          AEDiscussion value, $Res Function(AEDiscussion) then) =
      _$AEDiscussionCopyWithImpl<$Res, AEDiscussion>;
  @useResult
  $Res call(
      {String discussionName,
      String address,
      List<String> usersPubKey,
      List<String> adminPublicKey,
      int timestampLastUpdate});
}

/// @nodoc
class _$AEDiscussionCopyWithImpl<$Res, $Val extends AEDiscussion>
    implements $AEDiscussionCopyWith<$Res> {
  _$AEDiscussionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AEDiscussion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? discussionName = null,
    Object? address = null,
    Object? usersPubKey = null,
    Object? adminPublicKey = null,
    Object? timestampLastUpdate = null,
  }) {
    return _then(_value.copyWith(
      discussionName: null == discussionName
          ? _value.discussionName
          : discussionName // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      usersPubKey: null == usersPubKey
          ? _value.usersPubKey
          : usersPubKey // ignore: cast_nullable_to_non_nullable
              as List<String>,
      adminPublicKey: null == adminPublicKey
          ? _value.adminPublicKey
          : adminPublicKey // ignore: cast_nullable_to_non_nullable
              as List<String>,
      timestampLastUpdate: null == timestampLastUpdate
          ? _value.timestampLastUpdate
          : timestampLastUpdate // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AEDiscussionImplCopyWith<$Res>
    implements $AEDiscussionCopyWith<$Res> {
  factory _$$AEDiscussionImplCopyWith(
          _$AEDiscussionImpl value, $Res Function(_$AEDiscussionImpl) then) =
      __$$AEDiscussionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String discussionName,
      String address,
      List<String> usersPubKey,
      List<String> adminPublicKey,
      int timestampLastUpdate});
}

/// @nodoc
class __$$AEDiscussionImplCopyWithImpl<$Res>
    extends _$AEDiscussionCopyWithImpl<$Res, _$AEDiscussionImpl>
    implements _$$AEDiscussionImplCopyWith<$Res> {
  __$$AEDiscussionImplCopyWithImpl(
      _$AEDiscussionImpl _value, $Res Function(_$AEDiscussionImpl) _then)
      : super(_value, _then);

  /// Create a copy of AEDiscussion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? discussionName = null,
    Object? address = null,
    Object? usersPubKey = null,
    Object? adminPublicKey = null,
    Object? timestampLastUpdate = null,
  }) {
    return _then(_$AEDiscussionImpl(
      discussionName: null == discussionName
          ? _value.discussionName
          : discussionName // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      usersPubKey: null == usersPubKey
          ? _value._usersPubKey
          : usersPubKey // ignore: cast_nullable_to_non_nullable
              as List<String>,
      adminPublicKey: null == adminPublicKey
          ? _value._adminPublicKey
          : adminPublicKey // ignore: cast_nullable_to_non_nullable
              as List<String>,
      timestampLastUpdate: null == timestampLastUpdate
          ? _value.timestampLastUpdate
          : timestampLastUpdate // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AEDiscussionImpl extends _AEDiscussion {
  const _$AEDiscussionImpl(
      {this.discussionName = '',
      this.address = '',
      final List<String> usersPubKey = const [],
      final List<String> adminPublicKey = const [],
      this.timestampLastUpdate = 0})
      : _usersPubKey = usersPubKey,
        _adminPublicKey = adminPublicKey,
        super._();

  factory _$AEDiscussionImpl.fromJson(Map<String, dynamic> json) =>
      _$$AEDiscussionImplFromJson(json);

  @override
  @JsonKey()
  final String discussionName;
  @override
  @JsonKey()
  final String address;
  final List<String> _usersPubKey;
  @override
  @JsonKey()
  List<String> get usersPubKey {
    if (_usersPubKey is EqualUnmodifiableListView) return _usersPubKey;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_usersPubKey);
  }

  final List<String> _adminPublicKey;
  @override
  @JsonKey()
  List<String> get adminPublicKey {
    if (_adminPublicKey is EqualUnmodifiableListView) return _adminPublicKey;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_adminPublicKey);
  }

  @override
  @JsonKey()
  final int timestampLastUpdate;

  @override
  String toString() {
    return 'AEDiscussion(discussionName: $discussionName, address: $address, usersPubKey: $usersPubKey, adminPublicKey: $adminPublicKey, timestampLastUpdate: $timestampLastUpdate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AEDiscussionImpl &&
            (identical(other.discussionName, discussionName) ||
                other.discussionName == discussionName) &&
            (identical(other.address, address) || other.address == address) &&
            const DeepCollectionEquality()
                .equals(other._usersPubKey, _usersPubKey) &&
            const DeepCollectionEquality()
                .equals(other._adminPublicKey, _adminPublicKey) &&
            (identical(other.timestampLastUpdate, timestampLastUpdate) ||
                other.timestampLastUpdate == timestampLastUpdate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      discussionName,
      address,
      const DeepCollectionEquality().hash(_usersPubKey),
      const DeepCollectionEquality().hash(_adminPublicKey),
      timestampLastUpdate);

  /// Create a copy of AEDiscussion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AEDiscussionImplCopyWith<_$AEDiscussionImpl> get copyWith =>
      __$$AEDiscussionImplCopyWithImpl<_$AEDiscussionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AEDiscussionImplToJson(
      this,
    );
  }
}

abstract class _AEDiscussion extends AEDiscussion {
  const factory _AEDiscussion(
      {final String discussionName,
      final String address,
      final List<String> usersPubKey,
      final List<String> adminPublicKey,
      final int timestampLastUpdate}) = _$AEDiscussionImpl;
  const _AEDiscussion._() : super._();

  factory _AEDiscussion.fromJson(Map<String, dynamic> json) =
      _$AEDiscussionImpl.fromJson;

  @override
  String get discussionName;
  @override
  String get address;
  @override
  List<String> get usersPubKey;
  @override
  List<String> get adminPublicKey;
  @override
  int get timestampLastUpdate;

  /// Create a copy of AEDiscussion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AEDiscussionImplCopyWith<_$AEDiscussionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
