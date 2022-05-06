import 'package:common/params/login_request.dart';
import 'package:common/params/signup_request.dart';
import 'package:data/auth/dtos/token_response_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import "package:common/utils/constants.dart";

part 'auth_api_service.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  @POST('/login')
  Future<HttpResponse<TokenReponseModel>> login(@Body() LoginRequestParams params);

  @POST('/signup')
  Future<HttpResponse<TokenReponseModel>> signUp(@Body() SignUpRequestParams params);
}
