import 'dart:convert';

import 'package:common/params/change_profile_image_request.dart';
import 'package:common/resources/data_state.dart';
import 'package:domain/profile/entities/profile_details.dart';
import 'package:domain/profile/usecases/change_profile_image_usecase.dart';
import 'package:domain/profile/usecases/get_profile_details_usecase.dart';
import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import "package:meta/meta.dart";

part "profile_event.dart";
part "profile_state.dart";

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<FetchProfileDetails>(_onFetchProfileDetails);
    on<ChangeProfileImage>(_onChangeProfileImage);
  }

  final GetProfileDetailsUseCase _getProfileDetailsUseCase = GetIt.I.get<GetProfileDetailsUseCase>();
  final ChangeProfileImageUseCase _changeProfileImageUseCase = GetIt.I.get<ChangeProfileImageUseCase>();

  void _onFetchProfileDetails(FetchProfileDetails event, Emitter<ProfileState> emit) async {
    final response = await _getProfileDetailsUseCase(params: null);
    if (response is DataFailed) {
      final Map errorObject = json.decode(response.error?.response.toString() ?? "") as Map;
      emit(
          FetchProfileFailed(statusCode: response.error?.response?.statusCode, message: errorObject['msg'] as String?));
    } else {
      print(response.data);
      emit(ProfileDetailsFetched(profile: response.data!));
    }
  }

  void _onChangeProfileImage(ChangeProfileImage event, Emitter<ProfileState> emit) async {
    final currentState = state;
    final _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.gallery);

    if (currentState is ProfileDetailsFetched) {
      emit(ProfileDetailsFetched(profile: currentState.profile, image: image));
    }

    final response = await _changeProfileImageUseCase(
      params: ChangeProfileImageRequestParams(
        body: ChangeProfileImageBody(imageUrl: image?.path ?? ''),
      ),
    );

    if (response is DataFailed) {
      final Map errorObject = json.decode(response.error?.response.toString() ?? "") as Map;
      emit(
          FetchProfileFailed(statusCode: response.error?.response?.statusCode, message: errorObject['msg'] as String?));
    }
  }
}
