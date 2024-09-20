// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_farm_lock_user_infos_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetFarmLockUserInfosResponse _$GetFarmLockUserInfosResponseFromJson(
    Map<String, dynamic> json) {
  return _GetFarmLockUserInfosResponse.fromJson(json);
}

/// @nodoc
mixin _$GetFarmLockUserInfosResponse {
  List<Map<int, UserInfos>> get userInfos => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetFarmLockUserInfosResponseCopyWith<GetFarmLockUserInfosResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetFarmLockUserInfosResponseCopyWith<$Res> {
  factory $GetFarmLockUserInfosResponseCopyWith(
          GetFarmLockUserInfosResponse value,
          $Res Function(GetFarmLockUserInfosResponse) then) =
      _$GetFarmLockUserInfosResponseCopyWithImpl<$Res,
          GetFarmLockUserInfosResponse>;
  @useResult
  $Res call({List<Map<int, UserInfos>> userInfos});
}

/// @nodoc
class _$GetFarmLockUserInfosResponseCopyWithImpl<$Res,
        $Val extends GetFarmLockUserInfosResponse>
    implements $GetFarmLockUserInfosResponseCopyWith<$Res> {
  _$GetFarmLockUserInfosResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userInfos = null,
  }) {
    return _then(_value.copyWith(
      userInfos: null == userInfos
          ? _value.userInfos
          : userInfos // ignore: cast_nullable_to_non_nullable
              as List<Map<int, UserInfos>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetFarmLockUserInfosResponseImplCopyWith<$Res>
    implements $GetFarmLockUserInfosResponseCopyWith<$Res> {
  factory _$$GetFarmLockUserInfosResponseImplCopyWith(
          _$GetFarmLockUserInfosResponseImpl value,
          $Res Function(_$GetFarmLockUserInfosResponseImpl) then) =
      __$$GetFarmLockUserInfosResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Map<int, UserInfos>> userInfos});
}

/// @nodoc
class __$$GetFarmLockUserInfosResponseImplCopyWithImpl<$Res>
    extends _$GetFarmLockUserInfosResponseCopyWithImpl<$Res,
        _$GetFarmLockUserInfosResponseImpl>
    implements _$$GetFarmLockUserInfosResponseImplCopyWith<$Res> {
  __$$GetFarmLockUserInfosResponseImplCopyWithImpl(
      _$GetFarmLockUserInfosResponseImpl _value,
      $Res Function(_$GetFarmLockUserInfosResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userInfos = null,
  }) {
    return _then(_$GetFarmLockUserInfosResponseImpl(
      userInfos: null == userInfos
          ? _value._userInfos
          : userInfos // ignore: cast_nullable_to_non_nullable
              as List<Map<int, UserInfos>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetFarmLockUserInfosResponseImpl
    implements _GetFarmLockUserInfosResponse {
  const _$GetFarmLockUserInfosResponseImpl(
      {required final List<Map<int, UserInfos>> userInfos})
      : _userInfos = userInfos;

  factory _$GetFarmLockUserInfosResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetFarmLockUserInfosResponseImplFromJson(json);

  final List<Map<int, UserInfos>> _userInfos;
  @override
  List<Map<int, UserInfos>> get userInfos {
    if (_userInfos is EqualUnmodifiableListView) return _userInfos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userInfos);
  }

  @override
  String toString() {
    return 'GetFarmLockUserInfosResponse(userInfos: $userInfos)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetFarmLockUserInfosResponseImpl &&
            const DeepCollectionEquality()
                .equals(other._userInfos, _userInfos));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_userInfos));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetFarmLockUserInfosResponseImplCopyWith<
          _$GetFarmLockUserInfosResponseImpl>
      get copyWith => __$$GetFarmLockUserInfosResponseImplCopyWithImpl<
          _$GetFarmLockUserInfosResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetFarmLockUserInfosResponseImplToJson(
      this,
    );
  }
}

abstract class _GetFarmLockUserInfosResponse
    implements GetFarmLockUserInfosResponse {
  const factory _GetFarmLockUserInfosResponse(
          {required final List<Map<int, UserInfos>> userInfos}) =
      _$GetFarmLockUserInfosResponseImpl;

  factory _GetFarmLockUserInfosResponse.fromJson(Map<String, dynamic> json) =
      _$GetFarmLockUserInfosResponseImpl.fromJson;

  @override
  List<Map<int, UserInfos>> get userInfos;
  @override
  @JsonKey(ignore: true)
  _$$GetFarmLockUserInfosResponseImplCopyWith<
          _$GetFarmLockUserInfosResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

UserInfos _$UserInfosFromJson(Map<String, dynamic> json) {
  return _UserInfos.fromJson(json);
}

/// @nodoc
mixin _$UserInfos {
  String get id => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  @JsonKey(name: 'reward_amount')
  double get rewardAmount => throw _privateConstructorUsedError;
  int? get start => throw _privateConstructorUsedError;
  int? get end => throw _privateConstructorUsedError;
  String get level => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserInfosCopyWith<UserInfos> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserInfosCopyWith<$Res> {
  factory $UserInfosCopyWith(UserInfos value, $Res Function(UserInfos) then) =
      _$UserInfosCopyWithImpl<$Res, UserInfos>;
  @useResult
  $Res call(
      {String id,
      double amount,
      @JsonKey(name: 'reward_amount') double rewardAmount,
      int? start,
      int? end,
      String level});
}

/// @nodoc
class _$UserInfosCopyWithImpl<$Res, $Val extends UserInfos>
    implements $UserInfosCopyWith<$Res> {
  _$UserInfosCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? rewardAmount = null,
    Object? start = freezed,
    Object? end = freezed,
    Object? level = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      rewardAmount: null == rewardAmount
          ? _value.rewardAmount
          : rewardAmount // ignore: cast_nullable_to_non_nullable
              as double,
      start: freezed == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as int?,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as int?,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserInfosImplCopyWith<$Res>
    implements $UserInfosCopyWith<$Res> {
  factory _$$UserInfosImplCopyWith(
          _$UserInfosImpl value, $Res Function(_$UserInfosImpl) then) =
      __$$UserInfosImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      double amount,
      @JsonKey(name: 'reward_amount') double rewardAmount,
      int? start,
      int? end,
      String level});
}

/// @nodoc
class __$$UserInfosImplCopyWithImpl<$Res>
    extends _$UserInfosCopyWithImpl<$Res, _$UserInfosImpl>
    implements _$$UserInfosImplCopyWith<$Res> {
  __$$UserInfosImplCopyWithImpl(
      _$UserInfosImpl _value, $Res Function(_$UserInfosImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? rewardAmount = null,
    Object? start = freezed,
    Object? end = freezed,
    Object? level = null,
  }) {
    return _then(_$UserInfosImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      rewardAmount: null == rewardAmount
          ? _value.rewardAmount
          : rewardAmount // ignore: cast_nullable_to_non_nullable
              as double,
      start: freezed == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as int?,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as int?,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserInfosImpl implements _UserInfos {
  const _$UserInfosImpl(
      {required this.id,
      required this.amount,
      @JsonKey(name: 'reward_amount') required this.rewardAmount,
      this.start,
      this.end,
      required this.level});

  factory _$UserInfosImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserInfosImplFromJson(json);

  @override
  final String id;
  @override
  final double amount;
  @override
  @JsonKey(name: 'reward_amount')
  final double rewardAmount;
  @override
  final int? start;
  @override
  final int? end;
  @override
  final String level;

  @override
  String toString() {
    return 'UserInfos(id: $id, amount: $amount, rewardAmount: $rewardAmount, start: $start, end: $end, level: $level)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserInfosImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.rewardAmount, rewardAmount) ||
                other.rewardAmount == rewardAmount) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.level, level) || other.level == level));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, amount, rewardAmount, start, end, level);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserInfosImplCopyWith<_$UserInfosImpl> get copyWith =>
      __$$UserInfosImplCopyWithImpl<_$UserInfosImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserInfosImplToJson(
      this,
    );
  }
}

abstract class _UserInfos implements UserInfos {
  const factory _UserInfos(
      {required final String id,
      required final double amount,
      @JsonKey(name: 'reward_amount') required final double rewardAmount,
      final int? start,
      final int? end,
      required final String level}) = _$UserInfosImpl;

  factory _UserInfos.fromJson(Map<String, dynamic> json) =
      _$UserInfosImpl.fromJson;

  @override
  String get id;
  @override
  double get amount;
  @override
  @JsonKey(name: 'reward_amount')
  double get rewardAmount;
  @override
  int? get start;
  @override
  int? get end;
  @override
  String get level;
  @override
  @JsonKey(ignore: true)
  _$$UserInfosImplCopyWith<_$UserInfosImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
