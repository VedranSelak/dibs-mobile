import 'package:common/resources/data_state.dart';
import 'package:common/usecases/usecase.dart';
import 'package:domain/private_room/common/private_room_api_repository.dart';
import 'package:domain/private_room/entities/search_user.dart';

typedef Response = DataState<List<SearchUser>>;
typedef Params = String;

class SearchUsersUseCase implements UseCase<Response, Params> {
  SearchUsersUseCase(this.privateRoomApiRepository);
  final PrivateRoomApiRepository privateRoomApiRepository;

  @override
  Future<Response> call({required Params params}) {
    return privateRoomApiRepository.searchUsers(params);
  }
}
