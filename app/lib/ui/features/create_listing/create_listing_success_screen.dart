import 'package:app/res/assets.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateListingSuccessScreen extends StatelessWidget {
  const CreateListingSuccessScreen({Key? key}) : super(key: key);
  static const String routeName = "/create-listing-success";

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions.of(context);
    final textStyles = TextStyles.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Get.back<dynamic>();
            },
            icon: const Icon(
              Icons.close,
              color: Colors.blue,
              size: 35.0,
            ),
          ),
        ],
      ),
      body: SizedBox(
        width: dimensions.fullWidth,
        height: dimensions.fullHeight * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.successCheckmark,
              width: dimensions.fullWidth * 0.6,
              height: dimensions.fullWidth * 0.6,
            ),
            const SizedBox(height: 10.0),
            Text("Success!", style: textStyles.headerText),
            const SizedBox(height: 20.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: dimensions.fullWidth * 0.15),
              child: Text(
                "You have successfully created your public listing. The listing is currently in review and is not active. After the review is passed the listing will be visible to users.",
                style: textStyles.descriptiveText,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 50.0),
            PrimaryButton(
              buttonText: "Close",
              backgroundColor: Colors.blueAccent,
              onPress: () {
                Get.back<dynamic>();
              },
            ),
            const SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}
