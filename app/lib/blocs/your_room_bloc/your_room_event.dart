part of "your_room_bloc.dart";

abstract class YourRoomEvent extends Equatable {
  const YourRoomEvent();

  @override
  List<Object> get props => [];
}

class FetchYourRoomDetails extends YourRoomEvent {
  const FetchYourRoomDetails({required this.id});
  final int id;

  @override
  List<Object> get props => [id];
}

class AddInvite extends YourRoomEvent {
  const AddInvite({required this.user});
  final SearchUser user;

  @override
  List<Object> get props => [user];
}

class RemoveInvite extends YourRoomEvent {
  const RemoveInvite({required this.index});
  final int index;

  @override
  List<Object> get props => [index];
}
