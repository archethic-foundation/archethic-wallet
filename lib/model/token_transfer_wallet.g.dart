// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_transfer_wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TokenTransferWallet _$$_TokenTransferWalletFromJson(
        Map<String, dynamic> json) =>
    _$_TokenTransferWallet(
      amount: json['amount'] as int?,
      to: json['to'] as String?,
      tokenAddress: json['tokenAddress'] as String?,
      tokenId: json['tokenId'] as int?,
      toContactName: json['toContactName'] as String?,
    );

Map<String, dynamic> _$$_TokenTransferWalletToJson(
        _$_TokenTransferWallet instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'to': instance.to,
      'tokenAddress': instance.tokenAddress,
      'tokenId': instance.tokenId,
      'toContactName': instance.toContactName,
    };
