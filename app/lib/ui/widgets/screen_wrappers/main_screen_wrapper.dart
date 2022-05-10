import 'package:app/ui/features/profile/profile_screen.dart';
import 'package:app/ui/widgets/bottom_navigation/main_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreenWrapper extends StatelessWidget {
  const MainScreenWrapper({required this.child, Key? key}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(builder: (controller) {
      return Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: controller.tabIndex,
            children: [
              child,
              const ProfileScreen(),
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 80.0,
          child: BottomNavigationBar(
            onTap: controller.changeTabIndex,
            currentIndex: controller.tabIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.sportscourt),
                label: 'Profile',
              ),
            ],
          ),
        ),
      );
    });
  }
}
