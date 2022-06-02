import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:common/params/create_listing_request.dart';
import 'package:common/resources/data_state.dart';
import 'package:common/utils/constants.dart';
import 'package:data/public_listing/datasource/public_listing_api_service.dart';
import 'package:dio/dio.dart';
import 'package:domain/public_listing/common/public_listing_api_repository.dart';
import 'package:domain/public_listing/entities/created.dart';
import 'package:domain/public_listing/entities/public_listing.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PublicListingApiImpl implements PublicListingApiRepository {
  const PublicListingApiImpl(this.publicListingApiService, this.cloudinaryPublic);
  final PublicListingApiService publicListingApiService;
  final CloudinaryPublic cloudinaryPublic;

  @override
  Future<DataState<List<PublicListing>>> getAll() async {
    try {
      final httpResponse = await publicListingApiService.getAll();

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
  Future<DataState<List<String>>> postListingImages(List<String> images) async {
    try {
      final List<CloudinaryResponse> uploadedImages = [];
      for (final String image in images) {
        final CloudinaryResponse response = await cloudinaryPublic.uploadFile(
          CloudinaryFile.fromFile(image, resourceType: CloudinaryResourceType.Image),
        );
        uploadedImages.add(response);
      }

      final List<String> uploadedUrls = uploadedImages.map((i) => i.secureUrl).toList();
      return DataSuccess(uploadedUrls);
    } on CloudinaryException catch (_) {
      return const DataSuccess([]);
    }
  }

  @override
  Future<DataState<Created>> postListing(CreateListingRequestParams params) async {
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

      final httpResponse = await publicListingApiService.postListing(
        params,
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
    }
  }

  @override
  Future<DataState<PublicListing>> getListingById(int id) async {
    try {
      final httpResponse = await publicListingApiService.getListingById(id);

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
