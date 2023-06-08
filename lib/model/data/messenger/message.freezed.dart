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
mixin _$TalkMessage {
  @HiveField(0)
  String get senderPublicKey => throw _privateConstructorUsedError;
  @HiveField(1)
  String get content => throw _privateConstructorUsedError;
  @HiveField(2)
  DateTime get date => throw _privateConstructorUsedError;
  @HiveField(3)
  String get address => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TalkMessageCopyWith<TalkMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TalkMessageCopyWith<$Res> {
  factory $TalkMessageCopyWith(
          TalkMessage value, $Res Function(TalkMessage) then) =
      _$TalkMessageCopyWithImpl<$Res, TalkMessage>;
  @useResult
  $Res call(
      {@HiveField(0) String senderPublicKey,
      @HiveField(1) String content,
      @HiveField(2) DateTime date,
      @HiveField(3) String address});
}

/// @nodoc
class _$TalkMessageCopyWithImpl<$Res, $Val extends TalkMessage>
    implements $TalkMessageCopyWith<$Res> {
  _$TalkMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderPublicKey = null,
    Object? content = null,
    Object? date = null,
    Object? address = null,
  }) {
    return _then(_value.copyWith(
      senderPublicKey: null == senderPublicKey
          ? _value.senderPublicKey
          : senderPublicKey // ignore: cast_nullable_to_non_nullable
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
abstract class _$$_TalkMessageCopyWith<$Res>
    implements $TalkMessageCopyWith<$Res> {
  factory _$$_TalkMessageCopyWith(
          _$_TalkMessage value, $Res Function(_$_TalkMessage) then) =
      __$$_TalkMessageCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String senderPublicKey,
      @HiveField(1) String content,
      @HiveField(2) DateTime date,
      @HiveField(3) String address});
}

/// @nodoc
class __$$_TalkMessageCopyWithImpl<$Res>
    extends _$TalkMessageCopyWithImpl<$Res, _$_TalkMessage>
    implements _$$_TalkMessageCopyWith<$Res> {
  __$$_TalkMessageCopyWithImpl(
      _$_TalkMessage _value, $Res Function(_$_TalkMessage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderPublicKey = null,
    Object? content = null,
    Object? date = null,
    Object? address = null,
  }) {
    return _then(_$_TalkMessage(
      senderPublicKey: null == senderPublicKey
          ? _value.senderPublicKey
          : senderPublicKey // ignore: cast_nullable_to_non_nullable
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
class _$_TalkMessage extends _TalkMessage {
  const _$_TalkMessage(
      {@HiveField(0) required this.senderPublicKey,
      @HiveField(1) required this.content,
      @HiveField(2) required this.date,
      @HiveField(3) required this.address})
      : super._();

  @override
  @HiveField(0)
  final String senderPublicKey;
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
    return 'TalkMessage(senderPublicKey: $senderPublicKey, content: $content, date: $date, address: $address)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TalkMessage &&
            (identical(other.senderPublicKey, senderPublicKey) ||
                other.senderPublicKey == senderPublicKey) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.address, address) || other.address == address));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, senderPublicKey, content, date, address);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TalkMessageCopyWith<_$_TalkMessage> get copyWith =>
      __$$_TalkMessageCopyWithImpl<_$_TalkMessage>(this, _$identity);
}

abstract class _TalkMessage extends TalkMessage {
  const factory _TalkMessage(
      {@HiveField(0) required final String senderPublicKey,
      @HiveField(1) required final String content,
      @HiveField(2) required final DateTime date,
      @HiveField(3) required final String address}) = _$_TalkMessage;
  const _TalkMessage._() : super._();

  @override
  @HiveField(0)
  String get senderPublicKey;
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
  _$$_TalkMessageCopyWith<_$_TalkMessage> get copyWith =>
      throw _privateConstructorUsedError;
}
