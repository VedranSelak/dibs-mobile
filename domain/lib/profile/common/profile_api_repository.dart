import 'package:common/resources/data_state.dart';
import 'package:domain/profile/entities/profile_details.dart';

abstract class ProfileApiRepository {
  Future<DataState<ProfileDetails>> getAccountDetails();
}
