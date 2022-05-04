import 'package:app/ui/features/signup/widgets/signup_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static const routeName = '/signup';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Get.back<dynamic>();
          },
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.blue,
            size: 35.0,
          ),
        ),
      ),
      body: Column(
        children: const [
          SignUpForm(),
        ],
      ),
    );
  }
}
