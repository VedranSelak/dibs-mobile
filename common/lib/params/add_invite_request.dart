class AddInviteRequestParams {
  const AddInviteRequestParams({
    required this.invites,
    required this.id,
  });

  final List<SingleInviteRequestParams> invites;
  final int id;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'invites': invites,
        'id': id,
      };
}

class SingleInviteRequestParams {
  const SingleInviteRequestParams({
    required this.userId,
    required this.roomId,
  });

  final int userId;
  final int roomId;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'userId': userId,
        'roomId': roomId,
      };
}
