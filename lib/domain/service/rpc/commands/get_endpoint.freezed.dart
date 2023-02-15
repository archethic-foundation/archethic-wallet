// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_endpoint.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RPCGetEndpointCommand {
  /// Source application name
  RPCCommandOrigin get origin => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RPCGetEndpointCommandCopyWith<RPCGetEndpointCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RPCGetEndpointCommandCopyWith<$Res> {
  factory $RPCGetEndpointCommandCopyWith(RPCGetEndpointCommand value,
          $Res Function(RPCGetEndpointCommand) then) =
      _$RPCGetEndpointCommandCopyWithImpl<$Res, RPCGetEndpointCommand>;
  @useResult
  $Res call({RPCCommandOrigin origin});

  $RPCCommandOriginCopyWith<$Res> get origin;
}

/// @nodoc
class _$RPCGetEndpointCommandCopyWithImpl<$Res,
        $Val extends RPCGetEndpointCommand>
    implements $RPCGetEndpointCommandCopyWith<$Res> {
  _$RPCGetEndpointCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? origin = null,
  }) {
    return _then(_value.copyWith(
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as RPCCommandOrigin,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RPCCommandOriginCopyWith<$Res> get origin {
    return $RPCCommandOriginCopyWith<$Res>(_value.origin, (value) {
      return _then(_value.copyWith(origin: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_RPCGetEndpointCommandCopyWith<$Res>
    implements $RPCGetEndpointCommandCopyWith<$Res> {
  factory _$$_RPCGetEndpointCommandCopyWith(_$_RPCGetEndpointCommand value,
          $Res Function(_$_RPCGetEndpointCommand) then) =
      __$$_RPCGetEndpointCommandCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({RPCCommandOrigin origin});

  @override
  $RPCCommandOriginCopyWith<$Res> get origin;
}

/// @nodoc
class __$$_RPCGetEndpointCommandCopyWithImpl<$Res>
    extends _$RPCGetEndpointCommandCopyWithImpl<$Res, _$_RPCGetEndpointCommand>
    implements _$$_RPCGetEndpointCommandCopyWith<$Res> {
  __$$_RPCGetEndpointCommandCopyWithImpl(_$_RPCGetEndpointCommand _value,
      $Res Function(_$_RPCGetEndpointCommand) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? origin = null,
  }) {
    return _then(_$_RPCGetEndpointCommand(
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as RPCCommandOrigin,
    ));
  }
}

/// @nodoc

class _$_RPCGetEndpointCommand extends _RPCGetEndpointCommand {
  const _$_RPCGetEndpointCommand({required this.origin}) : super._();

  /// Source application name
  @override
  final RPCCommandOrigin origin;

  @override
  String toString() {
    return 'RPCGetEndpointCommand(origin: $origin)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RPCGetEndpointCommand &&
            (identical(other.origin, origin) || other.origin == origin));
  }

  @override
  int get hashCode => Object.hash(runtimeType, origin);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RPCGetEndpointCommandCopyWith<_$_RPCGetEndpointCommand> get copyWith =>
      __$$_RPCGetEndpointCommandCopyWithImpl<_$_RPCGetEndpointCommand>(
          this, _$identity);
}

abstract class _RPCGetEndpointCommand extends RPCGetEndpointCommand {
  const factory _RPCGetEndpointCommand(
      {required final RPCCommandOrigin origin}) = _$_RPCGetEndpointCommand;
  const _RPCGetEndpointCommand._() : super._();

  @override

  /// Source application name
  RPCCommandOrigin get origin;
  @override
  @JsonKey(ignore: true)
  _$$_RPCGetEndpointCommandCopyWith<_$_RPCGetEndpointCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RPCGetEndpointSuccess {
  String get endpoint => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RPCGetEndpointSuccessCopyWith<RPCGetEndpointSuccess> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RPCGetEndpointSuccessCopyWith<$Res> {
  factory $RPCGetEndpointSuccessCopyWith(RPCGetEndpointSuccess value,
          $Res Function(RPCGetEndpointSuccess) then) =
      _$RPCGetEndpointSuccessCopyWithImpl<$Res, RPCGetEndpointSuccess>;
  @useResult
  $Res call({String endpoint});
}

/// @nodoc
class _$RPCGetEndpointSuccessCopyWithImpl<$Res,
        $Val extends RPCGetEndpointSuccess>
    implements $RPCGetEndpointSuccessCopyWith<$Res> {
  _$RPCGetEndpointSuccessCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? endpoint = null,
  }) {
    return _then(_value.copyWith(
      endpoint: null == endpoint
          ? _value.endpoint
          : endpoint // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RPCGetEndpointSuccessCopyWith<$Res>
    implements $RPCGetEndpointSuccessCopyWith<$Res> {
  factory _$$_RPCGetEndpointSuccessCopyWith(_$_RPCGetEndpointSuccess value,
          $Res Function(_$_RPCGetEndpointSuccess) then) =
      __$$_RPCGetEndpointSuccessCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String endpoint});
}

/// @nodoc
class __$$_RPCGetEndpointSuccessCopyWithImpl<$Res>
    extends _$RPCGetEndpointSuccessCopyWithImpl<$Res, _$_RPCGetEndpointSuccess>
    implements _$$_RPCGetEndpointSuccessCopyWith<$Res> {
  __$$_RPCGetEndpointSuccessCopyWithImpl(_$_RPCGetEndpointSuccess _value,
      $Res Function(_$_RPCGetEndpointSuccess) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? endpoint = null,
  }) {
    return _then(_$_RPCGetEndpointSuccess(
      endpoint: null == endpoint
          ? _value.endpoint
          : endpoint // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_RPCGetEndpointSuccess extends _RPCGetEndpointSuccess {
  const _$_RPCGetEndpointSuccess({required this.endpoint}) : super._();

  @override
  final String endpoint;

  @override
  String toString() {
    return 'RPCGetEndpointSuccess(endpoint: $endpoint)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RPCGetEndpointSuccess &&
            (identical(other.endpoint, endpoint) ||
                other.endpoint == endpoint));
  }

  @override
  int get hashCode => Object.hash(runtimeType, endpoint);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RPCGetEndpointSuccessCopyWith<_$_RPCGetEndpointSuccess> get copyWith =>
      __$$_RPCGetEndpointSuccessCopyWithImpl<_$_RPCGetEndpointSuccess>(
          this, _$identity);
}

abstract class _RPCGetEndpointSuccess extends RPCGetEndpointSuccess {
  const factory _RPCGetEndpointSuccess({required final String endpoint}) =
      _$_RPCGetEndpointSuccess;
  const _RPCGetEndpointSuccess._() : super._();

  @override
  String get endpoint;
  @override
  @JsonKey(ignore: true)
  _$$_RPCGetEndpointSuccessCopyWith<_$_RPCGetEndpointSuccess> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RPCGetEndpointFailure {
  String get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RPCGetEndpointFailureCopyWith<RPCGetEndpointFailure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RPCGetEndpointFailureCopyWith<$Res> {
  factory $RPCGetEndpointFailureCopyWith(RPCGetEndpointFailure value,
          $Res Function(RPCGetEndpointFailure) then) =
      _$RPCGetEndpointFailureCopyWithImpl<$Res, RPCGetEndpointFailure>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$RPCGetEndpointFailureCopyWithImpl<$Res,
        $Val extends RPCGetEndpointFailure>
    implements $RPCGetEndpointFailureCopyWith<$Res> {
  _$RPCGetEndpointFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RPCGetEndpointFailureCopyWith<$Res>
    implements $RPCGetEndpointFailureCopyWith<$Res> {
  factory _$$_RPCGetEndpointFailureCopyWith(_$_RPCGetEndpointFailure value,
          $Res Function(_$_RPCGetEndpointFailure) then) =
      __$$_RPCGetEndpointFailureCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$_RPCGetEndpointFailureCopyWithImpl<$Res>
    extends _$RPCGetEndpointFailureCopyWithImpl<$Res, _$_RPCGetEndpointFailure>
    implements _$$_RPCGetEndpointFailureCopyWith<$Res> {
  __$$_RPCGetEndpointFailureCopyWithImpl(_$_RPCGetEndpointFailure _value,
      $Res Function(_$_RPCGetEndpointFailure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$_RPCGetEndpointFailure(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_RPCGetEndpointFailure extends _RPCGetEndpointFailure {
  const _$_RPCGetEndpointFailure({required this.message}) : super._();

  @override
  final String message;

  @override
  String toString() {
    return 'RPCGetEndpointFailure(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RPCGetEndpointFailure &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RPCGetEndpointFailureCopyWith<_$_RPCGetEndpointFailure> get copyWith =>
      __$$_RPCGetEndpointFailureCopyWithImpl<_$_RPCGetEndpointFailure>(
          this, _$identity);
}

abstract class _RPCGetEndpointFailure extends RPCGetEndpointFailure {
  const factory _RPCGetEndpointFailure({required final String message}) =
      _$_RPCGetEndpointFailure;
  const _RPCGetEndpointFailure._() : super._();

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$_RPCGetEndpointFailureCopyWith<_$_RPCGetEndpointFailure> get copyWith =>
      throw _privateConstructorUsedError;
}
