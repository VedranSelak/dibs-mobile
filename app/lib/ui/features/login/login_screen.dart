import 'package:app/blocs/login_bloc/login_bloc.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/widgets/outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles.of(context);
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Log in:", style: textStyles.headerText),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Email...',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Password...',
                    ),
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                    if (state is LoginFailed) {
                      return SizedBox(
                        width: mediaQuery.size.width,
                        child: Text(
                          "Incorrect email or password",
                          style: textStyles.errorText,
                          textAlign: TextAlign.start,
                        ),
                      );
                    }
                    return Text("", style: textStyles.errorText);
                  }),
                  SizedBox(
                      width: mediaQuery.size.width * 0.5,
                      child: PrimaryButton(
                        onPress: () {
                          context.read<LoginBloc>().add(StartLogin(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ));
                        },
                      )),
                ],
              ),
            ),
          ),
          const Text("SIGN UP"),
        ],
      ),
    );
  }
}
