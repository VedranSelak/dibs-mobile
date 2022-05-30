import 'package:app/res/listing_type.dart';
import "package:equatable/equatable.dart";
import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:image_picker/image_picker.dart';

part "create_room_event.dart";
part "create_room_state.dart";

class CreateRoomBloc extends Bloc<CreateRoomEvent, CreateRoomState> {
  CreateRoomBloc() : super(CreateRoomInitial()) {
    on<EnterRoomData>(_onEnterRoomData);
  }

  void _onEnterRoomData(EnterRoomData event, Emitter<CreateRoomState> emit) {}
}
