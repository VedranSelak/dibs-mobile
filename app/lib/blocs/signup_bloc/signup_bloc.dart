import 'package:app/res/account_type.dart';
import 'package:common/params/signup_request.dart';
import 'package:domain/auth/usecases/signup_usecase.dart';
import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:get_it/get_it.dart';
import "package:meta/meta.dart";

part "signup_event.dart";
part "signup_state.dart";

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<StartSignUp>(_onStartSignUp);
    on<ChooseAccountType>(_onChooseAccountType);
    on<ResetBloc>(_onResetBloc);
  }

  final SignUpUseCase _signUpUseCase = GetIt.I.get<SignUpUseCase>();

  void _onStartSignUp(StartSignUp event, Emitter<SignUpState> emit) async {
    if (state is SignUpStarted || state is SignUpFailed) {
      final response = await _signUpUseCase(
          params: SignUpRequestParams(
              email: event.email,
              firstName: event.firstName,
              lastName: event.lastName,
              password: event.password,
              type: state is SignUpStarted
                  ? (state as SignUpStarted).type.rawValue
                  : (state as SignUpFailed).type.rawValue,
              status: 'inactive'));
      print(response);
    }
  }

  void _onChooseAccountType(ChooseAccountType event, Emitter<SignUpState> emit) async {
    emit(SignUpStarted(type: event.type));
  }

  void _onResetBloc(ResetBloc event, Emitter<SignUpState> emit) async {
    emit(SignUpInitial());
  }
}
