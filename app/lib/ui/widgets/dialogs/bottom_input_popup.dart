import 'package:flutter/material.dart';

class BottomInputPopupWidget {
  BottomInputPopupWidget({required this.context});
  final BuildContext context;

  Future<dynamic> onTapped() {
    return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10.0),
              topLeft: Radius.circular(10.0),
            ),
          ),
          child: const Text("POPUP"),
        );
      },
    );
  }
}
