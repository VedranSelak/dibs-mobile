class InviteRequestParams {
  const InviteRequestParams({
    required this.id,
    required this.body,
  });

  final int id;
  final UserResponseParams body;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'body': body,
      };
}

class UserResponseParams {
  const UserResponseParams({
    required this.userResponse,
  });

  final bool userResponse;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'userResponse': userResponse,
      };
}
