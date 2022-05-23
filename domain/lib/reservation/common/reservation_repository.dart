import 'package:common/params/create_reservation_request.dart';
import 'package:common/resources/data_state.dart';
import 'package:domain/public_listing/entities/created.dart';

abstract class ReservationRepository {
  Future<DataState<Created>> postReservation(CreateReservationRequestParams params);
}
