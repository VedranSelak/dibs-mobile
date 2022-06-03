// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rooms_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomsResponseModel _$RoomsResponseModelFromJson(Map<String, dynamic> json) =>
    RoomsResponseModel(
      room: RoomDetailsModel.fromJson(json['room'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RoomsResponseModelToJson(RoomsResponseModel instance) =>
    <String, dynamic>{
      'room': instance.room,
    };
