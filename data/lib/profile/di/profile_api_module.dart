import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:common/base_di_module.dart';
import 'package:data/profile/datasource/profile_api_service.dart';
import 'package:data/profile/profile_api_impl.dart';
import 'package:domain/profile/common/profile_api_repository.dart';
import 'package:get_it/get_it.dart';

class ProfileApiModule extends BaseDiModule {
  ProfileApiModule(this.apiService, this.cloudinaryPublic);
  final ProfileApiService apiService;
  final CloudinaryPublic cloudinaryPublic;
  @override
  void inject() {
    GetIt.I.registerFactory<ProfileApiRepository>(() => ProfileApiImpl(apiService, cloudinaryPublic));
  }
}
