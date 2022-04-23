import 'package:common/params/login_request.dart';
import 'package:domain/auth/usecases/login_usecase.dart';
import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
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
    if (response.error != null) {
      print(response.error.toString());
    } else {
      print(response.data?.accessToken);
    }
  }
}
