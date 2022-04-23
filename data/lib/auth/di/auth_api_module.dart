import 'package:common/base_di_module.dart';
import 'package:data/auth/datasource/auth_api_service.dart';
import 'package:data/auth/auth_api_impl.dart';
import 'package:domain/auth/common/auth_api_repository.dart';
import 'package:get_it/get_it.dart';

class AuthApiModule extends BaseDiModule {
  AuthApiModule(this.apiService);
  final AuthApiService apiService;
  @override
  void inject() {
    GetIt.I.registerFactory<AuthApiRepository>(() => AuthApiImpl(apiService));
  }
}
