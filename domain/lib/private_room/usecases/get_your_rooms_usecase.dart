import 'package:common/resources/data_state.dart';
import 'package:common/usecases/usecase.dart';
import 'package:domain/private_room/common/private_room_api_repository.dart';
import 'package:domain/private_room/entities/private_room.dart';

typedef Response = DataState<List<PrivateRoom>>;
typedef Params = void;

class GetYourRoomsUseCase implements UseCase<Response, Params?> {
  GetYourRoomsUseCase(this.privateRoomApiRepository);
  final PrivateRoomApiRepository privateRoomApiRepository;

  @override
  Future<Response> call({required Params? params}) {
    return privateRoomApiRepository.getYourRooms();
  }
}
