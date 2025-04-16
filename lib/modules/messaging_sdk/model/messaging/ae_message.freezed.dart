// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ae_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AEMessage _$AEMessageFromJson(Map<String, dynamic> json) {
  return _AEMessage.fromJson(json);
}

/// @nodoc
mixin _$AEMessage {
  String get address => throw _privateConstructorUsedError;
  String get senderGenesisPublicKey => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  int get timestampCreation => throw _privateConstructorUsedError;
  String get sender => throw _privateConstructorUsedError;

  /// Serializes this AEMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AEMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AEMessageCopyWith<AEMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AEMessageCopyWith<$Res> {
  factory $AEMessageCopyWith(AEMessage value, $Res Function(AEMessage) then) =
      _$AEMessageCopyWithImpl<$Res, AEMessage>;
  @useResult
  $Res call(
      {String address,
      String senderGenesisPublicKey,
      String content,
      int timestampCreation,
      String sender});
}

/// @nodoc
class _$AEMessageCopyWithImpl<$Res, $Val extends AEMessage>
    implements $AEMessageCopyWith<$Res> {
  _$AEMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AEMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? senderGenesisPublicKey = null,
    Object? content = null,
    Object? timestampCreation = null,
    Object? sender = null,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      senderGenesisPublicKey: null == senderGenesisPublicKey
          ? _value.senderGenesisPublicKey
          : senderGenesisPublicKey // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      timestampCreation: null == timestampCreation
          ? _value.timestampCreation
          : timestampCreation // ignore: cast_nullable_to_non_nullable
              as int,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AEMessageImplCopyWith<$Res>
    implements $AEMessageCopyWith<$Res> {
  factory _$$AEMessageImplCopyWith(
          _$AEMessageImpl value, $Res Function(_$AEMessageImpl) then) =
      __$$AEMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String address,
      String senderGenesisPublicKey,
      String content,
      int timestampCreation,
      String sender});
}

/// @nodoc
class __$$AEMessageImplCopyWithImpl<$Res>
    extends _$AEMessageCopyWithImpl<$Res, _$AEMessageImpl>
    implements _$$AEMessageImplCopyWith<$Res> {
  __$$AEMessageImplCopyWithImpl(
      _$AEMessageImpl _value, $Res Function(_$AEMessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of AEMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? senderGenesisPublicKey = null,
    Object? content = null,
    Object? timestampCreation = null,
    Object? sender = null,
  }) {
    return _then(_$AEMessageImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      senderGenesisPublicKey: null == senderGenesisPublicKey
          ? _value.senderGenesisPublicKey
          : senderGenesisPublicKey // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      timestampCreation: null == timestampCreation
          ? _value.timestampCreation
          : timestampCreation // ignore: cast_nullable_to_non_nullable
              as int,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AEMessageImpl extends _AEMessage {
  const _$AEMessageImpl(
      {this.address = '',
      this.senderGenesisPublicKey = '',
      this.content = '',
      this.timestampCreation = 0,
      this.sender = ''})
      : super._();

  factory _$AEMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$AEMessageImplFromJson(json);

  @override
  @JsonKey()
  final String address;
  @override
  @JsonKey()
  final String senderGenesisPublicKey;
  @override
  @JsonKey()
  final String content;
  @override
  @JsonKey()
  final int timestampCreation;
  @override
  @JsonKey()
  final String sender;

  @override
  String toString() {
    return 'AEMessage(address: $address, senderGenesisPublicKey: $senderGenesisPublicKey, content: $content, timestampCreation: $timestampCreation, sender: $sender)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AEMessageImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.senderGenesisPublicKey, senderGenesisPublicKey) ||
                other.senderGenesisPublicKey == senderGenesisPublicKey) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.timestampCreation, timestampCreation) ||
                other.timestampCreation == timestampCreation) &&
            (identical(other.sender, sender) || other.sender == sender));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, address, senderGenesisPublicKey,
      content, timestampCreation, sender);

  /// Create a copy of AEMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AEMessageImplCopyWith<_$AEMessageImpl> get copyWith =>
      __$$AEMessageImplCopyWithImpl<_$AEMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AEMessageImplToJson(
      this,
    );
  }
}

abstract class _AEMessage extends AEMessage {
  const factory _AEMessage(
      {final String address,
      final String senderGenesisPublicKey,
      final String content,
      final int timestampCreation,
      final String sender}) = _$AEMessageImpl;
  const _AEMessage._() : super._();

  factory _AEMessage.fromJson(Map<String, dynamic> json) =
      _$AEMessageImpl.fromJson;

  @override
  String get address;
  @override
  String get senderGenesisPublicKey;
  @override
  String get content;
  @override
  int get timestampCreation;
  @override
  String get sender;

  /// Create a copy of AEMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AEMessageImplCopyWith<_$AEMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
