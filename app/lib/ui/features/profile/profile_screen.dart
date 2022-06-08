import 'dart:io';

import 'package:app/blocs/profile_bloc/profile_bloc.dart';
import 'package:app/blocs/user_type_bloc/user_type_bloc.dart';
import 'package:app/res/assets.dart';
import 'package:app/res/dimensions.dart';
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

    return Container(
      padding: const EdgeInsets.all(20.0),
      width: mediaQuery.size.width,
      height: mediaQuery.size.height,
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileDetailsFetched) {
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
              ],
            );
          }
          return const Center(
            child: SpinKitWave(
              color: Colors.blueAccent,
            ),
          );
        },
      ),
    );
  }
}
