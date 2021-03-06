import 'package:app/blocs/filters_bloc/filters_bloc.dart';
import 'package:app/blocs/listing_bloc/listing_bloc.dart';
import 'package:app/blocs/owner_mode_cubit/owner_mode_cubit.dart';
import 'package:app/blocs/profile_bloc/profile_bloc.dart';
import 'package:app/blocs/reservations_bloc/reservations_bloc.dart';
import 'package:app/blocs/rooms_bloc/rooms_bloc.dart';
import 'package:app/blocs/user_type_bloc/user_type_bloc.dart';
import 'package:app/ui/features/reservations/navigation/reservations_controller.dart';
import 'package:app/ui/features/rooms/navigation/rooms_controller.dart';
import 'package:app/ui/widgets/bottom_navigation/main_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class BottomAppBarWidget extends StatelessWidget {
  const BottomAppBarWidget({required this.controller, Key? key}) : super(key: key);
  final MainController controller;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 5.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(CupertinoIcons.home),
            color: controller.tabIndex == 0 ? Colors.blueAccent : Colors.black,
            tooltip: "Home",
            onPressed: () {
              controller.changeTabIndex(0);
              final filterState = context.read<FiltersBloc>().state as FiltersApplied;
              context.read<ListingBloc>().add(FetchListings(
                    filters: filterState.filters,
                    sort: filterState.sort,
                  ));
              context.read<UserTypeBloc>().add(GetUserType());
            },
          ),
          IconButton(
            icon: const Icon(CupertinoIcons.list_bullet),
            color: controller.tabIndex == 1 ? Colors.blueAccent : Colors.black,
            tooltip: "Reservations",
            onPressed: () {
              controller.changeTabIndex(1);
              final userType = context.read<UserTypeBloc>().state;
              if (userType is! GuestType) {
                final ReservationsController resController = Get.find();
                if (context.read<OwnerModeCubit>().state) {
                  if (resController.tabIndex == 0) {
                    context.read<ReservationsBloc>().add(FetchUpcomingListingReservations());
                  } else {
                    context.read<ReservationsBloc>().add(FetchRecentListingReservations());
                  }
                } else {
                  if (resController.tabIndex == 0) {
                    context.read<ReservationsBloc>().add(FetchUpcomingReservations());
                  } else {
                    context.read<ReservationsBloc>().add(FetchRecentReservations());
                  }
                }
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.meeting_room_outlined),
            color: controller.tabIndex == 2 ? Colors.blueAccent : Colors.black,
            tooltip: "Rooms",
            onPressed: () {
              controller.changeTabIndex(2);
              final userType = context.read<UserTypeBloc>().state;
              if (userType is! GuestType) {
                final RoomsController roomsController = Get.find();
                if (roomsController.tabIndex == 0) {
                  context.read<RoomsBloc>().add(FetchYourRooms());
                } else if (roomsController.tabIndex == 1) {
                  context.read<RoomsBloc>().add(FetchRooms());
                }
              }
            },
          ),
          IconButton(
            icon: const Icon(CupertinoIcons.person),
            color: controller.tabIndex == 3 ? Colors.blueAccent : Colors.black,
            tooltip: "Profile",
            onPressed: () {
              controller.changeTabIndex(3);
              final userState = context.read<UserTypeBloc>().state;
              if (userState is! GuestType) {
                context.read<ProfileBloc>().add(FetchProfileDetails());
              }
            },
          ),
        ],
      ),
    );
  }
}
