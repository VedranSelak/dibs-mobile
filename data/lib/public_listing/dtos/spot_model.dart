import 'package:domain/public_listing/entities/spot_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'spot_model.g.dart';

@JsonSerializable()
class SpotModel extends SpotEntity {
  const SpotModel({
    required int id,
    required int listingId,
    required int availableSpots,
    String? rowName,
  }) : super(
          id: id,
          listingId: listingId,
          availableSpots: availableSpots,
          rowName: rowName,
        );

  factory SpotModel.fromJson(Map<String, dynamic> json) => _$SpotModelFromJson(json);

  Map<String, dynamic> toJson() => _$SpotModelToJson(this);
}
