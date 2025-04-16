// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountImplAdapter extends TypeAdapter<_$AccountImpl> {
  @override
  final int typeId = 1;

  @override
  _$AccountImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$AccountImpl(
      name: fields[0] as String,
      genesisAddress: fields[1] as String,
      lastLoadingTransactionInputs: fields[2] as int?,
      selected: fields[3] as bool?,
      lastAddress: fields[4] as String?,
      balance: fields[5] as AccountBalance?,
      accountTokens: (fields[7] as List?)?.cast<AccountToken>(),
      accountNFT: (fields[8] as List?)?.cast<AccountToken>(),
      nftInfosOffChainList: (fields[10] as List?)?.cast<NftInfosOffChain>(),
      serviceType: fields[13] as String?,
      accountNFTCollections: (fields[14] as List?)?.cast<AccountToken>(),
      customTokenAddressList: (fields[15] as List?)?.cast<String>(),
      publicKey: fields[16] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _$AccountImpl obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.genesisAddress)
      ..writeByte(2)
      ..write(obj.lastLoadingTransactionInputs)
      ..writeByte(3)
      ..write(obj.selected)
      ..writeByte(4)
      ..write(obj.lastAddress)
      ..writeByte(5)
      ..write(obj.balance)
      ..writeByte(13)
      ..write(obj.serviceType)
      ..writeByte(16)
      ..write(obj.publicKey)
      ..writeByte(7)
      ..write(obj.accountTokens)
      ..writeByte(8)
      ..write(obj.accountNFT)
      ..writeByte(10)
      ..write(obj.nftInfosOffChainList)
      ..writeByte(14)
      ..write(obj.accountNFTCollections)
      ..writeByte(15)
      ..write(obj.customTokenAddressList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AccountImpl _$$AccountImplFromJson(Map<String, dynamic> json) =>
    _$AccountImpl(
      name: json['name'] as String,
      genesisAddress: json['genesisAddress'] as String,
      lastLoadingTransactionInputs:
          (json['lastLoadingTransactionInputs'] as num?)?.toInt(),
      selected: json['selected'] as bool?,
      lastAddress: json['lastAddress'] as String?,
      balance: json['balance'] == null
          ? null
          : AccountBalance.fromJson(json['balance'] as Map<String, dynamic>),
      accountTokens: (json['accountTokens'] as List<dynamic>?)
          ?.map((e) => AccountToken.fromJson(e as Map<String, dynamic>))
          .toList(),
      accountNFT: (json['accountNFT'] as List<dynamic>?)
          ?.map((e) => AccountToken.fromJson(e as Map<String, dynamic>))
          .toList(),
      nftInfosOffChainList: (json['nftInfosOffChainList'] as List<dynamic>?)
          ?.map((e) => NftInfosOffChain.fromJson(e as Map<String, dynamic>))
          .toList(),
      serviceType: json['serviceType'] as String?,
      accountNFTCollections: (json['accountNFTCollections'] as List<dynamic>?)
          ?.map((e) => AccountToken.fromJson(e as Map<String, dynamic>))
          .toList(),
      customTokenAddressList: (json['customTokenAddressList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      publicKey: json['publicKey'] as String?,
    );

Map<String, dynamic> _$$AccountImplToJson(_$AccountImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'genesisAddress': instance.genesisAddress,
      'lastLoadingTransactionInputs': instance.lastLoadingTransactionInputs,
      'selected': instance.selected,
      'lastAddress': instance.lastAddress,
      'balance': instance.balance,
      'accountTokens': instance.accountTokens,
      'accountNFT': instance.accountNFT,
      'nftInfosOffChainList': instance.nftInfosOffChainList,
      'serviceType': instance.serviceType,
      'accountNFTCollections': instance.accountNFTCollections,
      'customTokenAddressList': instance.customTokenAddressList,
      'publicKey': instance.publicKey,
    };
