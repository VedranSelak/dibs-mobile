part of "reservations_bloc.dart";

abstract class ReservationsEvent extends Equatable {
  const ReservationsEvent();

  @override
  List<Object> get props => [];
}

class FetchUpcomingReservations extends ReservationsEvent {}

class FetchRecentReservations extends ReservationsEvent {}

class FetchUpcomingListingReservations extends ReservationsEvent {}

class FetchRecentListingReservations extends ReservationsEvent {}

class CancelReservation extends ReservationsEvent {
  const CancelReservation({required this.id});
  final int id;

  @override
  List<Object> get props => [id];
}

class RemoveFromHistory extends ReservationsEvent {
  const RemoveFromHistory({required this.id});
  final int id;

  @override
  List<Object> get props => [id];
}
