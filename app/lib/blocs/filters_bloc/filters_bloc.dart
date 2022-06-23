import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:meta/meta.dart";

part "filters_event.dart";
part "filters_state.dart";

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  FiltersBloc() : super(const FiltersApplied(filters: [], sort: 'DESC')) {
    on<ChangeFilters>(_onChangeFilters);
    on<ResetFilters>(_onResetFilters);
  }

  void _onChangeFilters(ChangeFilters event, Emitter<FiltersState> emit) async {
    emit(FiltersApplied(filters: event.filters, sort: event.sort));
  }

  void _onResetFilters(ResetFilters event, Emitter<FiltersState> emit) async {
    emit(const FiltersApplied(filters: [], sort: 'DESC'));
  }
}
