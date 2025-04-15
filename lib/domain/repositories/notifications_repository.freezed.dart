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
  String get txAddress =>
      throw _privateConstructorUsedError; // => https://github.com/rrousselGit/freezed/issues/488
// ignore: invalid_annotation_target
  @JsonKey(name: 'txChainGenesisAddress')
  String get txChainGenesisAddress => throw _privateConstructorUsedError;

  /// Serializes this TxSentEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TxSentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      {@JsonKey(name: 'txAddress') String txAddress,
      @JsonKey(name: 'txChainGenesisAddress') String txChainGenesisAddress});
}

/// @nodoc
class _$TxSentEventCopyWithImpl<$Res, $Val extends TxSentEvent>
    implements $TxSentEventCopyWith<$Res> {
  _$TxSentEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TxSentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? txAddress = null,
    Object? txChainGenesisAddress = null,
  }) {
    return _then(_value.copyWith(
      txAddress: null == txAddress
          ? _value.txAddress
          : txAddress // ignore: cast_nullable_to_non_nullable
              as String,
      txChainGenesisAddress: null == txChainGenesisAddress
          ? _value.txChainGenesisAddress
          : txChainGenesisAddress // ignore: cast_nullable_to_non_nullable
              as String,
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
      {@JsonKey(name: 'txAddress') String txAddress,
      @JsonKey(name: 'txChainGenesisAddress') String txChainGenesisAddress});
}

/// @nodoc
class __$$TxSentEventImplCopyWithImpl<$Res>
    extends _$TxSentEventCopyWithImpl<$Res, _$TxSentEventImpl>
    implements _$$TxSentEventImplCopyWith<$Res> {
  __$$TxSentEventImplCopyWithImpl(
      _$TxSentEventImpl _value, $Res Function(_$TxSentEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of TxSentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? txAddress = null,
    Object? txChainGenesisAddress = null,
  }) {
    return _then(_$TxSentEventImpl(
      txAddress: null == txAddress
          ? _value.txAddress
          : txAddress // ignore: cast_nullable_to_non_nullable
              as String,
      txChainGenesisAddress: null == txChainGenesisAddress
          ? _value.txChainGenesisAddress
          : txChainGenesisAddress // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TxSentEventImpl extends _TxSentEvent {
  const _$TxSentEventImpl(
      {@JsonKey(name: 'txAddress') required this.txAddress,
      @JsonKey(name: 'txChainGenesisAddress')
      required this.txChainGenesisAddress})
      : super._();

  factory _$TxSentEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$TxSentEventImplFromJson(json);

// https://github.com/rrousselGit/freezed/issues/488
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'txAddress')
  final String txAddress;
// => https://github.com/rrousselGit/freezed/issues/488
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'txChainGenesisAddress')
  final String txChainGenesisAddress;

  @override
  String toString() {
    return 'TxSentEvent(txAddress: $txAddress, txChainGenesisAddress: $txChainGenesisAddress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TxSentEventImpl &&
            (identical(other.txAddress, txAddress) ||
                other.txAddress == txAddress) &&
            (identical(other.txChainGenesisAddress, txChainGenesisAddress) ||
                other.txChainGenesisAddress == txChainGenesisAddress));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, txAddress, txChainGenesisAddress);

  /// Create a copy of TxSentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      {@JsonKey(name: 'txAddress') required final String txAddress,
      @JsonKey(name: 'txChainGenesisAddress')
      required final String txChainGenesisAddress}) = _$TxSentEventImpl;
  const _TxSentEvent._() : super._();

  factory _TxSentEvent.fromJson(Map<String, dynamic> json) =
      _$TxSentEventImpl.fromJson;

// https://github.com/rrousselGit/freezed/issues/488
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'txAddress')
  String get txAddress; // => https://github.com/rrousselGit/freezed/issues/488
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'txChainGenesisAddress')
  String get txChainGenesisAddress;

  /// Create a copy of TxSentEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TxSentEventImplCopyWith<_$TxSentEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
