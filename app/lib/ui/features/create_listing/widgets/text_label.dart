import 'package:app/res/text_styles.dart';
import 'package:flutter/material.dart';

class TextLabel extends StatelessWidget {
  const TextLabel({required this.title, required this.tooltip, Key? key}) : super(key: key);
  final String title;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles.of(context);
    final mediaQuery = MediaQuery.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
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
            message: tooltip,
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
    );
  }
}
