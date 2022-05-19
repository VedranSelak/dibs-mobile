import 'package:common/resources/data_state.dart';
import 'package:common/usecases/usecase.dart';
import 'package:domain/public_listing/common/public_listing_api_repository.dart';
import 'package:domain/public_listing/entities/public_listing.dart';

typedef Response = DataState<PublicListing>;
typedef Params = int;

class GetListingDetailsUseCase implements UseCase<Response, Params> {
  GetListingDetailsUseCase(this.publicListingApiRepository);
  final PublicListingApiRepository publicListingApiRepository;

  @override
  Future<Response> call({required Params params}) {
    return publicListingApiRepository.getListingById(params);
  }
}
