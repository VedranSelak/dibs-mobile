import 'dart:convert';

import 'package:common/resources/data_state.dart';
import 'package:domain/public_listing/entities/public_listing.dart';
import 'package:domain/public_listing/usecases/get_all_listings_usecase.dart';
import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:get_it/get_it.dart';
import "package:meta/meta.dart";

part "listing_event.dart";
part "listing_state.dart";

class ListingBloc extends Bloc<ListingEvent, ListingState> {
  ListingBloc() : super(ListingsInitial()) {
    on<FetchListings>(_onFetchListings);
  }

  final GetAllListingsUseCase _getAllListingsUseCase = GetIt.I.get<GetAllListingsUseCase>();

  void _onFetchListings(FetchListings event, Emitter<ListingState> emit) async {
    final response = await _getAllListingsUseCase(params: null);
    if (response is DataFailed) {
      final Map errorObject = json.decode(response.error?.response.toString() ?? "") as Map;
      emit(ListingsFetchFailed(
          statusCode: response.error?.response?.statusCode, message: errorObject['msg'] as String?));
    } else {
      emit(ListingsFetchSuccess(listings: response.data ?? []));
    }
  }
}
