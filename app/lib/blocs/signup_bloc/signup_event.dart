part of "signup_bloc.dart";

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class ChooseAccountType extends SignUpEvent {
  const ChooseAccountType({required this.type});
  final AccountType type;

  @override
  List<Object> get props => [type];
}

class ResetBloc extends SignUpEvent {}

class StartSignUp extends SignUpEvent {
  const StartSignUp({required this.email, required this.firstName, required this.lastName, required this.password});
  final String email;
  final String firstName;
  final String lastName;
  final String password;

  @override
  List<Object> get props => [email, password];
}
