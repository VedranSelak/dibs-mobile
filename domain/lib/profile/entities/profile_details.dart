import 'package:equatable/equatable.dart';

class ProfileDetails extends Equatable {
  const ProfileDetails({required this.id, required this.firstName, required this.lastName, required this.imageUrl});
  final int id;
  final String firstName;
  final String lastName;
  final String? imageUrl;

  @override
  List<Object?> get props => [id, firstName, lastName, imageUrl];
}
