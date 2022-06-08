import 'package:common/resources/data_state.dart';
import 'package:domain/profile/entities/profile_details.dart';
import 'package:domain/public_listing/entities/created.dart';
import 'package:common/params/change_profile_image_request.dart';

abstract class ProfileApiRepository {
  Future<DataState<ProfileDetails>> getAccountDetails();
  Future<DataState<Created>> changeProfileImage(ChangeProfileImageRequestParams params);
}
