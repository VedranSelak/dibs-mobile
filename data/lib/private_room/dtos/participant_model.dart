import 'package:data/private_room/dtos/user_data_model.dart';
import 'package:domain/private_room/entities/participant.dart';
import 'package:json_annotation/json_annotation.dart';

part 'participant_model.g.dart';

@JsonSerializable()
class ParticipantModel extends Participant {
  const ParticipantModel({
    required int userId,
    required UserDataModel user,
  }) : super(
          userId: userId,
          user: user,
        );

  factory ParticipantModel.fromJson(Map<String, dynamic> json) => _$ParticipantModelFromJson(json);

  Map<String, dynamic> toJson() => _$ParticipantModelToJson(this);
}
