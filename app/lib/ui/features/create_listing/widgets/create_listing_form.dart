import 'package:app/blocs/create_listing_bloc/create_listing_bloc.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateListingForm extends StatefulWidget {
  const CreateListingForm({
    required this.nameController,
    required this.shortDescController,
    required this.detailedDescController,
    Key? key,
  }) : super(key: key);
  final TextEditingController nameController;
  final TextEditingController shortDescController;
  final TextEditingController detailedDescController;

  @override
  _CreateListingFormState createState() => _CreateListingFormState();
}

class _CreateListingFormState extends State<CreateListingForm> {
  final _formKey = GlobalKey<FormState>();
  int nameCharacterCount = 0;
  int shortDescCharacterCount = 0;
  int detailedDescCharacterCount = 0;

  @override
  void initState() {
    super.initState();
    widget.nameController.addListener(() {
      setState(() {
        nameCharacterCount = widget.nameController.text.length;
      });
    });

    widget.shortDescController.addListener(() {
      setState(() {
        shortDescCharacterCount = widget.shortDescController.text.length;
      });
    });

    widget.detailedDescController.addListener(() {
      setState(() {
        detailedDescCharacterCount = widget.detailedDescController.text.length;
      });
    });
  }

  @override
  void dispose() {
    widget.nameController.dispose();
    widget.shortDescController.dispose();
    widget.detailedDescController.dispose();
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "The listing name:",
                  style: textStyles.subheaderText,
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Tooltip(
                    margin: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.25),
                    padding: const EdgeInsets.all(10.0),
                    triggerMode: TooltipTriggerMode.tap,
                    waitDuration: Duration.zero,
                    showDuration: const Duration(seconds: 3),
                    message: "This is the name of the listing eg. name of your restaurant.",
                    child: Container(
                      padding: const EdgeInsets.all(2.0),
                      decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                      child: const Icon(
                        Icons.question_mark,
                        color: Colors.white,
                        size: 15.0,
                      ),
                    )),
              ],
            ),
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
                  return 'Please enter a listing name';
                }
                if (value.length < 3) {
                  return 'The listing name should be at least 3 characters';
                }
                return null;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                hintText: 'Listing name...',
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "A short description:",
                  style: textStyles.subheaderText,
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Tooltip(
                    margin: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.25),
                    padding: const EdgeInsets.all(10.0),
                    triggerMode: TooltipTriggerMode.tap,
                    waitDuration: Duration.zero,
                    showDuration: const Duration(seconds: 3),
                    message:
                        "This is a short description of the listing. It will be displayed to the user in the home screen.",
                    child: Container(
                      padding: const EdgeInsets.all(2.0),
                      decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                      child: const Icon(
                        Icons.question_mark,
                        color: Colors.white,
                        size: 15.0,
                      ),
                    )),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(40),
              ],
              controller: widget.shortDescController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the short description';
                }
                if (value.length < 8) {
                  return 'The short description should be at least 8 characters';
                }
                return null;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                hintText: 'Short description...',
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "$shortDescCharacterCount/40",
                  style: shortDescCharacterCount < 40 ? textStyles.secondaryLabel : textStyles.secondaryLabelAccent,
                  textAlign: TextAlign.right,
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Detailed description:",
                  style: textStyles.subheaderText,
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Tooltip(
                    margin: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.25),
                    padding: const EdgeInsets.all(10.0),
                    triggerMode: TooltipTriggerMode.tap,
                    waitDuration: Duration.zero,
                    showDuration: const Duration(seconds: 3),
                    message:
                        "This is a detailed description of the listing. It will be displayed to the user when the user enters the details screen of your listing.",
                    child: Container(
                      padding: const EdgeInsets.all(2.0),
                      decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                      child: const Icon(
                        Icons.question_mark,
                        color: Colors.white,
                        size: 15.0,
                      ),
                    )),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              minLines: 6,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              inputFormatters: [
                LengthLimitingTextInputFormatter(300),
              ],
              controller: widget.detailedDescController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the detailed description please';
                }
                if (value.length < 15) {
                  return 'The detailed description should be at least 15 characters';
                }
                return null;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                hintText: 'Detailed description...',
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "$detailedDescCharacterCount/300",
                  style: detailedDescCharacterCount < 300 ? textStyles.secondaryLabel : textStyles.secondaryLabelAccent,
                  textAlign: TextAlign.right,
                ),
              ],
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
                    if (_formKey.currentState!.validate()) {
                      final currentState = context.read<CreateListingBloc>().state;
                      if (currentState is ListingImagesEntered) {
                        context.read<CreateListingBloc>().add(EnterListingData(
                              name: widget.nameController.text,
                              shortDesc: widget.shortDescController.text,
                              detailedDesc: widget.detailedDescController.text,
                              type: "restaurant",
                              images: currentState.images,
                            ));
                      } else {
                        context.read<CreateListingBloc>().add(EnterListingData(
                              name: widget.nameController.text,
                              shortDesc: widget.shortDescController.text,
                              detailedDesc: widget.detailedDescController.text,
                              type: "restaurant",
                            ));
                      }
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
}
