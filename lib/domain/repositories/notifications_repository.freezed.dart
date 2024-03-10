// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notifications_repository.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TxSentEvent _$TxSentEventFromJson(Map<String, dynamic> json) {
  return _TxSentEvent.fromJson(json);
}

/// @nodoc
mixin _$TxSentEvent {
// https://github.com/rrousselGit/freezed/issues/488
// ignore: invalid_annotation_target
  @JsonKey(name: 'txAddress')
  String get notificationRecipientAddress =>
      throw _privateConstructorUsedError; // => https://github.com/rrousselGit/freezed/issues/488
// ignore: invalid_annotation_target
  @JsonKey(name: 'txChainGenesisAddress')
  String get listenAddress => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  dynamic get extra => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TxSentEventCopyWith<TxSentEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TxSentEventCopyWith<$Res> {
  factory $TxSentEventCopyWith(
          TxSentEvent value, $Res Function(TxSentEvent) then) =
      _$TxSentEventCopyWithImpl<$Res, TxSentEvent>;
  @useResult
  $Res call(
      {@JsonKey(name: 'txAddress') String notificationRecipientAddress,
      @JsonKey(name: 'txChainGenesisAddress') String listenAddress,
      String type,
      dynamic extra});
}

/// @nodoc
class _$TxSentEventCopyWithImpl<$Res, $Val extends TxSentEvent>
    implements $TxSentEventCopyWith<$Res> {
  _$TxSentEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notificationRecipientAddress = null,
    Object? listenAddress = null,
    Object? type = null,
    Object? extra = freezed,
  }) {
    return _then(_value.copyWith(
      notificationRecipientAddress: null == notificationRecipientAddress
          ? _value.notificationRecipientAddress
          : notificationRecipientAddress // ignore: cast_nullable_to_non_nullable
              as String,
      listenAddress: null == listenAddress
          ? _value.listenAddress
          : listenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      extra: freezed == extra
          ? _value.extra
          : extra // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TxSentEventImplCopyWith<$Res>
    implements $TxSentEventCopyWith<$Res> {
  factory _$$TxSentEventImplCopyWith(
          _$TxSentEventImpl value, $Res Function(_$TxSentEventImpl) then) =
      __$$TxSentEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'txAddress') String notificationRecipientAddress,
      @JsonKey(name: 'txChainGenesisAddress') String listenAddress,
      String type,
      dynamic extra});
}

/// @nodoc
class __$$TxSentEventImplCopyWithImpl<$Res>
    extends _$TxSentEventCopyWithImpl<$Res, _$TxSentEventImpl>
    implements _$$TxSentEventImplCopyWith<$Res> {
  __$$TxSentEventImplCopyWithImpl(
      _$TxSentEventImpl _value, $Res Function(_$TxSentEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notificationRecipientAddress = null,
    Object? listenAddress = null,
    Object? type = null,
    Object? extra = freezed,
  }) {
    return _then(_$TxSentEventImpl(
      notificationRecipientAddress: null == notificationRecipientAddress
          ? _value.notificationRecipientAddress
          : notificationRecipientAddress // ignore: cast_nullable_to_non_nullable
              as String,
      listenAddress: null == listenAddress
          ? _value.listenAddress
          : listenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      extra: freezed == extra
          ? _value.extra
          : extra // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TxSentEventImpl extends _TxSentEvent {
  const _$TxSentEventImpl(
      {@JsonKey(name: 'txAddress') required this.notificationRecipientAddress,
      @JsonKey(name: 'txChainGenesisAddress') required this.listenAddress,
      required this.type,
      required this.extra})
      : super._();

  factory _$TxSentEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$TxSentEventImplFromJson(json);

// https://github.com/rrousselGit/freezed/issues/488
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'txAddress')
  final String notificationRecipientAddress;
// => https://github.com/rrousselGit/freezed/issues/488
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'txChainGenesisAddress')
  final String listenAddress;
  @override
  final String type;
  @override
  final dynamic extra;

  @override
  String toString() {
    return 'TxSentEvent(notificationRecipientAddress: $notificationRecipientAddress, listenAddress: $listenAddress, type: $type, extra: $extra)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TxSentEventImpl &&
            (identical(other.notificationRecipientAddress,
                    notificationRecipientAddress) ||
                other.notificationRecipientAddress ==
                    notificationRecipientAddress) &&
            (identical(other.listenAddress, listenAddress) ||
                other.listenAddress == listenAddress) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other.extra, extra));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, notificationRecipientAddress,
      listenAddress, type, const DeepCollectionEquality().hash(extra));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TxSentEventImplCopyWith<_$TxSentEventImpl> get copyWith =>
      __$$TxSentEventImplCopyWithImpl<_$TxSentEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TxSentEventImplToJson(
      this,
    );
  }
}

abstract class _TxSentEvent extends TxSentEvent {
  const factory _TxSentEvent(
      {@JsonKey(name: 'txAddress')
      required final String notificationRecipientAddress,
      @JsonKey(name: 'txChainGenesisAddress')
      required final String listenAddress,
      required final String type,
      required final dynamic extra}) = _$TxSentEventImpl;
  const _TxSentEvent._() : super._();

  factory _TxSentEvent.fromJson(Map<String, dynamic> json) =
      _$TxSentEventImpl.fromJson;

  @override // https://github.com/rrousselGit/freezed/issues/488
// ignore: invalid_annotation_target
  @JsonKey(name: 'txAddress')
  String get notificationRecipientAddress;
  @override // => https://github.com/rrousselGit/freezed/issues/488
// ignore: invalid_annotation_target
  @JsonKey(name: 'txChainGenesisAddress')
  String get listenAddress;
  @override
  String get type;
  @override
  dynamic get extra;
  @override
  @JsonKey(ignore: true)
  _$$TxSentEventImplCopyWith<_$TxSentEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
