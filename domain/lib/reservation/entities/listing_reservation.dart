import 'package:data/private_room/dtos/user_data_model.dart';
import 'package:equatable/equatable.dart';

class ListingReservation extends Equatable {
  const ListingReservation({
    required this.id,
    required this.spotId,
    required this.arrivalTimestamp,
    required this.stayApprox,
    required this.numOfParticipants,
    required this.user,
  });

  final int id;
  final int spotId;
  final int arrivalTimestamp;
  final int stayApprox;
  final int numOfParticipants;
  final UserDataModel user;

  @override
  List<Object?> get props => [id, spotId, arrivalTimestamp, stayApprox, numOfParticipants, user];
}
