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
    this.users,
    this.errorMessage,
  });
  final String name;
  final String description;
  final int capacity;
  final XFile? image;
  final List<SearchUser>? users;
  final String? errorMessage;

  @override
  List<Object?> get props => [name, description, capacity, image, users, errorMessage];
}

class CreatingRoom extends CreateRoomState {}
