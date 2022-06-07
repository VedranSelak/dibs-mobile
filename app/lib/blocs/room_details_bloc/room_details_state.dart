part of "room_details_bloc.dart";

@immutable
abstract class RoomDetailsState extends Equatable {
  const RoomDetailsState();

  @override
  List<Object?> get props => [];
}

class RoomDetailsInitial extends RoomDetailsState {}

class RoomDetailsLoading extends RoomDetailsState {}

class RoomDetailsFetchFailed extends RoomDetailsState {
  const RoomDetailsFetchFailed({this.statusCode = 500, this.message = "Something went wrong"});
  final int? statusCode;
  final String? message;

  @override
  List<Object?> get props => [statusCode, message];
}

class RoomDetailsFetchSuccess extends RoomDetailsState {
  const RoomDetailsFetchSuccess({required this.room, this.errorMessage});
  final PrivateRoomDetails room;
  final String? errorMessage;

  @override
  List<Object?> get props => [room, errorMessage];
}
