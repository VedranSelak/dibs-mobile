part of "filters_bloc.dart";

@immutable
abstract class FiltersState extends Equatable {
  const FiltersState();

  @override
  List<Object?> get props => [];
}

class FiltersApplied extends FiltersState {
  const FiltersApplied({required this.filters, required this.sort});
  final List<String> filters;
  final String sort;

  @override
  List<Object?> get props => [filters, sort];
}
