part of "rooms_bloc.dart";

@immutable
abstract class RoomsState extends Equatable {
  const RoomsState();

  @override
  List<Object?> get props => [];
}

class RoomsInitial extends RoomsState {}

class FetchingYourRooms extends RoomsState {}

class FetchingRooms extends RoomsState {}

class FetchingInvites extends RoomsState {}

class FetchRoomsFailed extends RoomsState {
  const FetchRoomsFailed({this.statusCode = 500, this.message = "Something went wrong"});
  final int? statusCode;
  final String? message;

  @override
  List<Object?> get props => [statusCode, message];
}

class YourRoomsFetched extends RoomsState {
  const YourRoomsFetched({required this.rooms});
  final List<PrivateRoom> rooms;

  @override
  List<Object?> get props => [rooms];
}

class RoomsFetched extends RoomsState {
  const RoomsFetched({required this.rooms});
  final List<RoomsResponse> rooms;

  @override
  List<Object?> get props => [rooms];
}

class InvitesFetched extends RoomsState {
  const InvitesFetched({required this.invites});
  final List<Invite> invites;

  @override
  List<Object?> get props => [invites];
}
