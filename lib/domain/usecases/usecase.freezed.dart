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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UseCaseProgress {
  int get progress => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;

  /// Create a copy of UseCaseProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of UseCaseProgress
  /// with the given fields replaced by the non-null parameter values.
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
abstract class _$$UseCaseProgressImplCopyWith<$Res>
    implements $UseCaseProgressCopyWith<$Res> {
  factory _$$UseCaseProgressImplCopyWith(_$UseCaseProgressImpl value,
          $Res Function(_$UseCaseProgressImpl) then) =
      __$$UseCaseProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int progress, int total});
}

/// @nodoc
class __$$UseCaseProgressImplCopyWithImpl<$Res>
    extends _$UseCaseProgressCopyWithImpl<$Res, _$UseCaseProgressImpl>
    implements _$$UseCaseProgressImplCopyWith<$Res> {
  __$$UseCaseProgressImplCopyWithImpl(
      _$UseCaseProgressImpl _value, $Res Function(_$UseCaseProgressImpl) _then)
      : super(_value, _then);

  /// Create a copy of UseCaseProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? progress = null,
    Object? total = null,
  }) {
    return _then(_$UseCaseProgressImpl(
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

class _$UseCaseProgressImpl extends _UseCaseProgress {
  const _$UseCaseProgressImpl({required this.progress, required this.total})
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UseCaseProgressImpl &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.total, total) || other.total == total));
  }

  @override
  int get hashCode => Object.hash(runtimeType, progress, total);

  /// Create a copy of UseCaseProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UseCaseProgressImplCopyWith<_$UseCaseProgressImpl> get copyWith =>
      __$$UseCaseProgressImplCopyWithImpl<_$UseCaseProgressImpl>(
          this, _$identity);
}

abstract class _UseCaseProgress extends UseCaseProgress {
  const factory _UseCaseProgress(
      {required final int progress,
      required final int total}) = _$UseCaseProgressImpl;
  const _UseCaseProgress._() : super._();

  @override
  int get progress;
  @override
  int get total;

  /// Create a copy of UseCaseProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UseCaseProgressImplCopyWith<_$UseCaseProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
