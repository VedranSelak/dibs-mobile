// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listing_reservation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListingReservationModel _$ListingReservationModelFromJson(
        Map<String, dynamic> json) =>
    ListingReservationModel(
      id: json['id'] as int,
      spotId: json['spotId'] as int,
      arrivalTimestamp: json['arrivalTimestamp'] as int,
      stayApprox: json['stayApprox'] as int,
      numOfParticipants: json['numOfParticipants'] as int,
      user: UserDataModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ListingReservationModelToJson(
        ListingReservationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'spotId': instance.spotId,
      'arrivalTimestamp': instance.arrivalTimestamp,
      'stayApprox': instance.stayApprox,
      'numOfParticipants': instance.numOfParticipants,
      'user': instance.user,
    };
