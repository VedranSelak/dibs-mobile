// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'your_room_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YourRoomDetailsModel _$YourRoomDetailsModelFromJson(
        Map<String, dynamic> json) =>
    YourRoomDetailsModel(
      id: json['id'] as int,
      ownerId: json['ownerId'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      capacity: json['capacity'] as int,
      reservations: (json['reservations'] as List<dynamic>)
          .map((e) => RoomReservationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      recent: (json['recent'] as List<dynamic>)
          .map((e) => RoomReservationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$YourRoomDetailsModelToJson(
        YourRoomDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ownerId': instance.ownerId,
      'name': instance.name,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'capacity': instance.capacity,
      'reservations': instance.reservations,
      'recent': instance.recent,
    };
