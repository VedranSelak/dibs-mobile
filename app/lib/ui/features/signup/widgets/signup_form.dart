import 'package:app/blocs/login_bloc/login_bloc.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/widgets/outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = TextStyles.of(context);
    final mediaQuery = MediaQuery.of(context);

    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Sign up:", style: textStyles.headerText),
            const SizedBox(
              height: 20,
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
              controller: _lastNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'First name...',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Last name...',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Password...',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  )),
              obscureText: !_passwordVisible,
              enableSuggestions: false,
              autocorrect: false,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Confirm password...',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _confirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _confirmPasswordVisible = !_confirmPasswordVisible;
                      });
                    },
                  )),
              obscureText: !_confirmPasswordVisible,
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
                  buttonText: "Sign up",
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
    );
  }
}
