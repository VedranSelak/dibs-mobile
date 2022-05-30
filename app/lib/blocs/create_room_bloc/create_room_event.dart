part of "create_room_bloc.dart";

abstract class CreateRoomEvent extends Equatable {
  const CreateRoomEvent();

  @override
  List<Object?> get props => [];
}

class EnterRoomData extends CreateRoomEvent {
  const EnterRoomData({
    required this.name,
    required this.shortDesc,
    required this.detailedDesc,
  });
  final String name;
  final String shortDesc;
  final String detailedDesc;

  @override
  List<Object?> get props => [name, shortDesc, detailedDesc];
}
