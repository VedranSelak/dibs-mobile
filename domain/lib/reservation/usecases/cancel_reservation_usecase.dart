import 'package:common/resources/data_state.dart';
import 'package:common/usecases/usecase.dart';
import 'package:domain/public_listing/entities/created.dart';
import 'package:domain/reservation/common/reservation_repository.dart';

typedef Response = DataState<Created>;
typedef Params = int;

class CancelReservationUseCase implements UseCase<Response, Params> {
  CancelReservationUseCase(this.reservationRepository);
  final ReservationRepository reservationRepository;

  @override
  Future<Response> call({required Params params}) {
    return reservationRepository.cancelReservation(params);
  }
}
