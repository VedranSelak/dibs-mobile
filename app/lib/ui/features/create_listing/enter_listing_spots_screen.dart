import 'package:app/blocs/create_listing_bloc/create_listing_bloc.dart';
import 'package:app/res/dimensions.dart';
import 'package:app/res/listing_type.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/features/create_listing/enter_images_screen.dart';
import 'package:app/ui/features/create_listing/widgets/spot_list_container.dart';
import 'package:app/ui/features/create_listing/widgets/text_label.dart';
import 'package:app/ui/widgets/buttons/primary_button.dart';
import 'package:app/ui/widgets/screen_wrappers/simple_screen_wrapper.dart';
import 'package:domain/public_listing/entities/spot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/res/string_extension.dart';
import 'package:get/get.dart';

class EnterListingSpotsScreen extends StatefulWidget {
  const EnterListingSpotsScreen({Key? key}) : super(key: key);
  static const String routeName = "/enter-spots";

  @override
  State<EnterListingSpotsScreen> createState() => _EnterListingSpotsScreenState();
}

class _EnterListingSpotsScreenState extends State<EnterListingSpotsScreen> {
  ListingType? selectedType;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    final state = context.read<CreateListingBloc>().state;
    if (state is ListingDataEntering && state.type != null) {
      selectedType = state.type;
    }
  }

  void onBack() {
    Get.back<dynamic>();
  }

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions.of(context);
    final textStyles = TextStyles.of(context);

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
            const TextLabel(
                title: 'Type of listing:',
                tooltip: 'This is the type of your listing that will be user for further setup and filtering.'),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                DropdownButton<ListingType>(
                  value: selectedType,
                  hint: const Text('Select the listing type'),
                  items: ListingType.values.map((ListingType type) {
                    final String title = type.rawValue.capitalizeMe();
                    return DropdownMenuItem<ListingType>(
                      value: type,
                      child: Row(
                        children: [
                          Icon(type.icon),
                          const SizedBox(width: 5.0),
                          Text(title),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (ListingType? selected) {
                    setState(() {
                      selectedType = selected ?? ListingType.restaurant;
                    });
                    context.read<CreateListingBloc>().add(SelectListingType(type: selected ?? ListingType.restaurant));
                    setState(() {
                      hasError = false;
                    });
                  },
                  icon: const Icon(Icons.arrow_drop_down_rounded),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            BlocConsumer<CreateListingBloc, CreateListingState>(
              listener: (context, state) {
                if (state is ListingDataEntering && state.spots != null) {
                  if (state.spots!.isNotEmpty && hasError) {
                    setState(() {
                      hasError = false;
                    });
                  }
                }
              },
              builder: (context, state) {
                if (state is ListingDataEntering && state.type != null && state.spots != null) {
                  final List<Spot> rows = [];
                  if (state.type == ListingType.cinema || state.type == ListingType.theatre) {
                    final List<String> rowNames = [];
                    Spot temp = Spot(availableSpots: 0);
                    for (final spot in state.spots!) {
                      if (!rowNames.any((name) => name == spot.rowName!)) {
                        rowNames.add(spot.rowName!);
                        temp = Spot(availableSpots: 1, rowName: spot.rowName!);
                        rows.add(temp);
                      } else {
                        temp.availableSpots++;
                      }
                    }
                  }
                  return SpotListContainer(
                    type: state.type!,
                    spots:
                        state.type! == ListingType.cinema || state.type! == ListingType.theatre ? rows : state.spots!,
                  );
                }
                return Expanded(child: Container());
              },
            ),
            const SizedBox(height: 5.0),
            Row(
              children: [
                Text(
                  hasError
                      ? selectedType == null
                          ? 'Please select a type'
                          : "Please enter at least one ${selectedType!.itemTitle.toLowerCase()}"
                      : "",
                  style: textStyles.errorText,
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            PrimaryButton(
              buttonText: "Next",
              onPress: () {
                final state = context.read<CreateListingBloc>().state;
                if (state is ListingDataEntering && state.type != null && state.spots != null) {
                  if (state.spots!.isEmpty) {
                    setState(() {
                      hasError = true;
                    });
                    return;
                  }
                } else if (state is ListingDataEntering) {
                  setState(() {
                    hasError = true;
                  });
                  return;
                }
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
