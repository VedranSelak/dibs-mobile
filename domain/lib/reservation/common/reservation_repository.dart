import 'package:common/params/create_reservation_request.dart';
import 'package:common/params/create_room_reservation_request.dart';
import 'package:common/resources/data_state.dart';
import 'package:domain/public_listing/entities/created.dart';
import 'package:domain/reservation/entities/listing_reservation.dart';
import 'package:domain/reservation/entities/reservation.dart';

abstract class ReservationRepository {
  Future<DataState<Created>> postReservation(CreateReservationRequestParams params);
  Future<DataState<List<Reservation>>> getUpcomingReservations();
  Future<DataState<List<Reservation>>> getRecentReservations();
  Future<DataState<Created>> postRoomReservation(CreateRoomReservationRequestParams params);
  Future<DataState<List<ListingReservation>>> getUpcomingListingReservations();
  Future<DataState<List<ListingReservation>>> getRecentListingReservations();
  Future<DataState<Created>> removeFromHistory(int id);
  Future<DataState<Created>> cancelReservation(int id);
}
