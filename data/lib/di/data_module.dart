import 'package:common/base_di_module.dart';
import 'package:data/auth/datasource/auth_api_service.dart';
import 'package:data/auth/di/auth_api_module.dart';
import 'package:data/placeholder_api/datasource/placeholder_api_repository.dart';
import 'package:data/placeholder_api/di/placeholder_api_module.dart';
import 'package:data/public_listing/datasource/public_listing_api_service.dart';
import 'package:data/public_listing/di/public_listing_api_module.dart';
import 'package:dio/dio.dart';
import 'package:domain/auth/common/auth_api_repository.dart';
import 'package:domain/auth/usecases/get_user_usecase.dart';
import 'package:domain/auth/usecases/login_usecase.dart';
import 'package:domain/auth/usecases/signup_usecase.dart';
import 'package:domain/placeholder_api/common/placeholder_api_repository.dart';
import 'package:domain/placeholder_api/usecases/get_posts_usecase.dart';
import 'package:domain/public_listing/common/public_listing_api_repository.dart';
import 'package:domain/public_listing/usecases/get_all_listings_usecase.dart';
import 'package:get_it/get_it.dart';

class DataModule extends BaseDiModule {
  final _placeHolderApiService = PlaceholderApiService(Dio(BaseOptions(contentType: "application/json")));
  final _authApiService = AuthApiService(Dio(BaseOptions(contentType: "application/json")));
  final _publicListingApiService = PublicListingApiService(Dio(BaseOptions(contentType: "application/json")));

  @override
  void inject() {
    PlaceholderApiModule(_placeHolderApiService);
    AuthApiModule(_authApiService);
    PublicListingApiModule(_publicListingApiService);
    useCases();
  }

  void useCases() {
    final placeholderRepository = GetIt.I.get<PlaceholderApiRepository>();
    final authRepository = GetIt.I.get<AuthApiRepository>();
    final publicListingRepository = GetIt.I.get<PublicListingApiRepository>();

    GetIt.I.registerFactory(() => GetPostsUseCase(placeholderRepository));

    // auth usecases
    GetIt.I.registerFactory(() => LoginUseCase(authRepository));
    GetIt.I.registerFactory(() => SignUpUseCase(authRepository));
    GetIt.I.registerFactory(() => GetUserUseCase(authRepository));

    // listing usecases
    GetIt.I.registerFactory(() => GetAllListingsUseCase(publicListingRepository));
  }
}
