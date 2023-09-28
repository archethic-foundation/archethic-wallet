// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uco_transfer_wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UCOTransferWalletImpl _$$UCOTransferWalletImplFromJson(
        Map<String, dynamic> json) =>
    _$UCOTransferWalletImpl(
      amount: json['amount'] as int?,
      to: json['to'] as String?,
      toContactName: json['toContactName'] as String?,
    );

Map<String, dynamic> _$$UCOTransferWalletImplToJson(
        _$UCOTransferWalletImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'to': instance.to,
      'toContactName': instance.toContactName,
    };
