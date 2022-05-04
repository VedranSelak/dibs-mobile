import 'package:app/ui/features/login/login_screen.dart';
import 'package:app/ui/features/signup/signup_screen.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';

class Application extends StatelessWidget {
  Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Dibs",
      initialRoute: LoginScreen.routeName,
      getPages: _routes,
    );
  }

  final _routes = [
    GetPage<LoginScreen>(name: LoginScreen.routeName, page: LoginScreen.new),
    GetPage<SignUpScreen>(name: SignUpScreen.routeName, page: SignUpScreen.new),
  ];
}
