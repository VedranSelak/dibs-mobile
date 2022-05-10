// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_listing_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicListingModel _$PublicListingModelFromJson(Map<String, dynamic> json) =>
    PublicListingModel(
      id: json['id'] as int,
      ownerId: json['ownerId'] as int,
      name: json['name'] as String,
      shortDescription: json['shortDescription'] as String,
      detailedDescription: json['detailedDescription'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$PublicListingModelToJson(PublicListingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ownerId': instance.ownerId,
      'name': instance.name,
      'shortDescription': instance.shortDescription,
      'detailedDescription': instance.detailedDescription,
      'type': instance.type,
    };
