import 'package:equatable/equatable.dart';

class PublicListing extends Equatable {
  const PublicListing({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.shortDescription,
    required this.detailedDescription,
    required this.type,
  });

  final int id;
  final int ownerId;
  final String name;
  final String shortDescription;
  final String detailedDescription;
  final String type;

  @override
  List<Object> get props => [id, ownerId, name, shortDescription, detailedDescription, type];
}
