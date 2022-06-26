import 'package:common/resources/data_state.dart';
import 'package:domain/profile/usecases/get_has_listing_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ListingCreatedCubit extends Cubit<bool> {
  ListingCreatedCubit() : super(true);

  final GetHasListingUseCase _getHasListingUseCase = GetIt.I.get<GetHasListingUseCase>();

  void checkHasListing() async {
    final response = await _getHasListingUseCase(params: null);
    if (response is DataFailed) {
      emit(false);
    } else {
      emit(response.data?.hasListing ?? false);
    }
  }
}
