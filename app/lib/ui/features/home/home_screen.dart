import 'package:app/ui/widgets/screen_wrappers/main_screen_wrapper.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return MainScreenWrapper(
      child: Container(
        width: mediaQuery.size.width,
        height: mediaQuery.size.height,
        color: Colors.blue,
      ),
    );
  }
}
