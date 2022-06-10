import 'package:common/resources/data_state.dart';
import 'package:common/usecases/usecase.dart';
import 'package:domain/public_listing/common/public_listing_api_repository.dart';
import 'package:domain/public_listing/entities/public_listing.dart';

typedef Response = DataState<List<PublicListing>>;
typedef Params = String;

class SearchListingsUseCase implements UseCase<Response, Params> {
  SearchListingsUseCase(this.publicListingApiRepository);
  final PublicListingApiRepository publicListingApiRepository;

  @override
  Future<Response> call({required Params params}) {
    return publicListingApiRepository.searchListings(params);
  }
}
