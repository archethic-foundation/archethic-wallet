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
mixin _$TokensListFormState {
  AsyncValue<List<AEToken>?> get tokensToDisplay =>
      throw _privateConstructorUsedError;
  String get searchCriteria => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TokensListFormStateCopyWith<TokensListFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokensListFormStateCopyWith<$Res> {
  factory $TokensListFormStateCopyWith(
          TokensListFormState value, $Res Function(TokensListFormState) then) =
      _$TokensListFormStateCopyWithImpl<$Res, TokensListFormState>;
  @useResult
  $Res call(
      {AsyncValue<List<AEToken>?> tokensToDisplay, String searchCriteria});
}

/// @nodoc
class _$TokensListFormStateCopyWithImpl<$Res, $Val extends TokensListFormState>
    implements $TokensListFormStateCopyWith<$Res> {
  _$TokensListFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokensToDisplay = null,
    Object? searchCriteria = null,
  }) {
    return _then(_value.copyWith(
      tokensToDisplay: null == tokensToDisplay
          ? _value.tokensToDisplay
          : tokensToDisplay // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<AEToken>?>,
      searchCriteria: null == searchCriteria
          ? _value.searchCriteria
          : searchCriteria // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TokensListFormStateImplCopyWith<$Res>
    implements $TokensListFormStateCopyWith<$Res> {
  factory _$$TokensListFormStateImplCopyWith(_$TokensListFormStateImpl value,
          $Res Function(_$TokensListFormStateImpl) then) =
      __$$TokensListFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AsyncValue<List<AEToken>?> tokensToDisplay, String searchCriteria});
}

/// @nodoc
class __$$TokensListFormStateImplCopyWithImpl<$Res>
    extends _$TokensListFormStateCopyWithImpl<$Res, _$TokensListFormStateImpl>
    implements _$$TokensListFormStateImplCopyWith<$Res> {
  __$$TokensListFormStateImplCopyWithImpl(_$TokensListFormStateImpl _value,
      $Res Function(_$TokensListFormStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokensToDisplay = null,
    Object? searchCriteria = null,
  }) {
    return _then(_$TokensListFormStateImpl(
      tokensToDisplay: null == tokensToDisplay
          ? _value.tokensToDisplay
          : tokensToDisplay // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<AEToken>?>,
      searchCriteria: null == searchCriteria
          ? _value.searchCriteria
          : searchCriteria // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TokensListFormStateImpl extends _TokensListFormState {
  const _$TokensListFormStateImpl(
      {required this.tokensToDisplay, this.searchCriteria = ''})
      : super._();

  @override
  final AsyncValue<List<AEToken>?> tokensToDisplay;
  @override
  @JsonKey()
  final String searchCriteria;

  @override
  String toString() {
    return 'TokensListFormState(tokensToDisplay: $tokensToDisplay, searchCriteria: $searchCriteria)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokensListFormStateImpl &&
            (identical(other.tokensToDisplay, tokensToDisplay) ||
                other.tokensToDisplay == tokensToDisplay) &&
            (identical(other.searchCriteria, searchCriteria) ||
                other.searchCriteria == searchCriteria));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tokensToDisplay, searchCriteria);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TokensListFormStateImplCopyWith<_$TokensListFormStateImpl> get copyWith =>
      __$$TokensListFormStateImplCopyWithImpl<_$TokensListFormStateImpl>(
          this, _$identity);
}

abstract class _TokensListFormState extends TokensListFormState {
  const factory _TokensListFormState(
      {required final AsyncValue<List<AEToken>?> tokensToDisplay,
      final String searchCriteria}) = _$TokensListFormStateImpl;
  const _TokensListFormState._() : super._();

  @override
  AsyncValue<List<AEToken>?> get tokensToDisplay;
  @override
  String get searchCriteria;
  @override
  @JsonKey(ignore: true)
  _$$TokensListFormStateImplCopyWith<_$TokensListFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
