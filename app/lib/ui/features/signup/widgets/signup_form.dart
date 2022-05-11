import 'package:app/blocs/signup_bloc/signup_bloc.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/widgets/primary_button.dart';
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
  final _formKey = GlobalKey<FormState>();
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

    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      height: mediaQuery.size.height,
      width: mediaQuery.size.width,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Sign up:", style: textStyles.headerText),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an email';
                }
                if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                hintText: 'Email...',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _firstNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your first name';
                }
                return null;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'First name...',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _lastNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your last name';
                }
                return null;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Last name...',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }

                if (value.length < 6) {
                  return 'The password needs to be at least 6 characters long';
                }

                return null;
              },
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
            TextFormField(
              controller: _confirmPasswordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }
                if (value != _passwordController.text) {
                  return "Passwords don't match";
                }
                return null;
              },
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
              height: 20,
            ),
            BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
              if (state is SignUpFailed) {
                return SizedBox(
                  width: mediaQuery.size.width,
                  child: Text(
                    state.message!,
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
                    if (_formKey.currentState!.validate()) {
                      context.read<SignUpBloc>().add(StartSignUp(
                            email: _emailController.text,
                            firstName: _firstNameController.text,
                            lastName: _lastNameController.text,
                            password: _passwordController.text,
                          ));
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
}
