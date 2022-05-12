import 'package:app/blocs/login_bloc/login_bloc.dart';
import 'package:app/ui/features/login/widgets/login_form.dart';
import 'package:app/ui/features/signup/signup_screen.dart';
import 'package:app/ui/widgets/screen_wrappers/simple_screen_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return SimpleScreenWrapper(
      onBackPressed: () {
        Get.back<dynamic>();
        context.read<LoginBloc>().add(ResetLogin());
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const LoginForm(),
          Container(
            height: 1.0,
            decoration: const BoxDecoration(
              color: Colors.grey,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account?"),
              TextButton(
                  onPressed: () {
                    Get.toNamed<dynamic>(SignUpScreen.routeName);
                  },
                  child: const Text("Sign up"))
            ],
          ),
        ],
      ),
    );
  }
}
