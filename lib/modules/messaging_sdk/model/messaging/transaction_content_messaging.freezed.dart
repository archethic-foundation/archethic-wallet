// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_content_messaging.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TransactionContentMessaging _$TransactionContentMessagingFromJson(
    Map<String, dynamic> json) {
  return _TransactionContentMessaging.fromJson(json);
}

/// @nodoc
mixin _$TransactionContentMessaging {
  String get compressionAlgo => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  /// Serializes this TransactionContentMessaging to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TransactionContentMessaging
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionContentMessagingCopyWith<TransactionContentMessaging>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionContentMessagingCopyWith<$Res> {
  factory $TransactionContentMessagingCopyWith(
          TransactionContentMessaging value,
          $Res Function(TransactionContentMessaging) then) =
      _$TransactionContentMessagingCopyWithImpl<$Res,
          TransactionContentMessaging>;
  @useResult
  $Res call({String compressionAlgo, String message});
}

/// @nodoc
class _$TransactionContentMessagingCopyWithImpl<$Res,
        $Val extends TransactionContentMessaging>
    implements $TransactionContentMessagingCopyWith<$Res> {
  _$TransactionContentMessagingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionContentMessaging
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? compressionAlgo = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      compressionAlgo: null == compressionAlgo
          ? _value.compressionAlgo
          : compressionAlgo // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransactionContentMessagingImplCopyWith<$Res>
    implements $TransactionContentMessagingCopyWith<$Res> {
  factory _$$TransactionContentMessagingImplCopyWith(
          _$TransactionContentMessagingImpl value,
          $Res Function(_$TransactionContentMessagingImpl) then) =
      __$$TransactionContentMessagingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String compressionAlgo, String message});
}

/// @nodoc
class __$$TransactionContentMessagingImplCopyWithImpl<$Res>
    extends _$TransactionContentMessagingCopyWithImpl<$Res,
        _$TransactionContentMessagingImpl>
    implements _$$TransactionContentMessagingImplCopyWith<$Res> {
  __$$TransactionContentMessagingImplCopyWithImpl(
      _$TransactionContentMessagingImpl _value,
      $Res Function(_$TransactionContentMessagingImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionContentMessaging
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? compressionAlgo = null,
    Object? message = null,
  }) {
    return _then(_$TransactionContentMessagingImpl(
      compressionAlgo: null == compressionAlgo
          ? _value.compressionAlgo
          : compressionAlgo // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionContentMessagingImpl
    implements _TransactionContentMessaging {
  const _$TransactionContentMessagingImpl(
      {required this.compressionAlgo, required this.message});

  factory _$TransactionContentMessagingImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$TransactionContentMessagingImplFromJson(json);

  @override
  final String compressionAlgo;
  @override
  final String message;

  @override
  String toString() {
    return 'TransactionContentMessaging(compressionAlgo: $compressionAlgo, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionContentMessagingImpl &&
            (identical(other.compressionAlgo, compressionAlgo) ||
                other.compressionAlgo == compressionAlgo) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, compressionAlgo, message);

  /// Create a copy of TransactionContentMessaging
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionContentMessagingImplCopyWith<_$TransactionContentMessagingImpl>
      get copyWith => __$$TransactionContentMessagingImplCopyWithImpl<
          _$TransactionContentMessagingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionContentMessagingImplToJson(
      this,
    );
  }
}

abstract class _TransactionContentMessaging
    implements TransactionContentMessaging {
  const factory _TransactionContentMessaging(
      {required final String compressionAlgo,
      required final String message}) = _$TransactionContentMessagingImpl;

  factory _TransactionContentMessaging.fromJson(Map<String, dynamic> json) =
      _$TransactionContentMessagingImpl.fromJson;

  @override
  String get compressionAlgo;
  @override
  String get message;

  /// Create a copy of TransactionContentMessaging
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionContentMessagingImplCopyWith<_$TransactionContentMessagingImpl>
      get copyWith => throw _privateConstructorUsedError;
}
