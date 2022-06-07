import 'package:equatable/equatable.dart';

class PrivateRoom extends Equatable {
  const PrivateRoom({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.capacity,
  });

  final int id;
  final int ownerId;
  final String name;
  final String description;
  final String imageUrl;
  final int capacity;

  @override
  List<Object?> get props => [id, name, ownerId, description, imageUrl, capacity];
}
