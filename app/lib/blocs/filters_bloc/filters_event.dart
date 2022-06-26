part of "filters_bloc.dart";

abstract class FiltersEvent extends Equatable {
  const FiltersEvent();

  @override
  List<Object> get props => [];
}

class ChangeFilters extends FiltersEvent {
  const ChangeFilters({required this.filters, required this.sort});
  final List<String> filters;
  final String sort;

  @override
  List<Object> get props => [filters, sort];
}

class ResetFilters extends FiltersEvent {}
