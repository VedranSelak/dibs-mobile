import 'dart:io';

import 'package:app/blocs/create_listing_bloc/create_listing_bloc.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/widgets/buttons/primary_button.dart';
import 'package:app/ui/widgets/screen_wrappers/simple_screen_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class RoomInviteScreen extends StatelessWidget {
  const RoomInviteScreen({Key? key}) : super(key: key);
  static const String routeName = "/room-invite";

  void onBack(BuildContext context) {
    final state = context.read<CreateListingBloc>().state;
    if (state is! CreateListingInProgress) {
      Get.back<dynamic>();
    }
  }

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions.of(context);
    final mediaQuery = MediaQuery.of(context);
    final textStyles = TextStyles.of(context);

    return WillPopScope(
      onWillPop: () async {
        onBack(context);
        return false;
      },
      child: Stack(
        children: [
          SimpleScreenWrapper(
            title: "Enter room image",
            shouldGoUnderAppBar: false,
            onBackPressed: () {},
            child: Container(
              width: dimensions.fullWidth,
              height: dimensions.fullHeight,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(20.0),
                    onTap: () {
                      context.read<CreateListingBloc>().add(AddListingImages());
                    },
                    child: Container(
                      width: mediaQuery.size.width,
                      height: mediaQuery.size.height * 0.6,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent, width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Expanded(child: Container()),
                  const SizedBox(height: 20.0),
                  PrimaryButton(
                    buttonText: "Submit",
                    onPress: () {
                      context.read<CreateListingBloc>().add(SubmitListing());
                    },
                    backgroundColor: Colors.blueAccent,
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
          BlocBuilder<CreateListingBloc, CreateListingState>(
            builder: (context, state) {
              if (state is CreateListingInProgress) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: dimensions.fullWidth * 0.15),
                  width: dimensions.fullWidth,
                  height: dimensions.fullHeight,
                  color: Colors.black.withOpacity(0.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SpinKitWave(
                        color: Colors.lightBlue,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Creating your room. This may take a while...",
                        style: textStyles.buttonText,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
