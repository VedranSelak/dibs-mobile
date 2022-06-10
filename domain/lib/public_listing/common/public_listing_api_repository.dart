import 'package:common/params/create_listing_request.dart';
import 'package:common/resources/data_state.dart';
import 'package:domain/public_listing/entities/created.dart';
import 'package:domain/public_listing/entities/public_listing.dart';

abstract class PublicListingApiRepository {
  Future<DataState<List<PublicListing>>> getAll();
  Future<DataState<List<String>>> postListingImages(List<String> images);
  Future<DataState<Created>> postListing(CreateListingRequestParams params);
  Future<DataState<PublicListing>> getListingById(int id);
  Future<DataState<List<PublicListing>>> searchListings(String search);
}
