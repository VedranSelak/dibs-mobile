import 'package:app/blocs/create_listing_bloc/create_listing_bloc.dart';
import 'package:app/res/listing_type.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/widgets/buttons/primary_button.dart';
import 'package:domain/public_listing/entities/spot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomInputPopupWidget {
  BottomInputPopupWidget({required this.context, required this.type});
  final BuildContext context;
  final ListingType type;
  final _availableSpotsController = TextEditingController();

  Future<dynamic> onTapped() {
    return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final textStyles = TextStyles.of(context);
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                topLeft: Radius.circular(10.0),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10.0),
                Text(type.popupTitle, style: textStyles.labelText),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    Text('${type.textLabelText}:', style: textStyles.accentText),
                  ],
                ),
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Enter number...',
                  ),
                  keyboardType: TextInputType.number,
                  controller: _availableSpotsController,
                ),
                const SizedBox(height: 20.0),
                PrimaryButton(
                  buttonText: 'Create',
                  onPress: () {
                    if (type == ListingType.cinema || type == ListingType.theatre) {
                      int rowNumber = 1;
                      final state = context.read<CreateListingBloc>().state;
                      if (state is ListingSpotsEntered) {
                        int maxRow = 0;
                        for (final Spot spot in state.spots) {
                          if (spot.row! > maxRow) {
                            maxRow = spot.row!;
                          }
                        }
                        rowNumber = maxRow + 1;
                      }
                      for (int i = 0; i < int.parse(_availableSpotsController.text); i++) {
                        context.read<CreateListingBloc>().add(
                              AddListingSpot(
                                spot: Spot(
                                  availableSpots: 1,
                                  row: rowNumber,
                                ),
                              ),
                            );
                      }
                      return;
                    }
                    context.read<CreateListingBloc>().add(
                          AddListingSpot(
                            spot: Spot(
                              availableSpots: int.parse(_availableSpotsController.text),
                            ),
                          ),
                        );
                  },
                  backgroundColor: Colors.blueAccent,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
