import 'package:common/resources/data_state.dart';
import 'package:common/usecases/usecase.dart';
import 'package:domain/private_room/common/private_room_api_repository.dart';
import 'package:domain/private_room/entities/rooms_response.dart';

typedef Response = DataState<List<RoomsResponse>>;
typedef Params = void;

class GetRoomsUseCase implements UseCase<Response, Params?> {
  GetRoomsUseCase(this.privateRoomApiRepository);
  final PrivateRoomApiRepository privateRoomApiRepository;

  @override
  Future<Response> call({required Params? params}) {
    return privateRoomApiRepository.getRooms();
  }
}
