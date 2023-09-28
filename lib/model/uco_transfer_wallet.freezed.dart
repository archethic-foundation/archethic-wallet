// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'uco_transfer_wallet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UCOTransferWallet _$UCOTransferWalletFromJson(Map<String, dynamic> json) {
  return _UCOTransferWallet.fromJson(json);
}

/// @nodoc
mixin _$UCOTransferWallet {
  int? get amount => throw _privateConstructorUsedError;
  String? get to => throw _privateConstructorUsedError;
  String? get toContactName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UCOTransferWalletCopyWith<UCOTransferWallet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UCOTransferWalletCopyWith<$Res> {
  factory $UCOTransferWalletCopyWith(
          UCOTransferWallet value, $Res Function(UCOTransferWallet) then) =
      _$UCOTransferWalletCopyWithImpl<$Res, UCOTransferWallet>;
  @useResult
  $Res call({int? amount, String? to, String? toContactName});
}

/// @nodoc
class _$UCOTransferWalletCopyWithImpl<$Res, $Val extends UCOTransferWallet>
    implements $UCOTransferWalletCopyWith<$Res> {
  _$UCOTransferWalletCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = freezed,
    Object? to = freezed,
    Object? toContactName = freezed,
  }) {
    return _then(_value.copyWith(
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String?,
      toContactName: freezed == toContactName
          ? _value.toContactName
          : toContactName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UCOTransferWalletImplCopyWith<$Res>
    implements $UCOTransferWalletCopyWith<$Res> {
  factory _$$UCOTransferWalletImplCopyWith(_$UCOTransferWalletImpl value,
          $Res Function(_$UCOTransferWalletImpl) then) =
      __$$UCOTransferWalletImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? amount, String? to, String? toContactName});
}

/// @nodoc
class __$$UCOTransferWalletImplCopyWithImpl<$Res>
    extends _$UCOTransferWalletCopyWithImpl<$Res, _$UCOTransferWalletImpl>
    implements _$$UCOTransferWalletImplCopyWith<$Res> {
  __$$UCOTransferWalletImplCopyWithImpl(_$UCOTransferWalletImpl _value,
      $Res Function(_$UCOTransferWalletImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = freezed,
    Object? to = freezed,
    Object? toContactName = freezed,
  }) {
    return _then(_$UCOTransferWalletImpl(
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String?,
      toContactName: freezed == toContactName
          ? _value.toContactName
          : toContactName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UCOTransferWalletImpl extends _UCOTransferWallet {
  const _$UCOTransferWalletImpl({this.amount, this.to, this.toContactName})
      : super._();

  factory _$UCOTransferWalletImpl.fromJson(Map<String, dynamic> json) =>
      _$$UCOTransferWalletImplFromJson(json);

  @override
  final int? amount;
  @override
  final String? to;
  @override
  final String? toContactName;

  @override
  String toString() {
    return 'UCOTransferWallet(amount: $amount, to: $to, toContactName: $toContactName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UCOTransferWalletImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.toContactName, toContactName) ||
                other.toContactName == toContactName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, amount, to, toContactName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UCOTransferWalletImplCopyWith<_$UCOTransferWalletImpl> get copyWith =>
      __$$UCOTransferWalletImplCopyWithImpl<_$UCOTransferWalletImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UCOTransferWalletImplToJson(
      this,
    );
  }
}

abstract class _UCOTransferWallet extends UCOTransferWallet {
  const factory _UCOTransferWallet(
      {final int? amount,
      final String? to,
      final String? toContactName}) = _$UCOTransferWalletImpl;
  const _UCOTransferWallet._() : super._();

  factory _UCOTransferWallet.fromJson(Map<String, dynamic> json) =
      _$UCOTransferWalletImpl.fromJson;

  @override
  int? get amount;
  @override
  String? get to;
  @override
  String? get toContactName;
  @override
  @JsonKey(ignore: true)
  _$$UCOTransferWalletImplCopyWith<_$UCOTransferWalletImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
