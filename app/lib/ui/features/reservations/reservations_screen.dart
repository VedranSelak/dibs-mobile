import 'package:app/blocs/reservations_bloc/reservations_bloc.dart';
import 'package:app/blocs/user_type_bloc/user_type_bloc.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/features/login/login_screen.dart';
import 'package:app/ui/features/reservations/navigation/reservations_controller.dart';
import 'package:app/ui/features/reservations/widgets/recent_reservations_screen.dart';
import 'package:app/ui/features/reservations/widgets/upcoming_reservations_screen.dart';
import 'package:app/ui/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen({Key? key}) : super(key: key);
  static const routeName = '/reservations';

  @override
  State<ReservationsScreen> createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  bool _switchValue = false;

  @override
  void initState() {
    Get.put<ReservationsController>(ReservationsController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions.of(context);
    final textStyles = TextStyles.of(context);
    return GetBuilder<ReservationsController>(
      builder: (controller) {
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
                state is OwnerType
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 20.0),
                        child: Row(
                          children: [
                            Text(
                              'Owner mode: ',
                              style: textStyles.accentText,
                            ),
                            const SizedBox(width: 10.0),
                            FlutterSwitch(
                              height: 30.0,
                              width: 65.0,
                              activeColor: const Color.fromRGBO(34, 186, 82, 1),
                              value: _switchValue,
                              onToggle: (value) {
                                setState(() {
                                  _switchValue = value;
                                });
                                if (value) {
                                  if (controller.tabIndex == 0) {
                                    context.read<ReservationsBloc>().add(FetchUpcomingListingReservations());
                                  } else {
                                    context.read<ReservationsBloc>().add(FetchRecentListingReservations());
                                  }
                                } else {
                                  if (controller.tabIndex == 1) {
                                    context.read<ReservationsBloc>().add(FetchUpcomingReservations());
                                  } else {
                                    context.read<ReservationsBloc>().add(FetchRecentReservations());
                                  }
                                }
                              },
                            ),
                            Expanded(child: Container()),
                            _switchValue
                                ? SizedBox(
                                    height: 30.0,
                                    child: TextButton.icon(
                                      onPressed: () {},
                                      icon: const Icon(Icons.edit_outlined, color: Colors.blueAccent, size: 20.0),
                                      label: Text(
                                        'Edit',
                                        style: textStyles.accentText,
                                      ),
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      )
                    : Container(),
                _buildTopNavigation(context, controller),
                const SizedBox(height: 20.0),
                controller.tabIndex == 0
                    ? UpcomingReservationsScreen(ownerMode: _switchValue)
                    : controller.tabIndex == 1
                        ? RecentReservationsScreen(ownerMode: _switchValue)
                        : Container(),
              ],
            );
          }),
        );
      },
    );
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
