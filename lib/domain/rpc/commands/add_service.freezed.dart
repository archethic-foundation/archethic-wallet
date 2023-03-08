// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RPCAddServiceCommandData {
  /// - Name: service's name
  String get name => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RPCAddServiceCommandDataCopyWith<RPCAddServiceCommandData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RPCAddServiceCommandDataCopyWith<$Res> {
  factory $RPCAddServiceCommandDataCopyWith(RPCAddServiceCommandData value,
          $Res Function(RPCAddServiceCommandData) then) =
      _$RPCAddServiceCommandDataCopyWithImpl<$Res, RPCAddServiceCommandData>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class _$RPCAddServiceCommandDataCopyWithImpl<$Res,
        $Val extends RPCAddServiceCommandData>
    implements $RPCAddServiceCommandDataCopyWith<$Res> {
  _$RPCAddServiceCommandDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RPCAddServiceCommandDataCopyWith<$Res>
    implements $RPCAddServiceCommandDataCopyWith<$Res> {
  factory _$$_RPCAddServiceCommandDataCopyWith(
          _$_RPCAddServiceCommandData value,
          $Res Function(_$_RPCAddServiceCommandData) then) =
      __$$_RPCAddServiceCommandDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$_RPCAddServiceCommandDataCopyWithImpl<$Res>
    extends _$RPCAddServiceCommandDataCopyWithImpl<$Res,
        _$_RPCAddServiceCommandData>
    implements _$$_RPCAddServiceCommandDataCopyWith<$Res> {
  __$$_RPCAddServiceCommandDataCopyWithImpl(_$_RPCAddServiceCommandData _value,
      $Res Function(_$_RPCAddServiceCommandData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$_RPCAddServiceCommandData(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_RPCAddServiceCommandData extends _RPCAddServiceCommandData {
  const _$_RPCAddServiceCommandData({required this.name}) : super._();

  /// - Name: service's name
  @override
  final String name;

  @override
  String toString() {
    return 'RPCAddServiceCommandData(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RPCAddServiceCommandData &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RPCAddServiceCommandDataCopyWith<_$_RPCAddServiceCommandData>
      get copyWith => __$$_RPCAddServiceCommandDataCopyWithImpl<
          _$_RPCAddServiceCommandData>(this, _$identity);
}

abstract class _RPCAddServiceCommandData extends RPCAddServiceCommandData {
  const factory _RPCAddServiceCommandData({required final String name}) =
      _$_RPCAddServiceCommandData;
  const _RPCAddServiceCommandData._() : super._();

  @override

  /// - Name: service's name
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_RPCAddServiceCommandDataCopyWith<_$_RPCAddServiceCommandData>
      get copyWith => throw _privateConstructorUsedError;
}
