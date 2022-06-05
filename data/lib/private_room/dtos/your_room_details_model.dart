import 'package:data/private_room/dtos/room_reservation_model.dart';
import 'package:domain/private_room/entities/your_room_details.dart';
import 'package:json_annotation/json_annotation.dart';

part 'your_room_details_model.g.dart';

@JsonSerializable()
class YourRoomDetailsModel extends YourRoomDetails {
  const YourRoomDetailsModel({
    required int id,
    required int ownerId,
    required String name,
    required String description,
    required String imageUrl,
    required int capacity,
    required List<RoomReservationModel> reservations,
    required List<RoomReservationModel> recent,
  }) : super(
          id: id,
          ownerId: ownerId,
          name: name,
          description: description,
          imageUrl: imageUrl,
          capacity: capacity,
          reservations: reservations,
          recent: recent,
        );

  factory YourRoomDetailsModel.fromJson(Map<String, dynamic> json) => _$YourRoomDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$YourRoomDetailsModelToJson(this);
}
