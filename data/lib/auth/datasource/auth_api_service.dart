import 'package:common/params/login_request.dart';
import 'package:data/auth/dtos/login_response_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import "package:common/utils/constants.dart";

part 'auth_api_service.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  @POST('/login')
  Future<HttpResponse<LoginReponseModel>> login(@Body() LoginRequestParams params);
}
