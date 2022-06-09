import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  const UserData({
    required this.firstName,
    required this.lastName,
    required this.imageUrl,
  });

  final String firstName;
  final String lastName;
  final String? imageUrl;

  @override
  List<Object?> get props => [firstName, lastName, imageUrl];
}
