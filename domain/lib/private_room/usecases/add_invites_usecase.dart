import 'package:common/params/add_invite_request.dart';
import 'package:common/resources/data_state.dart';
import 'package:common/usecases/usecase.dart';
import 'package:domain/private_room/common/private_room_api_repository.dart';
import 'package:domain/public_listing/entities/created.dart';

typedef Response = DataState<Created>;
typedef Params = AddInviteRequestParams;

class AddInvitesUseCase implements UseCase<Response, Params> {
  AddInvitesUseCase(this.privateRoomApiRepository);
  final PrivateRoomApiRepository privateRoomApiRepository;

  @override
  Future<Response> call({required Params params}) {
    return privateRoomApiRepository.addInvites(params);
  }
}
