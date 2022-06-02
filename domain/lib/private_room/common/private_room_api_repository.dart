import 'package:common/params/create_room_request.dart';
import 'package:common/resources/data_state.dart';
import 'package:domain/private_room/entities/search_user.dart';
import 'package:domain/public_listing/entities/created.dart';

abstract class PrivateRoomApiRepository {
  Future<DataState<List<SearchUser>>> searchUsers(String search);
  Future<DataState<Created>> createRoom(CreateRoomRequestParams params);
}
