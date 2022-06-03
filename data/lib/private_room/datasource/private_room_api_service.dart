import 'package:common/params/create_room_request.dart';
import 'package:common/params/invite_request.dart';
import 'package:data/private_room/dtos/invite_model.dart';
import 'package:data/private_room/dtos/private_room_model.dart';
import 'package:data/private_room/dtos/rooms_response_model.dart';
import 'package:data/private_room/dtos/search_user_model.dart';
import 'package:data/public_listing/dtos/created_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import "package:common/utils/constants.dart";

part 'private_room_api_service.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class PrivateRoomApiService {
  factory PrivateRoomApiService(Dio dio, {String baseUrl}) = _PrivateRoomApiService;

  @GET('/users/{search}')
  Future<HttpResponse<List<SearchUserModel>>> searchUsers(
    @Path('search') String search,
    @Header('Authorization') String header,
  );

  @POST('/rooms')
  Future<HttpResponse<CreatedModel>> createRoom(
    @Body() CreateRoomRequestParams body,
    @Header('Authorization') String header,
  );

  @GET('/rooms/your')
  Future<HttpResponse<List<PrivateRoomModel>>> getYourRooms(
    @Header('Authorization') String header,
  );

  @GET('/rooms')
  Future<HttpResponse<List<RoomsResponseModel>>> getRooms(
    @Header('Authorization') String header,
  );

  @GET('/invites')
  Future<HttpResponse<List<InviteModel>>> getInvites(
    @Header('Authorization') String header,
  );

  @PATCH('/invites/{id}')
  Future<HttpResponse<CreatedModel>> respondToInvite(
    @Path('id') int id,
    @Body() UserResponseParams body,
    @Header('Authorization') String header,
  );

  @PATCH('/rooms/leave/{id}')
  Future<HttpResponse<CreatedModel>> leaveRoom(
    @Path('id') int id,
    @Header('Authorization') String header,
  );
}
