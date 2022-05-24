import 'package:common/params/login_request.dart';
import 'package:common/params/signup_request.dart';
import 'package:domain/auth/entities/token_response.dart';
import 'package:common/resources/data_state.dart';
import 'package:domain/auth/entities/user.dart';

abstract class AuthApiRepository {
  Future<DataState<TokenResponse>> login(LoginRequestParams params);
  Future<DataState<TokenResponse>> signUp(SignUpRequestParams params);
  Future<User?> getUser();
  Future<void> logoutUser();
}
