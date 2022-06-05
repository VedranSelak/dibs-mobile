import 'package:common/params/create_room_reservation_request.dart';
import 'package:common/resources/data_state.dart';
import 'package:common/usecases/usecase.dart';
import 'package:domain/public_listing/entities/created.dart';
import 'package:domain/reservation/common/reservation_repository.dart';

typedef Response = DataState<Created>;
typedef Params = CreateRoomReservationRequestParams;

class PostRoomReservationUseCase implements UseCase<Response, Params> {
  PostRoomReservationUseCase(this.reservationRepository);
  final ReservationRepository reservationRepository;

  @override
  Future<Response> call({required Params params}) {
    return reservationRepository.postRoomReservation(params);
  }
}
