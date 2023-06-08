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
  AccessRecipient get sender => throw _privateConstructorUsedError;
  @HiveField(1)
  String get message => throw _privateConstructorUsedError;
  @HiveField(2)
  DateTime get date => throw _privateConstructorUsedError;
  @HiveField(3)
  String get id => throw _privateConstructorUsedError;

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
      {@HiveField(0) AccessRecipient sender,
      @HiveField(1) String message,
      @HiveField(2) DateTime date,
      @HiveField(3) String id});

  $AccessRecipientCopyWith<$Res> get sender;
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
    Object? sender = null,
    Object? message = null,
    Object? date = null,
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as AccessRecipient,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AccessRecipientCopyWith<$Res> get sender {
    return $AccessRecipientCopyWith<$Res>(_value.sender, (value) {
      return _then(_value.copyWith(sender: value) as $Val);
    });
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
      {@HiveField(0) AccessRecipient sender,
      @HiveField(1) String message,
      @HiveField(2) DateTime date,
      @HiveField(3) String id});

  @override
  $AccessRecipientCopyWith<$Res> get sender;
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
    Object? sender = null,
    Object? message = null,
    Object? date = null,
    Object? id = null,
  }) {
    return _then(_$_TalkMessage(
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as AccessRecipient,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@HiveType(typeId: HiveTypeIds.talkMessage)
class _$_TalkMessage extends _TalkMessage {
  const _$_TalkMessage(
      {@HiveField(0) required this.sender,
      @HiveField(1) required this.message,
      @HiveField(2) required this.date,
      @HiveField(3) required this.id})
      : super._();

  @override
  @HiveField(0)
  final AccessRecipient sender;
  @override
  @HiveField(1)
  final String message;
  @override
  @HiveField(2)
  final DateTime date;
  @override
  @HiveField(3)
  final String id;

  @override
  String toString() {
    return 'TalkMessage(sender: $sender, message: $message, date: $date, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TalkMessage &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sender, message, date, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TalkMessageCopyWith<_$_TalkMessage> get copyWith =>
      __$$_TalkMessageCopyWithImpl<_$_TalkMessage>(this, _$identity);
}

abstract class _TalkMessage extends TalkMessage {
  const factory _TalkMessage(
      {@HiveField(0) required final AccessRecipient sender,
      @HiveField(1) required final String message,
      @HiveField(2) required final DateTime date,
      @HiveField(3) required final String id}) = _$_TalkMessage;
  const _TalkMessage._() : super._();

  @override
  @HiveField(0)
  AccessRecipient get sender;
  @override
  @HiveField(1)
  String get message;
  @override
  @HiveField(2)
  DateTime get date;
  @override
  @HiveField(3)
  String get id;
  @override
  @JsonKey(ignore: true)
  _$$_TalkMessageCopyWith<_$_TalkMessage> get copyWith =>
      throw _privateConstructorUsedError;
}
