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
mixin _$RPCCommandOrigin {
  String get name => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  String? get logo => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RPCCommandOriginCopyWith<RPCCommandOrigin> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RPCCommandOriginCopyWith<$Res> {
  factory $RPCCommandOriginCopyWith(
          RPCCommandOrigin value, $Res Function(RPCCommandOrigin) then) =
      _$RPCCommandOriginCopyWithImpl<$Res, RPCCommandOrigin>;
  @useResult
  $Res call({String name, String? url, String? logo});
}

/// @nodoc
class _$RPCCommandOriginCopyWithImpl<$Res, $Val extends RPCCommandOrigin>
    implements $RPCCommandOriginCopyWith<$Res> {
  _$RPCCommandOriginCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? url = freezed,
    Object? logo = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      logo: freezed == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RPCCommandOriginCopyWith<$Res>
    implements $RPCCommandOriginCopyWith<$Res> {
  factory _$$_RPCCommandOriginCopyWith(
          _$_RPCCommandOrigin value, $Res Function(_$_RPCCommandOrigin) then) =
      __$$_RPCCommandOriginCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String? url, String? logo});
}

/// @nodoc
class __$$_RPCCommandOriginCopyWithImpl<$Res>
    extends _$RPCCommandOriginCopyWithImpl<$Res, _$_RPCCommandOrigin>
    implements _$$_RPCCommandOriginCopyWith<$Res> {
  __$$_RPCCommandOriginCopyWithImpl(
      _$_RPCCommandOrigin _value, $Res Function(_$_RPCCommandOrigin) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? url = freezed,
    Object? logo = freezed,
  }) {
    return _then(_$_RPCCommandOrigin(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      logo: freezed == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_RPCCommandOrigin extends _RPCCommandOrigin {
  const _$_RPCCommandOrigin({required this.name, this.url, this.logo})
      : super._();

  @override
  final String name;
  @override
  final String? url;
  @override
  final String? logo;

  @override
  String toString() {
    return 'RPCCommandOrigin(name: $name, url: $url, logo: $logo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RPCCommandOrigin &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.logo, logo) || other.logo == logo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, url, logo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RPCCommandOriginCopyWith<_$_RPCCommandOrigin> get copyWith =>
      __$$_RPCCommandOriginCopyWithImpl<_$_RPCCommandOrigin>(this, _$identity);
}

abstract class _RPCCommandOrigin extends RPCCommandOrigin {
  const factory _RPCCommandOrigin(
      {required final String name,
      final String? url,
      final String? logo}) = _$_RPCCommandOrigin;
  const _RPCCommandOrigin._() : super._();

  @override
  String get name;
  @override
  String? get url;
  @override
  String? get logo;
  @override
  @JsonKey(ignore: true)
  _$$_RPCCommandOriginCopyWith<_$_RPCCommandOrigin> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RPCCommand<T> {
  RPCCommandOrigin get origin => throw _privateConstructorUsedError;
  T get data => throw _privateConstructorUsedError;

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
  $Res call({RPCCommandOrigin origin, T data});

  $RPCCommandOriginCopyWith<$Res> get origin;
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
    Object? origin = null,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as RPCCommandOrigin,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
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
abstract class _$$_RPCCommandCopyWith<T, $Res>
    implements $RPCCommandCopyWith<T, $Res> {
  factory _$$_RPCCommandCopyWith(
          _$_RPCCommand<T> value, $Res Function(_$_RPCCommand<T>) then) =
      __$$_RPCCommandCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({RPCCommandOrigin origin, T data});

  @override
  $RPCCommandOriginCopyWith<$Res> get origin;
}

/// @nodoc
class __$$_RPCCommandCopyWithImpl<T, $Res>
    extends _$RPCCommandCopyWithImpl<T, $Res, _$_RPCCommand<T>>
    implements _$$_RPCCommandCopyWith<T, $Res> {
  __$$_RPCCommandCopyWithImpl(
      _$_RPCCommand<T> _value, $Res Function(_$_RPCCommand<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? origin = null,
    Object? data = freezed,
  }) {
    return _then(_$_RPCCommand<T>(
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as RPCCommandOrigin,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$_RPCCommand<T> extends _RPCCommand<T> {
  const _$_RPCCommand({required this.origin, required this.data}) : super._();

  @override
  final RPCCommandOrigin origin;
  @override
  final T data;

  @override
  String toString() {
    return 'RPCCommand<$T>(origin: $origin, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RPCCommand<T> &&
            (identical(other.origin, origin) || other.origin == origin) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, origin, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RPCCommandCopyWith<T, _$_RPCCommand<T>> get copyWith =>
      __$$_RPCCommandCopyWithImpl<T, _$_RPCCommand<T>>(this, _$identity);
}

abstract class _RPCCommand<T> extends RPCCommand<T> {
  const factory _RPCCommand(
      {required final RPCCommandOrigin origin,
      required final T data}) = _$_RPCCommand<T>;
  const _RPCCommand._() : super._();

  @override
  RPCCommandOrigin get origin;
  @override
  T get data;
  @override
  @JsonKey(ignore: true)
  _$$_RPCCommandCopyWith<T, _$_RPCCommand<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
