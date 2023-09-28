// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'discussion_search_bar_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DiscussionSearchBarState {
  String get searchCriteria => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;
  Discussion? get discussion => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DiscussionSearchBarStateCopyWith<DiscussionSearchBarState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscussionSearchBarStateCopyWith<$Res> {
  factory $DiscussionSearchBarStateCopyWith(DiscussionSearchBarState value,
          $Res Function(DiscussionSearchBarState) then) =
      _$DiscussionSearchBarStateCopyWithImpl<$Res, DiscussionSearchBarState>;
  @useResult
  $Res call(
      {String searchCriteria,
      bool loading,
      String error,
      Discussion? discussion});

  $DiscussionCopyWith<$Res>? get discussion;
}

/// @nodoc
class _$DiscussionSearchBarStateCopyWithImpl<$Res,
        $Val extends DiscussionSearchBarState>
    implements $DiscussionSearchBarStateCopyWith<$Res> {
  _$DiscussionSearchBarStateCopyWithImpl(this._value, this._then);

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
    Object? discussion = freezed,
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
      discussion: freezed == discussion
          ? _value.discussion
          : discussion // ignore: cast_nullable_to_non_nullable
              as Discussion?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DiscussionCopyWith<$Res>? get discussion {
    if (_value.discussion == null) {
      return null;
    }

    return $DiscussionCopyWith<$Res>(_value.discussion!, (value) {
      return _then(_value.copyWith(discussion: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DiscussionSearchBarStateImplCopyWith<$Res>
    implements $DiscussionSearchBarStateCopyWith<$Res> {
  factory _$$DiscussionSearchBarStateImplCopyWith(
          _$DiscussionSearchBarStateImpl value,
          $Res Function(_$DiscussionSearchBarStateImpl) then) =
      __$$DiscussionSearchBarStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String searchCriteria,
      bool loading,
      String error,
      Discussion? discussion});

  @override
  $DiscussionCopyWith<$Res>? get discussion;
}

/// @nodoc
class __$$DiscussionSearchBarStateImplCopyWithImpl<$Res>
    extends _$DiscussionSearchBarStateCopyWithImpl<$Res,
        _$DiscussionSearchBarStateImpl>
    implements _$$DiscussionSearchBarStateImplCopyWith<$Res> {
  __$$DiscussionSearchBarStateImplCopyWithImpl(
      _$DiscussionSearchBarStateImpl _value,
      $Res Function(_$DiscussionSearchBarStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchCriteria = null,
    Object? loading = null,
    Object? error = null,
    Object? discussion = freezed,
  }) {
    return _then(_$DiscussionSearchBarStateImpl(
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
      discussion: freezed == discussion
          ? _value.discussion
          : discussion // ignore: cast_nullable_to_non_nullable
              as Discussion?,
    ));
  }
}

/// @nodoc

class _$DiscussionSearchBarStateImpl extends _DiscussionSearchBarState {
  const _$DiscussionSearchBarStateImpl(
      {this.searchCriteria = '',
      this.loading = false,
      this.error = '',
      this.discussion})
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
  final Discussion? discussion;

  @override
  String toString() {
    return 'DiscussionSearchBarState(searchCriteria: $searchCriteria, loading: $loading, error: $error, discussion: $discussion)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscussionSearchBarStateImpl &&
            (identical(other.searchCriteria, searchCriteria) ||
                other.searchCriteria == searchCriteria) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.discussion, discussion) ||
                other.discussion == discussion));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, searchCriteria, loading, error, discussion);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscussionSearchBarStateImplCopyWith<_$DiscussionSearchBarStateImpl>
      get copyWith => __$$DiscussionSearchBarStateImplCopyWithImpl<
          _$DiscussionSearchBarStateImpl>(this, _$identity);
}

abstract class _DiscussionSearchBarState extends DiscussionSearchBarState {
  const factory _DiscussionSearchBarState(
      {final String searchCriteria,
      final bool loading,
      final String error,
      final Discussion? discussion}) = _$DiscussionSearchBarStateImpl;
  const _DiscussionSearchBarState._() : super._();

  @override
  String get searchCriteria;
  @override
  bool get loading;
  @override
  String get error;
  @override
  Discussion? get discussion;
  @override
  @JsonKey(ignore: true)
  _$$DiscussionSearchBarStateImplCopyWith<_$DiscussionSearchBarStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
