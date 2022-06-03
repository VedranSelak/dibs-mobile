import 'package:data/private_room/dtos/participant_model.dart';
import 'package:equatable/equatable.dart';

class RoomDetails extends Equatable {
  const RoomDetails({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.capacity,
    required this.invites,
  });

  final int id;
  final int ownerId;
  final String name;
  final String description;
  final String imageUrl;
  final int capacity;
  final List<ParticipantModel> invites;

  @override
  List<Object?> get props => [id, name, ownerId, description, imageUrl, capacity];
}
