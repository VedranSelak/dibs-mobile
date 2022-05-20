import 'package:equatable/equatable.dart';

class SpotEntity extends Equatable {
  const SpotEntity({
    required this.id,
    required this.listingId,
    required this.availableSpots,
    this.rowName,
  });

  final int id;
  final int listingId;
  final int availableSpots;
  final String? rowName;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'listingId': listingId,
        'availableSpots': availableSpots,
        'rowName': rowName,
      };

  @override
  List<Object?> get props => [id, listingId, availableSpots, rowName];
}
