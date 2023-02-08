// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uco_transfer_wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UCOTransferWallet _$$_UCOTransferWalletFromJson(Map<String, dynamic> json) =>
    _$_UCOTransferWallet(
      amount: json['amount'] as int?,
      to: json['to'] as String?,
      toContactName: json['toContactName'] as String?,
    );

Map<String, dynamic> _$$_UCOTransferWalletToJson(
        _$_UCOTransferWallet instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'to': instance.to,
      'toContactName': instance.toContactName,
    };
