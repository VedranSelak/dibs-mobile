import 'package:common/resources/data_state.dart';
import 'package:common/usecases/usecase.dart';
import 'package:domain/private_room/common/private_room_api_repository.dart';
import 'package:domain/private_room/entities/private_room_details.dart';

typedef Response = DataState<PrivateRoomDetails>;
typedef Params = int;

class GetRoomDetailsUseCase implements UseCase<Response, Params> {
  GetRoomDetailsUseCase(this.privateRoomApiRepository);
  final PrivateRoomApiRepository privateRoomApiRepository;

  @override
  Future<Response> call({required Params params}) {
    return privateRoomApiRepository.getRoomDetails(params);
  }
}
