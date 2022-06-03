// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'private_room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrivateRoomModel _$PrivateRoomModelFromJson(Map<String, dynamic> json) =>
    PrivateRoomModel(
      id: json['id'] as int,
      ownerId: json['ownerId'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      capacity: json['capacity'] as int,
    );

Map<String, dynamic> _$PrivateRoomModelToJson(PrivateRoomModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ownerId': instance.ownerId,
      'name': instance.name,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'capacity': instance.capacity,
    };
