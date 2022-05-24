import 'package:app/blocs/listing_bloc/listing_bloc.dart';
import 'package:app/blocs/reservations_bloc/reservations_bloc.dart';
import 'package:app/blocs/user_type_bloc/user_type_bloc.dart';
import 'package:app/ui/widgets/bottom_navigation/main_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              context.read<ListingBloc>().add(FetchListings());
              context.read<UserTypeBloc>().add(GetUserType());
            },
          ),
          IconButton(
            icon: const Icon(CupertinoIcons.list_bullet),
            color: controller.tabIndex == 1 ? Colors.blueAccent : Colors.black,
            tooltip: "Reservations",
            onPressed: () {
              controller.changeTabIndex(1);
              context.read<ReservationsBloc>().add(FetchUpcomingReservations());
            },
          ),
          IconButton(
            icon: const Icon(Icons.meeting_room_outlined),
            color: controller.tabIndex == 2 ? Colors.blueAccent : Colors.black,
            tooltip: "Rooms",
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(CupertinoIcons.person),
            color: controller.tabIndex == 3 ? Colors.blueAccent : Colors.black,
            tooltip: "Profile",
            onPressed: () {
              controller.changeTabIndex(3);
            },
          ),
        ],
      ),
    );
  }
}
