import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({required this.id, required this.type, required this.accessToken, required this.isTokenExpired});

  final int id;
  final String type;
  final String accessToken;
  final bool isTokenExpired;

  @override
  List<Object> get props => [id, type, accessToken, isTokenExpired];
}
