import 'package:data/private_room/dtos/user_data_model.dart';
import 'package:domain/reservation/entities/listing_reservation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'listing_reservation_model.g.dart';

@JsonSerializable()
class ListingReservationModel extends ListingReservation {
  const ListingReservationModel({
    required int id,
    required int spotId,
    required int arrivalTimestamp,
    required int stayApprox,
    required int numOfParticipants,
    required UserDataModel user,
  }) : super(
          id: id,
          spotId: spotId,
          arrivalTimestamp: arrivalTimestamp,
          stayApprox: stayApprox,
          numOfParticipants: numOfParticipants,
          user: user,
        );

  factory ListingReservationModel.fromJson(Map<String, dynamic> json) => _$ListingReservationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListingReservationModelToJson(this);
}
