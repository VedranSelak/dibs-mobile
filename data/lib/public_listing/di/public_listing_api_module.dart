import 'package:common/base_di_module.dart';
import 'package:data/public_listing/datasource/public_listing_api_service.dart';
import 'package:data/public_listing/public_listing_api_impl.dart';
import 'package:domain/public_listing/common/public_listing_api_repository.dart';
import 'package:get_it/get_it.dart';

class PublicListingApiModule extends BaseDiModule {
  PublicListingApiModule(this.apiService);
  final PublicListingApiService apiService;
  @override
  void inject() {
    GetIt.I.registerFactory<PublicListingApiRepository>(() => PublicListingApiImpl(apiService));
  }
}
