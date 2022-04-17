import 'package:common/resources/data_state.dart';
import 'package:data/placeholder_api/datasource/placeholder_api_repository.dart';
import 'package:data/placeholder_api/dtos/post_model.dart';
import 'package:dio/dio.dart';
import 'package:domain/placeholder_api/common/placeholder_api_repository.dart';

class PlaceholderApiImpl implements PlaceholderApiRepository {
  const PlaceholderApiImpl(this.placeholderApiService);
  final PlaceholderApiService placeholderApiService;

  @override
  Future<DataState<List<PostModel>>> getPosts() async {
    try {
      final httpResponse = await placeholderApiService.getPosts();

      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(httpResponse.data);
      }
      return DataFailed(DioError(
        error: httpResponse.response.statusMessage,
        response: httpResponse.response,
        type: DioErrorType.response,
        requestOptions: httpResponse.response.requestOptions,
      ));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }
}
