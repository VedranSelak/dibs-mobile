import 'package:common/params/create_reservation_request.dart';
import 'package:common/params/create_room_reservation_request.dart';
import 'package:common/resources/data_state.dart';
import 'package:common/utils/constants.dart';
import 'package:data/reservation/datasource/reservation_api_service.dart';
import 'package:dio/dio.dart';
import 'package:domain/public_listing/entities/created.dart';
import 'package:domain/reservation/common/reservation_repository.dart';
import 'package:domain/reservation/entities/listing_reservation.dart';
import 'package:domain/reservation/entities/reservation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ReservationApiImpl implements ReservationRepository {
  const ReservationApiImpl(this.reservationApiService);
  final ReservationApiService reservationApiService;

  @override
  Future<DataState<Created>> postReservation(CreateReservationRequestParams params) async {
    try {
      const storage = FlutterSecureStorage();
      final String? token = await storage.read(key: kAccessTokenKey);
      if (token == null) {
        return DataFailed(DioError(
          response: Response<dynamic>(
            requestOptions: RequestOptions(path: ""),
            statusCode: 401,
          ),
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ""),
        ));
      }

      final httpResponse = await reservationApiService.postReservation(
        params,
        'Bearer $token',
      );

      if (httpResponse.response.statusCode == 201) {
        return DataSuccess(httpResponse.data);
      }
      return DataFailed(DioError(
        error: httpResponse.response.statusMessage,
        response: httpResponse.response,
        type: DioErrorType.response,
        requestOptions: httpResponse.response.requestOptions,
      ));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<Reservation>>> getUpcomingReservations() async {
    try {
      const storage = FlutterSecureStorage();
      final String? token = await storage.read(key: kAccessTokenKey);
      if (token == null) {
        return DataFailed(DioError(
          response: Response<dynamic>(
            requestOptions: RequestOptions(path: ""),
            statusCode: 401,
          ),
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ""),
        ));
      }

      final httpResponse = await reservationApiService.getUpcomingReservations(
        'Bearer $token',
      );

      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(httpResponse.data);
      }
      return DataFailed(DioError(
        error: httpResponse.response.statusMessage,
        response: httpResponse.response,
        type: DioErrorType.response,
        requestOptions: httpResponse.response.requestOptions,
      ));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<Reservation>>> getRecentReservations() async {
    try {
      const storage = FlutterSecureStorage();
      final String? token = await storage.read(key: kAccessTokenKey);
      if (token == null) {
        return DataFailed(DioError(
          response: Response<dynamic>(
            requestOptions: RequestOptions(path: ""),
            statusCode: 401,
          ),
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ""),
        ));
      }

      final httpResponse = await reservationApiService.getRecentReservations(
        'Bearer $token',
      );

      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(httpResponse.data);
      }
      return DataFailed(DioError(
        error: httpResponse.response.statusMessage,
        response: httpResponse.response,
        type: DioErrorType.response,
        requestOptions: httpResponse.response.requestOptions,
      ));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<Created>> postRoomReservation(CreateRoomReservationRequestParams params) async {
    try {
      const storage = FlutterSecureStorage();
      final String? token = await storage.read(key: kAccessTokenKey);
      if (token == null) {
        return DataFailed(DioError(
          response: Response<dynamic>(
            requestOptions: RequestOptions(path: ""),
            statusCode: 401,
          ),
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ""),
        ));
      }

      final httpResponse = await reservationApiService.postRoomReservation(
        params,
        'Bearer $token',
      );

      if (httpResponse.response.statusCode == 201) {
        return DataSuccess(httpResponse.data);
      }
      return DataFailed(DioError(
        error: httpResponse.response.statusMessage,
        response: httpResponse.response,
        type: DioErrorType.response,
        requestOptions: httpResponse.response.requestOptions,
      ));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<ListingReservation>>> getRecentListingReservations() async {
    try {
      const storage = FlutterSecureStorage();
      final String? token = await storage.read(key: kAccessTokenKey);
      if (token == null) {
        return DataFailed(DioError(
          response: Response<dynamic>(
            requestOptions: RequestOptions(path: ""),
            statusCode: 401,
          ),
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ""),
        ));
      }

      final httpResponse = await reservationApiService.getRecentListingReservations(
        'Bearer $token',
      );

      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(httpResponse.data);
      }
      return DataFailed(DioError(
        error: httpResponse.response.statusMessage,
        response: httpResponse.response,
        type: DioErrorType.response,
        requestOptions: httpResponse.response.requestOptions,
      ));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<ListingReservation>>> getUpcomingListingReservations() async {
    try {
      const storage = FlutterSecureStorage();
      final String? token = await storage.read(key: kAccessTokenKey);
      if (token == null) {
        return DataFailed(DioError(
          response: Response<dynamic>(
            requestOptions: RequestOptions(path: ""),
            statusCode: 401,
          ),
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ""),
        ));
      }

      final httpResponse = await reservationApiService.getUpcomingListingReservations(
        'Bearer $token',
      );

      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(httpResponse.data);
      }
      return DataFailed(DioError(
        error: httpResponse.response.statusMessage,
        response: httpResponse.response,
        type: DioErrorType.response,
        requestOptions: httpResponse.response.requestOptions,
      ));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<Created>> cancelReservation(int id) async {
    try {
      const storage = FlutterSecureStorage();
      final String? token = await storage.read(key: kAccessTokenKey);
      if (token == null) {
        return DataFailed(DioError(
          response: Response<dynamic>(
            requestOptions: RequestOptions(path: ""),
            statusCode: 401,
          ),
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ""),
        ));
      }

      final httpResponse = await reservationApiService.cancelReservation(
        id,
        'Bearer $token',
      );

      if (httpResponse.response.statusCode == 201) {
        return DataSuccess(httpResponse.data);
      }
      return DataFailed(DioError(
        error: httpResponse.response.statusMessage,
        response: httpResponse.response,
        type: DioErrorType.response,
        requestOptions: httpResponse.response.requestOptions,
      ));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<Created>> removeFromHistory(int id) async {
    try {
      const storage = FlutterSecureStorage();
      final String? token = await storage.read(key: kAccessTokenKey);
      if (token == null) {
        return DataFailed(DioError(
          response: Response<dynamic>(
            requestOptions: RequestOptions(path: ""),
            statusCode: 401,
          ),
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ""),
        ));
      }

      final httpResponse = await reservationApiService.removeFromHistory(
        id,
        'Bearer $token',
      );

      if (httpResponse.response.statusCode == 201) {
        return DataSuccess(httpResponse.data);
      }
      return DataFailed(DioError(
        error: httpResponse.response.statusMessage,
        response: httpResponse.response,
        type: DioErrorType.response,
        requestOptions: httpResponse.response.requestOptions,
      ));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }
}
