import 'package:app/ui/features/create_listing/widgets/create_listing_form.dart';
import 'package:app/ui/widgets/buttons/primary_button.dart';
import 'package:app/ui/widgets/dialogs/alert_dialog.dart';
import 'package:app/ui/widgets/screen_wrappers/simple_screen_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateListingScreen extends StatelessWidget {
  CreateListingScreen({Key? key}) : super(key: key);
  static const String routeName = "/create-listing";
  final _nameController = TextEditingController();
  final _shortDescriptionController = TextEditingController();
  final _detailedDescriptionController = TextEditingController();

  void onBack(BuildContext context) {
    final nameLength = _nameController.text.length;
    final shortDescLength = _shortDescriptionController.text.length;
    final detailedDescLength = _detailedDescriptionController.text.length;

    if (nameLength + shortDescLength + detailedDescLength <= 0) {
      Get.back<dynamic>();
    } else {
      AlertDialogWidget(
        context: context,
        title: "Progress will be lost",
        description:
            "By leaving this screen all the data you entered will be discarded. Are you sure you want to leave the screen?",
        acceptButton: PrimaryButton(
          backgroundColor: Colors.red,
          buttonText: "Discard",
          onPress: () {
            Get.back<dynamic>();
            // ignore: cascade_invocations
            Get.back<dynamic>();
          },
        ),
        rejectButton: PrimaryButton(
          backgroundColor: Colors.grey,
          buttonText: "Cancel",
          onPress: () {
            Get.back<dynamic>();
          },
        ),
      ).showAlertDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        onBack(context);
        return false;
      },
      child: SimpleScreenWrapper(
        title: "Enter listing details",
        onBackPressed: () {
          onBack(context);
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              CreateListingForm(
                nameController: _nameController,
                shortDescController: _shortDescriptionController,
                detailedDescController: _detailedDescriptionController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
