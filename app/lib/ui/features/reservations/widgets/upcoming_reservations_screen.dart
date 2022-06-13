import 'package:app/blocs/reservations_bloc/reservations_bloc.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/features/reservations/widgets/listing_reservation_list_item.dart';
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
    final textStyles = TextStyles.of(context);
    return Expanded(
      flex: 1,
      child: BlocBuilder<ReservationsBloc, ReservationsState>(builder: (context, state) {
        if (state is ReservationsFetched) {
          if (state.reservations.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<ReservationsBloc>().add(FetchUpcomingReservations());
              },
              child: ListView.builder(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                itemCount: state.reservations.length,
                itemBuilder: (context, index) {
                  final place = state.reservations[index].place;
                  final reservation = state.reservations[index];
                  final arrivalTime = _getArrivalTimeString(reservation.arrivalTimestamp);
                  final date = _getDateString(reservation.arrivalTimestamp);

                  return UpcomingListItem(
                    id: reservation.id,
                    imageUrl: place.imageUrl,
                    arrivalTime: arrivalTime,
                    name: place.name,
                    isPrivate: reservation.isPrivate,
                    date: date,
                  );
                },
              ),
            );
          } else {
            return Center(
              child: Text(
                'You have no upcoming reservations',
                style: textStyles.descriptiveText,
                textAlign: TextAlign.center,
              ),
            );
          }
        } else if (state is ListingReservationsFetched) {
          if (state.reservations.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<ReservationsBloc>().add(FetchUpcomingListingReservations());
              },
              child: ListView.builder(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                itemCount: state.reservations.length,
                itemBuilder: (context, index) {
                  final fullName =
                      '${state.reservations[index].user.firstName} ${state.reservations[index].user.lastName}';
                  final reservation = state.reservations[index];
                  final arrivalTime = _getArrivalTimeString(reservation.arrivalTimestamp);
                  final date = _getDateString(reservation.arrivalTimestamp);

                  return ListingReservationListItem(
                    fullName: fullName,
                    arrivalTime: arrivalTime,
                    date: date,
                    numOfPeople: reservation.numOfParticipants,
                    stay: (reservation.stayApprox - reservation.arrivalTimestamp) ~/ 3600000,
                    imageUrl: reservation.user.imageUrl,
                  );
                },
              ),
            );
          } else {
            return Center(
              child: Text(
                'You have no upcoming reservations',
                style: textStyles.descriptiveText,
                textAlign: TextAlign.center,
              ),
            );
          }
        }
        return const Center(
            child: SpinKitWave(
          color: Colors.blueAccent,
        ));
      }),
    );
  }
}
