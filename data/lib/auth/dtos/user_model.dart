import 'package:domain/auth/entities/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {
  const UserModel({
    required int id,
    required String type,
    required String accessToken,
    required bool isTokenExpired,
  }) : super(
          id: id,
          type: type,
          accessToken: accessToken,
          isTokenExpired: isTokenExpired,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
