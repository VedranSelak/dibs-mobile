import 'package:app/blocs/reservations_bloc/reservations_bloc.dart';
import 'package:app/ui/features/reservations/widgets/recent_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RecentReservationsScreen extends StatefulWidget {
  const RecentReservationsScreen({Key? key}) : super(key: key);

  @override
  State<RecentReservationsScreen> createState() => _RecentReservationsScreenState();
}

class _RecentReservationsScreenState extends State<RecentReservationsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ReservationsBloc>().add(FetchRecentReservations());
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
              context.read<ReservationsBloc>().add(FetchRecentReservations());
              const Duration(seconds: 1);
            },
            child: ListView.builder(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              itemCount: state.reservations.length,
              itemBuilder: (context, index) {
                final place = state.reservations[index].place;
                final reservation = state.reservations[index];
                final date = _getDateString(reservation.arrivalTimestamp);

                return RecentListItem(
                  imageUrl: place.imageUrl,
                  name: place.name,
                  isPrivate: reservation.isPrivate,
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
