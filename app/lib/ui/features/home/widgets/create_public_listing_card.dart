import 'package:app/blocs/show_reminder_cubit/show_reminder_cubit.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/features/create_listing/create_listing_screen.dart';
import 'package:app/ui/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class CreatePublicListingCard extends StatelessWidget {
  const CreatePublicListingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions.of(context);
    final textStyles = TextStyles.of(context);
    return BlocBuilder<ShowReminderCubit, bool>(builder: (context, state) {
      if (state) {
        return Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Stack(
              children: [
                SizedBox(
                  width: dimensions.fullWidth,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10.0),
                          Text("Create listing", style: textStyles.labelText),
                          const SizedBox(height: 15.0),
                          Text(
                            "Use the benefits of an owner account and create a public listing. This way users can view and enjoj your listing.",
                            style: textStyles.secondaryLabel,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 15.0),
                          PrimaryButton(
                            backgroundColor: Colors.blueAccent,
                            onPress: () {
                              Get.toNamed<dynamic>(CreateListingScreen.routeName);
                            },
                            buttonText: "Create",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () {
                            context.read<ShowReminderCubit>().closeReminder();
                          },
                          child: const Icon(Icons.close)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      }
      return Container();
    });
  }
}
