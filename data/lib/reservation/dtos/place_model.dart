import 'package:domain/reservation/entities/place.dart';
import 'package:json_annotation/json_annotation.dart';

part 'place_model.g.dart';

@JsonSerializable()
class PlaceModel extends Place {
  const PlaceModel({
    required int id,
    required String name,
    required String? shortDescription,
    required String? detailedDescription,
    required String? description,
    required String? type,
    required String imageUrl,
  }) : super(
          id: id,
          name: name,
          shortDescription: shortDescription,
          detailedDescription: detailedDescription,
          description: description,
          type: type,
          imageUrl: imageUrl,
        );

  factory PlaceModel.fromJson(Map<String, dynamic> json) => _$PlaceModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceModelToJson(this);
}
