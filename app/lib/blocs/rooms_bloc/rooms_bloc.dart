import 'dart:convert';

import 'package:common/params/invite_request.dart';
import 'package:common/resources/data_state.dart';
import 'package:domain/private_room/entities/invite.dart';
import 'package:domain/private_room/entities/private_room.dart';
import 'package:domain/private_room/entities/rooms_response.dart';
import 'package:domain/private_room/usecases/get_invites_usecase.dart';
import 'package:domain/private_room/usecases/get_rooms_usecase.dart';
import 'package:domain/private_room/usecases/get_your_rooms_usecase.dart';
import 'package:domain/private_room/usecases/respond_to_invite_usecase.dart';
import "package:equatable/equatable.dart";
import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import "package:meta/meta.dart";

part "rooms_event.dart";
part "rooms_state.dart";

class RoomsBloc extends Bloc<RoomsEvent, RoomsState> {
  RoomsBloc() : super(RoomsInitial()) {
    on<FetchYourRooms>(_onFetchYourRooms);
    on<FetchRooms>(_onFetchRooms);
    on<FetchInvites>(_onFetchInvites);
    on<RespondToInvite>(_onRespondToInvite);
  }

  final GetYourRoomsUseCase _getYourRoomsUseCase = GetIt.I.get<GetYourRoomsUseCase>();
  final GetRoomsUseCase _getRoomsUseCase = GetIt.I.get<GetRoomsUseCase>();
  final GetInvitesUseCase _getInvitesUseCase = GetIt.I.get<GetInvitesUseCase>();
  final RespondToInviteUseCase _respondToInviteUseCase = GetIt.I.get<RespondToInviteUseCase>();

  void _onFetchYourRooms(FetchYourRooms event, Emitter<RoomsState> emit) async {
    emit(FetchingYourRooms());
    final response = await _getYourRoomsUseCase(params: null);
    if (response is DataFailed) {
      if (response.error?.response?.statusCode != null && response.error?.response?.statusCode == 401) {
        emit(FetchRoomsFailed(statusCode: response.error?.response?.statusCode, message: 'Your session has expired'));
      } else if (response.error?.response?.statusCode != null && response.error?.response?.statusCode == 400) {
        final Map errorObject = json.decode(response.error?.response.toString() ?? "") as Map;
        emit(
            FetchRoomsFailed(statusCode: response.error?.response?.statusCode, message: errorObject['msg'] as String?));
      } else {
        emit(const FetchRoomsFailed(message: 'Something went wrong, try again later'));
      }
    } else {
      emit(YourRoomsFetched(rooms: response.data!));
    }
  }

  void _onFetchRooms(FetchRooms event, Emitter<RoomsState> emit) async {
    emit(FetchingRooms());
    final response = await _getRoomsUseCase(params: null);
    if (response is DataFailed) {
      if (response.error?.response?.statusCode != null && response.error?.response?.statusCode == 401) {
        emit(FetchRoomsFailed(statusCode: response.error?.response?.statusCode, message: 'Your session has expired'));
      } else if (response.error?.response?.statusCode != null && response.error?.response?.statusCode == 400) {
        final Map errorObject = json.decode(response.error?.response.toString() ?? "") as Map;
        emit(
            FetchRoomsFailed(statusCode: response.error?.response?.statusCode, message: errorObject['msg'] as String?));
      } else {
        emit(const FetchRoomsFailed(message: 'Something went wrong, try again later'));
      }
    } else {
      emit(RoomsFetched(rooms: response.data!));
    }
  }

  void _onFetchInvites(FetchInvites event, Emitter<RoomsState> emit) async {
    if (state is! FetchInvites) {
      emit(FetchingInvites());
    }
    final response = await _getInvitesUseCase(params: null);
    if (response is DataFailed) {
      if (response.error?.response?.statusCode != null && response.error?.response?.statusCode == 401) {
        emit(FetchRoomsFailed(statusCode: response.error?.response?.statusCode, message: 'Your session has expired'));
      } else if (response.error?.response?.statusCode != null && response.error?.response?.statusCode == 400) {
        final Map errorObject = json.decode(response.error?.response.toString() ?? "") as Map;
        emit(
            FetchRoomsFailed(statusCode: response.error?.response?.statusCode, message: errorObject['msg'] as String?));
      } else {
        emit(const FetchRoomsFailed(message: 'Something went wrong, try again later'));
      }
    } else {
      emit(InvitesFetched(invites: response.data!));
    }
  }

  void _onRespondToInvite(RespondToInvite event, Emitter<RoomsState> emit) async {
    final response = await _respondToInviteUseCase(
      params: InviteRequestParams(
        id: event.id,
        body: UserResponseParams(userResponse: event.response),
      ),
    );
    if (response is DataFailed) {
      if (response.error?.response?.statusCode != null && response.error?.response?.statusCode == 401) {
        emit(FetchRoomsFailed(statusCode: response.error?.response?.statusCode, message: 'Your session has expired'));
      } else if (response.error?.response?.statusCode != null && response.error?.response?.statusCode == 400) {
        final Map errorObject = json.decode(response.error?.response.toString() ?? "") as Map;
        emit(
            FetchRoomsFailed(statusCode: response.error?.response?.statusCode, message: errorObject['msg'] as String?));
      } else {
        emit(const FetchRoomsFailed(message: 'Something went wrong, try again later'));
      }
    } else {
      Fluttertoast.showToast(
        msg: 'Responded to invite',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
      );
      add(FetchInvites());
    }
  }
}
