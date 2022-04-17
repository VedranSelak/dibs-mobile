import 'package:data/placeholder_api/dtos/post_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'placeholder_api_repository.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com")
abstract class PlaceholderApiService {
  factory PlaceholderApiService(Dio dio, {String baseUrl}) =
      _PlaceholderApiService;

  @GET('/posts')
  Future<HttpResponse<List<PostModel>>> getPosts();
}
