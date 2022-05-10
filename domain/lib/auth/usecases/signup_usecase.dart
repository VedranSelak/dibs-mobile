import 'package:common/resources/data_state.dart';
import 'package:common/usecases/usecase.dart';
import 'package:common/params/signup_request.dart';
import 'package:domain/auth/common/auth_api_repository.dart';
import 'package:domain/auth/entities/token_response.dart';

typedef Response = DataState<TokenResponse>;
typedef Params = SignUpRequestParams;

class SignUpUseCase implements UseCase<Response, Params> {
  SignUpUseCase(this.authApiRepository);
  final AuthApiRepository authApiRepository;

  @override
  Future<Response> call({required Params params}) {
    return authApiRepository.signUp(params);
  }
}
