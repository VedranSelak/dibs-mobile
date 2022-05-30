import 'package:app/blocs/create_listing_bloc/create_listing_bloc.dart';
import 'package:app/ui/features/create_room/widgets/create_room_form.dart';
import 'package:app/ui/widgets/buttons/primary_button.dart';
import 'package:app/ui/widgets/dialogs/alert_dialog.dart';
import 'package:app/ui/widgets/screen_wrappers/simple_screen_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class CreateRoomScreen extends StatelessWidget {
  CreateRoomScreen({Key? key}) : super(key: key);
  static const String routeName = "/create-room";
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  void onBack(BuildContext context) {
    final nameLength = _nameController.text.length;
    final descLength = _descriptionController.text.length;

    if (nameLength + descLength <= 0) {
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
            context.read<CreateListingBloc>().add(ResetCreateListingBloc());
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
        title: "Enter room details",
        shouldGoUnderAppBar: true,
        onBackPressed: () {
          onBack(context);
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              CreateRoomForm(
                nameController: _nameController,
                descController: _descriptionController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
