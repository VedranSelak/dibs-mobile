import 'package:common/resources/data_state.dart';
import 'package:data/public_listing/datasource/public_listing_api_service.dart';
import 'package:dio/dio.dart';
import 'package:domain/public_listing/common/public_listing_api_repository.dart';
import 'package:domain/public_listing/entities/public_listing.dart';

class PublicListingApiImpl implements PublicListingApiRepository {
  const PublicListingApiImpl(this.publicListingApiService);
  final PublicListingApiService publicListingApiService;

  @override
  Future<DataState<List<PublicListing>>> getAll() async {
    try {
      final httpResponse = await publicListingApiService.getAll();

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
