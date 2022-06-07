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
