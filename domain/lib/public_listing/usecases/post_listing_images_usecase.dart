import 'package:common/resources/data_state.dart';
import 'package:common/usecases/usecase.dart';
import 'package:domain/public_listing/common/public_listing_api_repository.dart';

typedef Response = DataState<List<String>>;
typedef Params = List<String>;

class PostListingImagesUseCase implements UseCase<Response, Params> {
  PostListingImagesUseCase(this.publicListingApiRepository);
  final PublicListingApiRepository publicListingApiRepository;

  @override
  Future<Response> call({required Params params}) {
    return publicListingApiRepository.postListingImages(params);
  }
}
