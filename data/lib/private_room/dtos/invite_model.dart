import 'package:domain/private_room/entities/invite.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invite_model.g.dart';

@JsonSerializable()
class InviteModel extends Invite {
  const InviteModel({
    required int id,
    required int roomId,
    required String name,
    required String firstName,
    required String lastName,
    required String? imageUrl,
  }) : super(
          id: id,
          roomId: roomId,
          name: name,
          firstName: firstName,
          lastName: lastName,
          imageUrl: imageUrl,
        );

  factory InviteModel.fromJson(Map<String, dynamic> json) => _$InviteModelFromJson(json);

  Map<String, dynamic> toJson() => _$InviteModelToJson(this);
}
