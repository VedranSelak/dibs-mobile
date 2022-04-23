import 'package:common/params/login_request.dart';
import 'package:domain/auth/entities/login_response.dart';
import 'package:common/resources/data_state.dart';

abstract class AuthApiRepository {
  Future<DataState<LoginResponse>> login(LoginRequestParams params);
}
