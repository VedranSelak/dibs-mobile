import 'package:app/ui/features/create_listing/create_listing_screen.dart';
import 'package:app/ui/features/create_listing/create_listing_success_screen.dart';
import 'package:app/ui/features/create_listing/enter_images_screen.dart';
import 'package:app/ui/features/create_listing/enter_listing_spots_screen.dart';
import 'package:app/ui/features/home/home_screen.dart';
import 'package:app/ui/features/login/login_screen.dart';
import 'package:app/ui/features/profile/profile_screen.dart';
import 'package:app/ui/features/signup/signup_screen.dart';
import 'package:app/ui/widgets/bottom_navigation/bottom_navigation_binding.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';

class Application extends StatelessWidget {
  Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Dibs",
      initialRoute: HomeScreen.routeName,
      getPages: _routes,
    );
  }

  final _routes = [
    GetPage<LoginScreen>(
      name: LoginScreen.routeName,
      page: LoginScreen.new,
    ),
    GetPage<SignUpScreen>(
      name: SignUpScreen.routeName,
      page: SignUpScreen.new,
    ),
    GetPage<HomeScreen>(
      name: HomeScreen.routeName,
      page: HomeScreen.new,
      binding: BottomNavigationBinding(),
    ),
    GetPage<ProfileScreen>(
      name: ProfileScreen.routeName,
      page: ProfileScreen.new,
    ),
    GetPage<CreateListingScreen>(
      name: CreateListingScreen.routeName,
      page: CreateListingScreen.new,
    ),
    GetPage<EnterImagesScreen>(
      name: EnterImagesScreen.routeName,
      page: EnterImagesScreen.new,
    ),
    GetPage<EnterListingSpotsScreen>(
      name: EnterListingSpotsScreen.routeName,
      page: EnterListingSpotsScreen.new,
    ),
    GetPage<CreateListingSuccessScreen>(
      name: CreateListingSuccessScreen.routeName,
      page: CreateListingSuccessScreen.new,
    ),
  ];
}
