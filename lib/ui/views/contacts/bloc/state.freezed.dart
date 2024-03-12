// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ContactCreationFormState {
  String get name => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  bool get favorite => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;
  bool get creationInProgress => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ContactCreationFormStateCopyWith<ContactCreationFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactCreationFormStateCopyWith<$Res> {
  factory $ContactCreationFormStateCopyWith(ContactCreationFormState value,
          $Res Function(ContactCreationFormState) then) =
      _$ContactCreationFormStateCopyWithImpl<$Res, ContactCreationFormState>;
  @useResult
  $Res call(
      {String name,
      String address,
      bool favorite,
      String error,
      bool creationInProgress});
}

/// @nodoc
class _$ContactCreationFormStateCopyWithImpl<$Res,
        $Val extends ContactCreationFormState>
    implements $ContactCreationFormStateCopyWith<$Res> {
  _$ContactCreationFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? address = null,
    Object? favorite = null,
    Object? error = null,
    Object? creationInProgress = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      favorite: null == favorite
          ? _value.favorite
          : favorite // ignore: cast_nullable_to_non_nullable
              as bool,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      creationInProgress: null == creationInProgress
          ? _value.creationInProgress
          : creationInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContactCreationFormStateImplCopyWith<$Res>
    implements $ContactCreationFormStateCopyWith<$Res> {
  factory _$$ContactCreationFormStateImplCopyWith(
          _$ContactCreationFormStateImpl value,
          $Res Function(_$ContactCreationFormStateImpl) then) =
      __$$ContactCreationFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String address,
      bool favorite,
      String error,
      bool creationInProgress});
}

/// @nodoc
class __$$ContactCreationFormStateImplCopyWithImpl<$Res>
    extends _$ContactCreationFormStateCopyWithImpl<$Res,
        _$ContactCreationFormStateImpl>
    implements _$$ContactCreationFormStateImplCopyWith<$Res> {
  __$$ContactCreationFormStateImplCopyWithImpl(
      _$ContactCreationFormStateImpl _value,
      $Res Function(_$ContactCreationFormStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? address = null,
    Object? favorite = null,
    Object? error = null,
    Object? creationInProgress = null,
  }) {
    return _then(_$ContactCreationFormStateImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      favorite: null == favorite
          ? _value.favorite
          : favorite // ignore: cast_nullable_to_non_nullable
              as bool,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      creationInProgress: null == creationInProgress
          ? _value.creationInProgress
          : creationInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ContactCreationFormStateImpl extends _ContactCreationFormState {
  const _$ContactCreationFormStateImpl(
      {this.name = '',
      this.address = '',
      this.favorite = false,
      this.error = '',
      this.creationInProgress = false})
      : super._();

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String address;
  @override
  @JsonKey()
  final bool favorite;
  @override
  @JsonKey()
  final String error;
  @override
  @JsonKey()
  final bool creationInProgress;

  @override
  String toString() {
    return 'ContactCreationFormState(name: $name, address: $address, favorite: $favorite, error: $error, creationInProgress: $creationInProgress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactCreationFormStateImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.favorite, favorite) ||
                other.favorite == favorite) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.creationInProgress, creationInProgress) ||
                other.creationInProgress == creationInProgress));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, name, address, favorite, error, creationInProgress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactCreationFormStateImplCopyWith<_$ContactCreationFormStateImpl>
      get copyWith => __$$ContactCreationFormStateImplCopyWithImpl<
          _$ContactCreationFormStateImpl>(this, _$identity);
}

abstract class _ContactCreationFormState extends ContactCreationFormState {
  const factory _ContactCreationFormState(
      {final String name,
      final String address,
      final bool favorite,
      final String error,
      final bool creationInProgress}) = _$ContactCreationFormStateImpl;
  const _ContactCreationFormState._() : super._();

  @override
  String get name;
  @override
  String get address;
  @override
  bool get favorite;
  @override
  String get error;
  @override
  bool get creationInProgress;
  @override
  @JsonKey(ignore: true)
  _$$ContactCreationFormStateImplCopyWith<_$ContactCreationFormStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
