part of "create_room_bloc.dart";

abstract class CreateRoomEvent extends Equatable {
  const CreateRoomEvent();

  @override
  List<Object?> get props => [];
}

class EnterRoomData extends CreateRoomEvent {
  const EnterRoomData({
    required this.name,
    required this.description,
    required this.capacity,
  });
  final String name;
  final String description;
  final int capacity;

  @override
  List<Object?> get props => [name, description, capacity];
}

class AddRoomImage extends CreateRoomEvent {}
