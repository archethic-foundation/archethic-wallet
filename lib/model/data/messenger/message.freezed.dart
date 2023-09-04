// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DiscussionMessage {
  @HiveField(0)
  String get senderGenesisPublicKey => throw _privateConstructorUsedError;
  @HiveField(1)
  String get content => throw _privateConstructorUsedError;
  @HiveField(2)
  DateTime get date => throw _privateConstructorUsedError;
  @HiveField(3)
  String get address => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DiscussionMessageCopyWith<DiscussionMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscussionMessageCopyWith<$Res> {
  factory $DiscussionMessageCopyWith(
          DiscussionMessage value, $Res Function(DiscussionMessage) then) =
      _$DiscussionMessageCopyWithImpl<$Res, DiscussionMessage>;
  @useResult
  $Res call(
      {@HiveField(0) String senderGenesisPublicKey,
      @HiveField(1) String content,
      @HiveField(2) DateTime date,
      @HiveField(3) String address});
}

/// @nodoc
class _$DiscussionMessageCopyWithImpl<$Res, $Val extends DiscussionMessage>
    implements $DiscussionMessageCopyWith<$Res> {
  _$DiscussionMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderGenesisPublicKey = null,
    Object? content = null,
    Object? date = null,
    Object? address = null,
  }) {
    return _then(_value.copyWith(
      senderGenesisPublicKey: null == senderGenesisPublicKey
          ? _value.senderGenesisPublicKey
          : senderGenesisPublicKey // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DiscussionMessageCopyWith<$Res>
    implements $DiscussionMessageCopyWith<$Res> {
  factory _$$_DiscussionMessageCopyWith(_$_DiscussionMessage value,
          $Res Function(_$_DiscussionMessage) then) =
      __$$_DiscussionMessageCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String senderGenesisPublicKey,
      @HiveField(1) String content,
      @HiveField(2) DateTime date,
      @HiveField(3) String address});
}

/// @nodoc
class __$$_DiscussionMessageCopyWithImpl<$Res>
    extends _$DiscussionMessageCopyWithImpl<$Res, _$_DiscussionMessage>
    implements _$$_DiscussionMessageCopyWith<$Res> {
  __$$_DiscussionMessageCopyWithImpl(
      _$_DiscussionMessage _value, $Res Function(_$_DiscussionMessage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderGenesisPublicKey = null,
    Object? content = null,
    Object? date = null,
    Object? address = null,
  }) {
    return _then(_$_DiscussionMessage(
      senderGenesisPublicKey: null == senderGenesisPublicKey
          ? _value.senderGenesisPublicKey
          : senderGenesisPublicKey // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@HiveType(typeId: HiveTypeIds.talkMessage)
class _$_DiscussionMessage extends _DiscussionMessage {
  const _$_DiscussionMessage(
      {@HiveField(0) required this.senderGenesisPublicKey,
      @HiveField(1) required this.content,
      @HiveField(2) required this.date,
      @HiveField(3) required this.address})
      : super._();

  @override
  @HiveField(0)
  final String senderGenesisPublicKey;
  @override
  @HiveField(1)
  final String content;
  @override
  @HiveField(2)
  final DateTime date;
  @override
  @HiveField(3)
  final String address;

  @override
  String toString() {
    return 'DiscussionMessage(senderGenesisPublicKey: $senderGenesisPublicKey, content: $content, date: $date, address: $address)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DiscussionMessage &&
            (identical(other.senderGenesisPublicKey, senderGenesisPublicKey) ||
                other.senderGenesisPublicKey == senderGenesisPublicKey) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.address, address) || other.address == address));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, senderGenesisPublicKey, content, date, address);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DiscussionMessageCopyWith<_$_DiscussionMessage> get copyWith =>
      __$$_DiscussionMessageCopyWithImpl<_$_DiscussionMessage>(
          this, _$identity);
}

abstract class _DiscussionMessage extends DiscussionMessage {
  const factory _DiscussionMessage(
      {@HiveField(0) required final String senderGenesisPublicKey,
      @HiveField(1) required final String content,
      @HiveField(2) required final DateTime date,
      @HiveField(3) required final String address}) = _$_DiscussionMessage;
  const _DiscussionMessage._() : super._();

  @override
  @HiveField(0)
  String get senderGenesisPublicKey;
  @override
  @HiveField(1)
  String get content;
  @override
  @HiveField(2)
  DateTime get date;
  @override
  @HiveField(3)
  String get address;
  @override
  @JsonKey(ignore: true)
  _$$_DiscussionMessageCopyWith<_$_DiscussionMessage> get copyWith =>
      throw _privateConstructorUsedError;
}
