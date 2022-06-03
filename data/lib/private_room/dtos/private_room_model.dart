import 'package:domain/private_room/entities/private_room.dart';
import 'package:json_annotation/json_annotation.dart';

part 'private_room_model.g.dart';

@JsonSerializable()
class PrivateRoomModel extends PrivateRoom {
  const PrivateRoomModel({
    required int id,
    required int ownerId,
    required String name,
    required String description,
    required String imageUrl,
    required int capacity,
  }) : super(
          id: id,
          ownerId: ownerId,
          name: name,
          description: description,
          imageUrl: imageUrl,
          capacity: capacity,
        );

  factory PrivateRoomModel.fromJson(Map<String, dynamic> json) => _$PrivateRoomModelFromJson(json);

  Map<String, dynamic> toJson() => _$PrivateRoomModelToJson(this);
}
