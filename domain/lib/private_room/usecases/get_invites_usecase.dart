import 'package:common/resources/data_state.dart';
import 'package:common/usecases/usecase.dart';
import 'package:domain/private_room/common/private_room_api_repository.dart';
import 'package:domain/private_room/entities/invite.dart';

typedef Response = DataState<List<Invite>>;
typedef Params = void;

class GetInvitesUseCase implements UseCase<Response, Params?> {
  GetInvitesUseCase(this.privateRoomApiRepository);
  final PrivateRoomApiRepository privateRoomApiRepository;

  @override
  Future<Response> call({required Params? params}) {
    return privateRoomApiRepository.getInvites();
  }
}
