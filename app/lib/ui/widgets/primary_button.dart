import 'package:app/res/text_styles.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({required this.buttonText, required this.onPress, Key? key}) : super(key: key);
  final void Function() onPress;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles.of(context);

    return OutlinedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.blue),
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
      onPressed: onPress,
      child: Text(
        buttonText,
        style: textStyles.buttonText,
      ),
    );
  }
}