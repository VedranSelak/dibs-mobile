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
