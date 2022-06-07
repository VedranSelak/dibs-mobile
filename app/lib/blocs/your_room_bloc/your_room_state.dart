part of "your_room_bloc.dart";

@immutable
abstract class YourRoomState extends Equatable {
  const YourRoomState();

  @override
  List<Object?> get props => [];
}

class YourRoomInitial extends YourRoomState {}

class YourRoomLoading extends YourRoomState {}

class YourRoomFetchSuccess extends YourRoomState {
  const YourRoomFetchSuccess({required this.room, this.errorMessage});
  final YourRoomDetails room;
  final String? errorMessage;

  @override
  List<Object?> get props => [room, errorMessage];
}
