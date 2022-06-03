import 'package:data/private_room/dtos/participant_model.dart';
import 'package:domain/private_room/entities/room_details.dart';
import 'package:json_annotation/json_annotation.dart';

part 'room_details_model.g.dart';

@JsonSerializable()
class RoomDetailsModel extends RoomDetails {
  const RoomDetailsModel({
    required int id,
    required int ownerId,
    required String name,
    required String description,
    required String imageUrl,
    required int capacity,
    required List<ParticipantModel> invites,
  }) : super(
          id: id,
          ownerId: ownerId,
          name: name,
          description: description,
          imageUrl: imageUrl,
          capacity: capacity,
          invites: invites,
        );

  factory RoomDetailsModel.fromJson(Map<String, dynamic> json) => _$RoomDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomDetailsModelToJson(this);
}
