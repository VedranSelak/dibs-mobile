import 'package:common/params/create_reservation_request.dart';
import 'package:data/public_listing/dtos/created_model.dart';
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
}
