import 'package:app/blocs/room_details_bloc/room_details_bloc.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/widgets/buttons/primary_button.dart';
import 'package:app/ui/widgets/screen_wrappers/simple_screen_wrapper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

class RoomDeatilsScreen extends StatefulWidget {
  const RoomDeatilsScreen({required this.id, Key? key}) : super(key: key);
  static const String routeName = '/room-details';
  final int id;

  @override
  State<RoomDeatilsScreen> createState() => _RoomDeatilsScreenState();
}

class _RoomDeatilsScreenState extends State<RoomDeatilsScreen> {
  final TextEditingController _numberOfPeople = TextEditingController();
  final ValueNotifier<String> buttonText = ValueNotifier<String>('Choose time & data');
  final ValueNotifier<int> hours = ValueNotifier<int>(1);
  final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  final weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  int timestamp = 0;

  @override
  void initState() {
    super.initState();

    context.read<RoomDetailsBloc>().add(FetchRoomDetails(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions.of(context);
    final textStyles = TextStyles.of(context);
    return SimpleScreenWrapper(
      title: 'Details',
      onBackPressed: () {
        Get.back<dynamic>();
      },
      shouldGoUnderAppBar: false,
      child: SizedBox(
        width: dimensions.fullWidth,
        height: dimensions.fullHeight,
        child: BlocBuilder<RoomDetailsBloc, RoomDetailsState>(
          builder: (context, state) {
            if (state is RoomDetailsFetchSuccess) {
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
                      child: Row(
                        children: [
                          Text(
                            'Owner: ',
                            style: textStyles.accentText,
                          ),
                          const SizedBox(width: 10.0),
                          const Icon(Icons.person),
                          const SizedBox(width: 10.0),
                          Text(
                            '${state.room.owner.firstName} ${state.room.owner.lastName}',
                            style: textStyles.secondaryLabel,
                          ),
                        ],
                      ),
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
                    Text(
                      'Create a reservation',
                      style: textStyles.subheaderText,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          SizedBox(
                            width: dimensions.fullWidth,
                            child: Text(
                              'Arival time & date:',
                              style: textStyles.accentText,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Row(
                            children: [
                              OutlinedButton(
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(const EdgeInsets.all(10.0)),
                                ),
                                onPressed: () {
                                  DatePicker.showDateTimePicker(
                                    context,
                                    showTitleActions: true,
                                    minTime: DateTime.now(),
                                    maxTime: DateTime.now().add(const Duration(days: 60)),
                                    currentTime: DateTime.now(),
                                    onConfirm: (date) {
                                      final weekDay = weekDays[date.weekday - 1];
                                      final month = months[date.month - 1];
                                      final hour = date.hour < 10 ? "0${date.hour}" : date.hour;
                                      final minute = date.minute < 10 ? "0${date.minute}" : date.minute;
                                      buttonText.value =
                                          '$weekDay. ${date.day}. $month. ${date.year}. at $hour:$minute';
                                      timestamp = date.millisecondsSinceEpoch;
                                    },
                                  );
                                },
                                child: ValueListenableBuilder(
                                  valueListenable: buttonText,
                                  builder: (BuildContext context, String value, _) {
                                    return Text(
                                      value,
                                      style: textStyles.secondaryLabel,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          SizedBox(
                            width: dimensions.fullWidth,
                            child: Text(
                              'How long are you planing to stay (approx. in hours):',
                              style: textStyles.accentText,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          ValueListenableBuilder(
                            valueListenable: hours,
                            builder: (context, int value, _) {
                              return NumberPicker(
                                axis: Axis.horizontal,
                                value: value,
                                maxValue: 8,
                                minValue: 1,
                                step: 1,
                                onChanged: (value) {
                                  hours.value = value;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(state.errorMessage != null ? state.errorMessage! : '', style: textStyles.errorText),
                    const SizedBox(height: 5.0),
                    PrimaryButton(
                      buttonText: 'Make a reservation',
                      onPress: () {
                        context.read<RoomDetailsBloc>().add(CreateRoomReservation(
                              roomId: widget.id,
                              arrivalTime: timestamp,
                              stayApprox: hours.value,
                            ));
                      },
                      backgroundColor: Colors.blueAccent,
                    ),
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
  }
}
