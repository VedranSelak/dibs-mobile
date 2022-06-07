import 'package:common/resources/data_state.dart';
import 'package:common/usecases/usecase.dart';
import 'package:domain/reservation/common/reservation_repository.dart';
import 'package:domain/reservation/entities/listing_reservation.dart';

typedef Response = DataState<List<ListingReservation>>;
typedef Params = void;

class GetRecentListingReservationsUseCase implements UseCase<Response, Params?> {
  GetRecentListingReservationsUseCase(this.reservationRepository);
  final ReservationRepository reservationRepository;

  @override
  Future<Response> call({required Params? params}) {
    return reservationRepository.getRecentListingReservations();
  }
}
