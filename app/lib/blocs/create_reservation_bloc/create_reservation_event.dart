part of "create_reservation_bloc.dart";

abstract class CreateReservationEvent extends Equatable {
  const CreateReservationEvent();

  @override
  List<Object?> get props => [];
}

class CreateReservation extends CreateReservationEvent {
  const CreateReservation({
    required this.listingId,
    required this.numOfPeople,
    required this.arrivalTime,
    required this.stay,
  });
  final int listingId;
  final int numOfPeople;
  final int arrivalTime;
  final int stay;

  @override
  List<Object?> get props => [listingId, numOfPeople, arrivalTime, stay];
}
