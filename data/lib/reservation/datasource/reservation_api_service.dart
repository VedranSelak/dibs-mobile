import 'package:common/params/create_reservation_request.dart';
import 'package:common/params/create_room_reservation_request.dart';
import 'package:data/public_listing/dtos/created_model.dart';
import 'package:data/reservation/dtos/reservation_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import "package:common/utils/constants.dart";

part 'reservation_api_service.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class ReservationApiService {
  factory ReservationApiService(Dio dio, {String baseUrl}) = _ReservationApiService;

  @POST('/reservations')
  Future<HttpResponse<CreatedModel>> postReservation(
    @Body() CreateReservationRequestParams params,
    @Header('Authorization') String header,
  );

  @GET('/reservations/upcoming')
  Future<HttpResponse<List<ReservationModel>>> getUpcomingReservations(
    @Header('Authorization') String header,
  );

  @GET('/reservations/recent')
  Future<HttpResponse<List<ReservationModel>>> getRecentReservations(
    @Header('Authorization') String header,
  );

  @POST('/reservations/room')
  Future<HttpResponse<CreatedModel>> postRoomReservation(
    @Body() CreateRoomReservationRequestParams params,
    @Header('Authorization') String header,
  );
}
