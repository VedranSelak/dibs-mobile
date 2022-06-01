import 'dart:convert';

import 'package:app/ui/features/create_room/room_invite_screen.dart';
import 'package:app/ui/features/home/home_screen.dart';
import 'package:app/ui/widgets/success_screen.dart';
import 'package:common/params/create_room_request.dart';
import 'package:common/resources/data_state.dart';
import 'package:domain/private_room/entities/search_user.dart';
import 'package:domain/private_room/usecases/create_private_room_usecase.dart';
import "package:equatable/equatable.dart";
import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

part "create_room_event.dart";
part "create_room_state.dart";

class CreateRoomBloc extends Bloc<CreateRoomEvent, CreateRoomState> {
  CreateRoomBloc() : super(CreateRoomInitial()) {
    on<EnterRoomData>(_onEnterRoomData);
    on<AddRoomImage>(_onAddRoomImage);
    on<AddUser>(_onAddUser);
    on<SubmitRoom>(_onSubmitRoom);
  }

  final CreateRoomUseCase _createRoomUseCase = GetIt.I.get<CreateRoomUseCase>();

  void _onEnterRoomData(EnterRoomData event, Emitter<CreateRoomState> emit) {
    emit(RoomDataEntering(name: event.name, description: event.description, capacity: event.capacity));
    Get.toNamed<dynamic>(RoomInviteScreen.routeName);
  }

  void _onAddRoomImage(AddRoomImage event, Emitter<CreateRoomState> emit) async {
    final currentState = state;
    if (currentState is RoomDataEntering) {
      final ImagePicker _picker = ImagePicker();
      final image = await _picker.pickImage(source: ImageSource.gallery);
      emit(RoomDataEntering(
          name: currentState.name,
          description: currentState.description,
          capacity: currentState.capacity,
          image: image,
          users: currentState.users));
    }
  }

  void _onAddUser(AddUser event, Emitter<CreateRoomState> emit) async {
    final currentState = state;
    if (currentState is RoomDataEntering) {
      final users = currentState.users ?? [];
      if (users.any((user) => user.id == event.user.id)) {
        return;
      }
      users.add(event.user);
      emit(RoomDataEntering(
        name: currentState.name,
        description: currentState.description,
        capacity: currentState.capacity,
        image: currentState.image,
        users: users,
      ));
      Fluttertoast.showToast(
        msg: 'User added',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.lightGreen,
      );
    }
  }

  void _onSubmitRoom(SubmitRoom event, Emitter<CreateRoomState> emit) async {
    final currentState = state;
    emit(CreatingRoom());
    if (currentState is RoomDataEntering) {
      if (currentState.users == null || currentState.users!.isEmpty) {
        _emitErrorState("Please invite people to your room", currentState, emit);
        return;
      }

      if (currentState.image == null) {
        _emitErrorState("Please enter an image before submiting", currentState, emit);
        return;
      }

      final response = await _createRoomUseCase(
          params: CreateRoomRequestParams(
        name: currentState.name,
        description: currentState.description,
        capacity: currentState.capacity,
        imageUrl: currentState.image!.path,
        invites: currentState.users!.map((user) => user.id).toList(),
      ));

      if (response is DataFailed) {
        if (response.error?.response?.statusCode != null && response.error?.response?.statusCode == 401) {
          _emitErrorState("Your session expired", currentState, emit);
        } else if (response.error?.response?.statusCode != null && response.error?.response?.statusCode == 400) {
          final Map errorObject = json.decode(response.error?.response.toString() ?? "") as Map;
          _emitErrorState(errorObject['msg'] as String? ?? "Bad request", currentState, emit);
        } else {
          _emitErrorState('Something went wrong, try again later', currentState, emit);
        }
      } else {
        Get.offAll<dynamic>(
            const SuccessScreen(
              isListing: false,
            ),
            predicate: ModalRoute.withName(HomeScreen.routeName));
        emit(CreateRoomInitial());
      }
    }
  }

  void _emitErrorState(String message, RoomDataEntering enteringState, Emitter<CreateRoomState> emit) {
    emit(RoomDataEntering(
      name: enteringState.name,
      description: enteringState.description,
      capacity: enteringState.capacity,
      image: enteringState.image,
      users: enteringState.users,
      errorMessage: message,
    ));
  }
}
