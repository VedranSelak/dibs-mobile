import 'package:common/params/login_request.dart';
import 'package:common/params/signup_request.dart';
import 'package:common/resources/data_state.dart';
import 'package:common/utils/constants.dart';
import 'package:data/auth/datasource/auth_api_service.dart';
import 'package:data/auth/dtos/user_model.dart';
import 'package:dio/dio.dart';
import 'package:domain/auth/common/auth_api_repository.dart';
import 'package:domain/auth/entities/token_response.dart';
import 'package:domain/auth/entities/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';

class AuthApiImpl implements AuthApiRepository {
  const AuthApiImpl(this.authApiService);
  final AuthApiService authApiService;

  @override
  Future<DataState<TokenResponse>> login(LoginRequestParams params) async {
    try {
      final httpResponse = await authApiService.login(params);

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

  @override
  Future<DataState<TokenResponse>> signUp(SignUpRequestParams params) async {
    try {
      final httpResponse = await authApiService.signUp(params);

      if (httpResponse.response.statusCode == 201) {
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

  @override
  Future<User?> getUser() async {
    const storage = FlutterSecureStorage();
    final String? token = await storage.read(key: kAccessTokenKey);
    if (token == null) {
      return null;
    }
    final Map<String, dynamic> userData = Jwt.parseJwt(token);
    final DateTime? expiryDate = Jwt.getExpiryDate(token);
    if (expiryDate != null && expiryDate.isBefore(DateTime.now())) {
      userData['isTokenExpired'] = true;
    } else if (expiryDate != null && expiryDate.isAfter(DateTime.now())) {
      userData['isTokenExpired'] = false;
    } else {
      userData['isTokenExpired'] = true;
    }
    userData['accessToken'] = token;
    return UserModel.fromJson(userData);
  }

  @override
  Future<void> logoutUser() async {
    await const FlutterSecureStorage().delete(key: kAccessTokenKey);
  }
}
