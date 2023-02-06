// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DeeplinkRpcResult {
  DeeplinkRpcRequest? get request => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            DeeplinkRpcRequest? request, DeeplinkRpcFailure failure)
        failure,
    required TResult Function(DeeplinkRpcRequest request, dynamic result)
        success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DeeplinkRpcRequest? request, DeeplinkRpcFailure failure)?
        failure,
    TResult? Function(DeeplinkRpcRequest request, dynamic result)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DeeplinkRpcRequest? request, DeeplinkRpcFailure failure)?
        failure,
    TResult Function(DeeplinkRpcRequest request, dynamic result)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DeeplinkRpcResultFailure value) failure,
    required TResult Function(_DeeplinkRpcResultSuccess value) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DeeplinkRpcResultFailure value)? failure,
    TResult? Function(_DeeplinkRpcResultSuccess value)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DeeplinkRpcResultFailure value)? failure,
    TResult Function(_DeeplinkRpcResultSuccess value)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DeeplinkRpcResultCopyWith<DeeplinkRpcResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeeplinkRpcResultCopyWith<$Res> {
  factory $DeeplinkRpcResultCopyWith(
          DeeplinkRpcResult value, $Res Function(DeeplinkRpcResult) then) =
      _$DeeplinkRpcResultCopyWithImpl<$Res, DeeplinkRpcResult>;
  @useResult
  $Res call({DeeplinkRpcRequest request});

  $DeeplinkRpcRequestCopyWith<$Res>? get request;
}

/// @nodoc
class _$DeeplinkRpcResultCopyWithImpl<$Res, $Val extends DeeplinkRpcResult>
    implements $DeeplinkRpcResultCopyWith<$Res> {
  _$DeeplinkRpcResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? request = null,
  }) {
    return _then(_value.copyWith(
      request: null == request
          ? _value.request!
          : request // ignore: cast_nullable_to_non_nullable
              as DeeplinkRpcRequest,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DeeplinkRpcRequestCopyWith<$Res>? get request {
    if (_value.request == null) {
      return null;
    }

    return $DeeplinkRpcRequestCopyWith<$Res>(_value.request!, (value) {
      return _then(_value.copyWith(request: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_DeeplinkRpcResultFailureCopyWith<$Res>
    implements $DeeplinkRpcResultCopyWith<$Res> {
  factory _$$_DeeplinkRpcResultFailureCopyWith(
          _$_DeeplinkRpcResultFailure value,
          $Res Function(_$_DeeplinkRpcResultFailure) then) =
      __$$_DeeplinkRpcResultFailureCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DeeplinkRpcRequest? request, DeeplinkRpcFailure failure});

  @override
  $DeeplinkRpcRequestCopyWith<$Res>? get request;
  $DeeplinkRpcFailureCopyWith<$Res> get failure;
}

/// @nodoc
class __$$_DeeplinkRpcResultFailureCopyWithImpl<$Res>
    extends _$DeeplinkRpcResultCopyWithImpl<$Res, _$_DeeplinkRpcResultFailure>
    implements _$$_DeeplinkRpcResultFailureCopyWith<$Res> {
  __$$_DeeplinkRpcResultFailureCopyWithImpl(_$_DeeplinkRpcResultFailure _value,
      $Res Function(_$_DeeplinkRpcResultFailure) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? request = freezed,
    Object? failure = null,
  }) {
    return _then(_$_DeeplinkRpcResultFailure(
      request: freezed == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as DeeplinkRpcRequest?,
      failure: null == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as DeeplinkRpcFailure,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $DeeplinkRpcFailureCopyWith<$Res> get failure {
    return $DeeplinkRpcFailureCopyWith<$Res>(_value.failure, (value) {
      return _then(_value.copyWith(failure: value));
    });
  }
}

/// @nodoc

class _$_DeeplinkRpcResultFailure extends _DeeplinkRpcResultFailure {
  const _$_DeeplinkRpcResultFailure({this.request, required this.failure})
      : super._();

  @override
  final DeeplinkRpcRequest? request;
  @override
  final DeeplinkRpcFailure failure;

  @override
  String toString() {
    return 'DeeplinkRpcResult.failure(request: $request, failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DeeplinkRpcResultFailure &&
            (identical(other.request, request) || other.request == request) &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, request, failure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DeeplinkRpcResultFailureCopyWith<_$_DeeplinkRpcResultFailure>
      get copyWith => __$$_DeeplinkRpcResultFailureCopyWithImpl<
          _$_DeeplinkRpcResultFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            DeeplinkRpcRequest? request, DeeplinkRpcFailure failure)
        failure,
    required TResult Function(DeeplinkRpcRequest request, dynamic result)
        success,
  }) {
    return failure(request, this.failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DeeplinkRpcRequest? request, DeeplinkRpcFailure failure)?
        failure,
    TResult? Function(DeeplinkRpcRequest request, dynamic result)? success,
  }) {
    return failure?.call(request, this.failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DeeplinkRpcRequest? request, DeeplinkRpcFailure failure)?
        failure,
    TResult Function(DeeplinkRpcRequest request, dynamic result)? success,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(request, this.failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DeeplinkRpcResultFailure value) failure,
    required TResult Function(_DeeplinkRpcResultSuccess value) success,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DeeplinkRpcResultFailure value)? failure,
    TResult? Function(_DeeplinkRpcResultSuccess value)? success,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DeeplinkRpcResultFailure value)? failure,
    TResult Function(_DeeplinkRpcResultSuccess value)? success,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _DeeplinkRpcResultFailure extends DeeplinkRpcResult {
  const factory _DeeplinkRpcResultFailure(
      {final DeeplinkRpcRequest? request,
      required final DeeplinkRpcFailure failure}) = _$_DeeplinkRpcResultFailure;
  const _DeeplinkRpcResultFailure._() : super._();

  @override
  DeeplinkRpcRequest? get request;
  DeeplinkRpcFailure get failure;
  @override
  @JsonKey(ignore: true)
  _$$_DeeplinkRpcResultFailureCopyWith<_$_DeeplinkRpcResultFailure>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_DeeplinkRpcResultSuccessCopyWith<$Res>
    implements $DeeplinkRpcResultCopyWith<$Res> {
  factory _$$_DeeplinkRpcResultSuccessCopyWith(
          _$_DeeplinkRpcResultSuccess value,
          $Res Function(_$_DeeplinkRpcResultSuccess) then) =
      __$$_DeeplinkRpcResultSuccessCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DeeplinkRpcRequest request, dynamic result});

  @override
  $DeeplinkRpcRequestCopyWith<$Res> get request;
}

/// @nodoc
class __$$_DeeplinkRpcResultSuccessCopyWithImpl<$Res>
    extends _$DeeplinkRpcResultCopyWithImpl<$Res, _$_DeeplinkRpcResultSuccess>
    implements _$$_DeeplinkRpcResultSuccessCopyWith<$Res> {
  __$$_DeeplinkRpcResultSuccessCopyWithImpl(_$_DeeplinkRpcResultSuccess _value,
      $Res Function(_$_DeeplinkRpcResultSuccess) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? request = null,
    Object? result = freezed,
  }) {
    return _then(_$_DeeplinkRpcResultSuccess(
      request: null == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as DeeplinkRpcRequest,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $DeeplinkRpcRequestCopyWith<$Res> get request {
    return $DeeplinkRpcRequestCopyWith<$Res>(_value.request, (value) {
      return _then(_value.copyWith(request: value));
    });
  }
}

/// @nodoc

class _$_DeeplinkRpcResultSuccess extends _DeeplinkRpcResultSuccess {
  const _$_DeeplinkRpcResultSuccess({required this.request, this.result})
      : super._();

  @override
  final DeeplinkRpcRequest request;
  @override
  final dynamic result;

  @override
  String toString() {
    return 'DeeplinkRpcResult.success(request: $request, result: $result)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DeeplinkRpcResultSuccess &&
            (identical(other.request, request) || other.request == request) &&
            const DeepCollectionEquality().equals(other.result, result));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, request, const DeepCollectionEquality().hash(result));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DeeplinkRpcResultSuccessCopyWith<_$_DeeplinkRpcResultSuccess>
      get copyWith => __$$_DeeplinkRpcResultSuccessCopyWithImpl<
          _$_DeeplinkRpcResultSuccess>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            DeeplinkRpcRequest? request, DeeplinkRpcFailure failure)
        failure,
    required TResult Function(DeeplinkRpcRequest request, dynamic result)
        success,
  }) {
    return success(request, result);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DeeplinkRpcRequest? request, DeeplinkRpcFailure failure)?
        failure,
    TResult? Function(DeeplinkRpcRequest request, dynamic result)? success,
  }) {
    return success?.call(request, result);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DeeplinkRpcRequest? request, DeeplinkRpcFailure failure)?
        failure,
    TResult Function(DeeplinkRpcRequest request, dynamic result)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(request, result);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DeeplinkRpcResultFailure value) failure,
    required TResult Function(_DeeplinkRpcResultSuccess value) success,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_DeeplinkRpcResultFailure value)? failure,
    TResult? Function(_DeeplinkRpcResultSuccess value)? success,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DeeplinkRpcResultFailure value)? failure,
    TResult Function(_DeeplinkRpcResultSuccess value)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _DeeplinkRpcResultSuccess extends DeeplinkRpcResult {
  const factory _DeeplinkRpcResultSuccess(
      {required final DeeplinkRpcRequest request,
      final dynamic result}) = _$_DeeplinkRpcResultSuccess;
  const _DeeplinkRpcResultSuccess._() : super._();

  @override
  DeeplinkRpcRequest get request;
  dynamic get result;
  @override
  @JsonKey(ignore: true)
  _$$_DeeplinkRpcResultSuccessCopyWith<_$_DeeplinkRpcResultSuccess>
      get copyWith => throw _privateConstructorUsedError;
}
