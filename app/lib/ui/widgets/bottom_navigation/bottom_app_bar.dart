import 'package:app/ui/widgets/bottom_navigation/main_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomAppBarWidget extends StatelessWidget {
  const BottomAppBarWidget({required this.controller, Key? key}) : super(key: key);
  final MainController controller;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 5.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(CupertinoIcons.home),
            color: controller.tabIndex == 0 ? Colors.blueAccent : Colors.black,
            tooltip: "Home",
            onPressed: () {
              controller.changeTabIndex(0);
            },
          ),
          IconButton(
            icon: const Icon(CupertinoIcons.person),
            color: controller.tabIndex == 1 ? Colors.blueAccent : Colors.black,
            tooltip: "Profile",
            onPressed: () {
              controller.changeTabIndex(1);
            },
          ),
        ],
      ),
    );
  }
}
