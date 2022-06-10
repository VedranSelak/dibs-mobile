import 'package:equatable/equatable.dart';

class SearchUser extends Equatable {
  const SearchUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.imageUrl,
  });

  final int id;
  final String firstName;
  final String lastName;
  final String? imageUrl;

  @override
  List<Object?> get props => [id, firstName, lastName, imageUrl];
}
