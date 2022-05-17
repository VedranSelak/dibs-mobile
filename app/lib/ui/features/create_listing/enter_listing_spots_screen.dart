import 'package:app/blocs/create_listing_bloc/create_listing_bloc.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/res/listing_type.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/features/create_listing/enter_images_screen.dart';
import 'package:app/ui/widgets/buttons/primary_button.dart';
import 'package:app/ui/widgets/dialogs/bottom_input_popup.dart';
import 'package:app/ui/widgets/screen_wrappers/simple_screen_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class EnterListingSpotsScreen extends StatefulWidget {
  const EnterListingSpotsScreen({Key? key}) : super(key: key);
  static const String routeName = "/enter-spots";

  @override
  State<EnterListingSpotsScreen> createState() => _EnterListingSpotsScreenState();
}

class _EnterListingSpotsScreenState extends State<EnterListingSpotsScreen> {
  final List<ListingType> dropdownItems = [
    ListingType.restaurant,
    ListingType.sportcenter,
    ListingType.theatre,
    ListingType.cinema
  ];

  ListingType? selectedType;

  @override
  void initState() {
    super.initState();
    final state = context.read<CreateListingBloc>().state;
    if (state is ListingSpotsEntered) {
      selectedType = state.type;
    } else if (state is ListingImagesEntered) {
      selectedType = state.type;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions.of(context);
    final mediaQuery = MediaQuery.of(context);
    final textStyles = TextStyles.of(context);

    void onBack() {
      Get.back<dynamic>();
    }

    return SimpleScreenWrapper(
      title: "Enter listing details",
      shouldGoUnderAppBar: false,
      onBackPressed: onBack,
      child: Container(
        width: dimensions.fullWidth,
        height: dimensions.fullHeight,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Type of listing:",
                  style: textStyles.subheaderText,
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Tooltip(
                    margin: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.25),
                    padding: const EdgeInsets.all(10.0),
                    triggerMode: TooltipTriggerMode.tap,
                    waitDuration: Duration.zero,
                    showDuration: const Duration(seconds: 3),
                    message: "This is the type of your listing that will be user for further setup and filtering.",
                    child: Container(
                      padding: const EdgeInsets.all(2.0),
                      decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                      child: const Icon(
                        Icons.question_mark,
                        color: Colors.white,
                        size: 15.0,
                      ),
                    )),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                DropdownButton<ListingType>(
                  value: selectedType,
                  hint: const Text('Select the listing type'),
                  items: dropdownItems.map((ListingType type) {
                    return DropdownMenuItem<ListingType>(
                      value: type,
                      child: Row(
                        children: [
                          Icon(type.icon),
                          const SizedBox(width: 5.0),
                          Text(type.rawValue),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (ListingType? selected) {
                    setState(() {
                      selectedType = selected ?? ListingType.restaurant;
                    });
                    context.read<CreateListingBloc>().add(SelectListingType(type: selected ?? ListingType.restaurant));
                  },
                  icon: const Icon(Icons.arrow_drop_down_rounded),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            BlocBuilder<CreateListingBloc, CreateListingState>(
              builder: (context, state) {
                if (state is ListingSpotsEntered) {
                  return Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(state.type.title, style: textStyles.subheaderText),
                            GestureDetector(
                                onTap: () {
                                  BottomInputPopupWidget(context: context, type: state.type).onTapped();
                                },
                                child: const Icon(
                                  Icons.add_outlined,
                                  color: Colors.green,
                                )),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.blueAccent,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: state.spots.length,
                              itemBuilder: (context, index) {
                                return Text(state.spots[index].availableSpots.toString());
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }
                return Expanded(child: Container());
              },
            ),
            const SizedBox(height: 10.0),
            PrimaryButton(
              buttonText: "Next",
              onPress: () {
                Get.toNamed<dynamic>(EnterImagesScreen.routeName);
              },
              backgroundColor: Colors.blueAccent,
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
