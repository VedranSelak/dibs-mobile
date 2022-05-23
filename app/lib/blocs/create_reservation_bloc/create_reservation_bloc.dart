import 'dart:convert';

import 'package:common/params/create_reservation_request.dart';
import 'package:common/resources/data_state.dart';
import 'package:domain/reservation/usecases/post_reservation_usecase.dart';
import "package:equatable/equatable.dart";
import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

part "create_reservation_event.dart";
part "create_reservation_state.dart";

class CreateReservationBloc extends Bloc<CreateReservationEvent, CreateReservationState> {
  CreateReservationBloc() : super(CreateReservationInitial()) {
    on<CreateReservation>(_onCreateReservation);
  }

  final PostReservationUseCase _postReservationUseCase = GetIt.I.get<PostReservationUseCase>();

  void _onCreateReservation(CreateReservation event, Emitter<CreateReservationState> emit) async {
    if (event.numOfPeople <= 0) {
      emit(const ReservationFailed(message: 'Number of people is invalid'));
      return;
    } else if (event.arrivalTime <= 0) {
      emit(const ReservationFailed(message: 'Please provide data for all fields'));
      return;
    }

    final response = await _postReservationUseCase(
        params: CreateReservationRequestParams(
            listingId: event.listingId,
            numberOfParticipants: event.numOfPeople,
            isPrivate: false,
            arrivalTime: event.arrivalTime,
            stayApprox: event.arrivalTime + (event.stay * 3600000)));
    if (response is DataFailed) {
      if (response.error?.response?.statusCode != null && response.error?.response?.statusCode == 401) {
        emit(ReservationFailed(statusCode: response.error?.response?.statusCode, message: 'Your session has expired'));
      } else if (response.error?.response?.statusCode != null && response.error?.response?.statusCode == 400) {
        final Map errorObject = json.decode(response.error?.response.toString() ?? "") as Map;
        emit(ReservationFailed(
            statusCode: response.error?.response?.statusCode, message: errorObject['msg'] as String?));
      } else {
        emit(const ReservationFailed(message: 'Something went wrong, try again later'));
      }
    } else {
      emit(CreateReservationInitial());
      Get.back<dynamic>();
      Fluttertoast.showToast(
        msg: 'Reservation made!',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.lightGreen,
      );
    }
  }
}
