import 'package:domain/profile/entities/profile_details.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_details_model.g.dart';

@JsonSerializable()
class ProfileDetailsModel extends ProfileDetails {
  const ProfileDetailsModel({
    required int id,
    required String firstName,
    required String lastName,
    required String? imageUrl,
  }) : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
          imageUrl: imageUrl,
        );

  factory ProfileDetailsModel.fromJson(Map<String, dynamic> json) => _$ProfileDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDetailsModelToJson(this);
}
