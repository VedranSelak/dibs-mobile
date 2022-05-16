import 'package:domain/public_listing/entities/created.dart';
import 'package:json_annotation/json_annotation.dart';

part 'created_model.g.dart';

@JsonSerializable()
class CreatedModel extends Created {
  const CreatedModel({required int id}) : super(id: id);

  factory CreatedModel.fromJson(Map<String, dynamic> json) => _$CreatedModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreatedModelToJson(this);
}
