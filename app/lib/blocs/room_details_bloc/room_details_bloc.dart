import 'dart:convert';

import 'package:common/params/create_room_reservation_request.dart';
import 'package:common/resources/data_state.dart';
import 'package:domain/private_room/entities/private_room_details.dart';
import 'package:domain/private_room/usecases/get_room_details_usecase.dart';
import 'package:domain/reservation/usecases/post_room_reservation_usecase.dart';
import "package:equatable/equatable.dart";
import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';

part "room_details_event.dart";
part "room_details_state.dart";

class RoomDetailsBloc extends Bloc<RoomDetailsEvent, RoomDetailsState> {
  RoomDetailsBloc() : super(RoomDetailsInitial()) {
    on<FetchRoomDetails>(_onFetchRoomDetails);
    on<CreateRoomReservation>(_onCreateRoomReservations);
  }

  final GetRoomDetailsUseCase _getRoomDetailsUseCase = GetIt.I.get<GetRoomDetailsUseCase>();
  final PostRoomReservationUseCase _postRoomReservationUseCase = GetIt.I.get<PostRoomReservationUseCase>();

  void _onFetchRoomDetails(FetchRoomDetails event, Emitter<RoomDetailsState> emit) async {
    final response = await _getRoomDetailsUseCase(params: event.id);
    if (response is DataFailed) {
      print(response.error.toString());
    } else {
      emit(RoomDetailsFetchSuccess(room: response.data!));
    }
  }

  void _onCreateRoomReservations(CreateRoomReservation event, Emitter<RoomDetailsState> emit) async {
    final response = await _postRoomReservationUseCase(
      params: CreateRoomReservationRequestParams(
        roomId: event.roomId,
        arrivalTime: event.arrivalTime,
        stayApprox: event.arrivalTime + (event.stayApprox * 3600000),
      ),
    );
    final currentState = state;
    if (response is DataFailed && currentState is RoomDetailsFetchSuccess) {
      if (response.error?.response?.statusCode != null && response.error?.response?.statusCode == 401) {
        emit(RoomDetailsFetchSuccess(room: currentState.room, errorMessage: 'Your session has expired'));
      } else if (response.error?.response?.statusCode != null && response.error?.response?.statusCode == 400) {
        final Map errorObject = json.decode(response.error?.response.toString() ?? "") as Map;
        emit(RoomDetailsFetchSuccess(room: currentState.room, errorMessage: errorObject['msg'] as String?));
      } else {
        emit(RoomDetailsFetchSuccess(room: currentState.room, errorMessage: 'Something went wrong, try again later'));
      }
    } else if (currentState is RoomDetailsFetchSuccess) {
      Fluttertoast.showToast(
        msg: 'Created a reservation',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
      );
      emit(RoomDetailsFetchSuccess(room: currentState.room));
    }
  }
}
