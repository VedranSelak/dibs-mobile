import 'package:domain/auth/entities/login_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginReponseModel extends LoginResponse {
  const LoginReponseModel({
    required String accessToken,
  }) : super(
          accessToken: accessToken,
        );

  factory LoginReponseModel.fromJson(Map<String, dynamic> json) => _$LoginReponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginReponseModelToJson(this);
}
