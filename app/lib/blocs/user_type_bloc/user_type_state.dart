part of "user_type_bloc.dart";

@immutable
abstract class UserTypeState extends Equatable {
  const UserTypeState();

  @override
  List<Object?> get props => [];
}

class GuestType extends UserTypeState {}

class OwnerType extends UserTypeState {
  const OwnerType({required this.user});
  final User user;

  @override
  List<Object?> get props => [user];
}

class UserType extends UserTypeState {
  const UserType({required this.user});
  final User user;

  @override
  List<Object?> get props => [user];
}
