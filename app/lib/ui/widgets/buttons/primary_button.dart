import 'package:app/res/text_styles.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.buttonText,
    required this.onPress,
    required this.isPrimary,
    Key? key,
  }) : super(key: key);
  final void Function() onPress;
  final String buttonText;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles.of(context);

    return OutlinedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(isPrimary ? Colors.blue : Colors.grey),
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
