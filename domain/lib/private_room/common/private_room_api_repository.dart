import 'package:common/resources/data_state.dart';
import 'package:domain/private_room/entities/search_user.dart';

abstract class PrivateRoomApiRepository {
  Future<DataState<List<SearchUser>>> searchUsers(String search);
}
