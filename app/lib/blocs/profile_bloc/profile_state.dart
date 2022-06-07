part of "profile_bloc.dart";

@immutable
abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileDetailsFetched extends ProfileState {
  const ProfileDetailsFetched({required this.profile});
  final ProfileDetails profile;

  @override
  List<Object?> get props => [profile];
}

class FetchProfileFailed extends ProfileState {
  const FetchProfileFailed({this.statusCode = 500, this.message = "Something went wrong"});
  final int? statusCode;
  final String? message;

  @override
  List<Object?> get props => [statusCode, message];
}
