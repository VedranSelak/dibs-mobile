import 'package:common/params/create_listing_request.dart';
import 'package:common/resources/data_state.dart';
import 'package:common/usecases/usecase.dart';
import 'package:domain/public_listing/common/public_listing_api_repository.dart';
import 'package:domain/public_listing/entities/created.dart';

typedef Response = DataState<Created>;
typedef Params = CreateListingRequestParams;

class PostListingUseCase implements UseCase<Response, Params> {
  PostListingUseCase(this.publicListingApiRepository);
  final PublicListingApiRepository publicListingApiRepository;

  @override
  Future<Response> call({required Params params}) {
    return publicListingApiRepository.postListing(params);
  }
}
