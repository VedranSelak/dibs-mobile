import 'package:equatable/equatable.dart';

class Spot extends Equatable {
  const Spot({
    required this.availableSpots,
    this.row,
  });

  final int availableSpots;
  final int? row;

  @override
  List<Object?> get props => [availableSpots, row];
}
