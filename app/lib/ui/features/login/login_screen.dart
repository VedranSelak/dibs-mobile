import 'package:app/res/text_styles.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles.of(context);

    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Text("Log in", style: textStyles.headerText),
      ),
    );
  }
}
