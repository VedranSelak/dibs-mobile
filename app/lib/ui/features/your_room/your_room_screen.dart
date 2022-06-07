import 'package:app/blocs/your_room_bloc/your_room_bloc.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/features/your_room/navigation/your_room_controller.dart';
import 'package:app/ui/features/your_room/widgets/room_reservation_list_item.dart';
import 'package:app/ui/features/your_room/widgets/view_all_screen.dart';
import 'package:app/ui/widgets/screen_wrappers/simple_screen_wrapper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class YourRoomScreen extends StatefulWidget {
  const YourRoomScreen({required this.id, Key? key}) : super(key: key);
  final int id;

  @override
  _YourRoomScreenState createState() => _YourRoomScreenState();
}

class _YourRoomScreenState extends State<YourRoomScreen> {
  @override
  void initState() {
    Get.put<YourRoomController>(YourRoomController());
    super.initState();
    context.read<YourRoomBloc>().add(FetchYourRoomDetails(id: widget.id));
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
    final dimensions = Dimensions.of(context);
    final textStyles = TextStyles.of(context);
    return GetBuilder<YourRoomController>(builder: (controller) {
      return SimpleScreenWrapper(
        title: 'Room',
        onBackPressed: () {
          Get.back<dynamic>();
        },
        shouldGoUnderAppBar: false,
        child: SizedBox(
          width: dimensions.fullWidth,
          height: dimensions.fullHeight,
          child: BlocBuilder<YourRoomBloc, YourRoomState>(
            builder: (context, state) {
              if (state is YourRoomFetchSuccess) {
                final containerHeight = controller.tabIndex == 0
                    ? state.room.reservations.length > 3
                        ? 240.0
                        : double.parse((80 * state.room.reservations.length).toString())
                    : state.room.recent.length > 3
                        ? 240.0
                        : double.parse((80 * state.room.recent.length).toString());
                final count = controller.tabIndex == 0 ? state.room.reservations.length : state.room.recent.length;

                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: dimensions.fullHeight * 0.4,
                        width: dimensions.fullWidth,
                        child: CachedNetworkImage(
                          imageUrl: state.room.imageUrl,
                          placeholder: (context, _) => const SpinKitWave(color: Colors.blueAccent),
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        width: dimensions.fullWidth,
                        child: Text(state.room.name, style: textStyles.labelHeaderText),
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        width: dimensions.fullWidth,
                        child: Text('Description:', style: textStyles.labelText),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        width: dimensions.fullWidth,
                        child: Text(
                          state.room.description,
                          style: textStyles.secondaryLabel,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        width: dimensions.fullWidth,
                        height: 1.0,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        width: dimensions.fullWidth,
                        child: _buildTopNavigation(context, controller),
                      ),
                      const SizedBox(height: 20.0),
                      Stack(
                        children: [
                          containerHeight == 0
                              ? SizedBox(
                                  height: 80,
                                  child: Center(
                                    child: Text(
                                      'There are no reservations in this section',
                                      style: textStyles.descriptiveText,
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: containerHeight,
                                  child: ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: count,
                                    itemBuilder: (context, index) {
                                      String date = '';
                                      String time = '';
                                      String fullName = '';
                                      int stay;
                                      if (controller.tabIndex == 0) {
                                        date = _getDateString(state.room.reservations[index].arrivalTimestamp);
                                        time = _getArrivalTimeString(state.room.reservations[index].arrivalTimestamp);
                                        fullName =
                                            '${state.room.reservations[index].user.firstName} ${state.room.reservations[index].user.lastName}';
                                        stay = (state.room.reservations[index].stayApprox -
                                                state.room.reservations[index].arrivalTimestamp) ~/
                                            3600000;
                                      } else {
                                        date = _getDateString(state.room.recent[index].arrivalTimestamp);
                                        time = _getArrivalTimeString(state.room.recent[index].arrivalTimestamp);
                                        fullName =
                                            '${state.room.recent[index].user.firstName} ${state.room.recent[index].user.lastName}';
                                        stay = (state.room.recent[index].stayApprox -
                                                state.room.recent[index].arrivalTimestamp) ~/
                                            3600000;
                                      }

                                      return RoomReservationListItem(
                                          fullName: fullName, date: date, time: time, stay: stay);
                                    },
                                  ),
                                ),
                          count != 0
                              ? Container(
                                  height: containerHeight,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.white.withAlpha(0),
                                        Colors.grey.shade50,
                                      ],
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                      count > 3
                          ? TextButton(
                              onPressed: () {
                                final title = controller.tabIndex == 0 ? 'Upcoming' : 'Recent';
                                final reservations =
                                    controller.tabIndex == 0 ? state.room.reservations : state.room.recent;
                                Get.to<dynamic>(ViewAllScreen(title: title, reservations: reservations));
                              },
                              child: Text(
                                'View all',
                                style: textStyles.accentText,
                              ),
                            )
                          : Container(),
                      const SizedBox(height: 30.0),
                    ],
                  ),
                );
              }
              return const Center(
                  child: SpinKitWave(
                color: Colors.blueAccent,
              ));
            },
          ),
        ),
      );
    });
  }

  Widget _buildTopNavigation(BuildContext context, YourRoomController controller) {
    final textStyles = TextStyles.of(context);
    final dimensions = Dimensions.of(context);
    return SizedBox(
      width: dimensions.fullWidth,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                controller.changeTabIndex(0);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: controller.tabIndex == 0 ? Colors.blueAccent : Colors.white,
                  border: Border.all(color: Colors.blueAccent, width: 1.0),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                  ),
                ),
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Upcoming',
                  textAlign: TextAlign.center,
                  style: controller.tabIndex == 0 ? textStyles.whiteText : textStyles.accentText,
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                controller.changeTabIndex(1);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: controller.tabIndex == 1 ? Colors.blueAccent : Colors.white,
                  border: Border.all(color: Colors.blueAccent, width: 1.0),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                  ),
                ),
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Recent',
                  textAlign: TextAlign.center,
                  style: controller.tabIndex == 1 ? textStyles.whiteText : textStyles.accentText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
