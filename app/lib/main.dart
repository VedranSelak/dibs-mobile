import "package:app/application.dart";
import 'package:app/blocs/bloc_module.dart';
import 'package:app/blocs/create_listing_bloc/create_listing_bloc.dart';
import 'package:app/blocs/create_reservation_bloc/create_reservation_bloc.dart';
import 'package:app/blocs/create_room_bloc/create_room_bloc.dart';
import 'package:app/blocs/filters_bloc/filters_bloc.dart';
import 'package:app/blocs/listing_bloc/listing_bloc.dart';
import 'package:app/blocs/listing_created_cubit/listing_created_cubit.dart';
import 'package:app/blocs/listing_details_bloc/listing_details_bloc.dart';
import 'package:app/blocs/login_bloc/login_bloc.dart';
import 'package:app/blocs/owner_mode_cubit/owner_mode_cubit.dart';
import 'package:app/blocs/profile_bloc/profile_bloc.dart';
import 'package:app/blocs/reservations_bloc/reservations_bloc.dart';
import 'package:app/blocs/room_details_bloc/room_details_bloc.dart';
import 'package:app/blocs/rooms_bloc/rooms_bloc.dart';
import 'package:app/blocs/search_listings_bloc/search_listings_bloc.dart';
import 'package:app/blocs/show_reminder_cubit/show_reminder_cubit.dart';
import 'package:app/blocs/signup_bloc/signup_bloc.dart';
import 'package:app/blocs/test_bloc/test_bloc.dart';
import 'package:app/blocs/user_type_bloc/user_type_bloc.dart';
import 'package:app/blocs/your_room_bloc/your_room_bloc.dart';
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
      BlocProvider<ListingBloc>(
        create: (context) => GetIt.I.get<ListingBloc>(),
      ),
      BlocProvider<UserTypeBloc>(
        create: (context) => GetIt.I.get<UserTypeBloc>()..add(GetUserType()),
      ),
      BlocProvider<LoginBloc>(
        create: (context) => GetIt.I.get<LoginBloc>(
          param1: context.read<UserTypeBloc>(),
        ),
      ),
      BlocProvider<SignUpBloc>(
        create: (context) => GetIt.I.get<SignUpBloc>(
          param1: context.read<UserTypeBloc>(),
        ),
      ),
      BlocProvider<ListingCreatedCubit>(
        create: (context) => GetIt.I.get<ListingCreatedCubit>(),
      ),
      BlocProvider<CreateListingBloc>(
        create: (context) => GetIt.I.get<CreateListingBloc>(
          param1: context.read<ListingCreatedCubit>(),
        ),
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
      BlocProvider<CreateRoomBloc>(
        create: (context) => GetIt.I.get<CreateRoomBloc>(),
      ),
      BlocProvider<RoomsBloc>(
        create: (context) => GetIt.I.get<RoomsBloc>(),
      ),
      BlocProvider<RoomDetailsBloc>(
        create: (context) => GetIt.I.get<RoomDetailsBloc>(),
      ),
      BlocProvider<YourRoomBloc>(
        create: (context) => GetIt.I.get<YourRoomBloc>(),
      ),
      BlocProvider<OwnerModeCubit>(
        create: (context) => GetIt.I.get<OwnerModeCubit>(),
      ),
      BlocProvider<ProfileBloc>(
        create: (context) => GetIt.I.get<ProfileBloc>(),
      ),
      BlocProvider<SearchListingsBloc>(
        create: (context) => GetIt.I.get<SearchListingsBloc>(),
      ),
      BlocProvider<FiltersBloc>(
        create: (context) => GetIt.I.get<FiltersBloc>(),
      ),
      BlocProvider<ShowReminderCubit>(
        create: (context) => GetIt.I.get<ShowReminderCubit>(),
      ),
    ],
    child: Application(),
  ));
}

void registerServices() {
  BlocModule();
  DataModule();
}
