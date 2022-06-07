// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'private_room_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrivateRoomDetailsModel _$PrivateRoomDetailsModelFromJson(
        Map<String, dynamic> json) =>
    PrivateRoomDetailsModel(
      id: json['id'] as int,
      ownerId: json['ownerId'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      capacity: json['capacity'] as int,
      owner: UserDataModel.fromJson(json['owner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PrivateRoomDetailsModelToJson(
        PrivateRoomDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ownerId': instance.ownerId,
      'name': instance.name,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'capacity': instance.capacity,
      'owner': instance.owner,
    };
