import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:common/resources/data_state.dart';
import 'package:common/utils/constants.dart';
import 'package:data/profile/datasource/profile_api_service.dart';
import 'package:domain/profile/common/profile_api_repository.dart';
import 'package:domain/profile/entities/profile_details.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';

class ProfileApiImpl implements ProfileApiRepository {
  const ProfileApiImpl(this.profileApiService, this.cloudinaryPublic);
  final ProfileApiService profileApiService;
  final CloudinaryPublic cloudinaryPublic;

  @override
  Future<DataState<ProfileDetails>> getAccountDetails() async {
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

      final httpResponse = await profileApiService.getAccountDetails(
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
