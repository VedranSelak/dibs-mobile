import 'package:app/blocs/reservations_bloc/reservations_bloc.dart';
import 'package:app/ui/features/reservations/widgets/upcoming_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class UpcomingReservationsScreen extends StatefulWidget {
  const UpcomingReservationsScreen({Key? key}) : super(key: key);

  @override
  State<UpcomingReservationsScreen> createState() => _UpcomingReservationsScreenState();
}

class _UpcomingReservationsScreenState extends State<UpcomingReservationsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ReservationsBloc>().add(FetchUpcomingReservations());
  }

  String _getArrivalTimeString(int milliseconds) {
    final date = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    final hour = date.hour < 10 ? '0${date.hour}' : date.hour;
    final minute = date.minute < 10 ? '0${date.minute}' : date.hour;
    return '$hour:$minute';
  }

  String _getDateString(int milliseconds) {
    final weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final date = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    final weekDay = weekDays[date.weekday - 1];
    final month = months[date.month - 1];
    return '$weekDay. $month ${date.day}. ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: BlocBuilder<ReservationsBloc, ReservationsState>(builder: (context, state) {
        if (state is ReservationsFetched) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<ReservationsBloc>().add(FetchUpcomingReservations());
              const Duration(seconds: 1);
            },
            child: ListView.builder(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              itemCount: state.reservations.length,
              itemBuilder: (context, index) {
                final listing = state.reservations[index].publicListing;
                final reservation = state.reservations[index];
                final arrivalTime = _getArrivalTimeString(reservation.arrivalTimestamp);
                final date = _getDateString(reservation.arrivalTimestamp);

                return UpcomingListItem(
                  imageUrl: listing.imageUrls[0],
                  arrivalTime: arrivalTime,
                  name: listing.name,
                  date: date,
                );
              },
            ),
          );
        }
        return const Center(
            child: SpinKitWave(
          color: Colors.blueAccent,
        ));
      }),
    );
  }
}
