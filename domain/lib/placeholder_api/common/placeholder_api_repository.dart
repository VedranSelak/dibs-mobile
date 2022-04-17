import 'package:domain/placeholder_api/entities/post.dart';
import 'package:common/resources/data_state.dart';

abstract class PlaceholderApiRepository {
  Future<DataState<List<Post>>> getPosts();
}
