import 'package:app/blocs/create_listing_bloc/create_listing_bloc.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/features/create_listing/widgets/text_label.dart';
import 'package:app/ui/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';

class CreateRoomForm extends StatefulWidget {
  const CreateRoomForm({
    required this.nameController,
    required this.descController,
    Key? key,
  }) : super(key: key);
  final TextEditingController nameController;
  final TextEditingController descController;

  @override
  _CreateRoomFormState createState() => _CreateRoomFormState();
}

class _CreateRoomFormState extends State<CreateRoomForm> {
  final _formKey = GlobalKey<FormState>();
  int nameCharacterCount = 0;
  int descCharacterCount = 0;
  final ValueNotifier<int> availableSpots = ValueNotifier<int>(1);

  @override
  void initState() {
    super.initState();
    widget.nameController.addListener(() {
      setState(() {
        nameCharacterCount = widget.nameController.text.length;
      });
    });

    widget.descController.addListener(() {
      setState(() {
        descCharacterCount = widget.descController.text.length;
      });
    });
  }

  @override
  void dispose() {
    widget.nameController.dispose();
    widget.descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles.of(context);
    final mediaQuery = MediaQuery.of(context);

    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      height: mediaQuery.size.height,
      width: mediaQuery.size.width,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextLabel(
                title: "The room name:",
                tooltip: "This is the name of the room that will be show as the main text to the users."),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(30),
              ],
              controller: widget.nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a room name';
                }
                if (value.length < 3) {
                  return 'The room name should be at least 3 characters';
                }
                return null;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                hintText: 'Room name...',
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "$nameCharacterCount/30",
                  style: nameCharacterCount < 30 ? textStyles.secondaryLabel : textStyles.secondaryLabelAccent,
                  textAlign: TextAlign.right,
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            const TextLabel(
              title: "A description:",
              tooltip:
                  "This is a description of the room. It is supposed to explain to the users the purpose of the room.",
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              minLines: 6,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              inputFormatters: [
                LengthLimitingTextInputFormatter(200),
              ],
              controller: widget.descController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the description';
                }
                if (value.length < 8) {
                  return 'The description should be at least 8 characters';
                }
                return null;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                hintText: 'Description...',
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "$descCharacterCount/200",
                  style: descCharacterCount < 200 ? textStyles.secondaryLabel : textStyles.secondaryLabelAccent,
                  textAlign: TextAlign.right,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const TextLabel(
              title: "What is the capacity:",
              tooltip: "How many people can fit in this private room at the same time?",
            ),
            const SizedBox(
              height: 10.0,
            ),
            ValueListenableBuilder(
              valueListenable: availableSpots,
              builder: (context, int value, _) {
                return NumberPicker(
                  axis: Axis.horizontal,
                  value: value,
                  maxValue: 100,
                  minValue: 1,
                  step: 1,
                  onChanged: (value) {
                    availableSpots.value = value;
                  },
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                width: mediaQuery.size.width * 0.5,
                child: PrimaryButton(
                  buttonText: "Next",
                  backgroundColor: Colors.blueAccent,
                  onPress: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                )),
          ],
        ),
      ),
    );
  }
}
