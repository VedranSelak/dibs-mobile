import 'package:equatable/equatable.dart';

class Spot extends Equatable {
  const Spot({
    required this.ownerId,
    required this.availableSpots,
    this.row,
  });

  final int ownerId;
  final String availableSpots;
  final int? row;

  @override
  List<Object?> get props => [ownerId, availableSpots, row];
}
