import 'package:common/resources/data_state.dart';
import 'package:common/usecases/usecase.dart';
import 'package:domain/profile/common/profile_api_repository.dart';
import 'package:domain/profile/entities/profile_details.dart';

typedef Response = DataState<ProfileDetails>;
typedef Params = void;

class GetProfileDetailsUseCase implements UseCase<Response, Params?> {
  GetProfileDetailsUseCase(this.profileApiRepository);
  final ProfileApiRepository profileApiRepository;

  @override
  Future<Response> call({required Params? params}) {
    return profileApiRepository.getAccountDetails();
  }
}
