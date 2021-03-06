import 'package:common/params/add_invite_request.dart';
import 'package:common/resources/data_state.dart';
import 'package:domain/private_room/entities/search_user.dart';
import 'package:domain/private_room/entities/your_room_details.dart';
import 'package:domain/private_room/usecases/add_invites_usecase.dart';
import 'package:domain/private_room/usecases/get_your_room_usecase.dart';
import "package:equatable/equatable.dart";
import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';

part "your_room_event.dart";
part "your_room_state.dart";

class YourRoomBloc extends Bloc<YourRoomEvent, YourRoomState> {
  YourRoomBloc() : super(YourRoomInitial()) {
    on<FetchYourRoomDetails>(_onFetchRoomDetails);
    on<AddInvite>(_onAddInvite);
    on<RemoveInvite>(_onRemoveInvite);
    on<SendInvites>(_onSendInvites);
  }

  final GetYourRoomUseCase _getYourRoomUseCase = GetIt.I.get<GetYourRoomUseCase>();
  final AddInvitesUseCase _addInvitesUseCase = GetIt.I.get<AddInvitesUseCase>();

  void _onFetchRoomDetails(FetchYourRoomDetails event, Emitter<YourRoomState> emit) async {
    emit(YourRoomLoading());
    final response = await _getYourRoomUseCase(params: event.id);
    if (response is DataFailed) {
      print(response.error.toString());
    } else {
      emit(YourRoomFetchSuccess(room: response.data!));
    }
  }

  void _onAddInvite(AddInvite event, Emitter<YourRoomState> emit) async {
    final currentState = state;
    if (currentState is YourRoomFetchSuccess) {
      if (currentState.users != null && !currentState.users!.any((user) => user.id == event.user.id)) {
        final newUsers = currentState.users!..add(event.user);
        emit(YourRoomFetchSuccess(room: currentState.room, users: newUsers));
      } else if (currentState.users == null) {
        emit(YourRoomFetchSuccess(room: currentState.room, users: [event.user]));
      }
    }
  }

  void _onRemoveInvite(RemoveInvite event, Emitter<YourRoomState> emit) async {
    final currentState = state;
    if (currentState is YourRoomFetchSuccess && currentState.users != null) {
      final newUsers = [...currentState.users!]..removeAt(event.index);
      emit(YourRoomFetchSuccess(room: currentState.room, users: newUsers));
    }
  }

  void _onSendInvites(SendInvites event, Emitter<YourRoomState> emit) async {
    final currentState = state;
    if (currentState is YourRoomFetchSuccess && currentState.users != null) {
      final invites = currentState.users!
          .map((user) => SingleInviteRequestParams(userId: user.id, roomId: currentState.room.id))
          .toList();
      final response =
          await _addInvitesUseCase(params: AddInviteRequestParams(id: currentState.room.id, invites: invites));
      if (response is DataFailed) {
        Fluttertoast.showToast(
            msg: 'Sending invites failed', gravity: ToastGravity.BOTTOM, backgroundColor: Colors.red);
      } else {
        Fluttertoast.showToast(msg: 'Invites sent', gravity: ToastGravity.BOTTOM, backgroundColor: Colors.green);
        emit(YourRoomFetchSuccess(room: currentState.room));
      }
    }
  }
}
