import 'package:common/params/create_room_request.dart';
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
}
