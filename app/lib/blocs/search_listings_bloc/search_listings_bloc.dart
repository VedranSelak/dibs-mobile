import 'dart:convert';

import 'package:common/resources/data_state.dart';
import 'package:domain/public_listing/entities/public_listing.dart';
import 'package:domain/public_listing/usecases/search_listings_usecase.dart';
import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:get_it/get_it.dart';
import "package:meta/meta.dart";

part "search_listings_event.dart";
part "search_listings_state.dart";

class SearchListingsBloc extends Bloc<SearchListingsEvent, SearchListingsState> {
  SearchListingsBloc() : super(SearchListingsInitial()) {
    on<StartSearchListings>(_onStartSearchListings);
    on<SearchListings>(_onSearchListings);
  }

  final SearchListingsUseCase _searchListingsUseCase = GetIt.I.get<SearchListingsUseCase>();

  void _onSearchListings(SearchListings event, Emitter<SearchListingsState> emit) async {
    final response = await _searchListingsUseCase(params: event.search);
    if (response is DataFailed) {
      final Map errorObject = json.decode(response.error?.response.toString() ?? "") as Map;
      emit(SearchListingsFetchFailed(
        statusCode: response.error?.response?.statusCode,
        message: errorObject['msg'] as String?,
      ));
    } else {
      emit(SearchListingsFetchSuccess(listings: response.data ?? []));
    }
  }

  void _onStartSearchListings(StartSearchListings event, Emitter<SearchListingsState> emit) async {
    emit(SearchListingsFetchSuccess(listings: event.listings));
  }
}
