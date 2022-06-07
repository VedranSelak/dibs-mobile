// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileDetailsModel _$ProfileDetailsModelFromJson(Map<String, dynamic> json) =>
    ProfileDetailsModel(
      id: json['id'] as int,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$ProfileDetailsModelToJson(
        ProfileDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'imageUrl': instance.imageUrl,
    };
