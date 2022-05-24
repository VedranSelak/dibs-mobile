import 'package:common/usecases/usecase.dart';
import 'package:domain/auth/common/auth_api_repository.dart';

typedef Response = void;
typedef Params = void;

class LogoutUserUseCase implements UseCase<Response, Params?> {
  LogoutUserUseCase(this.authApiRepository);
  final AuthApiRepository authApiRepository;

  @override
  Future<Response> call({required Params? params}) {
    return authApiRepository.logoutUser();
  }
}
