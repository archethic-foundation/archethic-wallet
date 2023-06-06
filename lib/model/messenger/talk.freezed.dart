// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'talk.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Talk {
  @HiveField(0)
  String get address => throw _privateConstructorUsedError;
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TalkCopyWith<Talk> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TalkCopyWith<$Res> {
  factory $TalkCopyWith(Talk value, $Res Function(Talk) then) =
      _$TalkCopyWithImpl<$Res, Talk>;
  @useResult
  $Res call({@HiveField(0) String address, @HiveField(1) String name});
}

/// @nodoc
class _$TalkCopyWithImpl<$Res, $Val extends Talk>
    implements $TalkCopyWith<$Res> {
  _$TalkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TalkCopyWith<$Res> implements $TalkCopyWith<$Res> {
  factory _$$_TalkCopyWith(_$_Talk value, $Res Function(_$_Talk) then) =
      __$$_TalkCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@HiveField(0) String address, @HiveField(1) String name});
}

/// @nodoc
class __$$_TalkCopyWithImpl<$Res> extends _$TalkCopyWithImpl<$Res, _$_Talk>
    implements _$$_TalkCopyWith<$Res> {
  __$$_TalkCopyWithImpl(_$_Talk _value, $Res Function(_$_Talk) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? name = null,
  }) {
    return _then(_$_Talk(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@HiveType(typeId: HiveTypeIds.talk)
class _$_Talk extends _Talk {
  const _$_Talk(
      {@HiveField(0) required this.address, @HiveField(1) required this.name})
      : super._();

  @override
  @HiveField(0)
  final String address;
  @override
  @HiveField(1)
  final String name;

  @override
  String toString() {
    return 'Talk(address: $address, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Talk &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, address, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TalkCopyWith<_$_Talk> get copyWith =>
      __$$_TalkCopyWithImpl<_$_Talk>(this, _$identity);
}

abstract class _Talk extends Talk {
  const factory _Talk(
      {@HiveField(0) required final String address,
      @HiveField(1) required final String name}) = _$_Talk;
  const _Talk._() : super._();

  @override
  @HiveField(0)
  String get address;
  @override
  @HiveField(1)
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_TalkCopyWith<_$_Talk> get copyWith => throw _privateConstructorUsedError;
}
