part of "signup_bloc.dart";

@immutable
abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object?> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpFailed extends SignUpState {
  const SignUpFailed({this.statusCode = 500, this.message = "Something went wrong"});
  final int? statusCode;
  final String? message;

  @override
  List<Object?> get props => [statusCode, message];
}

class SignUpSuccessful extends SignUpState {}
