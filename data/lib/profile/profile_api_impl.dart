import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:common/params/change_profile_image_request.dart';
import 'package:common/resources/data_state.dart';
import 'package:common/utils/constants.dart';
import 'package:data/profile/datasource/profile_api_service.dart';
import 'package:domain/profile/common/profile_api_repository.dart';
import 'package:domain/profile/entities/checked.dart';
import 'package:domain/profile/entities/profile_details.dart';
import 'package:domain/public_listing/entities/created.dart';
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

  @override
  Future<DataState<Created>> changeProfileImage(ChangeProfileImageRequestParams params) async {
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

      final response = await cloudinaryPublic.uploadFile(
        CloudinaryFile.fromFile(params.body.imageUrl),
      );

      final httpResponse = await profileApiService.changeProfileImage(
        ChangeProfileImageBody(imageUrl: response.secureUrl),
        'Bearer $token',
      );

      if (httpResponse.response.statusCode == 201) {
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
    } on CloudinaryException catch (_) {
      return DataFailed(DioError(
        response: Response<String>(
          data: 'Unable to upload image',
          requestOptions: RequestOptions(path: ""),
          statusCode: 400,
        ),
        type: DioErrorType.response,
        requestOptions: RequestOptions(path: ""),
      ));
    }
  }

  @override
  Future<DataState<Checked>> getHasListing() async {
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

      final httpResponse = await profileApiService.getHasListing(
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
