import 'package:data/private_room/dtos/user_data_model.dart';
import 'package:domain/private_room/entities/private_room.dart';

class PrivateRoomDetails extends PrivateRoom {
  const PrivateRoomDetails({
    required int id,
    required int ownerId,
    required String name,
    required String description,
    required String imageUrl,
    required int capacity,
    required this.owner,
  }) : super(
          id: id,
          ownerId: ownerId,
          name: name,
          description: description,
          imageUrl: imageUrl,
          capacity: capacity,
        );

  final UserDataModel owner;

  @override
  List<Object?> get props => [id, ownerId, name, description, imageUrl, capacity, owner];
}
