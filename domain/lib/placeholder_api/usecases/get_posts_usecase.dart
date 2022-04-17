import 'package:common/resources/data_state.dart';
import 'package:domain/placeholder_api/common/placeholder_api_repository.dart';
import 'package:domain/placeholder_api/entities/post.dart';

class GetPostsUseCase {
  GetPostsUseCase(this.placeholderApiRepository);
  final PlaceholderApiRepository placeholderApiRepository;

  Future<DataState<List<Post>>> call() {
    return placeholderApiRepository.getPosts();
  }
}
