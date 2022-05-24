// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationModel _$ReservationModelFromJson(Map<String, dynamic> json) =>
    ReservationModel(
      id: json['id'] as int,
      spotId: json['spotId'] as int,
      arrivalTimestamp: json['arrivalTimestamp'] as int,
      stayApprox: json['stayApprox'] as int,
      isPrivate: json['isPrivate'] as bool,
      numOfParticipants: json['numOfParticipants'] as int,
      publicListing: PublicListingModel.fromJson(
          json['publicListing'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReservationModelToJson(ReservationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'spotId': instance.spotId,
      'isPrivate': instance.isPrivate,
      'arrivalTimestamp': instance.arrivalTimestamp,
      'stayApprox': instance.stayApprox,
      'numOfParticipants': instance.numOfParticipants,
      'publicListing': instance.publicListing,
    };
