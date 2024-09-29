// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dex_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DexTokenImpl _$$DexTokenImplFromJson(Map<String, dynamic> json) =>
    _$DexTokenImpl(
      address: json['address'] as String,
      name: json['name'] as String? ?? '',
      icon: json['icon'] as String?,
      symbol: json['symbol'] as String? ?? '',
      balance: (json['balance'] as num?)?.toDouble() ?? 0.0,
      reserve: (json['reserve'] as num?)?.toDouble() ?? 0.0,
      supply: (json['supply'] as num?)?.toDouble() ?? 0.0,
      isVerified: json['isVerified'] as bool? ?? false,
      isLpToken: json['isLpToken'] as bool? ?? false,
      lpTokenPair: json['lpTokenPair'] == null
          ? null
          : DexPair.fromJson(json['lpTokenPair'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DexTokenImplToJson(_$DexTokenImpl instance) =>
    <String, dynamic>{
      'address': instance.address,
      'name': instance.name,
      'icon': instance.icon,
      'symbol': instance.symbol,
      'balance': instance.balance,
      'reserve': instance.reserve,
      'supply': instance.supply,
      'isVerified': instance.isVerified,
      'isLpToken': instance.isLpToken,
      'lpTokenPair': instance.lpTokenPair,
    };
