part of "reservations_bloc.dart";

@immutable
abstract class ReservationsState extends Equatable {
  const ReservationsState();

  @override
  List<Object?> get props => [];
}

class ReservationsInitial extends ReservationsState {}

class FetchingReservations extends ReservationsState {}

class FetchReservationsFailed extends ReservationsState {
  const FetchReservationsFailed({this.statusCode = 500, this.message = "Something went wrong"});
  final int? statusCode;
  final String? message;

  @override
  List<Object?> get props => [statusCode, message];
}

class ReservationsFetched extends ReservationsState {
  const ReservationsFetched({required this.reservations});
  final List<Reservation> reservations;

  @override
  List<Object?> get props => [reservations];
}

class ListingReservationsFetched extends ReservationsState {
  const ListingReservationsFetched({required this.reservations});
  final List<ListingReservation> reservations;

  @override
  List<Object?> get props => [reservations];
}
