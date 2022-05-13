import 'package:common/resources/data_state.dart';
import 'package:domain/public_listing/entities/public_listing.dart';

abstract class PublicListingApiRepository {
  Future<DataState<List<PublicListing>>> getAll();
}
