import 'package:common/resources/data_state.dart';
import 'package:domain/public_listing/entities/public_listing.dart';
import 'package:domain/public_listing/usecases/get_listing_details_usecase.dart';
import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:get_it/get_it.dart';
import "package:meta/meta.dart";

part "listing_details_event.dart";
part "listing_details_state.dart";

class ListingDetailsBloc extends Bloc<ListingDetailsEvent, ListingDetailsState> {
  ListingDetailsBloc() : super(ListingDetailsInitial()) {
    on<FetchListingDetails>(_onFetchListingDetails);
  }

  final GetListingDetailsUseCase _getListingDetailsUseCase = GetIt.I.get<GetListingDetailsUseCase>();

  void _onFetchListingDetails(FetchListingDetails event, Emitter<ListingDetailsState> emit) async {
    final response = await _getListingDetailsUseCase(params: event.id);
    if (response is DataFailed) {
      print(response.error.toString());
    } else {
      emit(DetailsFetchSuccess(listing: response.data!));
    }
  }
}
