import 'package:app/blocs/rooms_bloc/rooms_bloc.dart';
import 'package:app/blocs/user_type_bloc/user_type_bloc.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/features/login/login_screen.dart';
import 'package:app/ui/features/rooms/navigation/rooms_controller.dart';
import 'package:app/ui/features/rooms/widgets/invites_list_screen.dart';
import 'package:app/ui/features/rooms/widgets/rooms_list_screen.dart';
import 'package:app/ui/features/rooms/widgets/your_rooms_screen.dart';
import 'package:app/ui/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({Key? key}) : super(key: key);
  static const routeName = '/rooms';

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  @override
  void initState() {
    Get.put<RoomsController>(RoomsController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions.of(context);
    final textStyles = TextStyles.of(context);
    return GetBuilder<RoomsController>(builder: (controller) {
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
                  'To be able to view your rooms you have to be logged into your account. Please log in to your account.',
                  style: textStyles.descriptiveText,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30.0),
                PrimaryButton(
                  buttonText: 'Log in',
                  onPress: () {
                    Get.toNamed<dynamic>(LoginScreen.routeName);
                  },
                  backgroundColor: Colors.blueAccent,
                ),
              ],
            );
          }
          return Column(
            children: [
              const SizedBox(height: 20.0),
              _buildTopNavigation(context, controller),
              const SizedBox(height: 20.0),
              controller.tabIndex == 0
                  ? const YourRoomsScreen()
                  : controller.tabIndex == 1
                      ? const RoomsListScreen()
                      : const InvitesListScreen(),
            ],
          );
        }),
      );
    });
  }

  Widget _buildTopNavigation(BuildContext context, RoomsController controller) {
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
                context.read<RoomsBloc>().add(FetchYourRooms());
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
                  'Your rooms',
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
                context.read<RoomsBloc>().add(FetchRooms());
              },
              child: Container(
                decoration: BoxDecoration(
                  color: controller.tabIndex == 1 ? Colors.blueAccent : Colors.white,
                  border: const Border.symmetric(horizontal: BorderSide(color: Colors.blueAccent, width: 1.0)),
                ),
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Rooms',
                  textAlign: TextAlign.center,
                  style: controller.tabIndex == 1 ? textStyles.whiteText : textStyles.accentText,
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                controller.changeTabIndex(2);
                context.read<RoomsBloc>().add(FetchInvites());
              },
              child: Container(
                decoration: BoxDecoration(
                  color: controller.tabIndex == 2 ? Colors.blueAccent : Colors.white,
                  border: Border.all(color: Colors.blueAccent, width: 1.0),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                  ),
                ),
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Invites',
                  textAlign: TextAlign.center,
                  style: controller.tabIndex == 2 ? textStyles.whiteText : textStyles.accentText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
