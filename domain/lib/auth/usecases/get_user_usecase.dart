import 'package:common/usecases/usecase.dart';
import 'package:domain/auth/common/auth_api_repository.dart';
import 'package:domain/auth/entities/user.dart';

typedef Response = User?;
typedef Params = void;

class GetUserUseCase implements UseCase<Response, Params?> {
  GetUserUseCase(this.authApiRepository);
  final AuthApiRepository authApiRepository;

  @override
  Future<Response> call({required Params? params}) {
    return authApiRepository.getUser();
  }
}
