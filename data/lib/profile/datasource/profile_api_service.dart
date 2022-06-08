import 'package:common/params/change_profile_image_request.dart';
import 'package:data/profile/dtos/profile_details_model.dart';
import 'package:data/public_listing/dtos/created_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import "package:common/utils/constants.dart";

part 'profile_api_service.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class ProfileApiService {
  factory ProfileApiService(Dio dio, {String baseUrl}) = _ProfileApiService;

  @GET('/users/me')
  Future<HttpResponse<ProfileDetailsModel>> getAccountDetails(
    @Header('Authorization') String header,
  );

  @PATCH('/users')
  Future<HttpResponse<CreatedModel>> changeProfileImage(
    @Body() ChangeProfileImageBody body,
    @Header('Authorization') String header,
  );
}
