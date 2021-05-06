// GENERATED CODE - DO NOT MODIFY BY HAND

// @dart=2.9

part of 'contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contact _$ContactFromJson(Map<String, dynamic> json) {
  return Contact(
    name: json['name'] as String,
    address: json['address'] as String,
  );
}

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
    };
