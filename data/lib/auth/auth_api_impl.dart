import 'package:common/params/login_request.dart';
import 'package:common/resources/data_state.dart';
import 'package:common/utils/constants.dart';
import 'package:data/auth/datasource/auth_api_service.dart';
import 'package:dio/dio.dart';
import 'package:domain/auth/common/auth_api_repository.dart';
import 'package:domain/auth/entities/login_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthApiImpl implements AuthApiRepository {
  const AuthApiImpl(this.placeholderApiService);
  final AuthApiService placeholderApiService;

  @override
  Future<DataState<LoginResponse>> login(LoginRequestParams params) async {
    try {
      final httpResponse = await placeholderApiService.login(params);

      if (httpResponse.response.statusCode == 200) {
        const storage = FlutterSecureStorage();
        await storage.write(key: kAccessTokenKey, value: httpResponse.data.accessToken);
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
