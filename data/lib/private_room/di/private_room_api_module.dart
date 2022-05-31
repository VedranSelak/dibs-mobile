import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:common/base_di_module.dart';
import 'package:data/private_room/datasource/private_room_api_service.dart';
import 'package:data/private_room/private_room_api_impl.dart';
import 'package:domain/private_room/common/private_room_api_repository.dart';
import 'package:get_it/get_it.dart';

class PrivateRoomApiModule extends BaseDiModule {
  PrivateRoomApiModule(this.apiService, this.cloudinaryPublic);
  final PrivateRoomApiService apiService;
  final CloudinaryPublic cloudinaryPublic;
  @override
  void inject() {
    GetIt.I.registerFactory<PrivateRoomApiRepository>(() => PrivateRoomApiImpl(apiService, cloudinaryPublic));
  }
}
