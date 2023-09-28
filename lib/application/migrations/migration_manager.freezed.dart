// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'migration_manager.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LocalDataMigrationState {
  bool get migrationInProgress => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LocalDataMigrationStateCopyWith<LocalDataMigrationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalDataMigrationStateCopyWith<$Res> {
  factory $LocalDataMigrationStateCopyWith(LocalDataMigrationState value,
          $Res Function(LocalDataMigrationState) then) =
      _$LocalDataMigrationStateCopyWithImpl<$Res, LocalDataMigrationState>;
  @useResult
  $Res call({bool migrationInProgress});
}

/// @nodoc
class _$LocalDataMigrationStateCopyWithImpl<$Res,
        $Val extends LocalDataMigrationState>
    implements $LocalDataMigrationStateCopyWith<$Res> {
  _$LocalDataMigrationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? migrationInProgress = null,
  }) {
    return _then(_value.copyWith(
      migrationInProgress: null == migrationInProgress
          ? _value.migrationInProgress
          : migrationInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LocalDataMigrationStateCopyWith<$Res>
    implements $LocalDataMigrationStateCopyWith<$Res> {
  factory _$$_LocalDataMigrationStateCopyWith(_$_LocalDataMigrationState value,
          $Res Function(_$_LocalDataMigrationState) then) =
      __$$_LocalDataMigrationStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool migrationInProgress});
}

/// @nodoc
class __$$_LocalDataMigrationStateCopyWithImpl<$Res>
    extends _$LocalDataMigrationStateCopyWithImpl<$Res,
        _$_LocalDataMigrationState>
    implements _$$_LocalDataMigrationStateCopyWith<$Res> {
  __$$_LocalDataMigrationStateCopyWithImpl(_$_LocalDataMigrationState _value,
      $Res Function(_$_LocalDataMigrationState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? migrationInProgress = null,
  }) {
    return _then(_$_LocalDataMigrationState(
      migrationInProgress: null == migrationInProgress
          ? _value.migrationInProgress
          : migrationInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_LocalDataMigrationState extends _LocalDataMigrationState {
  const _$_LocalDataMigrationState({this.migrationInProgress = false})
      : super._();

  @override
  @JsonKey()
  final bool migrationInProgress;

  @override
  String toString() {
    return 'LocalDataMigrationState(migrationInProgress: $migrationInProgress)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LocalDataMigrationState &&
            (identical(other.migrationInProgress, migrationInProgress) ||
                other.migrationInProgress == migrationInProgress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, migrationInProgress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LocalDataMigrationStateCopyWith<_$_LocalDataMigrationState>
      get copyWith =>
          __$$_LocalDataMigrationStateCopyWithImpl<_$_LocalDataMigrationState>(
              this, _$identity);
}

abstract class _LocalDataMigrationState extends LocalDataMigrationState {
  const factory _LocalDataMigrationState({final bool migrationInProgress}) =
      _$_LocalDataMigrationState;
  const _LocalDataMigrationState._() : super._();

  @override
  bool get migrationInProgress;
  @override
  @JsonKey(ignore: true)
  _$$_LocalDataMigrationStateCopyWith<_$_LocalDataMigrationState>
      get copyWith => throw _privateConstructorUsedError;
}
