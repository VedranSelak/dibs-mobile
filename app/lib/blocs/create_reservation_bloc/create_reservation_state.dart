part of "create_reservation_bloc.dart";

@immutable
abstract class CreateReservationState extends Equatable {
  const CreateReservationState();

  @override
  List<Object?> get props => [];
}

class CreateReservationInitial extends CreateReservationState {}

class ReservationFailed extends CreateReservationState {
  const ReservationFailed({this.statusCode = 500, this.message = "Something went wrong"});
  final int? statusCode;
  final String? message;

  @override
  List<Object?> get props => [statusCode, message];
}
