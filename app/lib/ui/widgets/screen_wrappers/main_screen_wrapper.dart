import 'package:app/blocs/user_type_bloc/user_type_bloc.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/features/login/login_screen.dart';
import 'package:app/ui/features/profile/profile_screen.dart';
import 'package:app/ui/widgets/bottom_navigation/bottom_app_bar.dart';
import 'package:app/ui/widgets/bottom_navigation/main_controller.dart';
import 'package:app/ui/widgets/dialogs/alert_dialog.dart';
import 'package:app/ui/widgets/main_screen_overlay.dart';
import 'package:app/ui/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class MainScreenWrapper extends StatefulWidget {
  const MainScreenWrapper({required this.child, Key? key}) : super(key: key);
  final Widget child;

  @override
  State<MainScreenWrapper> createState() => _MainScreenWrapperState();
}

class _MainScreenWrapperState extends State<MainScreenWrapper> {
  late OverlayEntry entry;

  @override
  void initState() {
    super.initState();
    entry = OverlayEntry(
      builder: (context) {
        return MainScreenOverlay(entry: entry);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions.of(context);
    return GetBuilder<MainController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: controller.tabIndex,
              children: [
                widget.child,
                const ProfileScreen(),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              final state = context.read<UserTypeBloc>().state;
              if (state is GuestType) {
                AlertDialogWidget(
                  context: context,
                  title: "You aren't logged in",
                  description: "To be able to take advantage the apps whole functionality please create an account.",
                  acceptButton: PrimaryButton(
                    buttonText: 'Log in',
                    onPress: () {
                      Get.back<dynamic>();
                      // ignore: cascade_invocations
                      Get.toNamed<dynamic>(LoginScreen.routeName);
                    },
                  ),
                  rejectButton: PrimaryButton(
                    buttonText: 'Cancel',
                    onPress: () {
                      Get.back<dynamic>();
                    },
                  ),
                ).showAlertDialog();
              } else {
                Overlay.of(context)?.insert(entry);
              }
            },
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: SizedBox(
            height: dimensions.bottomNavBarHeight,
            child: BottomAppBarWidget(controller: controller),
          ),
        );
      },
    );
  }
}
