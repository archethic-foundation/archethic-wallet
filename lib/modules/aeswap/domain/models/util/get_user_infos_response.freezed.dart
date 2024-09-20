// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_user_infos_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetUserInfosResponse _$GetUserInfosResponseFromJson(Map<String, dynamic> json) {
  return _GetUserInfosResponse.fromJson(json);
}

/// @nodoc
mixin _$GetUserInfosResponse {
  @JsonKey(name: 'deposited_amount')
  double get depositedAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'reward_amount')
  double get rewardAmount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetUserInfosResponseCopyWith<GetUserInfosResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetUserInfosResponseCopyWith<$Res> {
  factory $GetUserInfosResponseCopyWith(GetUserInfosResponse value,
          $Res Function(GetUserInfosResponse) then) =
      _$GetUserInfosResponseCopyWithImpl<$Res, GetUserInfosResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'deposited_amount') double depositedAmount,
      @JsonKey(name: 'reward_amount') double rewardAmount});
}

/// @nodoc
class _$GetUserInfosResponseCopyWithImpl<$Res,
        $Val extends GetUserInfosResponse>
    implements $GetUserInfosResponseCopyWith<$Res> {
  _$GetUserInfosResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? depositedAmount = null,
    Object? rewardAmount = null,
  }) {
    return _then(_value.copyWith(
      depositedAmount: null == depositedAmount
          ? _value.depositedAmount
          : depositedAmount // ignore: cast_nullable_to_non_nullable
              as double,
      rewardAmount: null == rewardAmount
          ? _value.rewardAmount
          : rewardAmount // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetUserInfosResponseImplCopyWith<$Res>
    implements $GetUserInfosResponseCopyWith<$Res> {
  factory _$$GetUserInfosResponseImplCopyWith(_$GetUserInfosResponseImpl value,
          $Res Function(_$GetUserInfosResponseImpl) then) =
      __$$GetUserInfosResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'deposited_amount') double depositedAmount,
      @JsonKey(name: 'reward_amount') double rewardAmount});
}

/// @nodoc
class __$$GetUserInfosResponseImplCopyWithImpl<$Res>
    extends _$GetUserInfosResponseCopyWithImpl<$Res, _$GetUserInfosResponseImpl>
    implements _$$GetUserInfosResponseImplCopyWith<$Res> {
  __$$GetUserInfosResponseImplCopyWithImpl(_$GetUserInfosResponseImpl _value,
      $Res Function(_$GetUserInfosResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? depositedAmount = null,
    Object? rewardAmount = null,
  }) {
    return _then(_$GetUserInfosResponseImpl(
      depositedAmount: null == depositedAmount
          ? _value.depositedAmount
          : depositedAmount // ignore: cast_nullable_to_non_nullable
              as double,
      rewardAmount: null == rewardAmount
          ? _value.rewardAmount
          : rewardAmount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetUserInfosResponseImpl implements _GetUserInfosResponse {
  const _$GetUserInfosResponseImpl(
      {@JsonKey(name: 'deposited_amount') required this.depositedAmount,
      @JsonKey(name: 'reward_amount') required this.rewardAmount});

  factory _$GetUserInfosResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetUserInfosResponseImplFromJson(json);

  @override
  @JsonKey(name: 'deposited_amount')
  final double depositedAmount;
  @override
  @JsonKey(name: 'reward_amount')
  final double rewardAmount;

  @override
  String toString() {
    return 'GetUserInfosResponse(depositedAmount: $depositedAmount, rewardAmount: $rewardAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetUserInfosResponseImpl &&
            (identical(other.depositedAmount, depositedAmount) ||
                other.depositedAmount == depositedAmount) &&
            (identical(other.rewardAmount, rewardAmount) ||
                other.rewardAmount == rewardAmount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, depositedAmount, rewardAmount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetUserInfosResponseImplCopyWith<_$GetUserInfosResponseImpl>
      get copyWith =>
          __$$GetUserInfosResponseImplCopyWithImpl<_$GetUserInfosResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetUserInfosResponseImplToJson(
      this,
    );
  }
}

abstract class _GetUserInfosResponse implements GetUserInfosResponse {
  const factory _GetUserInfosResponse(
      {@JsonKey(name: 'deposited_amount') required final double depositedAmount,
      @JsonKey(name: 'reward_amount')
      required final double rewardAmount}) = _$GetUserInfosResponseImpl;

  factory _GetUserInfosResponse.fromJson(Map<String, dynamic> json) =
      _$GetUserInfosResponseImpl.fromJson;

  @override
  @JsonKey(name: 'deposited_amount')
  double get depositedAmount;
  @override
  @JsonKey(name: 'reward_amount')
  double get rewardAmount;
  @override
  @JsonKey(ignore: true)
  _$$GetUserInfosResponseImplCopyWith<_$GetUserInfosResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
