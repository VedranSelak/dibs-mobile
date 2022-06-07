import 'package:data/private_room/dtos/user_data_model.dart';
import 'package:domain/private_room/entities/private_room_details.dart';
import 'package:json_annotation/json_annotation.dart';

part 'private_room_details_model.g.dart';

@JsonSerializable()
class PrivateRoomDetailsModel extends PrivateRoomDetails {
  const PrivateRoomDetailsModel({
    required int id,
    required int ownerId,
    required String name,
    required String description,
    required String imageUrl,
    required int capacity,
    required UserDataModel owner,
  }) : super(
          id: id,
          ownerId: ownerId,
          name: name,
          description: description,
          imageUrl: imageUrl,
          capacity: capacity,
          owner: owner,
        );

  factory PrivateRoomDetailsModel.fromJson(Map<String, dynamic> json) => _$PrivateRoomDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PrivateRoomDetailsModelToJson(this);
}
