// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nft_search_bar_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NftSearchBarState {
  String get searchCriteria => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;
  TokenInformation? get tokenInformation => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NftSearchBarStateCopyWith<NftSearchBarState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NftSearchBarStateCopyWith<$Res> {
  factory $NftSearchBarStateCopyWith(
          NftSearchBarState value, $Res Function(NftSearchBarState) then) =
      _$NftSearchBarStateCopyWithImpl<$Res, NftSearchBarState>;
  @useResult
  $Res call(
      {String searchCriteria,
      bool loading,
      String error,
      TokenInformation? tokenInformation});
}

/// @nodoc
class _$NftSearchBarStateCopyWithImpl<$Res, $Val extends NftSearchBarState>
    implements $NftSearchBarStateCopyWith<$Res> {
  _$NftSearchBarStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchCriteria = null,
    Object? loading = null,
    Object? error = null,
    Object? tokenInformation = freezed,
  }) {
    return _then(_value.copyWith(
      searchCriteria: null == searchCriteria
          ? _value.searchCriteria
          : searchCriteria // ignore: cast_nullable_to_non_nullable
              as String,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      tokenInformation: freezed == tokenInformation
          ? _value.tokenInformation
          : tokenInformation // ignore: cast_nullable_to_non_nullable
              as TokenInformation?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NftSearchBarStateImplCopyWith<$Res>
    implements $NftSearchBarStateCopyWith<$Res> {
  factory _$$NftSearchBarStateImplCopyWith(_$NftSearchBarStateImpl value,
          $Res Function(_$NftSearchBarStateImpl) then) =
      __$$NftSearchBarStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String searchCriteria,
      bool loading,
      String error,
      TokenInformation? tokenInformation});
}

/// @nodoc
class __$$NftSearchBarStateImplCopyWithImpl<$Res>
    extends _$NftSearchBarStateCopyWithImpl<$Res, _$NftSearchBarStateImpl>
    implements _$$NftSearchBarStateImplCopyWith<$Res> {
  __$$NftSearchBarStateImplCopyWithImpl(_$NftSearchBarStateImpl _value,
      $Res Function(_$NftSearchBarStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchCriteria = null,
    Object? loading = null,
    Object? error = null,
    Object? tokenInformation = freezed,
  }) {
    return _then(_$NftSearchBarStateImpl(
      searchCriteria: null == searchCriteria
          ? _value.searchCriteria
          : searchCriteria // ignore: cast_nullable_to_non_nullable
              as String,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      tokenInformation: freezed == tokenInformation
          ? _value.tokenInformation
          : tokenInformation // ignore: cast_nullable_to_non_nullable
              as TokenInformation?,
    ));
  }
}

/// @nodoc

class _$NftSearchBarStateImpl extends _NftSearchBarState {
  const _$NftSearchBarStateImpl(
      {this.searchCriteria = '',
      this.loading = false,
      this.error = '',
      this.tokenInformation})
      : super._();

  @override
  @JsonKey()
  final String searchCriteria;
  @override
  @JsonKey()
  final bool loading;
  @override
  @JsonKey()
  final String error;
  @override
  final TokenInformation? tokenInformation;

  @override
  String toString() {
    return 'NftSearchBarState(searchCriteria: $searchCriteria, loading: $loading, error: $error, tokenInformation: $tokenInformation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NftSearchBarStateImpl &&
            (identical(other.searchCriteria, searchCriteria) ||
                other.searchCriteria == searchCriteria) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.tokenInformation, tokenInformation) ||
                other.tokenInformation == tokenInformation));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, searchCriteria, loading, error, tokenInformation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NftSearchBarStateImplCopyWith<_$NftSearchBarStateImpl> get copyWith =>
      __$$NftSearchBarStateImplCopyWithImpl<_$NftSearchBarStateImpl>(
          this, _$identity);
}

abstract class _NftSearchBarState extends NftSearchBarState {
  const factory _NftSearchBarState(
      {final String searchCriteria,
      final bool loading,
      final String error,
      final TokenInformation? tokenInformation}) = _$NftSearchBarStateImpl;
  const _NftSearchBarState._() : super._();

  @override
  String get searchCriteria;
  @override
  bool get loading;
  @override
  String get error;
  @override
  TokenInformation? get tokenInformation;
  @override
  @JsonKey(ignore: true)
  _$$NftSearchBarStateImplCopyWith<_$NftSearchBarStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
