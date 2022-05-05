import 'package:app/res/account_type.dart';
import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:meta/meta.dart";

part "signup_event.dart";
part "signup_state.dart";

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<StartSignUp>(_onStartSignUp);
    on<ChooseAccountType>(_onChooseAccountType);
    on<ResetBloc>(_onResetBloc);
  }

  void _onStartSignUp(StartSignUp event, Emitter<SignUpState> emit) async {}

  void _onChooseAccountType(ChooseAccountType event, Emitter<SignUpState> emit) async {
    emit(SignUpStarted(type: event.type));
  }

  void _onResetBloc(ResetBloc event, Emitter<SignUpState> emit) async {
    emit(SignUpInitial());
  }
}
