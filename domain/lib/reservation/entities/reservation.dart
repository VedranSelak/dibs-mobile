import 'package:data/public_listing/dtos/public_listing_model.dart';
import 'package:equatable/equatable.dart';

class Reservation extends Equatable {
  const Reservation({
    required this.id,
    required this.spotId,
    required this.isPrivate,
    required this.arrivalTimestamp,
    required this.stayApprox,
    required this.numOfParticipants,
    required this.publicListing,
  });

  final int id;
  final int spotId;
  final bool isPrivate;
  final int arrivalTimestamp;
  final int stayApprox;
  final int numOfParticipants;
  final PublicListingModel publicListing;

  @override
  List<Object?> get props => [id, spotId, isPrivate, arrivalTimestamp, stayApprox, numOfParticipants, publicListing];
}
