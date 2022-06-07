import 'package:data/reservation/dtos/place_model.dart';
import 'package:domain/reservation/entities/reservation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reservation_model.g.dart';

@JsonSerializable()
class ReservationModel extends Reservation {
  const ReservationModel({
    required int id,
    required int? spotId,
    required int arrivalTimestamp,
    required int stayApprox,
    required bool isPrivate,
    required int numOfParticipants,
    required PlaceModel place,
  }) : super(
          id: id,
          spotId: spotId,
          arrivalTimestamp: arrivalTimestamp,
          stayApprox: stayApprox,
          isPrivate: isPrivate,
          numOfParticipants: numOfParticipants,
          place: place,
        );

  factory ReservationModel.fromJson(Map<String, dynamic> json) => _$ReservationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationModelToJson(this);
}
