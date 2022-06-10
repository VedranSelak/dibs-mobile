class ChangeProfileImageRequestParams {
  const ChangeProfileImageRequestParams({
    required this.body,
  });

  final ChangeProfileImageBody body;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'body': body,
      };
}

class ChangeProfileImageBody {
  const ChangeProfileImageBody({
    required this.imageUrl,
  });

  final String imageUrl;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'imageUrl': imageUrl,
      };
}
