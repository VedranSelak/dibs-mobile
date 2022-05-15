import 'dart:io';

import 'package:app/blocs/create_listing_bloc/create_listing_bloc.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/widgets/screen_wrappers/simple_screen_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class EnterImagesScreen extends StatelessWidget {
  const EnterImagesScreen({Key? key}) : super(key: key);
  static const String routeName = "/enter-images";

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions.of(context);
    final mediaQuery = MediaQuery.of(context);
    final textStyles = TextStyles.of(context);

    void onBack() {
      Get.back<dynamic>();
    }

    return SimpleScreenWrapper(
      title: "Enter listing images",
      shouldGoUnderAppBar: false,
      onBackPressed: onBack,
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
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent, width: 2.0),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: BlocBuilder<CreateListingBloc, CreateListingState>(builder: (context, state) {
                    if (state is ListingImagesEntered && state.images.isNotEmpty) {
                      return GridView.count(
                        crossAxisCount: 2,
                        children: List.generate(
                          state.images.length,
                          (index) {
                            return Image.file(
                              File(state.images[index].path),
                              fit: BoxFit.contain,
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
                  })),
            ),
          ],
        ),
      ),
    );
  }
}
