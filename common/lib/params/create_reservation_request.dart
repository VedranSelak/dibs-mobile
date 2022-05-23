class CreateReservationRequestParams {
  const CreateReservationRequestParams({
    required this.listingId,
    required this.numberOfParticipants,
    required this.isPrivate,
    required this.arrivalTime,
    required this.stayApprox,
  });

  final int listingId;
  final int numberOfParticipants;
  final bool isPrivate;
  final int arrivalTime;
  final int stayApprox;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'listingId': listingId,
        'numberOfParticipants': numberOfParticipants,
        'isPrivate': isPrivate,
        'arrivalTime': arrivalTime,
        'stayApprox': stayApprox,
      };
}
