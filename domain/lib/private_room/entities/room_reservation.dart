import 'package:data/private_room/dtos/user_data_model.dart';
import 'package:equatable/equatable.dart';

class RoomReservation extends Equatable {
  const RoomReservation({
    required this.id,
    required this.arrivalTimestamp,
    required this.stayApprox,
    required this.user,
  });

  final int id;
  final int arrivalTimestamp;
  final int stayApprox;
  final UserDataModel user;

  @override
  List<Object?> get props => [id, arrivalTimestamp, stayApprox, user];
}
