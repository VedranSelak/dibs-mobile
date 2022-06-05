// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceModel _$PlaceModelFromJson(Map<String, dynamic> json) => PlaceModel(
      id: json['id'] as int,
      name: json['name'] as String,
      shortDescription: json['shortDescription'] as String?,
      detailedDescription: json['detailedDescription'] as String?,
      description: json['description'] as String?,
      type: json['type'] as String?,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$PlaceModelToJson(PlaceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'shortDescription': instance.shortDescription,
      'detailedDescription': instance.detailedDescription,
      'description': instance.description,
      'type': instance.type,
      'imageUrl': instance.imageUrl,
    };
