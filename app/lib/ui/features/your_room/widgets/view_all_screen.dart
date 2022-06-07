import 'package:app/ui/features/your_room/widgets/room_reservation_list_item.dart';
import 'package:app/ui/widgets/screen_wrappers/simple_screen_wrapper.dart';
import 'package:domain/private_room/entities/room_reservation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewAllScreen extends StatelessWidget {
  const ViewAllScreen({required this.title, required this.reservations, Key? key}) : super(key: key);
  final String title;
  final List<RoomReservation> reservations;

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
    return SimpleScreenWrapper(
      onBackPressed: () {
        Get.back<dynamic>();
      },
      shouldGoUnderAppBar: false,
      title: title,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        itemCount: reservations.length,
        itemBuilder: (context, index) {
          final date = _getDateString(reservations[index].arrivalTimestamp);
          final time = _getArrivalTimeString(reservations[index].arrivalTimestamp);
          final fullName = '${reservations[index].user.firstName} ${reservations[index].user.lastName}';
          final stay = (reservations[index].stayApprox - reservations[index].arrivalTimestamp) ~/ 3600000;
          return RoomReservationListItem(fullName: fullName, date: date, time: time, stay: stay);
        },
      ),
    );
  }
}
