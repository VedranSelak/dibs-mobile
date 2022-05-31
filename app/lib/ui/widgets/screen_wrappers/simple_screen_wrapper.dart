import 'package:app/res/text_styles.dart';
import 'package:flutter/material.dart';

class SimpleScreenWrapper extends StatelessWidget {
  const SimpleScreenWrapper({
    required this.child,
    required this.onBackPressed,
    required this.shouldGoUnderAppBar,
    this.title,
    this.shouldResize = true,
    Key? key,
  }) : super(key: key);
  final Widget child;
  final void Function() onBackPressed;
  final bool shouldGoUnderAppBar;
  final String? title;
  final bool shouldResize;

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles.of(context);
    return Scaffold(
      extendBodyBehindAppBar: shouldGoUnderAppBar,
      resizeToAvoidBottomInset: shouldResize,
      appBar: AppBar(
        backgroundColor: title != null ? Colors.grey[50] : Colors.transparent,
        centerTitle: true,
        title: Text(
          title ?? "",
          style: textStyles.subheaderText,
          textAlign: TextAlign.center,
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: onBackPressed,
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.blue,
            size: 35.0,
          ),
        ),
      ),
      body: child,
    );
  }
}
