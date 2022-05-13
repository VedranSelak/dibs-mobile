import 'package:data/public_listing/dtos/public_listing_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import "package:common/utils/constants.dart";

part 'public_listing_api_service.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class PublicListingApiService {
  factory PublicListingApiService(Dio dio, {String baseUrl}) = _PublicListingApiService;

  @GET('/listings')
  Future<HttpResponse<List<PublicListingModel>>> getAll();
}
