import 'package:common/params/create_listing_request.dart';
import 'package:data/public_listing/dtos/created_model.dart';
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

  @POST('/listings')
  Future<HttpResponse<CreatedModel>> postListing(
    @Body() CreateListingRequestParams params,
    @Header('Authorization') String header,
  );

  @GET('/listings/{id}')
  Future<HttpResponse<PublicListingModel>> getListingById(@Path('id') int id);

  @GET('/listings/search/{search}')
  Future<HttpResponse<List<PublicListingModel>>> searchListings(@Path('search') String search);
}
