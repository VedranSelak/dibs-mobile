// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpotModel _$SpotModelFromJson(Map<String, dynamic> json) => SpotModel(
      id: json['id'] as int,
      listingId: json['listingId'] as int,
      availableSpots: json['availableSpots'] as int,
      rowName: json['rowName'] as String?,
    );

Map<String, dynamic> _$SpotModelToJson(SpotModel instance) => <String, dynamic>{
      'id': instance.id,
      'listingId': instance.listingId,
      'availableSpots': instance.availableSpots,
      'rowName': instance.rowName,
    };
