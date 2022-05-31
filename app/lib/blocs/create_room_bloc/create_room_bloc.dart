import 'package:app/ui/features/create_room/room_invite_screen.dart';
import 'package:domain/private_room/entities/search_user.dart';
import "package:equatable/equatable.dart";
import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

part "create_room_event.dart";
part "create_room_state.dart";

class CreateRoomBloc extends Bloc<CreateRoomEvent, CreateRoomState> {
  CreateRoomBloc() : super(CreateRoomInitial()) {
    on<EnterRoomData>(_onEnterRoomData);
    on<AddRoomImage>(_onAddRoomImage);
    on<AddUser>(_onAddUser);
  }

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
          image: image));
    }
  }

  void _onAddUser(AddUser event, Emitter<CreateRoomState> emit) async {
    final currentState = state;
    if (currentState is RoomDataEntering) {
      final users = currentState.users ?? []
        ..add(event.user);
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
}
