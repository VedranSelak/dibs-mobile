import 'dart:io';

import 'package:app/blocs/profile_bloc/profile_bloc.dart';
import 'package:app/blocs/user_type_bloc/user_type_bloc.dart';
import 'package:app/res/assets.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/res/string_extension.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/features/login/login_screen.dart';
import 'package:app/ui/widgets/buttons/primary_button.dart';
import 'package:app/ui/widgets/dialogs/alert_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final dimensions = Dimensions.of(context);
    final textStyles = TextStyles.of(context);

    return Container(
      padding: const EdgeInsets.all(20.0),
      width: mediaQuery.size.width,
      height: mediaQuery.size.height,
      child: BlocBuilder<UserTypeBloc, UserTypeState>(builder: (context, userState) {
        return BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (userState is GuestType) {
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
                    'Your are currently a guest. Please log in to your account.',
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
            } else if (state is ProfileDetailsFetched) {
              return Column(
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
                                // ignore: cascade_invocations
                                Get.toNamed<dynamic>(LoginScreen.routeName);
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
                  ),
                  SizedBox(
                    width: dimensions.fullWidth,
                    height: dimensions.mainContentHeight * 0.3,
                    child: Center(
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ClipOval(
                              child: state.image != null
                                  ? Image.file(File(state.image!.path), fit: BoxFit.cover, width: 180, height: 180)
                                  : state.profile.imageUrl != null
                                      ? CachedNetworkImage(
                                          imageUrl: state.profile.imageUrl!, fit: BoxFit.cover, width: 180, height: 180)
                                      : Image.asset(Assets.defaultProfileImage,
                                          fit: BoxFit.cover, width: 180, height: 180),
                            ),
                          ),
                          Positioned.fill(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(100.0),
                                  splashColor: Colors.lightBlue.withOpacity(0.2),
                                  onTap: () {
                                    context.read<ProfileBloc>().add(ChangeProfileImage());
                                  },
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton(
                                  onPressed: () {
                                    context.read<ProfileBloc>().add(ChangeProfileImage());
                                  },
                                  elevation: 0.0,
                                  mini: true,
                                  child: const Icon(Icons.image),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: dimensions.fullWidth,
                    child: Text(
                      '${state.profile.firstName} ${state.profile.lastName}',
                      style: textStyles.headerText,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: dimensions.fullWidth * 0.1),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Account type: ',
                              style: textStyles.subheaderText,
                            ),
                            const SizedBox(width: 10.0),
                            Text(
                              state.profile.type.capitalizeMe(),
                              style: textStyles.labelText,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          children: [
                            Text(
                              'Reservations made: ',
                              style: textStyles.subheaderText,
                            ),
                            const SizedBox(width: 10.0),
                            Text(
                              state.profile.reservationsCount.toString(),
                              style: textStyles.labelText,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          children: [
                            Text(
                              'Your private rooms: ',
                              style: textStyles.subheaderText,
                            ),
                            const SizedBox(width: 10.0),
                            Text(
                              state.profile.roomsCount.toString(),
                              style: textStyles.labelText,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return const Center(
                child: SpinKitRing(color: Colors.blueAccent),
              );
            }
          },
        );
      }),
    );
  }
}
