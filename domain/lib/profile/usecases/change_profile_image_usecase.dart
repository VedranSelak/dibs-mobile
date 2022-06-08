import 'package:common/params/change_profile_image_request.dart';
import 'package:common/resources/data_state.dart';
import 'package:common/usecases/usecase.dart';
import 'package:domain/profile/common/profile_api_repository.dart';
import 'package:domain/public_listing/entities/created.dart';

typedef Response = DataState<Created>;
typedef Params = ChangeProfileImageRequestParams;

class ChangeProfileImageUseCase implements UseCase<Response, Params> {
  ChangeProfileImageUseCase(this.profileApiRepository);
  final ProfileApiRepository profileApiRepository;

  @override
  Future<Response> call({required Params params}) {
    return profileApiRepository.changeProfileImage(params);
  }
}
