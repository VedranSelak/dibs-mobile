part of "room_details_bloc.dart";

abstract class RoomDetailsEvent extends Equatable {
  const RoomDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchRoomDetails extends RoomDetailsEvent {
  const FetchRoomDetails({required this.id});
  final int id;

  @override
  List<Object> get props => [id];
}

class CreateRoomReservation extends RoomDetailsEvent {
  const CreateRoomReservation({required this.roomId, required this.arrivalTime, required this.stayApprox});
  final int roomId;
  final int arrivalTime;
  final int stayApprox;

  @override
  List<Object> get props => [roomId, arrivalTime, stayApprox];
}
