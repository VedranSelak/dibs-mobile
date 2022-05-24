// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as int,
      type: json['type'] as String,
      accessToken: json['accessToken'] as String,
      isTokenExpired: json['isTokenExpired'] as bool,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'accessToken': instance.accessToken,
      'isTokenExpired': instance.isTokenExpired,
    };
