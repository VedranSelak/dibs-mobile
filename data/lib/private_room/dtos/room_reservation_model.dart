import 'package:data/private_room/dtos/user_data_model.dart';
import 'package:domain/private_room/entities/room_reservation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'room_reservation_model.g.dart';

@JsonSerializable()
class RoomReservationModel extends RoomReservation {
  const RoomReservationModel({
    required int id,
    required int arrivalTimestamp,
    required int stayApprox,
    required UserDataModel user,
  }) : super(
          id: id,
          arrivalTimestamp: arrivalTimestamp,
          stayApprox: stayApprox,
          user: user,
        );

  factory RoomReservationModel.fromJson(Map<String, dynamic> json) => _$RoomReservationModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomReservationModelToJson(this);
}
