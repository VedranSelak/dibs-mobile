import 'package:app/blocs/login_bloc/login_bloc.dart';
import 'package:app/res/text_styles.dart';
import 'package:app/ui/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;

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

    return Expanded(
      child: Container(
        height: mediaQuery.size.height,
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Log in:", style: textStyles.headerText),
              const SizedBox(
                height: 10,
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
                  border: OutlineInputBorder(),
                  hintText: 'Email...',
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
              BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                if (state is LoginFailed) {
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
                    buttonText: "Login",
                    onPress: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<LoginBloc>().add(StartLogin(
                              email: _emailController.text,
                              password: _passwordController.text,
                            ));
                      }
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
