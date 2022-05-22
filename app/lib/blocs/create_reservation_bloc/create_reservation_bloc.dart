import 'package:domain/public_listing/usecases/post_listing_usecase.dart';
import "package:equatable/equatable.dart";
import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import "package:meta/meta.dart";

part "create_reservation_event.dart";
part "create_reservation_state.dart";

class CreateReservationBloc extends Bloc<CreateReservationEvent, CreateReservationState> {
  CreateReservationBloc() : super(CreateReservationInitial()) {
    on<CreateReservation>(_onCreateReservation);
  }

  final PostListingUseCase _postListingUseCase = GetIt.I.get<PostListingUseCase>();

  void _onCreateReservation(CreateReservation event, Emitter<CreateReservationState> emit) async {
    if (event.numOfPeople <= 0) {
      emit(const ReservationFailed(message: 'Number of people is invalid'));
      return;
    } else if (event.arrivalTime <= 0) {
      emit(const ReservationFailed(message: 'Please provide data for all fields'));
      return;
    }

    emit(CreateReservationInitial());
    print("Good reservation");
  }
}
