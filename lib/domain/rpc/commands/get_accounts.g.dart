// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_accounts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RPCGetAccountsResultData _$$_RPCGetAccountsResultDataFromJson(
        Map<String, dynamic> json) =>
    _$_RPCGetAccountsResultData(
      accounts: (json['accounts'] as List<dynamic>)
          .map((e) => AppAccount.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_RPCGetAccountsResultDataToJson(
        _$_RPCGetAccountsResultData instance) =>
    <String, dynamic>{
      'accounts': instance.accounts,
    };
