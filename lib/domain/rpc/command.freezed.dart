// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'command.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RPCCommand<T> {
  T get data => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(RPCSessionOrigin origin, T data) authenticated,
    required TResult Function(T data) anonymous,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(RPCSessionOrigin origin, T data)? authenticated,
    TResult? Function(T data)? anonymous,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(RPCSessionOrigin origin, T data)? authenticated,
    TResult Function(T data)? anonymous,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RPCAuthenticatedCommand<T> value) authenticated,
    required TResult Function(RPCAnonymousCommand<T> value) anonymous,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RPCAuthenticatedCommand<T> value)? authenticated,
    TResult? Function(RPCAnonymousCommand<T> value)? anonymous,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RPCAuthenticatedCommand<T> value)? authenticated,
    TResult Function(RPCAnonymousCommand<T> value)? anonymous,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RPCCommandCopyWith<T, RPCCommand<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RPCCommandCopyWith<T, $Res> {
  factory $RPCCommandCopyWith(
          RPCCommand<T> value, $Res Function(RPCCommand<T>) then) =
      _$RPCCommandCopyWithImpl<T, $Res, RPCCommand<T>>;
  @useResult
  $Res call({T data});
}

/// @nodoc
class _$RPCCommandCopyWithImpl<T, $Res, $Val extends RPCCommand<T>>
    implements $RPCCommandCopyWith<T, $Res> {
  _$RPCCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RPCAuthenticatedCommandImplCopyWith<T, $Res>
    implements $RPCCommandCopyWith<T, $Res> {
  factory _$$RPCAuthenticatedCommandImplCopyWith(
          _$RPCAuthenticatedCommandImpl<T> value,
          $Res Function(_$RPCAuthenticatedCommandImpl<T>) then) =
      __$$RPCAuthenticatedCommandImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({RPCSessionOrigin origin, T data});

  $RPCSessionOriginCopyWith<$Res> get origin;
}

/// @nodoc
class __$$RPCAuthenticatedCommandImplCopyWithImpl<T, $Res>
    extends _$RPCCommandCopyWithImpl<T, $Res, _$RPCAuthenticatedCommandImpl<T>>
    implements _$$RPCAuthenticatedCommandImplCopyWith<T, $Res> {
  __$$RPCAuthenticatedCommandImplCopyWithImpl(
      _$RPCAuthenticatedCommandImpl<T> _value,
      $Res Function(_$RPCAuthenticatedCommandImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? origin = null,
    Object? data = freezed,
  }) {
    return _then(_$RPCAuthenticatedCommandImpl<T>(
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as RPCSessionOrigin,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $RPCSessionOriginCopyWith<$Res> get origin {
    return $RPCSessionOriginCopyWith<$Res>(_value.origin, (value) {
      return _then(_value.copyWith(origin: value));
    });
  }
}

/// @nodoc

class _$RPCAuthenticatedCommandImpl<T> extends RPCAuthenticatedCommand<T> {
  const _$RPCAuthenticatedCommandImpl(
      {required this.origin, required this.data})
      : super._();

  @override
  final RPCSessionOrigin origin;
  @override
  final T data;

  @override
  String toString() {
    return 'RPCCommand<$T>.authenticated(origin: $origin, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RPCAuthenticatedCommandImpl<T> &&
            (identical(other.origin, origin) || other.origin == origin) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, origin, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RPCAuthenticatedCommandImplCopyWith<T, _$RPCAuthenticatedCommandImpl<T>>
      get copyWith => __$$RPCAuthenticatedCommandImplCopyWithImpl<T,
          _$RPCAuthenticatedCommandImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(RPCSessionOrigin origin, T data) authenticated,
    required TResult Function(T data) anonymous,
  }) {
    return authenticated(origin, data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(RPCSessionOrigin origin, T data)? authenticated,
    TResult? Function(T data)? anonymous,
  }) {
    return authenticated?.call(origin, data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(RPCSessionOrigin origin, T data)? authenticated,
    TResult Function(T data)? anonymous,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(origin, data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RPCAuthenticatedCommand<T> value) authenticated,
    required TResult Function(RPCAnonymousCommand<T> value) anonymous,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RPCAuthenticatedCommand<T> value)? authenticated,
    TResult? Function(RPCAnonymousCommand<T> value)? anonymous,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RPCAuthenticatedCommand<T> value)? authenticated,
    TResult Function(RPCAnonymousCommand<T> value)? anonymous,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class RPCAuthenticatedCommand<T> extends RPCCommand<T> {
  const factory RPCAuthenticatedCommand(
      {required final RPCSessionOrigin origin,
      required final T data}) = _$RPCAuthenticatedCommandImpl<T>;
  const RPCAuthenticatedCommand._() : super._();

  RPCSessionOrigin get origin;
  @override
  T get data;
  @override
  @JsonKey(ignore: true)
  _$$RPCAuthenticatedCommandImplCopyWith<T, _$RPCAuthenticatedCommandImpl<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RPCAnonymousCommandImplCopyWith<T, $Res>
    implements $RPCCommandCopyWith<T, $Res> {
  factory _$$RPCAnonymousCommandImplCopyWith(_$RPCAnonymousCommandImpl<T> value,
          $Res Function(_$RPCAnonymousCommandImpl<T>) then) =
      __$$RPCAnonymousCommandImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({T data});
}

/// @nodoc
class __$$RPCAnonymousCommandImplCopyWithImpl<T, $Res>
    extends _$RPCCommandCopyWithImpl<T, $Res, _$RPCAnonymousCommandImpl<T>>
    implements _$$RPCAnonymousCommandImplCopyWith<T, $Res> {
  __$$RPCAnonymousCommandImplCopyWithImpl(_$RPCAnonymousCommandImpl<T> _value,
      $Res Function(_$RPCAnonymousCommandImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$RPCAnonymousCommandImpl<T>(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$RPCAnonymousCommandImpl<T> extends RPCAnonymousCommand<T> {
  const _$RPCAnonymousCommandImpl({required this.data}) : super._();

  @override
  final T data;

  @override
  String toString() {
    return 'RPCCommand<$T>.anonymous(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RPCAnonymousCommandImpl<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RPCAnonymousCommandImplCopyWith<T, _$RPCAnonymousCommandImpl<T>>
      get copyWith => __$$RPCAnonymousCommandImplCopyWithImpl<T,
          _$RPCAnonymousCommandImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(RPCSessionOrigin origin, T data) authenticated,
    required TResult Function(T data) anonymous,
  }) {
    return anonymous(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(RPCSessionOrigin origin, T data)? authenticated,
    TResult? Function(T data)? anonymous,
  }) {
    return anonymous?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(RPCSessionOrigin origin, T data)? authenticated,
    TResult Function(T data)? anonymous,
    required TResult orElse(),
  }) {
    if (anonymous != null) {
      return anonymous(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RPCAuthenticatedCommand<T> value) authenticated,
    required TResult Function(RPCAnonymousCommand<T> value) anonymous,
  }) {
    return anonymous(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RPCAuthenticatedCommand<T> value)? authenticated,
    TResult? Function(RPCAnonymousCommand<T> value)? anonymous,
  }) {
    return anonymous?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RPCAuthenticatedCommand<T> value)? authenticated,
    TResult Function(RPCAnonymousCommand<T> value)? anonymous,
    required TResult orElse(),
  }) {
    if (anonymous != null) {
      return anonymous(this);
    }
    return orElse();
  }
}

abstract class RPCAnonymousCommand<T> extends RPCCommand<T> {
  const factory RPCAnonymousCommand({required final T data}) =
      _$RPCAnonymousCommandImpl<T>;
  const RPCAnonymousCommand._() : super._();

  @override
  T get data;
  @override
  @JsonKey(ignore: true)
  _$$RPCAnonymousCommandImplCopyWith<T, _$RPCAnonymousCommandImpl<T>>
      get copyWith => throw _privateConstructorUsedError;
}
