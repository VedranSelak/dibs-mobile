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
    required this.shortDesc,
    required this.detailedDesc,
    required this.type,
    required this.images,
    this.errorMessage,
  });
  final String name;
  final String shortDesc;
  final String detailedDesc;
  final ListingType? type;
  final List<XFile>? images;
  final String? errorMessage;

  @override
  List<Object?> get props => [name, shortDesc, detailedDesc, type, images, errorMessage];
}
