import 'package:app/blocs/create_listing_bloc/create_listing_bloc.dart';
import 'package:app/res/listing_type.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/widgets/buttons/primary_button.dart';
import 'package:domain/public_listing/entities/spot.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class BottomInputPopupWidget {
  BottomInputPopupWidget({required this.context, required this.type, this.index, this.availableSpots, this.rowName});
  final BuildContext context;
  final ListingType type;
  final int? index;
  final String? availableSpots;
  final String? rowName;
  late final TextEditingController _availableSpotsController;
  late final TextEditingController _rowNameConteroller;
  final _formKey = GlobalKey<FormState>();

  Future<dynamic> onTapped() {
    _availableSpotsController = TextEditingController(text: availableSpots);
    _rowNameConteroller = TextEditingController(text: rowName);
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
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10.0),
                  Text(availableSpots != null ? 'Edit' : type.popupTitle, style: textStyles.labelText),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      Text('${type.textLabelText}:', style: textStyles.accentText),
                    ],
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter number...',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a number';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    controller: _availableSpotsController,
                  ),
                  const SizedBox(height: 20.0),
                  PrimaryButton(
                    buttonText: availableSpots != null ? 'Edit' : 'Create',
                    onPress: () {
                      if (_formKey.currentState!.validate()) {
                        if (availableSpots != null) {
                          context.read<CreateListingBloc>().add(EditListingSpot(
                                index: index ?? 0,
                                availableSpots: int.parse(_availableSpotsController.text),
                                rowName: _rowNameConteroller.text,
                                prevRowName: rowName,
                              ));
                          Get.back<dynamic>();
                          return;
                        }
                        context.read<CreateListingBloc>().add(
                              AddListingSpot(
                                spot: Spot(
                                  availableSpots: int.parse(_availableSpotsController.text),
                                ),
                              ),
                            );
                        Get.back<dynamic>();
                      }
                    },
                    backgroundColor: Colors.blueAccent,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
