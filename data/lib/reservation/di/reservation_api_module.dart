import 'package:common/base_di_module.dart';
import 'package:data/reservation/datasource/reservation_api_service.dart';
import 'package:data/reservation/reservation_api_impl.dart';
import 'package:domain/reservation/common/reservation_repository.dart';
import 'package:get_it/get_it.dart';

class ReservationApiModule extends BaseDiModule {
  ReservationApiModule(this.apiService);
  final ReservationApiService apiService;

  @override
  void inject() {
    GetIt.I.registerFactory<ReservationRepository>(() => ReservationApiImpl(apiService));
  }
}
