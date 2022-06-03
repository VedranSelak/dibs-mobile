import 'package:data/private_room/dtos/user_data_model.dart';
import 'package:equatable/equatable.dart';

class Participant extends Equatable {
  const Participant({
    required this.userId,
    required this.user,
  });

  final int userId;
  final UserDataModel user;

  @override
  List<Object?> get props => [userId, user];
}
