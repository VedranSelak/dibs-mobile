import 'package:domain/private_room/entities/user_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_data_model.g.dart';

@JsonSerializable()
class UserDataModel extends UserData {
  const UserDataModel({
    required String firstName,
    required String lastName,
  }) : super(
          firstName: firstName,
          lastName: lastName,
        );

  factory UserDataModel.fromJson(Map<String, dynamic> json) => _$UserDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataModelToJson(this);
}
