// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'buy_with_crypto_form_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BuyWithCryptoFormState {
  ({String id, String name, String svgIcon, String symbol})?
      get selectedToken => throw _privateConstructorUsedError;
  ({
    int chainId,
    String displayName,
    double feeRate,
    String id,
    String svgIcon,
    List<({String address, int decimals, String id})> tokens
  })? get selectedChain => throw _privateConstructorUsedError;
  bool get depositAddressVisible => throw _privateConstructorUsedError;

  /// Create a copy of BuyWithCryptoFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BuyWithCryptoFormStateCopyWith<BuyWithCryptoFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BuyWithCryptoFormStateCopyWith<$Res> {
  factory $BuyWithCryptoFormStateCopyWith(BuyWithCryptoFormState value,
          $Res Function(BuyWithCryptoFormState) then) =
      _$BuyWithCryptoFormStateCopyWithImpl<$Res, BuyWithCryptoFormState>;
  @useResult
  $Res call(
      {({String id, String name, String svgIcon, String symbol})? selectedToken,
      ({
        int chainId,
        String displayName,
        double feeRate,
        String id,
        String svgIcon,
        List<({String address, int decimals, String id})> tokens
      })? selectedChain,
      bool depositAddressVisible});
}

/// @nodoc
class _$BuyWithCryptoFormStateCopyWithImpl<$Res,
        $Val extends BuyWithCryptoFormState>
    implements $BuyWithCryptoFormStateCopyWith<$Res> {
  _$BuyWithCryptoFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BuyWithCryptoFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedToken = freezed,
    Object? selectedChain = freezed,
    Object? depositAddressVisible = null,
  }) {
    return _then(_value.copyWith(
      selectedToken: freezed == selectedToken
          ? _value.selectedToken
          : selectedToken // ignore: cast_nullable_to_non_nullable
              as ({String id, String name, String svgIcon, String symbol})?,
      selectedChain: freezed == selectedChain
          ? _value.selectedChain
          : selectedChain // ignore: cast_nullable_to_non_nullable
              as ({
              int chainId,
              String displayName,
              double feeRate,
              String id,
              String svgIcon,
              List<({String address, int decimals, String id})> tokens
            })?,
      depositAddressVisible: null == depositAddressVisible
          ? _value.depositAddressVisible
          : depositAddressVisible // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BuyWithCryptoFormStateImplCopyWith<$Res>
    implements $BuyWithCryptoFormStateCopyWith<$Res> {
  factory _$$BuyWithCryptoFormStateImplCopyWith(
          _$BuyWithCryptoFormStateImpl value,
          $Res Function(_$BuyWithCryptoFormStateImpl) then) =
      __$$BuyWithCryptoFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {({String id, String name, String svgIcon, String symbol})? selectedToken,
      ({
        int chainId,
        String displayName,
        double feeRate,
        String id,
        String svgIcon,
        List<({String address, int decimals, String id})> tokens
      })? selectedChain,
      bool depositAddressVisible});
}

/// @nodoc
class __$$BuyWithCryptoFormStateImplCopyWithImpl<$Res>
    extends _$BuyWithCryptoFormStateCopyWithImpl<$Res,
        _$BuyWithCryptoFormStateImpl>
    implements _$$BuyWithCryptoFormStateImplCopyWith<$Res> {
  __$$BuyWithCryptoFormStateImplCopyWithImpl(
      _$BuyWithCryptoFormStateImpl _value,
      $Res Function(_$BuyWithCryptoFormStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of BuyWithCryptoFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedToken = freezed,
    Object? selectedChain = freezed,
    Object? depositAddressVisible = null,
  }) {
    return _then(_$BuyWithCryptoFormStateImpl(
      selectedToken: freezed == selectedToken
          ? _value.selectedToken
          : selectedToken // ignore: cast_nullable_to_non_nullable
              as ({String id, String name, String svgIcon, String symbol})?,
      selectedChain: freezed == selectedChain
          ? _value.selectedChain
          : selectedChain // ignore: cast_nullable_to_non_nullable
              as ({
              int chainId,
              String displayName,
              double feeRate,
              String id,
              String svgIcon,
              List<({String address, int decimals, String id})> tokens
            })?,
      depositAddressVisible: null == depositAddressVisible
          ? _value.depositAddressVisible
          : depositAddressVisible // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$BuyWithCryptoFormStateImpl extends _BuyWithCryptoFormState {
  const _$BuyWithCryptoFormStateImpl(
      {this.selectedToken,
      this.selectedChain,
      required this.depositAddressVisible})
      : super._();

  @override
  final ({
    String id,
    String name,
    String svgIcon,
    String symbol
  })? selectedToken;
  @override
  final ({
    int chainId,
    String displayName,
    double feeRate,
    String id,
    String svgIcon,
    List<({String address, int decimals, String id})> tokens
  })? selectedChain;
  @override
  final bool depositAddressVisible;

  @override
  String toString() {
    return 'BuyWithCryptoFormState(selectedToken: $selectedToken, selectedChain: $selectedChain, depositAddressVisible: $depositAddressVisible)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BuyWithCryptoFormStateImpl &&
            (identical(other.selectedToken, selectedToken) ||
                other.selectedToken == selectedToken) &&
            (identical(other.selectedChain, selectedChain) ||
                other.selectedChain == selectedChain) &&
            (identical(other.depositAddressVisible, depositAddressVisible) ||
                other.depositAddressVisible == depositAddressVisible));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, selectedToken, selectedChain, depositAddressVisible);

  /// Create a copy of BuyWithCryptoFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BuyWithCryptoFormStateImplCopyWith<_$BuyWithCryptoFormStateImpl>
      get copyWith => __$$BuyWithCryptoFormStateImplCopyWithImpl<
          _$BuyWithCryptoFormStateImpl>(this, _$identity);
}

abstract class _BuyWithCryptoFormState extends BuyWithCryptoFormState {
  const factory _BuyWithCryptoFormState(
          {final ({
            String id,
            String name,
            String svgIcon,
            String symbol
          })? selectedToken,
          final ({
            int chainId,
            String displayName,
            double feeRate,
            String id,
            String svgIcon,
            List<({String address, int decimals, String id})> tokens
          })? selectedChain,
          required final bool depositAddressVisible}) =
      _$BuyWithCryptoFormStateImpl;
  const _BuyWithCryptoFormState._() : super._();

  @override
  ({String id, String name, String svgIcon, String symbol})? get selectedToken;
  @override
  ({
    int chainId,
    String displayName,
    double feeRate,
    String id,
    String svgIcon,
    List<({String address, int decimals, String id})> tokens
  })? get selectedChain;
  @override
  bool get depositAddressVisible;

  /// Create a copy of BuyWithCryptoFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BuyWithCryptoFormStateImplCopyWith<_$BuyWithCryptoFormStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
