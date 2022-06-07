// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomDetailsModel _$RoomDetailsModelFromJson(Map<String, dynamic> json) =>
    RoomDetailsModel(
      id: json['id'] as int,
      ownerId: json['ownerId'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      capacity: json['capacity'] as int,
      invites: (json['invites'] as List<dynamic>)
          .map((e) => ParticipantModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RoomDetailsModelToJson(RoomDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ownerId': instance.ownerId,
      'name': instance.name,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'capacity': instance.capacity,
      'invites': instance.invites,
    };
