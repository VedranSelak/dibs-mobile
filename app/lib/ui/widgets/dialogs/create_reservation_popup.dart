import 'package:app/blocs/create_reservation_bloc/create_reservation_bloc.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/res/listing_type.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/widgets/buttons/primary_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class CreateReservationPopup {
  CreateReservationPopup({required this.context, required this.type, required this.listingId});
  final BuildContext context;
  final ListingType type;
  final int listingId;
  final TextEditingController _numberOfPeople = TextEditingController();
  final ValueNotifier<String> buttonText = ValueNotifier<String>('Choose time & data');
  final ValueNotifier<int> hours = ValueNotifier<int>(1);
  final _formKey = GlobalKey<FormState>();
  final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  final weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  int timestamp = 0;

  Future<dynamic> onTapped() {
    final dimensions = Dimensions.of(context);
    return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final textStyles = TextStyles.of(context);
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                topLeft: Radius.circular(10.0),
              ),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10.0),
                  Text('Create a reservation', style: textStyles.labelText),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: dimensions.fullWidth,
                    child: Text('How many people are coming:', style: textStyles.accentText),
                  ),
                  TextFormField(
                    controller: _numberOfPeople,
                    decoration: const InputDecoration(
                      hintText: 'Number of people ...',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
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
                              buttonText.value = '$weekDay. ${date.day}. $month. ${date.year}. at $hour:$minute';
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
                      }),
                  const SizedBox(height: 5.0),
                  BlocBuilder<CreateReservationBloc, CreateReservationState>(
                    builder: (context, state) {
                      return SizedBox(
                        width: dimensions.fullWidth,
                        child: Text(
                          state is ReservationFailed ? state.message! : '',
                          style: textStyles.errorText,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20.0),
                  PrimaryButton(
                    buttonText: "Create",
                    onPress: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<CreateReservationBloc>().add(CreateReservation(
                              listingId: listingId,
                              arrivalTime: timestamp,
                              stay: hours.value,
                              numOfPeople: int.parse(_numberOfPeople.text),
                            ));
                      }
                    },
                    backgroundColor: Colors.blueAccent,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
