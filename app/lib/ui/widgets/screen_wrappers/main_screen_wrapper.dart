import 'package:app/blocs/user_type_bloc/user_type_bloc.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/ui/features/login/login_screen.dart';
import 'package:app/ui/features/profile/profile_screen.dart';
import 'package:app/ui/features/reservations/reservations_screen.dart';
import 'package:app/ui/features/rooms/rooms_screen.dart';
import 'package:app/ui/widgets/bottom_navigation/bottom_app_bar.dart';
import 'package:app/ui/widgets/bottom_navigation/main_controller.dart';
import 'package:app/ui/widgets/dialogs/alert_dialog.dart';
import 'package:app/ui/widgets/main_screen_overlay.dart';
import 'package:app/ui/widgets/buttons/primary_button.dart';
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
        return BlocListener<UserTypeBloc, UserTypeState>(
          listener: (context, state) {
            if (state is ExpiredUser) {
              AlertDialogWidget(
                context: context,
                title: 'Session expired',
                description:
                    'Your session has expired. This is done for your safety, please log in again to user your account.',
                acceptButton: PrimaryButton(
                  buttonText: 'Log in',
                  onPress: () {
                    context.read<UserTypeBloc>().add(SetGuest());
                    Get.back<dynamic>();
                    // ignore: cascade_invocations
                    Get.toNamed<dynamic>(LoginScreen.routeName);
                  },
                  backgroundColor: Colors.blueAccent,
                ),
                rejectButton: PrimaryButton(
                  buttonText: 'Cancel',
                  onPress: () {
                    context.read<UserTypeBloc>().add(SetGuest());
                    Get.back<dynamic>();
                  },
                  backgroundColor: Colors.grey,
                ),
              ).showAlertDialog();
            }
          },
          child: WillPopScope(
            onWillPop: () async {
              if (context.read<UserTypeBloc>().state is ExpiredUser) {
                return false;
              }
              return true;
            },
            child: Scaffold(
              body: SafeArea(
                child: IndexedStack(
                  index: controller.tabIndex,
                  children: [
                    widget.child,
                    const ReservationsScreen(),
                    const RoomsScreen(),
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
                      description:
                          "To be able to take advantage the apps whole functionality please create an account.",
                      acceptButton: PrimaryButton(
                        buttonText: 'Log in',
                        backgroundColor: Colors.blueAccent,
                        onPress: () {
                          Get.back<dynamic>();
                          // ignore: cascade_invocations
                          Get.toNamed<dynamic>(LoginScreen.routeName);
                        },
                      ),
                      rejectButton: PrimaryButton(
                        buttonText: 'Cancel',
                        backgroundColor: Colors.grey,
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
            ),
          ),
        );
      },
    );
  }
}
