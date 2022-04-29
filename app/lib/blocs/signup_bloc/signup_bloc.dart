import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:meta/meta.dart";

part "signup_event.dart";
part "signup_state.dart";

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<StartSignUp>(_onStartSignUp);
  }

  void _onStartSignUp(StartSignUp event, Emitter<SignUpState> emit) async {}
}
