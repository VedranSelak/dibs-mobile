import 'package:common/resources/data_state.dart';
import 'package:common/usecases/usecase.dart';
import 'package:domain/profile/common/profile_api_repository.dart';
import 'package:domain/profile/entities/checked.dart';

typedef Response = DataState<Checked>;
typedef Params = void;

class GetHasListingUseCase implements UseCase<Response, Params?> {
  GetHasListingUseCase(this.profileApiRepository);
  final ProfileApiRepository profileApiRepository;

  @override
  Future<Response> call({required Params? params}) {
    return profileApiRepository.getHasListing();
  }
}
