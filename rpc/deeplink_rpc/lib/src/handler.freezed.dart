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
mixin _$DeeplinkRpcHandler {
  DeeplinkRpcRoute get route => throw _privateConstructorUsedError;
  Future<Map<String, dynamic>> Function(DeeplinkRpcRequest) get handle =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DeeplinkRpcHandlerCopyWith<DeeplinkRpcHandler> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeeplinkRpcHandlerCopyWith<$Res> {
  factory $DeeplinkRpcHandlerCopyWith(
          DeeplinkRpcHandler value, $Res Function(DeeplinkRpcHandler) then) =
      _$DeeplinkRpcHandlerCopyWithImpl<$Res, DeeplinkRpcHandler>;
  @useResult
  $Res call(
      {DeeplinkRpcRoute route,
      Future<Map<String, dynamic>> Function(DeeplinkRpcRequest) handle});

  $DeeplinkRpcRouteCopyWith<$Res> get route;
}

/// @nodoc
class _$DeeplinkRpcHandlerCopyWithImpl<$Res, $Val extends DeeplinkRpcHandler>
    implements $DeeplinkRpcHandlerCopyWith<$Res> {
  _$DeeplinkRpcHandlerCopyWithImpl(this._value, this._then);

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
              as Future<Map<String, dynamic>> Function(DeeplinkRpcRequest),
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
abstract class _$$_DeeplinkRpcHandlerCopyWith<$Res>
    implements $DeeplinkRpcHandlerCopyWith<$Res> {
  factory _$$_DeeplinkRpcHandlerCopyWith(_$_DeeplinkRpcHandler value,
          $Res Function(_$_DeeplinkRpcHandler) then) =
      __$$_DeeplinkRpcHandlerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DeeplinkRpcRoute route,
      Future<Map<String, dynamic>> Function(DeeplinkRpcRequest) handle});

  @override
  $DeeplinkRpcRouteCopyWith<$Res> get route;
}

/// @nodoc
class __$$_DeeplinkRpcHandlerCopyWithImpl<$Res>
    extends _$DeeplinkRpcHandlerCopyWithImpl<$Res, _$_DeeplinkRpcHandler>
    implements _$$_DeeplinkRpcHandlerCopyWith<$Res> {
  __$$_DeeplinkRpcHandlerCopyWithImpl(
      _$_DeeplinkRpcHandler _value, $Res Function(_$_DeeplinkRpcHandler) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? route = null,
    Object? handle = null,
  }) {
    return _then(_$_DeeplinkRpcHandler(
      route: null == route
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as DeeplinkRpcRoute,
      handle: null == handle
          ? _value.handle
          : handle // ignore: cast_nullable_to_non_nullable
              as Future<Map<String, dynamic>> Function(DeeplinkRpcRequest),
    ));
  }
}

/// @nodoc

class _$_DeeplinkRpcHandler extends _DeeplinkRpcHandler {
  const _$_DeeplinkRpcHandler({required this.route, required this.handle})
      : super._();

  @override
  final DeeplinkRpcRoute route;
  @override
  final Future<Map<String, dynamic>> Function(DeeplinkRpcRequest) handle;

  @override
  String toString() {
    return 'DeeplinkRpcHandler(route: $route, handle: $handle)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DeeplinkRpcHandler &&
            (identical(other.route, route) || other.route == route) &&
            (identical(other.handle, handle) || other.handle == handle));
  }

  @override
  int get hashCode => Object.hash(runtimeType, route, handle);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DeeplinkRpcHandlerCopyWith<_$_DeeplinkRpcHandler> get copyWith =>
      __$$_DeeplinkRpcHandlerCopyWithImpl<_$_DeeplinkRpcHandler>(
          this, _$identity);
}

abstract class _DeeplinkRpcHandler extends DeeplinkRpcHandler {
  const factory _DeeplinkRpcHandler(
      {required final DeeplinkRpcRoute route,
      required final Future<Map<String, dynamic>> Function(DeeplinkRpcRequest)
          handle}) = _$_DeeplinkRpcHandler;
  const _DeeplinkRpcHandler._() : super._();

  @override
  DeeplinkRpcRoute get route;
  @override
  Future<Map<String, dynamic>> Function(DeeplinkRpcRequest) get handle;
  @override
  @JsonKey(ignore: true)
  _$$_DeeplinkRpcHandlerCopyWith<_$_DeeplinkRpcHandler> get copyWith =>
      throw _privateConstructorUsedError;
}
