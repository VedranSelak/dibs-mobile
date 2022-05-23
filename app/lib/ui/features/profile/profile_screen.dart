import 'package:app/blocs/user_type_bloc/user_type_bloc.dart';
import 'package:app/ui/widgets/buttons/primary_button.dart';
import 'package:app/ui/widgets/dialogs/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
        padding: const EdgeInsets.all(20.0),
        width: mediaQuery.size.width,
        height: mediaQuery.size.height,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    AlertDialogWidget(
                      context: context,
                      title: 'Log out?',
                      description: 'Are you sure you want to log out of your account?',
                      acceptButton: PrimaryButton(
                        buttonText: 'Log out',
                        onPress: () {
                          context.read<UserTypeBloc>().add(LogoutUser());
                          Get.back<dynamic>();
                        },
                        backgroundColor: Colors.blueAccent,
                      ),
                      rejectButton: PrimaryButton(
                        buttonText: 'Cancel',
                        onPress: () {
                          Get.back<dynamic>();
                        },
                        backgroundColor: Colors.grey,
                      ),
                    ).showAlertDialog();
                  },
                  icon: const Icon(Icons.logout),
                )
              ],
            )
          ],
        ));
  }
}
