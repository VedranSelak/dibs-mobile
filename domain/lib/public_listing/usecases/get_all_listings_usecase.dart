import 'package:common/params/fetch_listings_request.dart';
import 'package:common/resources/data_state.dart';
import 'package:common/usecases/usecase.dart';
import 'package:domain/public_listing/common/public_listing_api_repository.dart';
import 'package:domain/public_listing/entities/public_listing.dart';

typedef Response = DataState<List<PublicListing>>;
typedef Params = FetchListingsRequestParams;

class GetAllListingsUseCase implements UseCase<Response, Params> {
  GetAllListingsUseCase(this.publicListingApiRepository);
  final PublicListingApiRepository publicListingApiRepository;

  @override
  Future<Response> call({required Params params}) {
    return publicListingApiRepository.getAll(params);
  }
}
