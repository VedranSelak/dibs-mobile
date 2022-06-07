// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_reservation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomReservationModel _$RoomReservationModelFromJson(
        Map<String, dynamic> json) =>
    RoomReservationModel(
      id: json['id'] as int,
      arrivalTimestamp: json['arrivalTimestamp'] as int,
      stayApprox: json['stayApprox'] as int,
      user: UserDataModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RoomReservationModelToJson(
        RoomReservationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'arrivalTimestamp': instance.arrivalTimestamp,
      'stayApprox': instance.stayApprox,
      'user': instance.user,
    };
