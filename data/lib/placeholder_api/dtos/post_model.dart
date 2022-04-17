import 'package:domain/placeholder_api/entities/post.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel extends Post {
  const PostModel({
    required int id,
    required int userId,
    required String title,
    required String body,
  }) : super(
          id: id,
          userId: userId,
          title: title,
          body: body,
        );

  factory PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}
