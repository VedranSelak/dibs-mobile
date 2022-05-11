import 'package:app/res/dimensions.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/features/profile/profile_screen.dart';
import 'package:app/ui/widgets/bottom_navigation/main_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreenWrapper extends StatefulWidget {
  const MainScreenWrapper({required this.child, Key? key}) : super(key: key);
  final Widget child;

  @override
  State<MainScreenWrapper> createState() => _MainScreenWrapperState();
}

class _MainScreenWrapperState extends State<MainScreenWrapper> {
  late OverlayEntry entry;

  @override
  void initState() {
    super.initState();
    entry = OverlayEntry(
      builder: (context) {
        final dimensions = Dimensions.of(context);
        final textStyles = TextStyles.of(context);

        return GestureDetector(
          onTap: () {
            entry.remove();
          },
          child: Material(
            color: Colors.transparent,
            child: Center(
              child: Container(
                height: dimensions.fullHeight,
                width: dimensions.fullWidth,
                color: Colors.black.withOpacity(0.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 90.0,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text("Room", style: textStyles.buttonText),
                          const SizedBox(
                            height: 10.0,
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 90.0,
                      child: Column(
                        children: [
                          Text("Listing", style: textStyles.buttonText),
                          const SizedBox(
                            height: 10.0,
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 90.0,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text("Invite", style: textStyles.buttonText),
                          const SizedBox(
                            height: 10.0,
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dimensions = Dimensions.of(context);
    return GetBuilder<MainController>(builder: (controller) {
      return Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: controller.tabIndex,
            children: [
              widget.child,
              const ProfileScreen(),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Overlay.of(context)?.insert(entry);
          },
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: SizedBox(
          height: dimensions.bottomNavBarHeight,
          child: BottomAppBar(
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
          ),
        ),
      );
    });
  }
}
