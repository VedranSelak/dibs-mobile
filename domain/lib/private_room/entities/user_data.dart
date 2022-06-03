import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  const UserData({
    required this.firstName,
    required this.lastName,
  });

  final String firstName;
  final String lastName;

  @override
  List<Object?> get props => [firstName, lastName];
}
