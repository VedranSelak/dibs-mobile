import "package:app/application.dart";
import 'package:app/blocs/bloc_module.dart';
import 'package:app/blocs/create_listing_bloc/create_listing_bloc.dart';
import 'package:app/blocs/create_reservation_bloc/create_reservation_bloc.dart';
import 'package:app/blocs/listing_bloc/listing_bloc.dart';
import 'package:app/blocs/listing_details_bloc/listing_details_bloc.dart';
import 'package:app/blocs/login_bloc/login_bloc.dart';
import 'package:app/blocs/reservations_bloc/reservations_bloc.dart';
import 'package:app/blocs/signup_bloc/signup_bloc.dart';
import 'package:app/blocs/test_bloc/test_bloc.dart';
import 'package:app/blocs/user_type_bloc/user_type_bloc.dart';
import 'package:data/di/data_module.dart';
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  registerServices();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<TestBloc>(
        create: (context) => GetIt.I.get<TestBloc>(),
      ),
      BlocProvider<LoginBloc>(
        create: (context) => GetIt.I.get<LoginBloc>(),
      ),
      BlocProvider<SignUpBloc>(
        create: (context) => GetIt.I.get<SignUpBloc>(),
      ),
      BlocProvider<ListingBloc>(
        create: (context) => GetIt.I.get<ListingBloc>(),
      ),
      BlocProvider<UserTypeBloc>(
        create: (context) => GetIt.I.get<UserTypeBloc>()..add(GetUserType()),
      ),
      BlocProvider<CreateListingBloc>(
        create: (context) => GetIt.I.get<CreateListingBloc>(),
      ),
      BlocProvider<ListingDetailsBloc>(
        create: (context) => GetIt.I.get<ListingDetailsBloc>(),
      ),
      BlocProvider<CreateReservationBloc>(
        create: (context) => GetIt.I.get<CreateReservationBloc>(),
      ),
      BlocProvider<ReservationsBloc>(
        create: (context) => GetIt.I.get<ReservationsBloc>(),
      ),
    ],
    child: Application(),
  ));
}

void registerServices() {
  BlocModule();
  DataModule();
}
