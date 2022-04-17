import 'package:common/base_di_module.dart';
import 'package:data/placeholder_api/datasource/placeholder_api_repository.dart';
import 'package:data/placeholder_api/di/placeholder_api_module.dart';
import 'package:dio/dio.dart';
import 'package:domain/placeholder_api/common/placeholder_api_repository.dart';
import 'package:domain/placeholder_api/usecases/get_posts_usecase.dart';
import 'package:get_it/get_it.dart';

class DataModule extends BaseDiModule {
  final _placeHolderApiService =
      PlaceholderApiService(Dio(BaseOptions(contentType: "application/json")));

  @override
  void inject() {
    PlaceholderApiModule(_placeHolderApiService);
    useCases();
  }

  void useCases() {
    final placeholderRepository = GetIt.I.get<PlaceholderApiRepository>();

    GetIt.I.registerFactory(() => GetPostsUseCase(placeholderRepository));
  }
}
