import 'package:app/res/text_styles.dart';
import 'package:flutter/material.dart';

class AlertDialogWidget {
  const AlertDialogWidget({
    required this.context,
    required this.title,
    required this.description,
    required this.acceptButton,
    this.rejectButton,
  });
  final BuildContext context;
  final String title;
  final String description;
  final Widget acceptButton;
  final Widget? rejectButton;

  void showAlertDialog() async {
    return showDialog<void>(
      context: context,
      builder: (context) {
        final textStyles = TextStyles.of(context);

        return AlertDialog(
          buttonPadding: const EdgeInsets.all(20.0),
          title: Text(title, textAlign: TextAlign.center, style: textStyles.labelText),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(description, textAlign: TextAlign.center, style: textStyles.secondaryLabel),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: acceptButton,
                ),
                rejectButton != null
                    ? const SizedBox(
                        width: 10.0,
                      )
                    : Container(),
                rejectButton != null
                    ? Expanded(
                        child: rejectButton!,
                      )
                    : Container(),
              ],
            )
          ],
        );
      },
    );
  }
}
