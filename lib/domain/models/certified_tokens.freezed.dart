// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'certified_tokens.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CertifiedTokens _$CertifiedTokensFromJson(Map<String, dynamic> json) {
  return _CertifiedTokens.fromJson(json);
}

/// @nodoc
mixin _$CertifiedTokens {
  List<String> get mainnet => throw _privateConstructorUsedError;
  List<String> get testnet => throw _privateConstructorUsedError;
  List<String> get devnet => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CertifiedTokensCopyWith<CertifiedTokens> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CertifiedTokensCopyWith<$Res> {
  factory $CertifiedTokensCopyWith(
          CertifiedTokens value, $Res Function(CertifiedTokens) then) =
      _$CertifiedTokensCopyWithImpl<$Res, CertifiedTokens>;
  @useResult
  $Res call({List<String> mainnet, List<String> testnet, List<String> devnet});
}

/// @nodoc
class _$CertifiedTokensCopyWithImpl<$Res, $Val extends CertifiedTokens>
    implements $CertifiedTokensCopyWith<$Res> {
  _$CertifiedTokensCopyWithImpl(this._value, this._then);

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
abstract class _$$CertifiedTokensImplCopyWith<$Res>
    implements $CertifiedTokensCopyWith<$Res> {
  factory _$$CertifiedTokensImplCopyWith(_$CertifiedTokensImpl value,
          $Res Function(_$CertifiedTokensImpl) then) =
      __$$CertifiedTokensImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> mainnet, List<String> testnet, List<String> devnet});
}

/// @nodoc
class __$$CertifiedTokensImplCopyWithImpl<$Res>
    extends _$CertifiedTokensCopyWithImpl<$Res, _$CertifiedTokensImpl>
    implements _$$CertifiedTokensImplCopyWith<$Res> {
  __$$CertifiedTokensImplCopyWithImpl(
      _$CertifiedTokensImpl _value, $Res Function(_$CertifiedTokensImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mainnet = null,
    Object? testnet = null,
    Object? devnet = null,
  }) {
    return _then(_$CertifiedTokensImpl(
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
class _$CertifiedTokensImpl implements _CertifiedTokens {
  const _$CertifiedTokensImpl(
      {required final List<String> mainnet,
      required final List<String> testnet,
      required final List<String> devnet})
      : _mainnet = mainnet,
        _testnet = testnet,
        _devnet = devnet;

  factory _$CertifiedTokensImpl.fromJson(Map<String, dynamic> json) =>
      _$$CertifiedTokensImplFromJson(json);

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
    return 'CertifiedTokens(mainnet: $mainnet, testnet: $testnet, devnet: $devnet)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CertifiedTokensImpl &&
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
  _$$CertifiedTokensImplCopyWith<_$CertifiedTokensImpl> get copyWith =>
      __$$CertifiedTokensImplCopyWithImpl<_$CertifiedTokensImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CertifiedTokensImplToJson(
      this,
    );
  }
}

abstract class _CertifiedTokens implements CertifiedTokens {
  const factory _CertifiedTokens(
      {required final List<String> mainnet,
      required final List<String> testnet,
      required final List<String> devnet}) = _$CertifiedTokensImpl;

  factory _CertifiedTokens.fromJson(Map<String, dynamic> json) =
      _$CertifiedTokensImpl.fromJson;

  @override
  List<String> get mainnet;
  @override
  List<String> get testnet;
  @override
  List<String> get devnet;
  @override
  @JsonKey(ignore: true)
  _$$CertifiedTokensImplCopyWith<_$CertifiedTokensImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
