import 'package:equatable/equatable.dart';

class Place extends Equatable {
  const Place({
    required this.id,
    required this.name,
    required this.shortDescription,
    required this.detailedDescription,
    required this.description,
    required this.type,
    required this.imageUrl,
  });

  final int id;
  final String name;
  final String? shortDescription;
  final String? detailedDescription;
  final String? description;
  final String? type;
  final String imageUrl;

  @override
  List<Object?> get props => [id, name, shortDescription, detailedDescription, description, type, imageUrl];
}
