import 'package:flutter/material.dart';

class SimpleScreenWrapper extends StatelessWidget {
  const SimpleScreenWrapper({
    required this.child,
    required this.onBackPressed,
    Key? key,
  }) : super(key: key);
  final Widget child;
  final void Function() onBackPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
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
