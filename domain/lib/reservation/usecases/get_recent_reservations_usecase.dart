import 'package:common/resources/data_state.dart';
import 'package:common/usecases/usecase.dart';
import 'package:domain/reservation/common/reservation_repository.dart';
import 'package:domain/reservation/entities/reservation.dart';

typedef Response = DataState<List<Reservation>>;
typedef Params = void;

class GetRecentReservationsUseCase implements UseCase<Response, Params?> {
  GetRecentReservationsUseCase(this.reservationRepository);
  final ReservationRepository reservationRepository;

  @override
  Future<Response> call({required Params? params}) {
    return reservationRepository.getRecentReservations();
  }
}
