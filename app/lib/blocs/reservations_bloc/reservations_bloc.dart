import 'dart:convert';

import 'package:common/resources/data_state.dart';
import 'package:domain/reservation/entities/listing_reservation.dart';
import 'package:domain/reservation/entities/reservation.dart';
import 'package:domain/reservation/usecases/cancel_reservation_usecase.dart';
import 'package:domain/reservation/usecases/get_recent_listing_reservations_usecase.dart';
import 'package:domain/reservation/usecases/get_upcoming_listing_reservations_usecase.dart';
import 'package:domain/reservation/usecases/get_upcoming_reservations_usecase.dart';
import 'package:domain/reservation/usecases/get_recent_reservations_usecase.dart';
import 'package:domain/reservation/usecases/remove_from_history_usecase.dart';
import "package:equatable/equatable.dart";
import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';

part "reservations_event.dart";
part "reservations_state.dart";

class ReservationsBloc extends Bloc<ReservationsEvent, ReservationsState> {
  ReservationsBloc() : super(ReservationsInitial()) {
    on<FetchUpcomingReservations>(_onFetchUpcomingReservations);
    on<FetchRecentReservations>(_onFetchRecentReservations);
    on<FetchUpcomingListingReservations>(_onFetchUpcomingListingReservations);
    on<FetchRecentListingReservations>(_onFetchRecentListingReservations);
    on<CancelReservation>(_onCancelReservation);
    on<RemoveFromHistory>(_onRemoveFromHistory);
  }

  final GetUpcomingReservationsUseCase _getUpcomingReservationsUseCase = GetIt.I.get<GetUpcomingReservationsUseCase>();
  final GetRecentReservationsUseCase _getRecentReservationsUseCase = GetIt.I.get<GetRecentReservationsUseCase>();
  final GetUpcomingListingReservationsUseCase _getUpcomingListingReservationsUseCase =
      GetIt.I.get<GetUpcomingListingReservationsUseCase>();
  final GetRecentListingReservationsUseCase _getRecentListingReservationsUseCase =
      GetIt.I.get<GetRecentListingReservationsUseCase>();
  final CancelReservationUseCase _cancelReservationUseCase = GetIt.I.get<CancelReservationUseCase>();
  final RemoveFromHistoryUseCase _removeFromHistoryUseCase = GetIt.I.get<RemoveFromHistoryUseCase>();

  void _onFetchUpcomingReservations(FetchUpcomingReservations event, Emitter<ReservationsState> emit) async {
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

  void _onFetchUpcomingListingReservations(
      FetchUpcomingListingReservations event, Emitter<ReservationsState> emit) async {
    emit(FetchingReservations());
    final response = await _getUpcomingListingReservationsUseCase(params: null);
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
      emit(ListingReservationsFetched(reservations: response.data!));
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

  void _onFetchRecentListingReservations(FetchRecentListingReservations event, Emitter<ReservationsState> emit) async {
    emit(FetchingReservations());
    final response = await _getRecentListingReservationsUseCase(params: null);
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
      emit(ListingReservationsFetched(reservations: response.data!));
    }
  }

  void _onCancelReservation(CancelReservation event, Emitter<ReservationsState> emit) async {
    final response = await _cancelReservationUseCase(params: event.id);
    if (response is DataFailed) {
      Fluttertoast.showToast(
        msg: 'To late to cancel reservation',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
      );
    } else {
      Fluttertoast.showToast(
        msg: 'Reservation canceled',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
      );
      add(FetchUpcomingReservations());
    }
  }

  void _onRemoveFromHistory(RemoveFromHistory event, Emitter<ReservationsState> emit) async {
    final response = await _removeFromHistoryUseCase(params: event.id);
    if (response is DataFailed) {
      Fluttertoast.showToast(
        msg: 'Something went wrong',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
      );
    } else {
      Fluttertoast.showToast(
        msg: 'Removed from history',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
      );
      add(FetchRecentReservations());
    }
  }
}
