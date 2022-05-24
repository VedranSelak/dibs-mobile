import 'package:app/blocs/user_type_bloc/user_type_bloc.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/features/login/login_screen.dart';
import 'package:app/ui/features/reservations/navigation/reservations_controller.dart';
import 'package:app/ui/features/reservations/widgets/upcoming_reservations_screen.dart';
import 'package:app/ui/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen({Key? key}) : super(key: key);
  static const routeName = '/reservations';

  @override
  State<ReservationsScreen> createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  @override
  void initState() {
    Get.put<ReservationsController>(ReservationsController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions.of(context);
    final textStyles = TextStyles.of(context);
    return GetBuilder<ReservationsController>(builder: (controller) {
      return Container(
        padding: const EdgeInsets.all(20.0),
        width: dimensions.fullWidth,
        height: dimensions.mainContentHeight,
        child: BlocBuilder<UserTypeBloc, UserTypeState>(builder: (context, state) {
          if (state is GuestType) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'You are a guest',
                  style: textStyles.headerText,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),
                Text(
                  'To be able to view your resevations you have to be logged into your account. Please log in to your account.',
                  style: textStyles.descriptiveText,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30.0),
                PrimaryButton(
                    buttonText: 'Log in',
                    onPress: () {
                      Get.toNamed<dynamic>(LoginScreen.routeName);
                    },
                    backgroundColor: Colors.blueAccent),
              ],
            );
          }
          return Column(
            children: [
              const SizedBox(height: 20.0),
              _buildTopNavigation(context, controller),
              const SizedBox(height: 20.0),
              controller.tabIndex == 0
                  ? const UpcomingReservationsScreen()
                  : controller.tabIndex == 1
                      ? const Text('Recent')
                      : Container(),
            ],
          );
        }),
      );
    });
  }

  Widget _buildTopNavigation(BuildContext context, ReservationsController controller) {
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
