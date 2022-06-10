// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invite_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InviteModel _$InviteModelFromJson(Map<String, dynamic> json) => InviteModel(
      id: json['id'] as int,
      roomId: json['roomId'] as int,
      name: json['name'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$InviteModelToJson(InviteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roomId': instance.roomId,
      'name': instance.name,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'imageUrl': instance.imageUrl,
    };
