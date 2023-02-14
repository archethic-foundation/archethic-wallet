// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'usecase.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UseCaseProgress {
  int get progress => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UseCaseProgressCopyWith<UseCaseProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UseCaseProgressCopyWith<$Res> {
  factory $UseCaseProgressCopyWith(
          UseCaseProgress value, $Res Function(UseCaseProgress) then) =
      _$UseCaseProgressCopyWithImpl<$Res, UseCaseProgress>;
  @useResult
  $Res call({int progress, int total});
}

/// @nodoc
class _$UseCaseProgressCopyWithImpl<$Res, $Val extends UseCaseProgress>
    implements $UseCaseProgressCopyWith<$Res> {
  _$UseCaseProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? progress = null,
    Object? total = null,
  }) {
    return _then(_value.copyWith(
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UseCaseProgressCopyWith<$Res>
    implements $UseCaseProgressCopyWith<$Res> {
  factory _$$_UseCaseProgressCopyWith(
          _$_UseCaseProgress value, $Res Function(_$_UseCaseProgress) then) =
      __$$_UseCaseProgressCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int progress, int total});
}

/// @nodoc
class __$$_UseCaseProgressCopyWithImpl<$Res>
    extends _$UseCaseProgressCopyWithImpl<$Res, _$_UseCaseProgress>
    implements _$$_UseCaseProgressCopyWith<$Res> {
  __$$_UseCaseProgressCopyWithImpl(
      _$_UseCaseProgress _value, $Res Function(_$_UseCaseProgress) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? progress = null,
    Object? total = null,
  }) {
    return _then(_$_UseCaseProgress(
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_UseCaseProgress extends _UseCaseProgress {
  const _$_UseCaseProgress({required this.progress, required this.total})
      : super._();

  @override
  final int progress;
  @override
  final int total;

  @override
  String toString() {
    return 'UseCaseProgress(progress: $progress, total: $total)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UseCaseProgress &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.total, total) || other.total == total));
  }

  @override
  int get hashCode => Object.hash(runtimeType, progress, total);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UseCaseProgressCopyWith<_$_UseCaseProgress> get copyWith =>
      __$$_UseCaseProgressCopyWithImpl<_$_UseCaseProgress>(this, _$identity);
}

abstract class _UseCaseProgress extends UseCaseProgress {
  const factory _UseCaseProgress(
      {required final int progress,
      required final int total}) = _$_UseCaseProgress;
  const _UseCaseProgress._() : super._();

  @override
  int get progress;
  @override
  int get total;
  @override
  @JsonKey(ignore: true)
  _$$_UseCaseProgressCopyWith<_$_UseCaseProgress> get copyWith =>
      throw _privateConstructorUsedError;
}
