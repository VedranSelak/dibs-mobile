part of "rooms_bloc.dart";

abstract class RoomsEvent extends Equatable {
  const RoomsEvent();

  @override
  List<Object> get props => [];
}

class FetchYourRooms extends RoomsEvent {}

class FetchRooms extends RoomsEvent {}

class FetchInvites extends RoomsEvent {}

class RespondToInvite extends RoomsEvent {
  const RespondToInvite({required this.id, required this.response});
  final int id;
  final bool response;

  @override
  List<Object> get props => [id, response];
}

class LeaveRoom extends RoomsEvent {
  const LeaveRoom({required this.id});
  final int id;

  @override
  List<Object> get props => [id];
}
