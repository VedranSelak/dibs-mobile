import 'package:equatable/equatable.dart';

class Created extends Equatable {
  const Created({required this.id});
  final int id;

  @override
  List<Object> get props => [id];
}
