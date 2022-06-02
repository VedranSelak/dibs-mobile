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

class EnterImagesScreen extends StatelessWidget {
  const EnterImagesScreen({Key? key}) : super(key: key);
  static const String routeName = "/enter-images";

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
            title: "Enter listing images",
            shouldGoUnderAppBar: false,
            onBackPressed: () {
              onBack(context);
            },
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
                      child: BlocBuilder<CreateListingBloc, CreateListingState>(
                        buildWhen: (prevState, newState) {
                          if (newState is CreateListingInProgress) {
                            return false;
                          }
                          return true;
                        },
                        builder: (context, state) {
                          if (state is ListingDataEntering && state.images != null && state.images!.isNotEmpty) {
                            return GridView.count(
                              physics: const BouncingScrollPhysics(),
                              crossAxisCount: 2,
                              mainAxisSpacing: 5.0,
                              crossAxisSpacing: 5.0,
                              children: List.generate(
                                state.images!.length,
                                (index) {
                                  return Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.blueAccent.withOpacity(0.5), width: 1.5),
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        clipBehavior: Clip.antiAlias,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8.5),
                                          child: Image.file(
                                            File(state.images![index].path),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                          padding: const EdgeInsets.all(0.0),
                                          width: 20.0,
                                          child: GestureDetector(
                                            child: const Icon(
                                              Icons.remove_circle,
                                              size: 20.0,
                                              color: Colors.red,
                                            ),
                                            onTap: () {
                                              context.read<CreateListingBloc>().add(RemoveListingImage(index: index));
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            );
                          }
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_circle_outlined,
                                color: Colors.blueAccent,
                                size: mediaQuery.size.width * 0.15,
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                "Add images of your listing",
                                style: textStyles.accentText,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  BlocBuilder<CreateListingBloc, CreateListingState>(
                    buildWhen: (prevState, newState) {
                      if (newState is CreateListingInProgress) {
                        return false;
                      }
                      return true;
                    },
                    builder: (context, state) {
                      int numberOfImages = 0;
                      if (state is ListingDataEntering && state.images != null) {
                        numberOfImages = state.images!.length;
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(state is ListingDataEntering && state.errorMessage != null ? state.errorMessage! : "",
                              style: textStyles.errorText),
                          Text("$numberOfImages/6",
                              style: numberOfImages >= 6 ? textStyles.secondaryLabelAccent : textStyles.secondaryLabel),
                        ],
                      );
                    },
                  ),
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
                        "Creating your public listing. This may take a while...",
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
