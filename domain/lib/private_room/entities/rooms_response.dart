import 'package:data/private_room/dtos/room_details_model.dart';
import 'package:equatable/equatable.dart';

class RoomsResponse extends Equatable {
  const RoomsResponse({
    required this.room,
  });

  final RoomDetailsModel room;

  @override
  List<Object?> get props => [room];
}
