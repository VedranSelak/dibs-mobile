import 'package:data/private_room/dtos/room_details_model.dart';
import 'package:domain/private_room/entities/private_room.dart';
import 'package:domain/private_room/entities/rooms_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rooms_response_model.g.dart';

@JsonSerializable()
class RoomsResponseModel extends RoomsResponse {
  const RoomsResponseModel({
    required RoomDetailsModel room,
  }) : super(
          room: room,
        );

  factory RoomsResponseModel.fromJson(Map<String, dynamic> json) => _$RoomsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomsResponseModelToJson(this);
}
