import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:common/resources/data_state.dart';
import 'package:common/utils/constants.dart';
import 'package:data/private_room/datasource/private_room_api_service.dart';
import 'package:dio/dio.dart';
import 'package:domain/private_room/common/private_room_api_repository.dart';
import 'package:domain/private_room/entities/search_user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PrivateRoomApiImpl implements PrivateRoomApiRepository {
  const PrivateRoomApiImpl(this.privateRoomApiService, this.cloudinaryPublic);
  final PrivateRoomApiService privateRoomApiService;
  final CloudinaryPublic cloudinaryPublic;

  @override
  Future<DataState<List<SearchUser>>> searchUsers(String search) async {
    try {
      const storage = FlutterSecureStorage();
      final String? token = await storage.read(key: kAccessTokenKey);
      if (token == null) {
        return DataFailed(DioError(
          response: Response<dynamic>(
            requestOptions: RequestOptions(path: ""),
            statusCode: 401,
          ),
          type: DioErrorType.response,
          requestOptions: RequestOptions(path: ""),
        ));
      }

      final httpResponse = await privateRoomApiService.searchUsers(
        search,
        'Bearer $token',
      );

      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(httpResponse.data);
      }
      return DataFailed(DioError(
        error: httpResponse.response.statusMessage,
        response: httpResponse.response,
        type: DioErrorType.response,
        requestOptions: httpResponse.response.requestOptions,
      ));
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }
}
