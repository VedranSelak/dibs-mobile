import 'package:domain/public_listing/entities/public_listing.dart';
import 'package:json_annotation/json_annotation.dart';

part 'public_listing_model.g.dart';

@JsonSerializable()
class PublicListingModel extends PublicListing {
  const PublicListingModel(
      {required int id,
      required int ownerId,
      required String name,
      required String shortDescription,
      required String detailedDescription,
      required String type})
      : super(
          id: id,
          ownerId: ownerId,
          name: name,
          shortDescription: shortDescription,
          detailedDescription: detailedDescription,
          type: type,
        );

  factory PublicListingModel.fromJson(Map<String, dynamic> json) => _$PublicListingModelFromJson(json);

  Map<String, dynamic> toJson() => _$PublicListingModelToJson(this);
}
