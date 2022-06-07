import 'dart:convert';

import 'package:common/resources/data_state.dart';
import 'package:domain/profile/entities/profile_details.dart';
import 'package:domain/profile/usecases/get_profile_details_usecase.dart';
import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:get_it/get_it.dart';
import "package:meta/meta.dart";

part "profile_event.dart";
part "profile_state.dart";

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<FetchProfileDetails>(_onFetchProfileDetails);
  }

  final GetProfileDetailsUseCase _getProfileDetailsUseCase = GetIt.I.get<GetProfileDetailsUseCase>();

  void _onFetchProfileDetails(FetchProfileDetails event, Emitter<ProfileState> emit) async {
    final response = await _getProfileDetailsUseCase(params: null);
    if (response is DataFailed) {
      final Map errorObject = json.decode(response.error?.response.toString() ?? "") as Map;
      emit(
          FetchProfileFailed(statusCode: response.error?.response?.statusCode, message: errorObject['msg'] as String?));
    } else {
      emit(ProfileDetailsFetched(profile: response.data!));
    }
  }
}
