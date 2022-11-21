// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AddAccountFormState {
  String get seed => throw _privateConstructorUsedError;
  AddAccountProcessStep get addAccountProcessStep =>
      throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get errorText => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AddAccountFormStateCopyWith<AddAccountFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddAccountFormStateCopyWith<$Res> {
  factory $AddAccountFormStateCopyWith(
          AddAccountFormState value, $Res Function(AddAccountFormState) then) =
      _$AddAccountFormStateCopyWithImpl<$Res, AddAccountFormState>;
  @useResult
  $Res call(
      {String seed,
      AddAccountProcessStep addAccountProcessStep,
      String name,
      String errorText});
}

/// @nodoc
class _$AddAccountFormStateCopyWithImpl<$Res, $Val extends AddAccountFormState>
    implements $AddAccountFormStateCopyWith<$Res> {
  _$AddAccountFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seed = null,
    Object? addAccountProcessStep = null,
    Object? name = null,
    Object? errorText = null,
  }) {
    return _then(_value.copyWith(
      seed: null == seed
          ? _value.seed
          : seed // ignore: cast_nullable_to_non_nullable
              as String,
      addAccountProcessStep: null == addAccountProcessStep
          ? _value.addAccountProcessStep
          : addAccountProcessStep // ignore: cast_nullable_to_non_nullable
              as AddAccountProcessStep,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      errorText: null == errorText
          ? _value.errorText
          : errorText // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AddAccountFormStateCopyWith<$Res>
    implements $AddAccountFormStateCopyWith<$Res> {
  factory _$$_AddAccountFormStateCopyWith(_$_AddAccountFormState value,
          $Res Function(_$_AddAccountFormState) then) =
      __$$_AddAccountFormStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String seed,
      AddAccountProcessStep addAccountProcessStep,
      String name,
      String errorText});
}

/// @nodoc
class __$$_AddAccountFormStateCopyWithImpl<$Res>
    extends _$AddAccountFormStateCopyWithImpl<$Res, _$_AddAccountFormState>
    implements _$$_AddAccountFormStateCopyWith<$Res> {
  __$$_AddAccountFormStateCopyWithImpl(_$_AddAccountFormState _value,
      $Res Function(_$_AddAccountFormState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seed = null,
    Object? addAccountProcessStep = null,
    Object? name = null,
    Object? errorText = null,
  }) {
    return _then(_$_AddAccountFormState(
      seed: null == seed
          ? _value.seed
          : seed // ignore: cast_nullable_to_non_nullable
              as String,
      addAccountProcessStep: null == addAccountProcessStep
          ? _value.addAccountProcessStep
          : addAccountProcessStep // ignore: cast_nullable_to_non_nullable
              as AddAccountProcessStep,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      errorText: null == errorText
          ? _value.errorText
          : errorText // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_AddAccountFormState extends _AddAccountFormState {
  const _$_AddAccountFormState(
      {required this.seed,
      this.addAccountProcessStep = AddAccountProcessStep.form,
      this.name = '',
      this.errorText = ''})
      : super._();

  @override
  final String seed;
  @override
  @JsonKey()
  final AddAccountProcessStep addAccountProcessStep;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String errorText;

  @override
  String toString() {
    return 'AddAccountFormState(seed: $seed, addAccountProcessStep: $addAccountProcessStep, name: $name, errorText: $errorText)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AddAccountFormState &&
            (identical(other.seed, seed) || other.seed == seed) &&
            (identical(other.addAccountProcessStep, addAccountProcessStep) ||
                other.addAccountProcessStep == addAccountProcessStep) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.errorText, errorText) ||
                other.errorText == errorText));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, seed, addAccountProcessStep, name, errorText);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AddAccountFormStateCopyWith<_$_AddAccountFormState> get copyWith =>
      __$$_AddAccountFormStateCopyWithImpl<_$_AddAccountFormState>(
          this, _$identity);
}

abstract class _AddAccountFormState extends AddAccountFormState {
  const factory _AddAccountFormState(
      {required final String seed,
      final AddAccountProcessStep addAccountProcessStep,
      final String name,
      final String errorText}) = _$_AddAccountFormState;
  const _AddAccountFormState._() : super._();

  @override
  String get seed;
  @override
  AddAccountProcessStep get addAccountProcessStep;
  @override
  String get name;
  @override
  String get errorText;
  @override
  @JsonKey(ignore: true)
  _$$_AddAccountFormStateCopyWith<_$_AddAccountFormState> get copyWith =>
      throw _privateConstructorUsedError;
}
