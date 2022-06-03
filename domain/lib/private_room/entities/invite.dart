import 'package:equatable/equatable.dart';

class Invite extends Equatable {
  const Invite({
    required this.id,
    required this.roomId,
    required this.name,
    required this.firstName,
    required this.lastName,
  });

  final int id;
  final int roomId;
  final String name;
  final String firstName;
  final String lastName;

  @override
  List<Object?> get props => [id, roomId, name, firstName, lastName];
}
