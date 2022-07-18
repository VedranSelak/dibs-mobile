import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:common/base_di_module.dart';
import 'package:data/auth/datasource/auth_api_service.dart';
import 'package:data/auth/di/auth_api_module.dart';
import 'package:data/placeholder_api/datasource/placeholder_api_repository.dart';
import 'package:data/placeholder_api/di/placeholder_api_module.dart';
import 'package:data/private_room/datasource/private_room_api_service.dart';
import 'package:data/private_room/di/private_room_api_module.dart';
import 'package:data/profile/datasource/profile_api_service.dart';
import 'package:data/profile/di/profile_api_module.dart';
import 'package:data/public_listing/datasource/public_listing_api_service.dart';
import 'package:data/public_listing/di/public_listing_api_module.dart';
import 'package:data/reservation/datasource/reservation_api_service.dart';
import 'package:data/reservation/di/reservation_api_module.dart';
import 'package:dio/dio.dart';
import 'package:domain/auth/common/auth_api_repository.dart';
import 'package:domain/auth/usecases/get_user_usecase.dart';
import 'package:domain/auth/usecases/login_usecase.dart';
import 'package:domain/auth/usecases/logout_user_usecase.dart';
import 'package:domain/auth/usecases/signup_usecase.dart';
import 'package:domain/placeholder_api/common/placeholder_api_repository.dart';
import 'package:domain/placeholder_api/usecases/get_posts_usecase.dart';
import 'package:domain/private_room/usecases/add_invites_usecase.dart';
import 'package:domain/private_room/usecases/create_private_room_usecase.dart';
import 'package:domain/private_room/usecases/delete_room_usecase.dart';
import 'package:domain/private_room/usecases/get_invites_usecase.dart';
import 'package:domain/private_room/usecases/get_room_details_usecase.dart';
import 'package:domain/private_room/usecases/get_rooms_usecase.dart';
import 'package:domain/private_room/usecases/get_your_room_usecase.dart';
import 'package:domain/private_room/usecases/get_your_rooms_usecase.dart';
import 'package:domain/private_room/usecases/leave_room_usecase.dart';
import 'package:domain/private_room/usecases/respond_to_invite_usecase.dart';
import 'package:domain/private_room/usecases/search_users_usecase.dart';
import 'package:domain/profile/common/profile_api_repository.dart';
import 'package:domain/profile/usecases/change_profile_image_usecase.dart';
import 'package:domain/profile/usecases/get_has_listing_usecase.dart';
import 'package:domain/profile/usecases/get_profile_details_usecase.dart';
import 'package:domain/public_listing/common/public_listing_api_repository.dart';
import 'package:domain/private_room/common/private_room_api_repository.dart';
import 'package:domain/public_listing/usecases/get_all_listings_usecase.dart';
import 'package:domain/public_listing/usecases/get_listing_details_usecase.dart';
import 'package:domain/public_listing/usecases/post_listing_images_usecase.dart';
import 'package:domain/public_listing/usecases/post_listing_usecase.dart';
import 'package:domain/public_listing/usecases/search_listings_usecase.dart';
import 'package:domain/reservation/common/reservation_repository.dart';
import 'package:domain/reservation/usecases/cancel_reservation_usecase.dart';
import 'package:domain/reservation/usecases/get_recent_listing_reservations_usecase.dart';
import 'package:domain/reservation/usecases/get_recent_reservations_usecase.dart';
import 'package:domain/reservation/usecases/get_upcoming_listing_reservations_usecase.dart';
import 'package:domain/reservation/usecases/get_upcoming_reservations_usecase.dart';
import 'package:domain/reservation/usecases/post_reservation_usecase.dart';
import 'package:domain/reservation/usecases/post_room_reservation_usecase.dart';
import 'package:domain/reservation/usecases/remove_from_history_usecase.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

class DataModule extends BaseDiModule {
  final _placeHolderApiService = PlaceholderApiService(Dio(BaseOptions(contentType: "application/json")));
  final _authApiService = AuthApiService(Dio(BaseOptions(contentType: "application/json")));
  final _publicListingApiService = PublicListingApiService(Dio(BaseOptions(contentType: "application/json")));
  final _reservationApiService = ReservationApiService(Dio(BaseOptions(contentType: "application/json")));
  final _privateRoomApiService = PrivateRoomApiService(Dio(BaseOptions(contentType: "application/json")));
  final _profileApiService = ProfileApiService(Dio(BaseOptions(contentType: "application/json")));

  @override
  void inject() {
    final _cloudinaryPublic = CloudinaryPublic(
      dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? "",
      dotenv.env['CLOUDINARY_PRESET_NAME'] ?? "",
      cache: false,
    );
    PlaceholderApiModule(_placeHolderApiService);
    AuthApiModule(_authApiService);
    PublicListingApiModule(_publicListingApiService, _cloudinaryPublic);
    ReservationApiModule(_reservationApiService);
    PrivateRoomApiModule(_privateRoomApiService, _cloudinaryPublic);
    ProfileApiModule(_profileApiService, _cloudinaryPublic);
    useCases();
  }

  void useCases() {
    final placeholderRepository = GetIt.I.get<PlaceholderApiRepository>();
    final authRepository = GetIt.I.get<AuthApiRepository>();
    final publicListingRepository = GetIt.I.get<PublicListingApiRepository>();
    final reservationRepository = GetIt.I.get<ReservationRepository>();
    final privateRoomRepository = GetIt.I.get<PrivateRoomApiRepository>();
    final profileRepository = GetIt.I.get<ProfileApiRepository>();

    GetIt.I.registerFactory(() => GetPostsUseCase(placeholderRepository));

    // auth usecases
    GetIt.I.registerFactory(() => LoginUseCase(authRepository));
    GetIt.I.registerFactory(() => SignUpUseCase(authRepository));
    GetIt.I.registerFactory(() => GetUserUseCase(authRepository));
    GetIt.I.registerFactory(() => LogoutUserUseCase(authRepository));

    // listing usecases
    GetIt.I.registerFactory(() => GetAllListingsUseCase(publicListingRepository));
    GetIt.I.registerFactory(() => PostListingImagesUseCase(publicListingRepository));
    GetIt.I.registerFactory(() => PostListingUseCase(publicListingRepository));
    GetIt.I.registerFactory(() => GetListingDetailsUseCase(publicListingRepository));
    GetIt.I.registerFactory(() => SearchListingsUseCase(publicListingRepository));

    // reservation usecases
    GetIt.I.registerFactory(() => PostReservationUseCase(reservationRepository));
    GetIt.I.registerFactory(() => GetUpcomingReservationsUseCase(reservationRepository));
    GetIt.I.registerFactory(() => GetRecentReservationsUseCase(reservationRepository));
    GetIt.I.registerFactory(() => PostRoomReservationUseCase(reservationRepository));
    GetIt.I.registerFactory(() => GetUpcomingListingReservationsUseCase(reservationRepository));
    GetIt.I.registerFactory(() => GetRecentListingReservationsUseCase(reservationRepository));
    GetIt.I.registerFactory(() => CancelReservationUseCase(reservationRepository));
    GetIt.I.registerFactory(() => RemoveFromHistoryUseCase(reservationRepository));

    // room usecases
    GetIt.I.registerFactory(() => SearchUsersUseCase(privateRoomRepository));
    GetIt.I.registerFactory(() => CreateRoomUseCase(privateRoomRepository));
    GetIt.I.registerFactory(() => GetYourRoomsUseCase(privateRoomRepository));
    GetIt.I.registerFactory(() => GetRoomsUseCase(privateRoomRepository));
    GetIt.I.registerFactory(() => GetInvitesUseCase(privateRoomRepository));
    GetIt.I.registerFactory(() => RespondToInviteUseCase(privateRoomRepository));
    GetIt.I.registerFactory(() => LeaveRoomUseCase(privateRoomRepository));
    GetIt.I.registerFactory(() => GetRoomDetailsUseCase(privateRoomRepository));
    GetIt.I.registerFactory(() => GetYourRoomUseCase(privateRoomRepository));
    GetIt.I.registerFactory(() => DeleteRoomUseCase(privateRoomRepository));
    GetIt.I.registerFactory(() => AddInvitesUseCase(privateRoomRepository));

    // profile usecases
    GetIt.I.registerFactory(() => GetProfileDetailsUseCase(profileRepository));
    GetIt.I.registerFactory(() => ChangeProfileImageUseCase(profileRepository));
    GetIt.I.registerFactory(() => GetHasListingUseCase(profileRepository));
  }
}
