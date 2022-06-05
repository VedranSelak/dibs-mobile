import 'package:domain/private_room/entities/private_room.dart';
import 'package:data/private_room/dtos/room_reservation_model.dart';

class YourRoomDetails extends PrivateRoom {
  const YourRoomDetails({
    required int id,
    required int ownerId,
    required String name,
    required String description,
    required String imageUrl,
    required int capacity,
    required this.reservations,
    required this.recent,
  }) : super(
          id: id,
          ownerId: ownerId,
          name: name,
          description: description,
          imageUrl: imageUrl,
          capacity: capacity,
        );

  final List<RoomReservationModel> reservations;
  final List<RoomReservationModel> recent;

  @override
  List<Object?> get props => [id, ownerId, name, description, imageUrl, capacity, reservations, recent];
}
