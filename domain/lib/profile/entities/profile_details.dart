import 'package:equatable/equatable.dart';

class ProfileDetails extends Equatable {
  const ProfileDetails({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.imageUrl,
    required this.type,
    required this.roomsCount,
    required this.reservationsCount,
  });
  final int id;
  final String firstName;
  final String lastName;
  final String? imageUrl;
  final String type;
  final int roomsCount;
  final int reservationsCount;

  @override
  List<Object?> get props => [id, firstName, lastName, imageUrl, roomsCount, reservationsCount];
}
