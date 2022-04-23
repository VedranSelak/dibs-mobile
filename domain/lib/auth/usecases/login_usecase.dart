import 'package:common/resources/data_state.dart';
import 'package:common/usecases/usecase.dart';
import 'package:common/params/login_request.dart';
import 'package:domain/auth/common/auth_api_repository.dart';
import 'package:domain/auth/entities/login_response.dart';

typedef Response = DataState<LoginResponse>;
typedef Params = LoginRequestParams;

class LoginUseCase implements UseCase<Response, Params> {
  LoginUseCase(this.authApiRepository);
  final AuthApiRepository authApiRepository;

  @override
  Future<Response> call({required Params params}) {
    return authApiRepository.login(params);
  }
}
