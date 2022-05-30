part of "create_room_bloc.dart";

@immutable
abstract class CreateRoomState extends Equatable {
  const CreateRoomState();

  @override
  List<Object?> get props => [];
}

class CreateRoomInitial extends CreateRoomState {}

class RoomDataEntering extends CreateRoomState {
  const RoomDataEntering({
    required this.name,
    required this.description,
    required this.capacity,
    this.image,
  });
  final String name;
  final String description;
  final int capacity;
  final XFile? image;

  @override
  List<Object?> get props => [name, description, capacity, image];
}
