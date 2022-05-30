import 'dart:convert';

import 'package:common/resources/data_state.dart';
import 'package:domain/reservation/entities/reservation.dart';
import 'package:domain/reservation/usecases/get_upcoming_reservations_usecase.dart';
import 'package:domain/reservation/usecases/get_recent_reservations_usecase.dart';
import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:get_it/get_it.dart';
import "package:meta/meta.dart";

part "reservations_event.dart";
part "reservations_state.dart";

class ReservationsBloc extends Bloc<ReservationsEvent, ReservationsState> {
  ReservationsBloc() : super(ReservationsInitial()) {
    on<FetchUpcomingReservations>(_onFetchUpcomingReservations);
    on<FetchRecentReservations>(_onFetchRecentReservations);
  }

  final GetUpcomingReservationsUseCase _getUpcomingReservationsUseCase = GetIt.I.get<GetUpcomingReservationsUseCase>();
  final GetRecentReservationsUseCase _getRecentReservationsUseCase = GetIt.I.get<GetRecentReservationsUseCase>();

  void _onFetchUpcomingReservations(FetchUpcomingReservations event, Emitter<ReservationsState> emit) async {
    emit(FetchingReservations());
    final response = await _getUpcomingReservationsUseCase(params: null);
    if (response is DataFailed) {
      if (response.error?.response?.statusCode != null && response.error?.response?.statusCode == 401) {
        emit(FetchReservationsFailed(
            statusCode: response.error?.response?.statusCode, message: 'Your session has expired'));
      } else if (response.error?.response?.statusCode != null && response.error?.response?.statusCode == 400) {
        final Map errorObject = json.decode(response.error?.response.toString() ?? "") as Map;
        emit(FetchReservationsFailed(
            statusCode: response.error?.response?.statusCode, message: errorObject['msg'] as String?));
      } else {
        emit(const FetchReservationsFailed(message: 'Something went wrong, try again later'));
      }
    } else {
      emit(ReservationsFetched(reservations: response.data!));
    }
  }

  void _onFetchRecentReservations(FetchRecentReservations event, Emitter<ReservationsState> emit) async {
    emit(FetchingReservations());
    final response = await _getRecentReservationsUseCase(params: null);
    if (response is DataFailed) {
      if (response.error?.response?.statusCode != null && response.error?.response?.statusCode == 401) {
        emit(FetchReservationsFailed(
            statusCode: response.error?.response?.statusCode, message: 'Your session has expired'));
      } else if (response.error?.response?.statusCode != null && response.error?.response?.statusCode == 400) {
        final Map errorObject = json.decode(response.error?.response.toString() ?? "") as Map;
        emit(FetchReservationsFailed(
            statusCode: response.error?.response?.statusCode, message: errorObject['msg'] as String?));
      } else {
        emit(const FetchReservationsFailed(message: 'Something went wrong, try again later'));
      }
    } else {
      emit(ReservationsFetched(reservations: response.data!));
    }
  }
}
