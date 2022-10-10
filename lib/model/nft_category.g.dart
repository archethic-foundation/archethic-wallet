// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nft_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NftCategory _$$_NftCategoryFromJson(Map<String, dynamic> json) =>
    _$_NftCategory(
      id: json['id'] as int? ?? 0,
      name: json['name'] ?? '',
      image: json['image'] as String? ?? '',
    );

Map<String, dynamic> _$$_NftCategoryToJson(_$_NftCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
    };
