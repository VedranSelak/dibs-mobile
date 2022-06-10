import 'package:app/blocs/create_listing_bloc/create_listing_bloc.dart';
import 'package:app/blocs/create_reservation_bloc/create_reservation_bloc.dart';
import 'package:app/blocs/create_room_bloc/create_room_bloc.dart';
import 'package:app/blocs/listing_bloc/listing_bloc.dart';
import 'package:app/blocs/login_bloc/login_bloc.dart';
import 'package:app/blocs/owner_mode_cubit/owner_mode_cubit.dart';
import 'package:app/blocs/profile_bloc/profile_bloc.dart';
import 'package:app/blocs/reservations_bloc/reservations_bloc.dart';
import 'package:app/blocs/room_details_bloc/room_details_bloc.dart';
import 'package:app/blocs/rooms_bloc/rooms_bloc.dart';
import 'package:app/blocs/search_listings_bloc/search_listings_bloc.dart';
import 'package:app/blocs/signup_bloc/signup_bloc.dart';
import 'package:app/blocs/test_bloc/test_bloc.dart';
import 'package:app/blocs/user_type_bloc/user_type_bloc.dart';
import 'package:app/blocs/listing_details_bloc/listing_details_bloc.dart';
import 'package:app/blocs/your_room_bloc/your_room_bloc.dart';
import 'package:common/base_di_module.dart';
import 'package:get_it/get_it.dart';

class BlocModule extends BaseDiModule {
  @override
  void inject() {
    /// Blocs
    GetIt.I.registerFactory<TestBloc>(TestBloc.new);
    GetIt.I.registerFactory<LoginBloc>(LoginBloc.new);
    GetIt.I.registerFactory<SignUpBloc>(SignUpBloc.new);
    GetIt.I.registerFactory<ListingBloc>(ListingBloc.new);
    GetIt.I.registerFactory<UserTypeBloc>(UserTypeBloc.new);
    GetIt.I.registerFactory<CreateListingBloc>(CreateListingBloc.new);
    GetIt.I.registerFactory<ListingDetailsBloc>(ListingDetailsBloc.new);
    GetIt.I.registerFactory<CreateReservationBloc>(CreateReservationBloc.new);
    GetIt.I.registerFactory<ReservationsBloc>(ReservationsBloc.new);
    GetIt.I.registerFactory<CreateRoomBloc>(CreateRoomBloc.new);
    GetIt.I.registerFactory<RoomsBloc>(RoomsBloc.new);
    GetIt.I.registerFactory<RoomDetailsBloc>(RoomDetailsBloc.new);
    GetIt.I.registerFactory<YourRoomBloc>(YourRoomBloc.new);
    GetIt.I.registerFactory<OwnerModeCubit>(OwnerModeCubit.new);
    GetIt.I.registerFactory<ProfileBloc>(ProfileBloc.new);
    GetIt.I.registerFactory<SearchListingsBloc>(SearchListingsBloc.new);
  }
}
