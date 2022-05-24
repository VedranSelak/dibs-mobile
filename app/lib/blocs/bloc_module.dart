import 'package:app/blocs/create_listing_bloc/create_listing_bloc.dart';
import 'package:app/blocs/create_reservation_bloc/create_reservation_bloc.dart';
import 'package:app/blocs/listing_bloc/listing_bloc.dart';
import 'package:app/blocs/login_bloc/login_bloc.dart';
import 'package:app/blocs/reservations_bloc/reservations_bloc.dart';
import 'package:app/blocs/signup_bloc/signup_bloc.dart';
import 'package:app/blocs/test_bloc/test_bloc.dart';
import 'package:app/blocs/user_type_bloc/user_type_bloc.dart';
import 'package:app/blocs/listing_details_bloc/listing_details_bloc.dart';
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
  }
}
