import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:common/base_di_module.dart';
import 'package:data/auth/datasource/auth_api_service.dart';
import 'package:data/auth/di/auth_api_module.dart';
import 'package:data/placeholder_api/datasource/placeholder_api_repository.dart';
import 'package:data/placeholder_api/di/placeholder_api_module.dart';
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
import 'package:domain/public_listing/common/public_listing_api_repository.dart';
import 'package:domain/public_listing/usecases/get_all_listings_usecase.dart';
import 'package:domain/public_listing/usecases/get_listing_details_usecase.dart';
import 'package:domain/public_listing/usecases/post_listing_images_usecase.dart';
import 'package:domain/public_listing/usecases/post_listing_usecase.dart';
import 'package:domain/reservation/common/reservation_repository.dart';
import 'package:domain/reservation/usecases/get_recent_reservations_usecase.dart';
import 'package:domain/reservation/usecases/get_upcoming_reservations_usecase.dart';
import 'package:domain/reservation/usecases/post_reservation_usecase.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

class DataModule extends BaseDiModule {
  final _placeHolderApiService = PlaceholderApiService(Dio(BaseOptions(contentType: "application/json")));
  final _authApiService = AuthApiService(Dio(BaseOptions(contentType: "application/json")));
  final _publicListingApiService = PublicListingApiService(Dio(BaseOptions(contentType: "application/json")));
  final _reservationApiService = ReservationApiService(Dio(BaseOptions(contentType: "application/json")));

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
    useCases();
  }

  void useCases() {
    final placeholderRepository = GetIt.I.get<PlaceholderApiRepository>();
    final authRepository = GetIt.I.get<AuthApiRepository>();
    final publicListingRepository = GetIt.I.get<PublicListingApiRepository>();
    final reservationRepository = GetIt.I.get<ReservationRepository>();

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

    // reservation usecases
    GetIt.I.registerFactory(() => PostReservationUseCase(reservationRepository));
    GetIt.I.registerFactory(() => GetUpcomingReservationsUseCase(reservationRepository));
    GetIt.I.registerFactory(() => GetRecentReservationsUseCase(reservationRepository));
  }
}
