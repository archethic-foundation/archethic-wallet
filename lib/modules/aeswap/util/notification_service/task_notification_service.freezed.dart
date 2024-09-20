// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_notification_service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Task<DataT, FailureT extends Failure> {
  String get id => throw _privateConstructorUsedError;
  DataT get data => throw _privateConstructorUsedError;
  DateTime? get dateTask => throw _privateConstructorUsedError;
  Result<void, FailureT>? get result => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TaskCopyWith<DataT, FailureT, Task<DataT, FailureT>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskCopyWith<DataT, FailureT extends Failure, $Res> {
  factory $TaskCopyWith(Task<DataT, FailureT> value,
          $Res Function(Task<DataT, FailureT>) then) =
      _$TaskCopyWithImpl<DataT, FailureT, $Res, Task<DataT, FailureT>>;
  @useResult
  $Res call(
      {String id,
      DataT data,
      DateTime? dateTask,
      Result<void, FailureT>? result});
}

/// @nodoc
class _$TaskCopyWithImpl<DataT, FailureT extends Failure, $Res,
        $Val extends Task<DataT, FailureT>>
    implements $TaskCopyWith<DataT, FailureT, $Res> {
  _$TaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? data = freezed,
    Object? dateTask = freezed,
    Object? result = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as DataT,
      dateTask: freezed == dateTask
          ? _value.dateTask
          : dateTask // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as Result<void, FailureT>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskImplCopyWith<DataT, FailureT extends Failure, $Res>
    implements $TaskCopyWith<DataT, FailureT, $Res> {
  factory _$$TaskImplCopyWith(_$TaskImpl<DataT, FailureT> value,
          $Res Function(_$TaskImpl<DataT, FailureT>) then) =
      __$$TaskImplCopyWithImpl<DataT, FailureT, $Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DataT data,
      DateTime? dateTask,
      Result<void, FailureT>? result});
}

/// @nodoc
class __$$TaskImplCopyWithImpl<DataT, FailureT extends Failure, $Res>
    extends _$TaskCopyWithImpl<DataT, FailureT, $Res,
        _$TaskImpl<DataT, FailureT>>
    implements _$$TaskImplCopyWith<DataT, FailureT, $Res> {
  __$$TaskImplCopyWithImpl(_$TaskImpl<DataT, FailureT> _value,
      $Res Function(_$TaskImpl<DataT, FailureT>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? data = freezed,
    Object? dateTask = freezed,
    Object? result = freezed,
  }) {
    return _then(_$TaskImpl<DataT, FailureT>(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as DataT,
      dateTask: freezed == dateTask
          ? _value.dateTask
          : dateTask // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as Result<void, FailureT>?,
    ));
  }
}

/// @nodoc

class _$TaskImpl<DataT, FailureT extends Failure>
    extends _Task<DataT, FailureT> {
  const _$TaskImpl(
      {required this.id, required this.data, this.dateTask, this.result})
      : super._();

  @override
  final String id;
  @override
  final DataT data;
  @override
  final DateTime? dateTask;
  @override
  final Result<void, FailureT>? result;

  @override
  String toString() {
    return 'Task<$DataT, $FailureT>(id: $id, data: $data, dateTask: $dateTask, result: $result)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskImpl<DataT, FailureT> &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.dateTask, dateTask) ||
                other.dateTask == dateTask) &&
            (identical(other.result, result) || other.result == result));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id,
      const DeepCollectionEquality().hash(data), dateTask, result);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskImplCopyWith<DataT, FailureT, _$TaskImpl<DataT, FailureT>>
      get copyWith => __$$TaskImplCopyWithImpl<DataT, FailureT,
          _$TaskImpl<DataT, FailureT>>(this, _$identity);
}

abstract class _Task<DataT, FailureT extends Failure>
    extends Task<DataT, FailureT> {
  const factory _Task(
      {required final String id,
      required final DataT data,
      final DateTime? dateTask,
      final Result<void, FailureT>? result}) = _$TaskImpl<DataT, FailureT>;
  const _Task._() : super._();

  @override
  String get id;
  @override
  DataT get data;
  @override
  DateTime? get dateTask;
  @override
  Result<void, FailureT>? get result;
  @override
  @JsonKey(ignore: true)
  _$$TaskImplCopyWith<DataT, FailureT, _$TaskImpl<DataT, FailureT>>
      get copyWith => throw _privateConstructorUsedError;
}
