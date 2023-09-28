// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_transfer_wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TokenTransferWalletImpl _$$TokenTransferWalletImplFromJson(
        Map<String, dynamic> json) =>
    _$TokenTransferWalletImpl(
      amount: json['amount'] as int?,
      to: json['to'] as String?,
      tokenAddress: json['tokenAddress'] as String?,
      tokenId: json['tokenId'] as int?,
      toContactName: json['toContactName'] as String?,
    );

Map<String, dynamic> _$$TokenTransferWalletImplToJson(
        _$TokenTransferWalletImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'to': instance.to,
      'tokenAddress': instance.tokenAddress,
      'tokenId': instance.tokenId,
      'toContactName': instance.toContactName,
    };
