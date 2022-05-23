part of "user_type_bloc.dart";

abstract class UserTypeEvent extends Equatable {
  const UserTypeEvent();

  @override
  List<Object> get props => [];
}

class GetUserType extends UserTypeEvent {}

class SetGuest extends UserTypeEvent {}

class LogoutUser extends UserTypeEvent {}
