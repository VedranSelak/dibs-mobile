import 'dart:convert';

import 'package:app/ui/features/home/home_screen.dart';
import 'package:common/params/login_request.dart';
import 'package:common/resources/data_state.dart';
import 'package:domain/auth/usecases/login_usecase.dart';
import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import "package:meta/meta.dart";

part "login_event.dart";
part "login_state.dart";

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<StartLogin>(_onStartLogin);
  }

  final LoginUseCase _loginUseCase = GetIt.I.get<LoginUseCase>();

  void _onStartLogin(StartLogin event, Emitter<LoginState> emit) async {
    final response = await _loginUseCase(
      params: LoginRequestParams(password: event.password, email: event.email),
    );
    if (response is DataFailed) {
      final Map errorObject = json.decode(response.error?.response.toString() ?? "") as Map;
      emit(LoginFailed(statusCode: response.error?.response?.statusCode, message: errorObject['msg'] as String?));
    } else {
      Get.offAllNamed<dynamic>(HomeScreen.routeName);
      emit(LoginSuccessful());
    }
  }
}
