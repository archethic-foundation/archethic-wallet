// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nft_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NftCategoryImpl _$$NftCategoryImplFromJson(Map<String, dynamic> json) =>
    _$NftCategoryImpl(
      id: json['id'] as int? ?? 0,
      name: json['name'] ?? '',
      image: json['image'] as String? ?? '',
    );

Map<String, dynamic> _$$NftCategoryImplToJson(_$NftCategoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
    };
