// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verified_pools.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VerifiedPools _$VerifiedPoolsFromJson(Map<String, dynamic> json) {
  return _VerifiedPools.fromJson(json);
}

/// @nodoc
mixin _$VerifiedPools {
  List<String> get mainnet => throw _privateConstructorUsedError;
  List<String> get testnet => throw _privateConstructorUsedError;
  List<String> get devnet => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VerifiedPoolsCopyWith<VerifiedPools> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerifiedPoolsCopyWith<$Res> {
  factory $VerifiedPoolsCopyWith(
          VerifiedPools value, $Res Function(VerifiedPools) then) =
      _$VerifiedPoolsCopyWithImpl<$Res, VerifiedPools>;
  @useResult
  $Res call({List<String> mainnet, List<String> testnet, List<String> devnet});
}

/// @nodoc
class _$VerifiedPoolsCopyWithImpl<$Res, $Val extends VerifiedPools>
    implements $VerifiedPoolsCopyWith<$Res> {
  _$VerifiedPoolsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mainnet = null,
    Object? testnet = null,
    Object? devnet = null,
  }) {
    return _then(_value.copyWith(
      mainnet: null == mainnet
          ? _value.mainnet
          : mainnet // ignore: cast_nullable_to_non_nullable
              as List<String>,
      testnet: null == testnet
          ? _value.testnet
          : testnet // ignore: cast_nullable_to_non_nullable
              as List<String>,
      devnet: null == devnet
          ? _value.devnet
          : devnet // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VerifiedPoolsImplCopyWith<$Res>
    implements $VerifiedPoolsCopyWith<$Res> {
  factory _$$VerifiedPoolsImplCopyWith(
          _$VerifiedPoolsImpl value, $Res Function(_$VerifiedPoolsImpl) then) =
      __$$VerifiedPoolsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> mainnet, List<String> testnet, List<String> devnet});
}

/// @nodoc
class __$$VerifiedPoolsImplCopyWithImpl<$Res>
    extends _$VerifiedPoolsCopyWithImpl<$Res, _$VerifiedPoolsImpl>
    implements _$$VerifiedPoolsImplCopyWith<$Res> {
  __$$VerifiedPoolsImplCopyWithImpl(
      _$VerifiedPoolsImpl _value, $Res Function(_$VerifiedPoolsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mainnet = null,
    Object? testnet = null,
    Object? devnet = null,
  }) {
    return _then(_$VerifiedPoolsImpl(
      mainnet: null == mainnet
          ? _value._mainnet
          : mainnet // ignore: cast_nullable_to_non_nullable
              as List<String>,
      testnet: null == testnet
          ? _value._testnet
          : testnet // ignore: cast_nullable_to_non_nullable
              as List<String>,
      devnet: null == devnet
          ? _value._devnet
          : devnet // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VerifiedPoolsImpl implements _VerifiedPools {
  const _$VerifiedPoolsImpl(
      {required final List<String> mainnet,
      required final List<String> testnet,
      required final List<String> devnet})
      : _mainnet = mainnet,
        _testnet = testnet,
        _devnet = devnet;

  factory _$VerifiedPoolsImpl.fromJson(Map<String, dynamic> json) =>
      _$$VerifiedPoolsImplFromJson(json);

  final List<String> _mainnet;
  @override
  List<String> get mainnet {
    if (_mainnet is EqualUnmodifiableListView) return _mainnet;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mainnet);
  }

  final List<String> _testnet;
  @override
  List<String> get testnet {
    if (_testnet is EqualUnmodifiableListView) return _testnet;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_testnet);
  }

  final List<String> _devnet;
  @override
  List<String> get devnet {
    if (_devnet is EqualUnmodifiableListView) return _devnet;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_devnet);
  }

  @override
  String toString() {
    return 'VerifiedPools(mainnet: $mainnet, testnet: $testnet, devnet: $devnet)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifiedPoolsImpl &&
            const DeepCollectionEquality().equals(other._mainnet, _mainnet) &&
            const DeepCollectionEquality().equals(other._testnet, _testnet) &&
            const DeepCollectionEquality().equals(other._devnet, _devnet));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_mainnet),
      const DeepCollectionEquality().hash(_testnet),
      const DeepCollectionEquality().hash(_devnet));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VerifiedPoolsImplCopyWith<_$VerifiedPoolsImpl> get copyWith =>
      __$$VerifiedPoolsImplCopyWithImpl<_$VerifiedPoolsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VerifiedPoolsImplToJson(
      this,
    );
  }
}

abstract class _VerifiedPools implements VerifiedPools {
  const factory _VerifiedPools(
      {required final List<String> mainnet,
      required final List<String> testnet,
      required final List<String> devnet}) = _$VerifiedPoolsImpl;

  factory _VerifiedPools.fromJson(Map<String, dynamic> json) =
      _$VerifiedPoolsImpl.fromJson;

  @override
  List<String> get mainnet;
  @override
  List<String> get testnet;
  @override
  List<String> get devnet;
  @override
  @JsonKey(ignore: true)
  _$$VerifiedPoolsImplCopyWith<_$VerifiedPoolsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
