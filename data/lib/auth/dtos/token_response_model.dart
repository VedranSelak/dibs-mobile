import 'package:domain/auth/entities/token_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'token_response_model.g.dart';

@JsonSerializable()
class TokenReponseModel extends TokenResponse {
  const TokenReponseModel({
    required String accessToken,
  }) : super(
          accessToken: accessToken,
        );

  factory TokenReponseModel.fromJson(Map<String, dynamic> json) => _$TokenReponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$TokenReponseModelToJson(this);
}
