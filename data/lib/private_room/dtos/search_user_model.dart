import 'package:domain/private_room/entities/search_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_user_model.g.dart';

@JsonSerializable()
class SearchUserModel extends SearchUser {
  const SearchUserModel({
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

  factory SearchUserModel.fromJson(Map<String, dynamic> json) => _$SearchUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchUserModelToJson(this);
}
