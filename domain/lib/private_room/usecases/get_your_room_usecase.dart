import 'package:common/resources/data_state.dart';
import 'package:common/usecases/usecase.dart';
import 'package:domain/private_room/common/private_room_api_repository.dart';
import 'package:domain/private_room/entities/your_room_details.dart';

typedef Response = DataState<YourRoomDetails>;
typedef Params = int;

class GetYourRoomUseCase implements UseCase<Response, Params> {
  GetYourRoomUseCase(this.privateRoomApiRepository);
  final PrivateRoomApiRepository privateRoomApiRepository;

  @override
  Future<Response> call({required Params params}) {
    return privateRoomApiRepository.getYourRoom(params);
  }
}
