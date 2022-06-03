// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParticipantModel _$ParticipantModelFromJson(Map<String, dynamic> json) =>
    ParticipantModel(
      userId: json['userId'] as int,
      user: UserDataModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ParticipantModelToJson(ParticipantModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'user': instance.user,
    };
