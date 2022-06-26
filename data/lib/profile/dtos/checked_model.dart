import 'package:domain/profile/entities/checked.dart';
import 'package:json_annotation/json_annotation.dart';

part 'checked_model.g.dart';

@JsonSerializable()
class CheckedModel extends Checked {
  const CheckedModel({
    required bool hasListing,
  }) : super(
          hasListing: hasListing,
        );

  factory CheckedModel.fromJson(Map<String, dynamic> json) => _$CheckedModelFromJson(json);

  Map<String, dynamic> toJson() => _$CheckedModelToJson(this);
}
