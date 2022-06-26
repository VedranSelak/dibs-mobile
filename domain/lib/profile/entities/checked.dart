import 'package:equatable/equatable.dart';

class Checked extends Equatable {
  const Checked({
    required this.hasListing,
  });
  final bool hasListing;

  @override
  List<Object?> get props => [hasListing];
}
