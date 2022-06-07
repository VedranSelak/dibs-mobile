class CreateRoomReservationRequestParams {
  const CreateRoomReservationRequestParams({
    required this.roomId,
    required this.arrivalTime,
    required this.stayApprox,
  });

  final int roomId;
  final int arrivalTime;
  final int stayApprox;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'roomId': roomId,
        'arrivalTime': arrivalTime,
        'stayApprox': stayApprox,
      };
}
