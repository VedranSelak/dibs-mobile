import 'package:data/reservation/dtos/place_model.dart';
import 'package:equatable/equatable.dart';

class Reservation extends Equatable {
  const Reservation({
    required this.id,
    required this.spotId,
    required this.isPrivate,
    required this.arrivalTimestamp,
    required this.stayApprox,
    required this.numOfParticipants,
    required this.place,
  });

  final int id;
  final int? spotId;
  final bool isPrivate;
  final int arrivalTimestamp;
  final int stayApprox;
  final int numOfParticipants;
  final PlaceModel place;

  @override
  List<Object?> get props => [id, spotId, isPrivate, arrivalTimestamp, stayApprox, numOfParticipants, place];
}
