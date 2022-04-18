import 'package:app/blocs/test_bloc/test_bloc.dart';
import 'package:app/ui/features/login/login_screen.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
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
  ];
}
