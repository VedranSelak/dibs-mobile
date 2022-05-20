import 'package:domain/public_listing/entities/spot_entity.dart';
import 'package:equatable/equatable.dart';

class PublicListing extends Equatable {
  const PublicListing({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.shortDescription,
    required this.detailedDescription,
    required this.type,
    required this.imageUrls,
    this.spots,
  });

  final int id;
  final int ownerId;
  final String name;
  final String shortDescription;
  final String detailedDescription;
  final String type;
  final List<String> imageUrls;
  final List<SpotEntity>? spots;

  @override
  List<Object?> get props => [id, ownerId, name, shortDescription, detailedDescription, type, imageUrls, spots];
}
