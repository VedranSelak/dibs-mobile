import 'package:app/res/dimensions.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';

class CreatePublicListingCard extends StatelessWidget {
  const CreatePublicListingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions.of(context);
    final textStyles = TextStyles.of(context);
    return Column(
      children: [
        const SizedBox(
          height: 20.0,
        ),
        SizedBox(
          width: dimensions.fullWidth,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Please create a public listing", style: textStyles.labelText),
                  const SizedBox(
                    height: 10.0,
                  ),
                  PrimaryButton(
                    isPrimary: true,
                    onPress: () {
                      print("Create listing");
                    },
                    buttonText: "Create",
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
