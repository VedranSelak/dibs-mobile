import 'package:common/base_di_module.dart';
import 'package:data/placeholder_api/datasource/placeholder_api_repository.dart';
import 'package:data/placeholder_api/placeholder_api_impl.dart';
import 'package:domain/placeholder_api/common/placeholder_api_repository.dart';
import 'package:get_it/get_it.dart';

class PlaceholderApiModule extends BaseDiModule {
  PlaceholderApiModule(this.apiService);
  final PlaceholderApiService apiService;
  @override
  void inject() {
    GetIt.I.registerFactory<PlaceholderApiRepository>(
        () => PlaceholderApiImpl(apiService));
  }
}
