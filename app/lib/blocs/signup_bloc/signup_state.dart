part of "signup_bloc.dart";

@immutable
abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object?> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpStarted extends SignUpState {
  const SignUpStarted({required this.type});
  final AccountType type;

  @override
  List<Object?> get props => [type];
}

class SignUpFailed extends SignUpState {
  const SignUpFailed({required this.type, this.statusCode = 500, this.message = "Something went wrong"});
  final AccountType type;
  final int? statusCode;
  final String? message;

  @override
  List<Object?> get props => [type, statusCode, message];
}

class SignUpSuccessful extends SignUpState {}
