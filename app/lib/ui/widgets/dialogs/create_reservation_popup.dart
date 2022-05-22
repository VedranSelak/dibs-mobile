import 'package:app/blocs/create_listing_bloc/create_listing_bloc.dart';
import 'package:app/res/listing_type.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/widgets/buttons/primary_button.dart';
import 'package:domain/public_listing/entities/spot.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class CreateReservationPopup {
  CreateReservationPopup({required this.context, required this.type});
  final BuildContext context;
  final ListingType type;
  late final TextEditingController _availableSpotsController;
  late final TextEditingController _rowNameConteroller;
  final _formKey = GlobalKey<FormState>();

  Future<dynamic> onTapped() {
    _availableSpotsController = TextEditingController();
    _rowNameConteroller = TextEditingController();
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
                  Text('Create a reservation', style: textStyles.labelText),
                  const SizedBox(height: 20.0),
                  PrimaryButton(
                    buttonText: "Create",
                    onPress: () {
                      if (_formKey.currentState!.validate()) {}
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
