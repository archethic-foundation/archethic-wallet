// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'handler.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DeeplinkRpcRoute {
  String get pathFirstSegment => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DeeplinkRpcRouteCopyWith<DeeplinkRpcRoute> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeeplinkRpcRouteCopyWith<$Res> {
  factory $DeeplinkRpcRouteCopyWith(
          DeeplinkRpcRoute value, $Res Function(DeeplinkRpcRoute) then) =
      _$DeeplinkRpcRouteCopyWithImpl<$Res, DeeplinkRpcRoute>;
  @useResult
  $Res call({String pathFirstSegment});
}

/// @nodoc
class _$DeeplinkRpcRouteCopyWithImpl<$Res, $Val extends DeeplinkRpcRoute>
    implements $DeeplinkRpcRouteCopyWith<$Res> {
  _$DeeplinkRpcRouteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pathFirstSegment = null,
  }) {
    return _then(_value.copyWith(
      pathFirstSegment: null == pathFirstSegment
          ? _value.pathFirstSegment
          : pathFirstSegment // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DeeplinkRpcRouteCopyWith<$Res>
    implements $DeeplinkRpcRouteCopyWith<$Res> {
  factory _$$_DeeplinkRpcRouteCopyWith(
          _$_DeeplinkRpcRoute value, $Res Function(_$_DeeplinkRpcRoute) then) =
      __$$_DeeplinkRpcRouteCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String pathFirstSegment});
}

/// @nodoc
class __$$_DeeplinkRpcRouteCopyWithImpl<$Res>
    extends _$DeeplinkRpcRouteCopyWithImpl<$Res, _$_DeeplinkRpcRoute>
    implements _$$_DeeplinkRpcRouteCopyWith<$Res> {
  __$$_DeeplinkRpcRouteCopyWithImpl(
      _$_DeeplinkRpcRoute _value, $Res Function(_$_DeeplinkRpcRoute) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pathFirstSegment = null,
  }) {
    return _then(_$_DeeplinkRpcRoute(
      null == pathFirstSegment
          ? _value.pathFirstSegment
          : pathFirstSegment // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_DeeplinkRpcRoute extends _DeeplinkRpcRoute {
  const _$_DeeplinkRpcRoute(this.pathFirstSegment) : super._();

  @override
  final String pathFirstSegment;

  @override
  String toString() {
    return 'DeeplinkRpcRoute(pathFirstSegment: $pathFirstSegment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DeeplinkRpcRoute &&
            (identical(other.pathFirstSegment, pathFirstSegment) ||
                other.pathFirstSegment == pathFirstSegment));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pathFirstSegment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DeeplinkRpcRouteCopyWith<_$_DeeplinkRpcRoute> get copyWith =>
      __$$_DeeplinkRpcRouteCopyWithImpl<_$_DeeplinkRpcRoute>(this, _$identity);
}

abstract class _DeeplinkRpcRoute extends DeeplinkRpcRoute {
  const factory _DeeplinkRpcRoute(final String pathFirstSegment) =
      _$_DeeplinkRpcRoute;
  const _DeeplinkRpcRoute._() : super._();

  @override
  String get pathFirstSegment;
  @override
  @JsonKey(ignore: true)
  _$$_DeeplinkRpcRouteCopyWith<_$_DeeplinkRpcRoute> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DeeplinkRpcRequestHandler {
  DeeplinkRpcRoute get route => throw _privateConstructorUsedError;
  FutureOr<Map<String, dynamic>> Function(DeeplinkRpcRequest) get handle =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DeeplinkRpcRequestHandlerCopyWith<DeeplinkRpcRequestHandler> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeeplinkRpcRequestHandlerCopyWith<$Res> {
  factory $DeeplinkRpcRequestHandlerCopyWith(DeeplinkRpcRequestHandler value,
          $Res Function(DeeplinkRpcRequestHandler) then) =
      _$DeeplinkRpcRequestHandlerCopyWithImpl<$Res, DeeplinkRpcRequestHandler>;
  @useResult
  $Res call(
      {DeeplinkRpcRoute route,
      FutureOr<Map<String, dynamic>> Function(DeeplinkRpcRequest) handle});

  $DeeplinkRpcRouteCopyWith<$Res> get route;
}

/// @nodoc
class _$DeeplinkRpcRequestHandlerCopyWithImpl<$Res,
        $Val extends DeeplinkRpcRequestHandler>
    implements $DeeplinkRpcRequestHandlerCopyWith<$Res> {
  _$DeeplinkRpcRequestHandlerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? route = null,
    Object? handle = null,
  }) {
    return _then(_value.copyWith(
      route: null == route
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as DeeplinkRpcRoute,
      handle: null == handle
          ? _value.handle
          : handle // ignore: cast_nullable_to_non_nullable
              as FutureOr<Map<String, dynamic>> Function(DeeplinkRpcRequest),
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DeeplinkRpcRouteCopyWith<$Res> get route {
    return $DeeplinkRpcRouteCopyWith<$Res>(_value.route, (value) {
      return _then(_value.copyWith(route: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_DeeplinkRpcRequestHandlerCopyWith<$Res>
    implements $DeeplinkRpcRequestHandlerCopyWith<$Res> {
  factory _$$_DeeplinkRpcRequestHandlerCopyWith(
          _$_DeeplinkRpcRequestHandler value,
          $Res Function(_$_DeeplinkRpcRequestHandler) then) =
      __$$_DeeplinkRpcRequestHandlerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DeeplinkRpcRoute route,
      FutureOr<Map<String, dynamic>> Function(DeeplinkRpcRequest) handle});

  @override
  $DeeplinkRpcRouteCopyWith<$Res> get route;
}

/// @nodoc
class __$$_DeeplinkRpcRequestHandlerCopyWithImpl<$Res>
    extends _$DeeplinkRpcRequestHandlerCopyWithImpl<$Res,
        _$_DeeplinkRpcRequestHandler>
    implements _$$_DeeplinkRpcRequestHandlerCopyWith<$Res> {
  __$$_DeeplinkRpcRequestHandlerCopyWithImpl(
      _$_DeeplinkRpcRequestHandler _value,
      $Res Function(_$_DeeplinkRpcRequestHandler) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? route = null,
    Object? handle = null,
  }) {
    return _then(_$_DeeplinkRpcRequestHandler(
      route: null == route
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as DeeplinkRpcRoute,
      handle: null == handle
          ? _value.handle
          : handle // ignore: cast_nullable_to_non_nullable
              as FutureOr<Map<String, dynamic>> Function(DeeplinkRpcRequest),
    ));
  }
}

/// @nodoc

class _$_DeeplinkRpcRequestHandler extends _DeeplinkRpcRequestHandler {
  const _$_DeeplinkRpcRequestHandler(
      {required this.route, required this.handle})
      : super._();

  @override
  final DeeplinkRpcRoute route;
  @override
  final FutureOr<Map<String, dynamic>> Function(DeeplinkRpcRequest) handle;

  @override
  String toString() {
    return 'DeeplinkRpcRequestHandler(route: $route, handle: $handle)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DeeplinkRpcRequestHandler &&
            (identical(other.route, route) || other.route == route) &&
            (identical(other.handle, handle) || other.handle == handle));
  }

  @override
  int get hashCode => Object.hash(runtimeType, route, handle);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DeeplinkRpcRequestHandlerCopyWith<_$_DeeplinkRpcRequestHandler>
      get copyWith => __$$_DeeplinkRpcRequestHandlerCopyWithImpl<
          _$_DeeplinkRpcRequestHandler>(this, _$identity);
}

abstract class _DeeplinkRpcRequestHandler extends DeeplinkRpcRequestHandler {
  const factory _DeeplinkRpcRequestHandler(
      {required final DeeplinkRpcRoute route,
      required final FutureOr<Map<String, dynamic>> Function(DeeplinkRpcRequest)
          handle}) = _$_DeeplinkRpcRequestHandler;
  const _DeeplinkRpcRequestHandler._() : super._();

  @override
  DeeplinkRpcRoute get route;
  @override
  FutureOr<Map<String, dynamic>> Function(DeeplinkRpcRequest) get handle;
  @override
  @JsonKey(ignore: true)
  _$$_DeeplinkRpcRequestHandlerCopyWith<_$_DeeplinkRpcRequestHandler>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DeeplinkRpcResponseHandler {
  DeeplinkRpcRoute get route => throw _privateConstructorUsedError;
  FutureOr<void> Function(DeeplinkRpcResponse) get handle =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DeeplinkRpcResponseHandlerCopyWith<DeeplinkRpcResponseHandler>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeeplinkRpcResponseHandlerCopyWith<$Res> {
  factory $DeeplinkRpcResponseHandlerCopyWith(DeeplinkRpcResponseHandler value,
          $Res Function(DeeplinkRpcResponseHandler) then) =
      _$DeeplinkRpcResponseHandlerCopyWithImpl<$Res,
          DeeplinkRpcResponseHandler>;
  @useResult
  $Res call(
      {DeeplinkRpcRoute route,
      FutureOr<void> Function(DeeplinkRpcResponse) handle});

  $DeeplinkRpcRouteCopyWith<$Res> get route;
}

/// @nodoc
class _$DeeplinkRpcResponseHandlerCopyWithImpl<$Res,
        $Val extends DeeplinkRpcResponseHandler>
    implements $DeeplinkRpcResponseHandlerCopyWith<$Res> {
  _$DeeplinkRpcResponseHandlerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? route = null,
    Object? handle = null,
  }) {
    return _then(_value.copyWith(
      route: null == route
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as DeeplinkRpcRoute,
      handle: null == handle
          ? _value.handle
          : handle // ignore: cast_nullable_to_non_nullable
              as FutureOr<void> Function(DeeplinkRpcResponse),
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DeeplinkRpcRouteCopyWith<$Res> get route {
    return $DeeplinkRpcRouteCopyWith<$Res>(_value.route, (value) {
      return _then(_value.copyWith(route: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_DeeplinkRpcResponseHandlerCopyWith<$Res>
    implements $DeeplinkRpcResponseHandlerCopyWith<$Res> {
  factory _$$_DeeplinkRpcResponseHandlerCopyWith(
          _$_DeeplinkRpcResponseHandler value,
          $Res Function(_$_DeeplinkRpcResponseHandler) then) =
      __$$_DeeplinkRpcResponseHandlerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DeeplinkRpcRoute route,
      FutureOr<void> Function(DeeplinkRpcResponse) handle});

  @override
  $DeeplinkRpcRouteCopyWith<$Res> get route;
}

/// @nodoc
class __$$_DeeplinkRpcResponseHandlerCopyWithImpl<$Res>
    extends _$DeeplinkRpcResponseHandlerCopyWithImpl<$Res,
        _$_DeeplinkRpcResponseHandler>
    implements _$$_DeeplinkRpcResponseHandlerCopyWith<$Res> {
  __$$_DeeplinkRpcResponseHandlerCopyWithImpl(
      _$_DeeplinkRpcResponseHandler _value,
      $Res Function(_$_DeeplinkRpcResponseHandler) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? route = null,
    Object? handle = null,
  }) {
    return _then(_$_DeeplinkRpcResponseHandler(
      route: null == route
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as DeeplinkRpcRoute,
      handle: null == handle
          ? _value.handle
          : handle // ignore: cast_nullable_to_non_nullable
              as FutureOr<void> Function(DeeplinkRpcResponse),
    ));
  }
}

/// @nodoc

class _$_DeeplinkRpcResponseHandler extends _DeeplinkRpcResponseHandler {
  const _$_DeeplinkRpcResponseHandler(
      {required this.route, required this.handle})
      : super._();

  @override
  final DeeplinkRpcRoute route;
  @override
  final FutureOr<void> Function(DeeplinkRpcResponse) handle;

  @override
  String toString() {
    return 'DeeplinkRpcResponseHandler(route: $route, handle: $handle)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DeeplinkRpcResponseHandler &&
            (identical(other.route, route) || other.route == route) &&
            (identical(other.handle, handle) || other.handle == handle));
  }

  @override
  int get hashCode => Object.hash(runtimeType, route, handle);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DeeplinkRpcResponseHandlerCopyWith<_$_DeeplinkRpcResponseHandler>
      get copyWith => __$$_DeeplinkRpcResponseHandlerCopyWithImpl<
          _$_DeeplinkRpcResponseHandler>(this, _$identity);
}

abstract class _DeeplinkRpcResponseHandler extends DeeplinkRpcResponseHandler {
  const factory _DeeplinkRpcResponseHandler(
          {required final DeeplinkRpcRoute route,
          required final FutureOr<void> Function(DeeplinkRpcResponse) handle}) =
      _$_DeeplinkRpcResponseHandler;
  const _DeeplinkRpcResponseHandler._() : super._();

  @override
  DeeplinkRpcRoute get route;
  @override
  FutureOr<void> Function(DeeplinkRpcResponse) get handle;
  @override
  @JsonKey(ignore: true)
  _$$_DeeplinkRpcResponseHandlerCopyWith<_$_DeeplinkRpcResponseHandler>
      get copyWith => throw _privateConstructorUsedError;
}
