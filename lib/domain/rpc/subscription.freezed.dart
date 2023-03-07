// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RPCSubscription<R> {
  String get id => throw _privateConstructorUsedError;
  Stream<R> get updates => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RPCSubscriptionCopyWith<R, RPCSubscription<R>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RPCSubscriptionCopyWith<R, $Res> {
  factory $RPCSubscriptionCopyWith(
          RPCSubscription<R> value, $Res Function(RPCSubscription<R>) then) =
      _$RPCSubscriptionCopyWithImpl<R, $Res, RPCSubscription<R>>;
  @useResult
  $Res call({String id, Stream<R> updates});
}

/// @nodoc
class _$RPCSubscriptionCopyWithImpl<R, $Res, $Val extends RPCSubscription<R>>
    implements $RPCSubscriptionCopyWith<R, $Res> {
  _$RPCSubscriptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? updates = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      updates: null == updates
          ? _value.updates
          : updates // ignore: cast_nullable_to_non_nullable
              as Stream<R>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RPCSubscriptionCopyWith<R, $Res>
    implements $RPCSubscriptionCopyWith<R, $Res> {
  factory _$$_RPCSubscriptionCopyWith(_$_RPCSubscription<R> value,
          $Res Function(_$_RPCSubscription<R>) then) =
      __$$_RPCSubscriptionCopyWithImpl<R, $Res>;
  @override
  @useResult
  $Res call({String id, Stream<R> updates});
}

/// @nodoc
class __$$_RPCSubscriptionCopyWithImpl<R, $Res>
    extends _$RPCSubscriptionCopyWithImpl<R, $Res, _$_RPCSubscription<R>>
    implements _$$_RPCSubscriptionCopyWith<R, $Res> {
  __$$_RPCSubscriptionCopyWithImpl(
      _$_RPCSubscription<R> _value, $Res Function(_$_RPCSubscription<R>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? updates = null,
  }) {
    return _then(_$_RPCSubscription<R>(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      updates: null == updates
          ? _value.updates
          : updates // ignore: cast_nullable_to_non_nullable
              as Stream<R>,
    ));
  }
}

/// @nodoc

class _$_RPCSubscription<R> extends _RPCSubscription<R> {
  const _$_RPCSubscription({required this.id, required this.updates})
      : super._();

  @override
  final String id;
  @override
  final Stream<R> updates;

  @override
  String toString() {
    return 'RPCSubscription<$R>(id: $id, updates: $updates)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RPCSubscription<R> &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.updates, updates) || other.updates == updates));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, updates);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RPCSubscriptionCopyWith<R, _$_RPCSubscription<R>> get copyWith =>
      __$$_RPCSubscriptionCopyWithImpl<R, _$_RPCSubscription<R>>(
          this, _$identity);
}

abstract class _RPCSubscription<R> extends RPCSubscription<R> {
  const factory _RPCSubscription(
      {required final String id,
      required final Stream<R> updates}) = _$_RPCSubscription<R>;
  const _RPCSubscription._() : super._();

  @override
  String get id;
  @override
  Stream<R> get updates;
  @override
  @JsonKey(ignore: true)
  _$$_RPCSubscriptionCopyWith<R, _$_RPCSubscription<R>> get copyWith =>
      throw _privateConstructorUsedError;
}
